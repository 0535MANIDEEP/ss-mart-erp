# SS MART - Sync Engine Design

## 1. Sync Engine Architecture

### 1.1 High-Level Design

```
┌─────────────────────────────────────────────────────────────┐
│                    SYNC ENGINE ARCHITECTURE                   │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌─────────────────────────────────────────────────────┐   │
│  │                 Flutter App (Client)                 │   │
│  │  ┌─────────────────────────────────────────────┐   │   │
│  │  │  1. Local SQLite Database                    │   │   │
│  │  │  2. Sync Queue Table                         │   │   │
│  │  │  3. Background Sync Service                  │   │   │
│  │  │  4. Conflict Resolver                        │   │   │
│  │  │  5. Network Monitor                          │   │   │
│  │  └─────────────────────────────────────────────┘   │   │
│  └─────────────────────────────────────────────────────┘   │
│                          │                                    │
│                          ▼                                    │
│  ┌─────────────────────────────────────────────────────┐   │
│  │              Sync Queue Manager                      │   │
│  │  ┌─────────────────────────────────────────────┐   │   │
│  │  │  Priority Queue (FIFO with priorities)      │   │   │
│  │  │  - HIGH: Bills, Payments, Stock Updates      │   │   │
│  │  │  - MEDIUM: Customer updates, Loyalty         │   │   │
│  │  │  - LOW: Reports, Settings, Audit logs        │   │   │
│  │  └─────────────────────────────────────────────┘   │   │
│  └─────────────────────────────────────────────────────┘   │
│                          │                                    │
│                          ▼                                    │
│  ┌─────────────────────────────────────────────────────┐   │
│  │              Network Manager                         │   │
│  │  ┌─────────────────────────────────────────────┐   │   │
│  │  │  - Online/Offline detection                  │   │   │
│  │  │  - Connection quality monitoring             │   │   │
│  │  │  - Retry logic with exponential backoff      │   │   │
│  │  │  - Request queuing                           │   │   │
│  │  └─────────────────────────────────────────────┘   │   │
│  └─────────────────────────────────────────────────────┘   │
│                          │                                    │
│                          ▼                                    │
│  ┌─────────────────────────────────────────────────────┐   │
│  │              Server API (.NET 8)                     │   │
│  │  ┌─────────────────────────────────────────────┐   │   │
│  │  │  - Sync endpoints                            │   │   │
│  │  │  - Conflict detection                        │   │   │
│  │  │  - Version management                        │   │   │
│  │  │  - Conflict resolution                       │   │   │
│  │  └─────────────────────────────────────────────┘   │   │
│  └─────────────────────────────────────────────────────┘   │
│                          │                                    │
│                          ▼                                    │
│  ┌─────────────────────────────────────────────────────┐   │
│  │              PostgreSQL Server Database               │   │
│  │  ┌─────────────────────────────────────────────┐   │   │
│  │  │  - All master data                           │   │   │
│  │  │  - All transactions                          │   │   │
│  │  │  - Version tracking                          │   │   │
│  │  │  - Audit logs                                │   │   │
│  │  └─────────────────────────────────────────────┘   │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### 1.2 Sync Process Flow

```
┌─────────────────────────────────────────────────────────────┐
│                    SYNC PROCESS FLOW                         │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  1. Data Write (Offline)                                    │
│     │  - User creates/updates data                          │
│     │  - Write to local SQLite database                     │
│     │  - Generate UUID for new records                      │
│     │  - Set sync_status = 'pending'                        │
│     │  - Add to sync queue                                  │
│     ▼                                                        │
│  2. Queue Management                                        │
│     │  - Add item to sync queue                             │
│     │  - Set priority level                                 │
│     │  - Set retry count = 0                                │
│     │  - Set max retries = 3                                │
│     ▼                                                        │
│  3. Network Check                                           │
│     │  - Check network connectivity                         │
│     │  - If offline: Wait for connection                    │
│     │  - If online: Proceed to sync                         │
│     ▼                                                        │
│  4. Process Queue                                           │
│     │  - Get pending items (oldest first)                   │
│     │  - Group by entity type                               │
│     │  - Process in dependency order:                       │
│     │    1. Products (no dependencies)                      │
│     │    2. Customers (no dependencies)                     │
│     │    3. Bills (depends on products, customers)          │
│     │    4. Stock (depends on products, bills)              │
│     │    5. Loyalty (depends on customers, bills)           │
│     ▼                                                        │
│  5. Send to Server                                          │
│     │  - Prepare API request                                │
│     │  - Include: entity type, ID, operation, payload       │
│     │  - Include: client timestamp, version                 │
│     │  - Send to /api/sync/upload                           │
│     ▼                                                        │
│  6. Server Processing                                       │
│     │  - Validate data                                      │
│     │  - Check for conflicts                                │
│     │  - If no conflict: Apply changes                      │
│     │  - If conflict: Return conflict details               │
│     │  - Return response                                    │
│     ▼                                                        │
│  7. Handle Response                                         │
│     │  - If success:                                        │
│     │    - Update sync_status = 'completed'                 │
│     │    - Update local version                             │
│     │    - Remove from queue                                │
│     │  - If conflict:                                       │
│     │    - Apply conflict resolution strategy               │
│     │    - Update local data                                │
│     │    - Mark as resolved                                 │
│     │  - If error:                                          │
│     │    - Increment retry count                            │
│     │    - Set error message                                │
│     │    - Schedule retry                                   │
│     ▼                                                        │
│  8. Retry Logic                                             │
│     │  - If retry count < max retries:                      │
│     │    - Exponential backoff: 2^n seconds                 │
│     │    - n = retry count                                  │
│     │    - Maximum delay: 5 minutes                         │
│     │  - If retry count >= max retries:                     │
│     │    - Mark as failed                                   │
│     │    - Alert user                                       │
│     │    - Log error                                        │
│     ▼                                                        │
│  9. Conflict Resolution                                     │
│        - Detect conflicts using version numbers             │
│        - Apply resolution strategy                          │
│        - Log resolution details                             │
│        - Update both local and server data                  │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## 2. Sync Queue Implementation

### 2.1 Queue Data Structure

```dart
// Flutter/Dart Sync Queue Implementation

class SyncQueue {
  final Database _database;
  
  SyncQueue(this._database);
  
  // Add item to queue
  Future<void> addToQueue({
    required EntityType entityType,
    required UUID entityId,
    required OperationType operation,
    required String payload,
    int priority = 2, // 1=HIGH, 2=MEDIUM, 3=LOW
  }) async {
    await _database.into(_database.syncQueue).insert(
      SyncQueueCompanion.insert(
        id: Uuid().v4(),
        entityType: entityType.value,
        entityId: entityId,
        operation: operation.value,
        payload: payload,
        status: 'pending',
        retryCount: Value(0),
        maxRetries: Value(3),
        createdAt: DateTime.now().toIso8601String(),
      ),
    );
  }
  
  // Get pending items by priority
  Future<List<SyncQueueItem>> getPendingItems({
    int limit = 10,
    int? priority,
  }) async {
    final query = _database.select(_database.syncQueue)
      ..where((t) => t.status.equals('pending'))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
      ..limit(limit);
    
    if (priority != null) {
      query.where((t) => t.priority.equals(priority));
    }
    
    return await query.get();
  }
  
  // Update item status
  Future<void> updateStatus({
    required UUID id,
    required String status,
    String? error,
  }) async {
    await (_database.update(_database.syncQueue)
      ..where((t) => t.id.equals(id)))
      .write(
        SyncQueueCompanion(
          status: Value(status),
          lastAttemptAt: Value(DateTime.now().toIso8601String()),
          error: Value(error),
          ...(status == 'completed'
              ? {
                  completedAt: Value(DateTime.now().toIso8601String()),
                }
              : {}),
        ),
      );
  }
  
  // Increment retry count
  Future<void> incrementRetryCount(UUID id) async {
    final item = await (_database.select(_database.syncQueue)
      ..where((t) => t.id.equals(id)))
      .getSingleOrNull();
    
    if (item != null) {
      await (_database.update(_database.syncQueue)
        ..where((t) => t.id.equals(id)))
        .write(
          SyncQueueCompanion(
            retryCount: Value(item.retryCount + 1),
            lastAttemptAt: Value(DateTime.now().toIso8601String()),
          ),
        );
    }
  }
  
  // Get failed items
  Future<List<SyncQueueItem>> getFailedItems() async {
    return await (_database.select(_database.syncQueue)
      ..where((t) => t.status.equals('failed'))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
      .get();
  }
  
  // Clear completed items older than days
  Future<void> clearOldCompletedItems({int days = 7}) async {
    final cutoffDate = DateTime.now()
        .subtract(Duration(days: days))
        .toIso8601String();
    
    await (_database.delete(_database.syncQueue)
      ..where((t) => 
          t.status.equals('completed') & 
          t.completedAt.isSmallerThanValue(cutoffDate)))
      .go();
  }
}
```

```csharp
// .NET/C# Sync Queue Implementation

public class SyncQueueService : ISyncQueueService
{
    private readonly AppDbContext _context;
    private readonly ILogger<SyncQueueService> _logger;
    
    public SyncQueueService(AppDbContext context, ILogger<SyncQueueService> logger)
    {
        _context = context;
        _logger = logger;
    }
    
    public async Task<SyncQueue> AddToQueueAsync(
        EntityType entityType,
        Guid entityId,
        OperationType operation,
        string payload,
        int priority = 2)
    {
        var queueItem = new SyncQueue
        {
            Id = Guid.NewGuid(),
            EntityType = entityType,
            EntityId = entityId,
            Operation = operation,
            Payload = payload,
            Status = SyncStatus.Pending,
            RetryCount = 0,
            MaxRetries = 3,
            Priority = priority,
            CreatedAt = DateTime.UtcNow
        };
        
        _context.SyncQueues.Add(queueItem);
        await _context.SaveChangesAsync();
        
        return queueItem;
    }
    
    public async Task<List<SyncQueue>> GetPendingItemsAsync(
        int limit = 10,
        int? priority = null)
    {
        var query = _context.SyncQueues
            .Where(s => s.Status == SyncStatus.Pending)
            .OrderBy(s => s.CreatedAt)
            .Take(limit);
        
        if (priority.HasValue)
        {
            query = query.Where(s => s.Priority == priority.Value)
                .OrderBy(s => s.CreatedAt)
                .Take(limit);
        }
        
        return await query.ToListAsync();
    }
    
    public async Task UpdateStatusAsync(
        Guid id,
        SyncStatus status,
        string? error = null)
    {
        var item = await _context.SyncQueues.FindAsync(id);
        if (item != null)
        {
            item.Status = status;
            item.LastAttemptAt = DateTime.UtcNow;
            item.Error = error;
            
            if (status == SyncStatus.Completed)
            {
                item.CompletedAt = DateTime.UtcNow;
            }
            
            await _context.SaveChangesAsync();
        }
    }
    
    public async Task IncrementRetryCountAsync(Guid id)
    {
        var item = await _context.SyncQueues.FindAsync(id);
        if (item != null)
        {
            item.RetryCount++;
            item.LastAttemptAt = DateTime.UtcNow;
            await _context.SaveChangesAsync();
        }
    }
    
    public async Task<List<SyncQueue>> GetFailedItemsAsync()
    {
        return await _context.SyncQueues
            .Where(s => s.Status == SyncStatus.Failed)
            .OrderByDescending(s => s.CreatedAt)
            .ToListAsync();
    }
    
    public async Task ClearOldCompletedItemsAsync(int days = 7)
    {
        var cutoffDate = DateTime.UtcNow.AddDays(-days);
        
        var oldItems = await _context.SyncQueues
            .Where(s => s.Status == SyncStatus.Completed && 
                        s.CompletedAt < cutoffDate)
            .ToListAsync();
        
        _context.SyncQueues.RemoveRange(oldItems);
        await _context.SaveChangesAsync();
    }
}
```

### 2.2 Background Sync Service

```dart
// Flutter/Dart Background Sync Service

class BackgroundSyncService {
  final SyncQueue _syncQueue;
  final NetworkInfo _networkInfo;
  final ApiService _apiService;
  final ConflictResolver _conflictResolver;
  
  Timer? _syncTimer;
  bool _isSyncing = false;
  
  BackgroundSyncService({
    required SyncQueue syncQueue,
    required NetworkInfo networkInfo,
    required ApiService apiService,
    required ConflictResolver conflictResolver,
  })  : _syncQueue = syncQueue,
        _networkInfo = networkInfo,
        _apiService = apiService,
        _conflictResolver = conflictResolver;
  
  // Start background sync
  void startSync({Duration interval = const Duration(minutes: 5)}) {
    _syncTimer = Timer.periodic(interval, (_) => _performSync());
    
    // Also perform initial sync
    _performSync();
  }
  
  // Stop background sync
  void stopSync() {
    _syncTimer?.cancel();
    _syncTimer = null;
  }
  
  // Perform sync
  Future<void> _performSync() async {
    if (_isSyncing) return;
    
    try {
      _isSyncing = true;
      
      // Check network connectivity
      final isConnected = await _networkInfo.isConnected;
      if (!isConnected) {
        _logger.info('No network connection, skipping sync');
        return;
      }
      
      // Get pending items
      final pendingItems = await _syncQueue.getPendingItems(limit: 10);
      if (pendingItems.isEmpty) {
        _logger.info('No pending items to sync');
        return;
      }
      
      // Group by entity type for batch processing
      final groupedItems = _groupByEntityType(pendingItems);
      
      // Process each group
      for (final entry in groupedItems.entries) {
        await _processEntityTypeGroup(entry.key, entry.value);
      }
      
    } catch (e) {
      _logger.error('Sync failed: $e');
    } finally {
      _isSyncing = false;
    }
  }
  
  // Group items by entity type
  Map<EntityType, List<SyncQueueItem>> _groupByEntityType(
    List<SyncQueueItem> items,
  ) {
    final grouped = <EntityType, List<SyncQueueItem>>{};
    
    for (final item in items) {
      final entityType = EntityType.fromString(item.entityType);
      if (!grouped.containsKey(entityType)) {
        grouped[entityType] = [];
      }
      grouped[entityType]!.add(item);
    }
    
    return grouped;
  }
  
  // Process entity type group
  Future<void> _processEntityTypeGroup(
    EntityType entityType,
    List<SyncQueueItem> items,
  ) async {
    for (final item in items) {
      await _processSyncItem(item);
    }
  }
  
  // Process single sync item
  Future<void> _processSyncItem(SyncQueueItem item) async {
    try {
      // Update status to in progress
      await _syncQueue.updateStatus(
        id: item.id,
        status: 'in_progress',
      );
      
      // Prepare request
      final request = SyncUploadRequest(
        entityType: EntityType.fromString(item.entityType),
        entityId: item.entityId,
        operation: OperationType.fromString(item.operation),
        payload: item.payload,
        clientTimestamp: DateTime.parse(item.createdAt),
      );
      
      // Send to server
      final response = await _apiService.uploadSyncData(request);
      
      if (response.success) {
        // Check for conflicts
        if (response.data!.conflicts > 0) {
          await _handleConflicts(response.data!.results);
        } else {
          // Update status to completed
          await _syncQueue.updateStatus(
            id: item.id,
            status: 'completed',
          );
          
          // Update local entity version if needed
          await _updateLocalVersion(
            item.entityType,
            item.entityId,
            response.data!.results.first.serverTimestamp,
          );
        }
      } else {
        throw Exception(response.error ?? 'Sync failed');
      }
      
    } catch (e) {
      _logger.error('Failed to sync item ${item.id}: $e');
      
      // Increment retry count
      await _syncQueue.incrementRetryCount(item.id);
      
      // Check if max retries exceeded
      if (item.retryCount + 1 >= item.maxRetries) {
        await _syncQueue.updateStatus(
          id: item.id,
          status: 'failed',
          error: e.toString(),
        );
      } else {
        // Schedule retry with exponential backoff
        await _scheduleRetry(item);
      }
    }
  }
  
  // Handle conflicts
  Future<void> _handleConflicts(List<SyncResult> results) async {
    for (final result in results) {
      if (result.status == 'conflict') {
        await _conflictResolver.resolveConflict(
          entityType: result.entityType,
          entityId: result.entityId,
          clientPayload: result.clientPayload!,
          serverPayload: result.serverPayload!,
          strategy: ConflictStrategy.lastWriteWins,
        );
      }
    }
  }
  
  // Schedule retry with exponential backoff
  Future<void> _scheduleRetry(SyncQueueItem item) async {
    final delay = Duration(
      seconds: (2 ^ item.retryCount).clamp(1, 300), // Max 5 minutes
    );
    
    _logger.info(
      'Scheduling retry for item ${item.id} in ${delay.inSeconds} seconds',
    );
    
    await Future.delayed(delay, () => _processSyncItem(item));
  }
  
  // Update local entity version
  Future<void> _updateLocalVersion(
    String entityType,
    UUID entityId,
    DateTime serverTimestamp,
  ) async {
    // Update the entity's version in local database
    // This prevents conflicts on next sync
    await _database.execute(
      '''
      UPDATE $entityType 
      SET version = version + 1, 
          sync_status = 'completed',
          updated_at = ?
      WHERE id = ?
      ''',
      [serverTimestamp.toIso8601String(), entityId],
    );
  }
}
```

```csharp
// .NET/C# Background Sync Service

public class BackgroundSyncService : BackgroundService
{
    private readonly IServiceProvider _serviceProvider;
    private readonly ILogger<BackgroundSyncService> _logger;
    private readonly TimeSpan _syncInterval = TimeSpan.FromMinutes(5);
    
    public BackgroundSyncService(
        IServiceProvider serviceProvider,
        ILogger<BackgroundSyncService> logger)
    {
        _serviceProvider = serviceProvider;
        _logger = logger;
    }
    
    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        while (!stoppingToken.IsCancellationRequested)
        {
            try
            {
                await PerformSyncAsync(stoppingToken);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Sync failed");
            }
            
            await Task.Delay(_syncInterval, stoppingToken);
        }
    }
    
    private async Task PerformSyncAsync(CancellationToken cancellationToken)
    {
        using var scope = _serviceProvider.CreateScope();
        var syncService = scope.ServiceProvider.GetRequiredService<ISyncService>();
        
        // Process pending items
        await syncService.ProcessPendingItemsAsync();
        
        // Clean up old completed items
        await syncService.CleanupOldItemsAsync();
    }
}
```

## 3. Conflict Resolution Implementation

### 3.1 Conflict Detection

```dart
// Flutter/Dart Conflict Detection

class ConflictDetector {
  final Database _database;
  
  ConflictDetector(this._database);
  
  // Detect conflicts before sync
  Future<List<Conflict>> detectConflicts({
    required EntityType entityType,
    required UUID entityId,
    required String clientPayload,
    required DateTime clientTimestamp,
  }) async {
    final conflicts = <Conflict>[];
    
    // Get server version
    final serverResponse = await _apiService.getEntity(
      entityType: entityType,
      entityId: entityId,
    );
    
    if (!serverResponse.success) {
      // Entity doesn't exist on server, no conflict
      return conflicts;
    }
    
    final serverEntity = serverResponse.data;
    final clientEntity = json.decode(clientPayload);
    
    // Check version conflict
    if (serverEntity.version > clientEntity['version']) {
      conflicts.add(Conflict(
        type: ConflictType.version,
        entityType: entityType,
        entityId: entityId,
        clientVersion: clientEntity['version'],
        serverVersion: serverEntity.version,
        clientTimestamp: clientTimestamp,
        serverTimestamp: serverEntity.updatedAt,
      ));
    }
    
    // Check timestamp conflict
    if (serverEntity.updatedAt.isAfter(clientTimestamp)) {
      conflicts.add(Conflict(
        type: ConflictType.timestamp,
        entityType: entityType,
        entityId: entityId,
        clientTimestamp: clientTimestamp,
        serverTimestamp: serverEntity.updatedAt,
      ));
    }
    
    // Check field-level conflicts
    final fieldConflicts = _detectFieldConflicts(
      clientEntity,
      serverEntity.toJson(),
    );
    
    if (fieldConflicts.isNotEmpty) {
      conflicts.add(Conflict(
        type: ConflictType.fieldLevel,
        entityType: entityType,
        entityId: entityId,
        fieldConflicts: fieldConflicts,
      ));
    }
    
    return conflicts;
  }
  
  // Detect field-level conflicts
  List<FieldConflict> _detectFieldConflicts(
    Map<String, dynamic> clientData,
    Map<String, dynamic> serverData,
  ) {
    final fieldConflicts = <FieldConflict>[];
    
    for (final key in clientData.keys) {
      if (serverData.containsKey(key)) {
        if (clientData[key] != serverData[key]) {
          // Skip version and timestamp fields
          if (key != 'version' && key != 'updatedAt' && key != 'syncStatus') {
            fieldConflicts.add(FieldConflict(
              fieldName: key,
              clientValue: clientData[key],
              serverValue: serverData[key],
            ));
          }
        }
      }
    }
    
    return fieldConflicts;
  }
}
```

```csharp
// .NET/C# Conflict Detection

public class ConflictDetector : IConflictDetector
{
    private readonly AppDbContext _context;
    private readonly ILogger<ConflictDetector> _logger;
    
    public ConflictDetector(AppDbContext context, ILogger<ConflictDetector> logger)
    {
        _context = context;
        _logger = logger;
    }
    
    public async Task<List<Conflict>> DetectConflictsAsync(
        EntityType entityType,
        Guid entityId,
        string clientPayload,
        DateTime clientTimestamp)
    {
        var conflicts = new List<Conflict>();
        
        // Get server entity
        var serverEntity = await GetServerEntityAsync(entityType, entityId);
        if (serverEntity == null)
        {
            // Entity doesn't exist on server, no conflict
            return conflicts;
        }
        
        var clientEntity = JsonSerializer.Deserialize<Dictionary<string, object>>(clientPayload);
        
        // Check version conflict
        if (serverEntity.Version > (int)clientEntity["version"])
        {
            conflicts.Add(new Conflict
            {
                Type = ConflictType.Version,
                EntityType = entityType,
                EntityId = entityId,
                ClientVersion = (int)clientEntity["version"],
                ServerVersion = serverEntity.Version,
                ClientTimestamp = clientTimestamp,
                ServerTimestamp = serverEntity.UpdatedAt
            });
        }
        
        // Check timestamp conflict
        if (serverEntity.UpdatedAt > clientTimestamp)
        {
            conflicts.Add(new Conflict
            {
                Type = ConflictType.Timestamp,
                EntityType = entityType,
                EntityId = entityId,
                ClientTimestamp = clientTimestamp,
                ServerTimestamp = serverEntity.UpdatedAt
            });
        }
        
        // Check field-level conflicts
        var fieldConflicts = DetectFieldConflicts(clientEntity, serverEntity);
        if (fieldConflicts.Any())
        {
            conflicts.Add(new Conflict
            {
                Type = ConflictType.FieldLevel,
                EntityType = entityType,
                EntityId = entityId,
                FieldConflicts = fieldConflicts
            });
        }
        
        return conflicts;
    }
    
    private List<FieldConflict> DetectFieldConflicts(
        Dictionary<string, object> clientData,
        BaseEntity serverEntity)
    {
        var fieldConflicts = new List<FieldConflict>();
        var serverData = serverEntity.ToDictionary();
        
        foreach (var key in clientData.Keys)
        {
            if (serverData.ContainsKey(key))
            {
                if (!clientData[key].Equals(serverData[key]))
                {
                    // Skip version and timestamp fields
                    if (key != "Version" && key != "UpdatedAt" && key != "SyncStatus")
                    {
                        fieldConflicts.Add(new FieldConflict
                        {
                            FieldName = key,
                            ClientValue = clientData[key],
                            ServerValue = serverData[key]
                        });
                    }
                }
            }
        }
        
        return fieldConflicts;
    }
    
    private async Task<BaseEntity?> GetServerEntityAsync(
        EntityType entityType,
        Guid entityId)
    {
        return entityType switch
        {
            EntityType.Product => await _context.Products.FindAsync(entityId),
            EntityType.Customer => await _context.Customers.FindAsync(entityId),
            EntityType.Bill => await _context.Bills.FindAsync(entityId),
            EntityType.Stock => await _context.Stocks.FindAsync(entityId),
            _ => null
        };
    }
}
```

### 3.2 Conflict Resolution Strategies

```dart
// Flutter/Dart Conflict Resolution Strategies

class ConflictResolver {
  final Database _database;
  final AuditLogger _auditLogger;
  
  ConflictResolver(this._database, this._auditLogger);
  
  // Resolve conflict using specified strategy
  Future<void> resolveConflict({
    required Conflict conflict,
    required ConflictStrategy strategy,
  }) async {
    switch (strategy) {
      case ConflictStrategy.lastWriteWins:
        await _resolveLastWriteWins(conflict);
        break;
      case ConflictStrategy.fieldLevelMerge:
        await _resolveFieldLevelMerge(conflict);
        break;
      case ConflictStrategy.manualResolution:
        await _queueForManualResolution(conflict);
        break;
      case ConflictStrategy.serverWins:
        await _resolveServerWins(conflict);
        break;
      case ConflictStrategy.clientWins:
        await _resolveClientWins(conflict);
        break;
    }
    
    // Log resolution
    await _auditLogger.logConflictResolution(
      conflict: conflict,
      strategy: strategy,
    );
  }
  
  // Last Write Wins strategy
  Future<void> _resolveLastWriteWins(Conflict conflict) async {
    if (conflict.clientTimestamp.isAfter(conflict.serverTimestamp)) {
      // Client wins - push client version to server
      await _pushToServer(conflict);
    } else {
      // Server wins - pull server version to client
      await _pullFromServer(conflict);
    }
  }
  
  // Field Level Merge strategy
  Future<void> _resolveFieldLevelMerge(Conflict conflict) async {
    if (conflict.fieldConflicts == null || 
        conflict.fieldConflicts!.isEmpty) {
      // No field conflicts, use last write wins
      await _resolveLastWriteWins(conflict);
      return;
    }
    
    // Get both versions
    final clientData = json.decode(conflict.clientPayload!);
    final serverData = await _getServerEntity(
      conflict.entityType,
      conflict.entityId,
    );
    
    // Merge fields
    final mergedData = <String, dynamic>{};
    
    for (final fieldConflict in conflict.fieldConflicts!) {
      // Use client value for client-modified fields
      // Use server value for server-modified fields
      // For both-modified fields, use timestamp-based decision
      
      if (_wasModifiedByClient(fieldConflict, conflict.clientTimestamp)) {
        mergedData[fieldConflict.fieldName] = fieldConflict.clientValue;
      } else {
        mergedData[fieldConflict.fieldName] = fieldConflict.serverValue;
      }
    }
    
    // Update local database with merged data
    await _updateLocalEntity(
      conflict.entityType,
      conflict.entityId,
      mergedData,
    );
    
    // Push merged data to server
    await _pushToServer(conflict, payload: json.encode(mergedData));
  }
  
  // Queue for manual resolution
  Future<void> _queueForManualResolution(Conflict conflict) async {
    await _database.into(_database.conflictQueue).insert(
      ConflictQueueCompanion.insert(
        id: Uuid().v4(),
        entityType: conflict.entityType.value,
        entityId: conflict.entityId,
        clientPayload: conflict.clientPayload ?? '',
        serverPayload: conflict.serverPayload ?? '',
        clientTimestamp: conflict.clientTimestamp.toIso8601String(),
        serverTimestamp: conflict.serverTimestamp.toIso8601String(),
        status: 'pending',
        createdAt: DateTime.now().toIso8601String(),
      ),
    );
  }
  
  // Server Wins strategy
  Future<void> _resolveServerWins(Conflict conflict) async {
    await _pullFromServer(conflict);
  }
  
  // Client Wins strategy
  Future<void> _resolveClientWins(Conflict conflict) async {
    await _pushToServer(conflict);
  }
  
  // Helper: Push to server
  Future<void> _pushToServer(
    Conflict conflict, {
    String? payload,
  }) async {
    final request = SyncUploadRequest(
      entityType: conflict.entityType,
      entityId: conflict.entityId,
      operation: OperationType.update,
      payload: payload ?? conflict.clientPayload!,
      clientTimestamp: conflict.clientTimestamp,
    );
    
    await _apiService.uploadSyncData(request);
  }
  
  // Helper: Pull from server
  Future<void> _pullFromServer(Conflict conflict) async {
    final response = await _apiService.getEntity(
      entityType: conflict.entityType,
      entityId: conflict.entityId,
    );
    
    if (response.success) {
      await _updateLocalEntity(
        conflict.entityType,
        conflict.entityId,
        response.data!.toJson(),
      );
    }
  }
  
  // Helper: Check if field was modified by client
  bool _wasModifiedByClient(
    FieldConflict fieldConflict,
    DateTime clientTimestamp,
  ) {
    // Simple heuristic: if client value is different from server,
    // assume client modified it
    return fieldConflict.clientValue != fieldConflict.serverValue;
  }
}
```

```csharp
// .NET/C# Conflict Resolution Strategies

public class ConflictResolver : IConflictResolver
{
    private readonly AppDbContext _context;
    private readonly IAuditLogger _auditLogger;
    private readonly ILogger<ConflictResolver> _logger;
    
    public ConflictResolver(
        AppDbContext context,
        IAuditLogger auditLogger,
        ILogger<ConflictResolver> logger)
    {
        _context = context;
        _auditLogger = auditLogger;
        _logger = logger;
    }
    
    public async Task ResolveConflictAsync(
        Conflict conflict,
        ConflictStrategy strategy)
    {
        switch (strategy)
        {
            case ConflictStrategy.LastWriteWins:
                await ResolveLastWriteWinsAsync(conflict);
                break;
            case ConflictStrategy.FieldLevelMerge:
                await ResolveFieldLevelMergeAsync(conflict);
                break;
            case ConflictStrategy.ManualResolution:
                await QueueForManualResolutionAsync(conflict);
                break;
            case ConflictStrategy.ServerWins:
                await ResolveServerWinsAsync(conflict);
                break;
            case ConflictStrategy.ClientWins:
                await ResolveClientWinsAsync(conflict);
                break;
        }
        
        await _auditLogger.LogConflictResolutionAsync(conflict, strategy);
    }
    
    private async Task ResolveLastWriteWinsAsync(Conflict conflict)
    {
        if (conflict.ClientTimestamp > conflict.ServerTimestamp)
        {
            // Client wins - push client version to server
            await PushToServerAsync(conflict);
        }
        else
        {
            // Server wins - pull server version to client
            await PullFromServerAsync(conflict);
        }
    }
    
    private async Task ResolveFieldLevelMergeAsync(Conflict conflict)
    {
        if (conflict.FieldConflicts == null || !conflict.FieldConflicts.Any())
        {
            await ResolveLastWriteWinsAsync(conflict);
            return;
        }
        
        var clientData = JsonSerializer.Deserialize<Dictionary<string, object>>(
            conflict.ClientPayload);
        var serverEntity = await GetServerEntityAsync(
            conflict.EntityType, 
            conflict.EntityId);
        
        if (serverEntity == null)
        {
            await PushToServerAsync(conflict);
            return;
        }
        
        var serverData = serverEntity.ToDictionary();
        var mergedData = new Dictionary<string, object>();
        
        foreach (var fieldConflict in conflict.FieldConflicts)
        {
            if (WasModifiedByClient(fieldConflict, conflict.ClientTimestamp))
            {
                mergedData[fieldConflict.FieldName] = fieldConflict.ClientValue;
            }
            else
            {
                mergedData[fieldConflict.FieldName] = fieldConflict.ServerValue;
            }
        }
        
        // Update server with merged data
        await UpdateServerEntityAsync(
            conflict.EntityType,
            conflict.EntityId,
            mergedData);
    }
    
    private async Task QueueForManualResolutionAsync(Conflict conflict)
    {
        var queueItem = new ConflictQueue
        {
            Id = Guid.NewGuid(),
            EntityType = conflict.EntityType,
            EntityId = conflict.EntityId,
            ClientPayload = conflict.ClientPayload,
            ServerPayload = conflict.ServerPayload,
            ClientTimestamp = conflict.ClientTimestamp,
            ServerTimestamp = conflict.ServerTimestamp,
            Status = "pending",
            CreatedAt = DateTime.UtcNow
        };
        
        _context.ConflictQueues.Add(queueItem);
        await _context.SaveChangesAsync();
    }
    
    private async Task ResolveServerWinsAsync(Conflict conflict)
    {
        await PullFromServerAsync(conflict);
    }
    
    private async Task ResolveClientWinsAsync(Conflict conflict)
    {
        await PushToServerAsync(conflict);
    }
    
    private async Task PushToServerAsync(Conflict conflict, string? payload = null)
    {
        // Implementation to push client version to server
        var clientPayload = payload ?? conflict.ClientPayload;
        // Update server entity
    }
    
    private async Task PullFromServerAsync(Conflict conflict)
    {
        // Implementation to pull server version to client
        // This would typically send an update to the mobile app
    }
    
    private async Task<BaseEntity?> GetServerEntityAsync(
        EntityType entityType, 
        Guid entityId)
    {
        return entityType switch
        {
            EntityType.Product => await _context.Products.FindAsync(entityId),
            EntityType.Customer => await _context.Customers.FindAsync(entityId),
            EntityType.Bill => await _context.Bills.FindAsync(entityId),
            _ => null
        };
    }
    
    private bool WasModifiedByClient(FieldConflict fieldConflict, DateTime clientTimestamp)
    {
        return !fieldConflict.ClientValue.Equals(fieldConflict.ServerValue);
    }
}
```

## 4. Network Manager

### 4.1 Network Status Monitoring

```dart
// Flutter/Dart Network Manager

class NetworkManager {
  final Connectivity _connectivity;
  final StreamController<NetworkStatus> _statusController =
      StreamController<NetworkStatus>.broadcast();
  
  Stream<NetworkStatus> get status => _statusController.stream;
  
  NetworkManager(this._connectivity) {
    _connectivity.onConnectivityChanged.listen((result) {
      _statusController.add(_getStatusFromResult(result));
    });
  }
  
  // Get current network status
  Future<NetworkStatus> getCurrentStatus() async {
    final result = await _connectivity.checkConnectivity();
    return _getStatusFromResult(result);
  }
  
  // Check if connected
  Future<bool> get isConnected async {
    final status = await getCurrentStatus();
    return status == NetworkStatus.wifi || 
           status == NetworkStatus.mobile;
  }
  
  // Get connection quality
  Future<ConnectionQuality> getConnectionQuality() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.example.com/health'),
      ).timeout(const Duration(seconds: 5));
      
      if (response.statusCode == 200) {
        final latency = response.headers['x-response-time'];
        if (latency != null) {
          final latencyMs = int.parse(latency);
          if (latencyMs < 100) return ConnectionQuality.excellent;
          if (latencyMs < 300) return ConnectionQuality.good;
          if (latencyMs < 1000) return ConnectionQuality.fair;
          return ConnectionQuality.poor;
        }
      }
    } catch (e) {
      // Ignore errors
    }
    
    return ConnectionQuality.unknown;
  }
  
  NetworkStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        return NetworkStatus.wifi;
      case ConnectivityResult.mobile:
        return NetworkStatus.mobile;
      case ConnectivityResult.ethernet:
        return NetworkStatus.ethernet;
      case ConnectivityResult.bluetooth:
        return NetworkStatus.bluetooth;
      case ConnectivityResult.vpn:
        return NetworkStatus.vpn;
      case ConnectivityResult.other:
        return NetworkStatus.other;
      case ConnectivityResult.none:
        return NetworkStatus.offline;
    }
  }
  
  void dispose() {
    _statusController.close();
  }
}

enum NetworkStatus {
  wifi,
  mobile,
  ethernet,
  bluetooth,
  vpn,
  other,
  offline,
}

enum ConnectionQuality {
  excellent,
  good,
  fair,
  poor,
  unknown,
}
```

```csharp
// .NET/C# Network Manager

public class NetworkManager : INetworkManager
{
    private readonly HttpClient _httpClient;
    private readonly ILogger<NetworkManager> _logger;
    
    public NetworkManager(HttpClient httpClient, ILogger<NetworkManager> logger)
    {
        _httpClient = httpClient;
        _logger = logger;
    }
    
    public async Task<bool> IsConnectedAsync()
    {
        try
        {
            var response = await _httpClient.GetAsync("/health")
                .Timeout(TimeSpan.FromSeconds(5));
            return response.IsSuccessStatusCode;
        }
        catch (Exception ex)
        {
            _logger.LogWarning(ex, "Network connectivity check failed");
            return false;
        }
    }
    
    public async Task<ConnectionQuality> GetConnectionQualityAsync()
    {
        try
        {
            var stopwatch = Stopwatch.StartNew();
            var response = await _httpClient.GetAsync("/health")
                .Timeout(TimeSpan.FromSeconds(5));
            stopwatch.Stop();
            
            if (response.IsSuccessStatusCode)
            {
                var latencyMs = stopwatch.ElapsedMilliseconds;
                
                if (latencyMs < 100) return ConnectionQuality.Excellent;
                if (latencyMs < 300) return ConnectionQuality.Good;
                if (latencyMs < 1000) return ConnectionQuality.Fair;
                return ConnectionQuality.Poor;
            }
        }
        catch (Exception ex)
        {
            _logger.LogWarning(ex, "Connection quality check failed");
        }
        
        return ConnectionQuality.Unknown;
    }
}

public enum ConnectionQuality
{
    Excellent,
    Good,
    Fair,
    Poor,
    Unknown
}
```

## 5. Sync API Implementation

### 5.1 Server-Side Sync Controller

```csharp
// .NET/C# Sync Controller

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class SyncController : ControllerBase
{
    private readonly ISyncService _syncService;
    private readonly IConflictDetector _conflictDetector;
    private readonly IConflictResolver _conflictResolver;
    private readonly ILogger<SyncController> _logger;
    
    public SyncController(
        ISyncService syncService,
        IConflictDetector conflictDetector,
        IConflictResolver conflictResolver,
        ILogger<SyncController> logger)
    {
        _syncService = syncService;
        _conflictDetector = conflictDetector;
        _conflictResolver = conflictResolver;
        _logger = logger;
    }
    
    [HttpPost("upload")]
    public async Task<ActionResult<SyncUploadResponse>> Upload(
        [FromBody] SyncUploadRequest request)
    {
        try
        {
            var results = new List<SyncResult>();
            var conflicts = 0;
            
            foreach (var item in request.Items)
            {
                var result = await ProcessSyncItemAsync(item);
                results.Add(result);
                
                if (result.Status == "conflict")
                {
                    conflicts++;
                }
            }
            
            var response = new SyncUploadResponse
            {
                Success = true,
                Data = new SyncUploadResult
                {
                    Processed = results.Count(r => r.Status == "completed"),
                    Failed = results.Count(r => r.Status == "failed"),
                    Conflicts = conflicts,
                    Results = results
                },
                Message = "Sync upload completed"
            };
            
            return Ok(response);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Sync upload failed");
            return StatusCode(500, new SyncUploadResponse
            {
                Success = false,
                Error = "Sync upload failed"
            });
        }
    }
    
    [HttpPost("download")]
    public async ActionResult<SyncDownloadResponse> Download(
        [FromBody] SyncDownloadRequest request)
    {
        try
        {
            var items = await _syncService.GetSyncItemsAsync(
                request.LastSyncTimestamp,
                request.EntityTypes,
                request.Limit);
            
            var response = new SyncDownloadResponse
            {
                Success = true,
                Data = new SyncDownloadResult
                {
                    Items = items,
                    ServerTimestamp = DateTime.UtcNow,
                    TotalItems = items.Count
                }
            };
            
            return Ok(response);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Sync download failed");
            return StatusCode(500, new SyncDownloadResponse
            {
                Success = false,
                Error = "Sync download failed"
            });
        }
    }
    
    private async Task<SyncResult> ProcessSyncItemAsync(SyncItem item)
    {
        try
        {
            // Detect conflicts
            var conflicts = await _conflictDetector.DetectConflictsAsync(
                item.EntityType,
                item.EntityId,
                item.Payload,
                item.ClientTimestamp);
            
            if (conflicts.Any())
            {
                // Resolve conflicts
                foreach (var conflict in conflicts)
                {
                    await _conflictResolver.ResolveConflictAsync(
                        conflict,
                        ConflictStrategy.LastWriteWins);
                }
            }
            
            // Apply changes
            await _syncService.ApplyChangesAsync(
                item.EntityType,
                item.EntityId,
                item.Operation,
                item.Payload);
            
            return new SyncResult
            {
                EntityType = item.EntityType,
                EntityId = item.EntityId,
                Status = "completed",
                ServerTimestamp = DateTime.UtcNow
            };
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, $"Failed to sync item {item.EntityId}");
            
            return new SyncResult
            {
                EntityType = item.EntityType,
                EntityId = item.EntityId,
                Status = "failed",
                Error = ex.Message
            };
        }
    }
}
```

### 5.2 Sync Service Implementation

```csharp
// .NET/C# Sync Service

public class SyncService : ISyncService
{
    private readonly AppDbContext _context;
    private readonly ILogger<SyncService> _logger;
    
    public SyncService(AppDbContext context, ILogger<SyncService> logger)
    {
        _context = context;
        _logger = logger;
    }
    
    public async Task<List<SyncItem>> GetSyncItemsAsync(
        DateTime lastSyncTimestamp,
        List<string> entityTypes,
        int limit)
    {
        var items = new List<SyncItem>();
        
        foreach (var entityType in entityTypes)
        {
            var entityItems = await GetEntitySyncItemsAsync(
                entityType,
                lastSyncTimestamp,
                limit);
            
            items.AddRange(entityItems);
        }
        
        return items.Take(limit).ToList();
    }
    
    public async Task ApplyChangesAsync(
        EntityType entityType,
        Guid entityId,
        OperationType operation,
        string payload)
    {
        switch (operation)
        {
            case OperationType.Create:
                await CreateEntityAsync(entityType, entityId, payload);
                break;
            case OperationType.Update:
                await UpdateEntityAsync(entityType, entityId, payload);
                break;
            case OperationType.Delete:
                await DeleteEntityAsync(entityType, entityId);
                break;
        }
        
        await _context.SaveChangesAsync();
    }
    
    private async Task<List<SyncItem>> GetEntitySyncItemsAsync(
        string entityType,
        DateTime lastSyncTimestamp,
        int limit)
    {
        return entityType.ToLower() switch
        {
            "product" => await _context.Products
                .Where(p => p.UpdatedAt > lastSyncTimestamp && 
                           p.DeletedAt == null)
                .Take(limit)
                .Select(p => new SyncItem
                {
                    EntityType = EntityType.Product,
                    EntityId = p.Id,
                    Operation = OperationType.Update,
                    Payload = JsonSerializer.Serialize(p),
                    ServerTimestamp = p.UpdatedAt,
                    Version = p.Version
                })
                .ToListAsync(),
            
            "customer" => await _context.Customers
                .Where(c => c.UpdatedAt > lastSyncTimestamp && 
                           c.DeletedAt == null)
                .Take(limit)
                .Select(c => new SyncItem
                {
                    EntityType = EntityType.Customer,
                    EntityId = c.Id,
                    Operation = OperationType.Update,
                    Payload = JsonSerializer.Serialize(c),
                    ServerTimestamp = c.UpdatedAt,
                    Version = c.Version
                })
                .ToListAsync(),
            
            _ => new List<SyncItem>()
        };
    }
    
    private async Task CreateEntityAsync(
        EntityType entityType,
        Guid entityId,
        string payload)
    {
        switch (entityType)
        {
            case EntityType.Product:
                var product = JsonSerializer.Deserialize<Product>(payload);
                if (product != null)
                {
                    product.Id = entityId;
                    product.CreatedAt = DateTime.UtcNow;
                    product.UpdatedAt = DateTime.UtcNow;
                    _context.Products.Add(product);
                }
                break;
            
            case EntityType.Customer:
                var customer = JsonSerializer.Deserialize<Customer>(payload);
                if (customer != null)
                {
                    customer.Id = entityId;
                    customer.CreatedAt = DateTime.UtcNow;
                    customer.UpdatedAt = DateTime.UtcNow;
                    _context.Customers.Add(customer);
                }
                break;
        }
    }
    
    private async Task UpdateEntityAsync(
        EntityType entityType,
        Guid entityId,
        string payload)
    {
        switch (entityType)
        {
            case EntityType.Product:
                var product = await _context.Products.FindAsync(entityId);
                if (product != null)
                {
                    var updatedData = JsonSerializer.Deserialize<Dictionary<string, object>>(payload);
                    // Update fields
                    product.UpdatedAt = DateTime.UtcNow;
                    product.Version++;
                }
                break;
            
            case EntityType.Customer:
                var customer = await _context.Customers.FindAsync(entityId);
                if (customer != null)
                {
                    var updatedData = JsonSerializer.Deserialize<Dictionary<string, object>>(payload);
                    // Update fields
                    customer.UpdatedAt = DateTime.UtcNow;
                    customer.Version++;
                }
                break;
        }
    }
    
    private async Task DeleteEntityAsync(EntityType entityType, Guid entityId)
    {
        switch (entityType)
        {
            case EntityType.Product:
                var product = await _context.Products.FindAsync(entityId);
                if (product != null)
                {
                    product.DeletedAt = DateTime.UtcNow;
                }
                break;
            
            case EntityType.Customer:
                var customer = await _context.Customers.FindAsync(entityId);
                if (customer != null)
                {
                    customer.DeletedAt = DateTime.UtcNow;
                }
                break;
        }
    }
    
    public async Task CleanupOldItemsAsync(int days = 7)
    {
        var cutoffDate = DateTime.UtcNow.AddDays(-days);
        
        var oldItems = await _context.SyncQueues
            .Where(s => s.Status == SyncStatus.Completed && 
                        s.CompletedAt < cutoffDate)
            .ToListAsync();
        
        _context.SyncQueues.RemoveRange(oldItems);
        await _context.SaveChangesAsync();
    }
}
```

This comprehensive sync engine design provides a robust foundation for offline-first operations with intelligent conflict resolution, background syncing, and network management for the SS MART retail ERP system.
