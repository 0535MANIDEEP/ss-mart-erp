# SS MART - Data Types & Entity Definitions

## 1. Core Data Types

### 1.1 Base Types

```dart
// Flutter/Dart Types

// UUID Type
typedef UUID = String;

// DateTime Type (ISO 8601 format)
typedef Timestamp = String; // Format: "2026-07-24T10:30:00Z"

// Money Type (in paise/cents to avoid floating point issues)
typedef Money = int; // Represents amount in smallest currency unit

// Quantity Type
typedef Quantity = double;

// Percentage Type (0-100)
typedef Percentage = double;

// Email Type
typedef Email = String;

// PhoneNumber Type (E.164 format)
typedef PhoneNumber = String;

// GSTIN Type (15 characters)
typedef GSTIN = String;

// HSN Code Type (up to 8 digits)
typedef HSNCode = String;

// Barcode Type (EAN-13 or EAN-8)
typedef Barcode = String;

// SKU Type (Stock Keeping Unit)
typedef SKU = String;
```

```csharp
// .NET/C# Types

// Base Entity Class
public abstract class BaseEntity
{
    public Guid Id { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }
    public int Version { get; set; }
    public string SyncStatus { get; set; }
    public DateTime? DeletedAt { get; set; }
}

// Money Type (in paise/cents)
public struct Money
{
    public long Amount { get; set; }
    public string Currency { get; set; }
    
    public Money(long amount, string currency = "INR")
    {
        Amount = amount;
        Currency = currency;
    }
    
    public static Money operator +(Money a, Money b)
    {
        if (a.Currency != b.Currency)
            throw new InvalidOperationException("Cannot add different currencies");
        return new Money(a.Amount + b.Amount, a.Currency);
    }
    
    public static Money operator -(Money a, Money b)
    {
        if (a.Currency != b.Currency)
            throw new InvalidOperationException("Cannot subtract different currencies");
        return new Money(a.Amount - b.Amount, a.Currency);
    }
    
    public decimal ToDecimal() => Amount / 100m;
    public static Money FromDecimal(decimal amount) => new Money((long)(amount * 100));
}
```

### 1.2 Enum Types

```dart
// Flutter/Dart Enums

// Entity Type for Sync
enum EntityType {
  product,
  customer,
  bill,
  billItem,
  stock,
  stockMovement,
  purchase,
  purchaseItem,
  loyaltyTransaction,
  employee,
  shift,
  attendance,
  auditLog,
  syncQueue,
  settings
}

// Sync Status
enum SyncStatus {
  pending,
  inProgress,
  completed,
  failed,
  cancelled
}

// Payment Mode
enum PaymentMode {
  cash,
  upi,
  card,
  wallet,
  credit,
  mixed,
  bankTransfer,
  cheque
}

// Bill Status
enum BillStatus {
  draft,
  completed,
  cancelled,
  returned,
  partiallyReturned
}

// Stock Movement Type
enum StockMovementType {
  purchase,
  sale,
  return,
  adjustment,
  transfer,
  opening,
  damaged,
  expired
}

// Loyalty Transaction Type
enum LoyaltyTransactionType {
  earn,
  redeem,
  expire,
  adjust,
  bonus,
  referral
}

// User Role
enum UserRole {
  admin,
  manager,
  cashier,
  inventory,
  viewer
}

// Customer Type
enum CustomerType {
  b2c,  // Business to Consumer
  b2b   // Business to Business
}

// Tax Type
enum TaxType {
  gst,
  igst,
  vat,
  none
}

// Unit Type
enum UnitType {
  pcs,    // Pieces
  kg,     // Kilogram
  g,      // Gram
  ltr,    // Liter
  ml,     // Milliliter
  m,      // Meter
  cm,     // Centimeter
  sqft,   // Square Feet
  sqm,    // Square Meter
  box,    // Box
  pack,   // Pack
  dozen,  // Dozen
  quintal // Quintal (100 kg)
}

// Discount Type
enum DiscountType {
  percentage,
  fixed
}

// Attendance Status
enum AttendanceStatus {
  present,
  absent,
  late,
  halfDay,
  onLeave
}

// Shift Status
enum ShiftStatus {
  scheduled,
  inProgress,
  completed,
  cancelled
}

// Report Type
enum ReportType {
  sales,
  purchase,
  inventory,
  financial,
  tax,
  loyalty,
  customer,
  employee
}

// Import Status
enum ImportStatus {
  pending,
  validating,
  validated,
  importing,
  completed,
  failed
}

// Conflict Resolution Strategy
enum ConflictStrategy {
  lastWriteWins,
  fieldLevelMerge,
  manualResolution,
  serverWins,
  clientWins
}
```

```csharp
// .NET/C# Enums

public enum EntityType
{
    Product,
    Customer,
    Bill,
    BillItem,
    Stock,
    StockMovement,
    Purchase,
    PurchaseItem,
    LoyaltyTransaction,
    Employee,
    Shift,
    Attendance,
    AuditLog,
    SyncQueue,
    Settings
}

public enum SyncStatus
{
    Pending,
    InProgress,
    Completed,
    Failed,
    Cancelled
}

public enum PaymentMode
{
    Cash,
    UPI,
    Card,
    Wallet,
    Credit,
    Mixed,
    BankTransfer,
    Cheque
}

public enum BillStatus
{
    Draft,
    Completed,
    Cancelled,
    Returned,
    PartiallyReturned
}

public enum StockMovementType
{
    Purchase,
    Sale,
    Return,
    Adjustment,
    Transfer,
    Opening,
    Damaged,
    Expired
}

public enum LoyaltyTransactionType
{
    Earn,
    Redeem,
    Expire,
    Adjust,
    Bonus,
    Referral
}

public enum UserRole
{
    Admin,
    Manager,
    Cashier,
    Inventory,
    Viewer
}

public enum CustomerType
{
    B2C,
    B2B
}

public enum TaxType
{
    GST,
    IGST,
    VAT,
    None
}

public enum UnitType
{
    Pcs,
    Kg,
    G,
    Ltr,
    Ml,
    M,
    Cm,
    SqFt,
    SqM,
    Box,
    Pack,
    Dozen,
    Quintal
}

public enum DiscountType
{
    Percentage,
    Fixed
}

public enum AttendanceStatus
{
    Present,
    Absent,
    Late,
    HalfDay,
    OnLeave
}

public enum ShiftStatus
{
    Scheduled,
    InProgress,
    Completed,
    Cancelled
}

public enum ReportType
{
    Sales,
    Purchase,
    Inventory,
    Financial,
    Tax,
    Loyalty,
    Customer,
    Employee
}

public enum ImportStatus
{
    Pending,
    Validating,
    Validated,
    Importing,
    Completed,
    Failed
}

public enum ConflictStrategy
{
    LastWriteWins,
    FieldLevelMerge,
    ManualResolution,
    ServerWins,
    ClientWins
}
```

## 2. Entity Definitions

### 2.1 Product Entity

```dart
// Flutter/Dart Product Entity

class ProductEntity {
  final UUID id;
  final String name;
  final SKU? sku;
  final Barcode? barcode;
  final HSNCode hsnCode;
  final UnitType unit;
  final double packSize;
  final Money mrp;
  final Money sellingPrice;
  final Money? purchasePrice;
  final double taxRate;
  final TaxType taxType;
  final UUID? categoryId;
  final UUID? supplierId;
  final int reorderLevel;
  final int currentStock;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final SyncStatus syncStatus;

  ProductEntity({
    required this.id,
    required this.name,
    this.sku,
    this.barcode,
    required this.hsnCode,
    this.unit = UnitType.pcs,
    this.packSize = 1.0,
    required this.mrp,
    required this.sellingPrice,
    this.purchasePrice,
    this.taxRate = 0.0,
    this.taxType = TaxType.gst,
    this.categoryId,
    this.supplierId,
    this.reorderLevel = 10,
    this.currentStock = 0,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
    this.version = 1,
    this.syncStatus = SyncStatus.pending,
  });

  // Computed properties
  bool get isLowStock => currentStock <= reorderLevel;
  bool get isOutOfStock => currentStock <= 0;
  double get taxAmount => sellingPrice.amount * taxRate / 100;
  Money get sellingPriceWithTax => Money(
    amount: sellingPrice.amount + taxAmount.round(),
    currency: sellingPrice.currency,
  );
  double get margin => purchasePrice != null
      ? ((sellingPrice.amount - purchasePrice!.amount) / purchasePrice!.amount * 100)
      : 0.0;
}
```

```csharp
// .NET/C# Product Entity

public class Product : BaseEntity
{
    public string Name { get; set; } = string.Empty;
    public string? SKU { get; set; }
    public string? Barcode { get; set; }
    public string HSNCode { get; set; } = string.Empty;
    public UnitType Unit { get; set; } = UnitType.Pcs;
    public double PackSize { get; set; } = 1.0;
    public Money MRP { get; set; }
    public Money SellingPrice { get; set; }
    public Money? PurchasePrice { get; set; }
    public double TaxRate { get; set; } = 0.0;
    public TaxType TaxType { get; set; } = TaxType.GST;
    public Guid? CategoryId { get; set; }
    public Guid? SupplierId { get; set; }
    public int ReorderLevel { get; set; } = 10;
    public int CurrentStock { get; set; } = 0;
    public bool IsActive { get; set; } = true;
    
    // Navigation properties
    public virtual Category? Category { get; set; }
    public virtual Supplier? Supplier { get; set; }
    public virtual ICollection<Stock> Stocks { get; set; }
    public virtual ICollection<BillItem> BillItems { get; set; }
    public virtual ICollection<PurchaseItem> PurchaseItems { get; set; }
    
    // Computed properties
    public bool IsLowStock => CurrentStock <= ReorderLevel;
    public bool IsOutOfStock => CurrentStock <= 0;
    public decimal TaxAmount => SellingPrice.ToDecimal() * (decimal)TaxRate / 100;
    public Money SellingPriceWithTax => Money.FromDecimal(
        SellingPrice.ToDecimal() + (decimal)TaxAmount);
    public double Margin => PurchasePrice.HasValue
        ? ((SellingPrice.ToDecimal() - PurchasePrice.Value.ToDecimal()) 
            / PurchasePrice.Value.ToDecimal() * 100)
        : 0.0;
}
```

### 2.2 Customer Entity

```dart
// Flutter/Dart Customer Entity

class CustomerEntity {
  final UUID id;
  final String name;
  final PhoneNumber? phone;
  final Email? email;
  final String? address;
  final String? city;
  final String? state;
  final String? pincode;
  final GSTIN? gstin;
  final CustomerType type;
  final Money creditLimit;
  final Money currentBalance;
  final int loyaltyPoints;
  final String? loyaltyCardNumber;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final SyncStatus syncStatus;

  CustomerEntity({
    required this.id,
    required this.name,
    this.phone,
    this.email,
    this.address,
    this.city,
    this.state,
    this.pincode,
    this.gstin,
    this.type = CustomerType.b2c,
    this.creditLimit = const Money(0),
    this.currentBalance = const Money(0),
    this.loyaltyPoints = 0,
    this.loyaltyCardNumber,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
    this.version = 1,
    this.syncStatus = SyncStatus.pending,
  });

  // Computed properties
  bool get isB2B => type == CustomerType.b2b;
  bool get hasCreditLimit => creditLimit.amount > 0;
  bool get hasOutstanding => currentBalance.amount > 0;
  bool get canPurchaseOnCredit => 
      hasCreditLimit && currentBalance.amount < creditLimit.amount;
  double get creditUtilization => 
      hasCreditLimit ? (currentBalance.amount / creditLimit.amount * 100) : 0.0;
}
```

```csharp
// .NET/C# Customer Entity

public class Customer : BaseEntity
{
    public string Name { get; set; } = string.Empty;
    public string? Phone { get; set; }
    public string? Email { get; set; }
    public string? Address { get; set; }
    public string? City { get; set; }
    public string? State { get; set; }
    public string? Pincode { get; set; }
    public string? GSTIN { get; set; }
    public CustomerType Type { get; set; } = CustomerType.B2C;
    public Money CreditLimit { get; set; }
    public Money CurrentBalance { get; set; }
    public int LoyaltyPoints { get; set; } = 0;
    public string? LoyaltyCardNumber { get; set; }
    public bool IsActive { get; set; } = true;
    
    // Navigation properties
    public virtual ICollection<Bill> Bills { get; set; }
    public virtual ICollection<LoyaltyTransaction> LoyaltyTransactions { get; set; }
    
    // Computed properties
    public bool IsB2B => Type == CustomerType.B2B;
    public bool HasCreditLimit => CreditLimit.Amount > 0;
    public bool HasOutstanding => CurrentBalance.Amount > 0;
    public bool CanPurchaseOnCredit => 
        HasCreditLimit && CurrentBalance.Amount < CreditLimit.Amount;
    public double CreditUtilization => 
        HasCreditLimit ? (double)(CurrentBalance.Amount / CreditLimit.Amount * 100) : 0.0;
}
```

### 2.3 Bill Entity

```dart
// Flutter/Dart Bill Entity

class BillEntity {
  final UUID id;
  final String billNumber;
  final String? invoiceNumber;
  final UUID? customerId;
  final DateTime billDate;
  final DateTime? dueDate;
  final Money subtotal;
  final Money taxAmount;
  final Money discountAmount;
  final Money roundOff;
  final Money totalAmount;
  final Money paidAmount;
  final Money dueAmount;
  final PaymentMode paymentMode;
  final BillStatus status;
  final bool isReturn;
  final UUID? referenceBillId;
  final UUID createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final SyncStatus syncStatus;

  BillEntity({
    required this.id,
    required this.billNumber,
    this.invoiceNumber,
    this.customerId,
    required this.billDate,
    this.dueDate,
    required this.subtotal,
    this.taxAmount = const Money(0),
    this.discountAmount = const Money(0),
    this.roundOff = const Money(0),
    required this.totalAmount,
    this.paidAmount = const Money(0),
    this.dueAmount = const Money(0),
    this.paymentMode = PaymentMode.cash,
    this.status = BillStatus.completed,
    this.isReturn = false,
    this.referenceBillId,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.version = 1,
    this.syncStatus = SyncStatus.pending,
  });

  // Computed properties
  bool get isFullyPaid => dueAmount.amount == 0;
  bool get isPartialPayment => paidAmount.amount > 0 && dueAmount.amount > 0;
  bool get isCreditSale => paymentMode == PaymentMode.credit;
  bool get isReturnBill => isReturn;
  Money get netAmount => subtotal + taxAmount - discountAmount + roundOff;
}
```

```csharp
// .NET/C# Bill Entity

public class Bill : BaseEntity
{
    public string BillNumber { get; set; } = string.Empty;
    public string? InvoiceNumber { get; set; }
    public Guid? CustomerId { get; set; }
    public DateTime BillDate { get; set; }
    public DateTime? DueDate { get; set; }
    public Money Subtotal { get; set; }
    public Money TaxAmount { get; set; }
    public Money DiscountAmount { get; set; }
    public Money RoundOff { get; set; }
    public Money TotalAmount { get; set; }
    public Money PaidAmount { get; set; }
    public Money DueAmount { get; set; }
    public PaymentMode PaymentMode { get; set; }
    public BillStatus Status { get; set; }
    public bool IsReturn { get; set; }
    public Guid? ReferenceBillId { get; set; }
    public Guid CreatedBy { get; set; }
    
    // Navigation properties
    public virtual Customer? Customer { get; set; }
    public virtual Employee? Creator { get; set; }
    public virtual Bill? ReferenceBill { get; set; }
    public virtual ICollection<BillItem> Items { get; set; }
    public virtual ICollection<Payment> Payments { get; set; }
    
    // Computed properties
    public bool IsFullyPaid => DueAmount.Amount == 0;
    public bool IsPartialPayment => PaidAmount.Amount > 0 && DueAmount.Amount > 0;
    public bool IsCreditSale => PaymentMode == PaymentMode.Credit;
    public bool IsReturnBill => IsReturn;
    public Money NetAmount => Subtotal + TaxAmount - DiscountAmount + RoundOff;
}
```

### 2.4 Bill Item Entity

```dart
// Flutter/Dart Bill Item Entity

class BillItemEntity {
  final UUID id;
  final UUID billId;
  final UUID productId;
  final Quantity quantity;
  final Money unitPrice;
  final Percentage discountPercent;
  final Money discountAmount;
  final Money taxAmount;
  final Money totalAmount;
  final String? batchNumber;
  final DateTime? expiryDate;
  final DateTime createdAt;

  BillItemEntity({
    required this.id,
    required this.billId,
    required this.productId,
    required this.quantity,
    required this.unitPrice,
    this.discountPercent = 0.0,
    this.discountAmount = const Money(0),
    this.taxAmount = const Money(0),
    required this.totalAmount,
    this.batchNumber,
    this.expiryDate,
    required this.createdAt,
  });

  // Computed properties
  Money get subtotal => Money(
    amount: (unitPrice.amount * quantity).round(),
    currency: unitPrice.currency,
  );
  Money get netAmount => subtotal - discountAmount + taxAmount;
  bool get hasDiscount => discountAmount.amount > 0;
  bool hasBatch => batchNumber != null;
  bool get isExpired => expiryDate != null && expiryDate!.isBefore(DateTime.now());
}
```

```csharp
// .NET/C# Bill Item Entity

public class BillItem : BaseEntity
{
    public Guid BillId { get; set; }
    public Guid ProductId { get; set; }
    public double Quantity { get; set; }
    public Money UnitPrice { get; set; }
    public double DiscountPercent { get; set; }
    public Money DiscountAmount { get; set; }
    public Money TaxAmount { get; set; }
    public Money TotalAmount { get; set; }
    public string? BatchNumber { get; set; }
    public DateTime? ExpiryDate { get; set; }
    
    // Navigation properties
    public virtual Bill Bill { get; set; }
    public virtual Product Product { get; set; }
    
    // Computed properties
    public Money Subtotal => Money.FromDecimal(UnitPrice.ToDecimal() * (decimal)Quantity);
    public Money NetAmount => Subtotal - DiscountAmount + TaxAmount;
    public bool HasDiscount => DiscountAmount.Amount > 0;
    public bool HasBatch => !string.IsNullOrEmpty(BatchNumber);
    public bool IsExpired => ExpiryDate.HasValue && ExpiryDate.Value < DateTime.UtcNow;
}
```

### 2.5 Stock Entity

```dart
// Flutter/Dart Stock Entity

class StockEntity {
  final UUID id;
  final UUID productId;
  final String locationId;
  final int quantity;
  final int reservedQuantity;
  final String? batchNumber;
  final DateTime? expiryDate;
  final DateTime lastUpdated;

  StockEntity({
    required this.id,
    required this.productId,
    this.locationId = 'MAIN',
    required this.quantity,
    this.reservedQuantity = 0,
    this.batchNumber,
    this.expiryDate,
    required this.lastUpdated,
  });

  // Computed properties
  int get availableQuantity => quantity - reservedQuantity;
  bool get isLowStock => availableQuantity <= 0;
  bool hasBatch => batchNumber != null;
  bool get isExpired => expiryDate != null && expiryDate!.isBefore(DateTime.now());
  bool get isNearExpiry => expiryDate != null && 
      expiryDate!.difference(DateTime.now()).inDays <= 30;
}
```

```csharp
// .NET/C# Stock Entity

public class Stock : BaseEntity
{
    public Guid ProductId { get; set; }
    public string LocationId { get; set; } = "MAIN";
    public int Quantity { get; set; }
    public int ReservedQuantity { get; set; } = 0;
    public string? BatchNumber { get; set; }
    public DateTime? ExpiryDate { get; set; }
    public DateTime LastUpdated { get; set; }
    
    // Navigation properties
    public virtual Product Product { get; set; }
    public virtual Location? Location { get; set; }
    
    // Computed properties
    public int AvailableQuantity => Quantity - ReservedQuantity;
    public bool IsLowStock => AvailableQuantity <= 0;
    public bool HasBatch => !string.IsNullOrEmpty(BatchNumber);
    public bool IsExpired => ExpiryDate.HasValue && ExpiryDate.Value < DateTime.UtcNow;
    public bool IsNearExpiry => ExpiryDate.HasValue && 
        ExpiryDate.Value.Date.AddDays(30) >= DateTime.UtcNow;
}
```

### 2.6 Stock Movement Entity

```dart
// Flutter/Dart Stock Movement Entity

class StockMovementEntity {
  final UUID id;
  final UUID productId;
  final StockMovementType movementType;
  final Quantity quantity;
  final String? referenceType;
  final UUID? referenceId;
  final String? notes;
  final UUID createdBy;
  final DateTime createdAt;

  StockMovementEntity({
    required this.id,
    required this.productId,
    required this.movementType,
    required this.quantity,
    this.referenceType,
    this.referenceId,
    this.notes,
    required this.createdBy,
    required this.createdAt,
  });

  // Computed properties
  bool get isInward => [
    StockMovementType.purchase,
    StockMovementType.return,
    StockMovementType.opening,
    StockMovementType.adjustment
  ].contains(movementType);
  
  bool get isOutward => [
    StockMovementType.sale,
    StockMovementType.damaged,
    StockMovementType.expired
  ].contains(movementType);
}
```

```csharp
// .NET/C# Stock Movement Entity

public class StockMovement : BaseEntity
{
    public Guid ProductId { get; set; }
    public StockMovementType MovementType { get; set; }
    public double Quantity { get; set; }
    public string? ReferenceType { get; set; }
    public Guid? ReferenceId { get; set; }
    public string? Notes { get; set; }
    public Guid CreatedBy { get; set; }
    
    // Navigation properties
    public virtual Product Product { get; set; }
    public virtual Employee Creator { get; set; }
    
    // Computed properties
    public bool IsInward => new[]
    {
        StockMovementType.Purchase,
        StockMovementType.Return,
        StockMovementType.Opening,
        StockMovementType.Adjustment
    }.Contains(MovementType);
    
    public bool IsOutward => new[]
    {
        StockMovementType.Sale,
        StockMovementType.Damaged,
        StockMovementType.Expired
    }.Contains(MovementType);
}
```

### 2.7 Loyalty Transaction Entity

```dart
// Flutter/Dart Loyalty Transaction Entity

class LoyaltyTransactionEntity {
  final UUID id;
  final UUID customerId;
  final LoyaltyTransactionType transactionType;
  final int points;
  final String? referenceType;
  final UUID? referenceId;
  final DateTime? expiryDate;
  final String? notes;
  final UUID createdBy;
  final DateTime createdAt;

  LoyaltyTransactionEntity({
    required this.id,
    required this.customerId,
    required this.transactionType,
    required this.points,
    this.referenceType,
    this.referenceId,
    this.expiryDate,
    this.notes,
    required this.createdBy,
    required this.createdAt,
  });

  // Computed properties
  bool get isEarn => transactionType == LoyaltyTransactionType.earn;
  bool get isRedeem => transactionType == LoyaltyTransactionType.redeem;
  bool get isExpired => expiryDate != null && expiryDate!.isBefore(DateTime.now());
  bool get hasReference => referenceType != null && referenceId != null;
  int get netPoints => isEarn ? points : -points;
}
```

```csharp
// .NET/C# Loyalty Transaction Entity

public class LoyaltyTransaction : BaseEntity
{
    public Guid CustomerId { get; set; }
    public LoyaltyTransactionType TransactionType { get; set; }
    public int Points { get; set; }
    public string? ReferenceType { get; set; }
    public Guid? ReferenceId { get; set; }
    public DateTime? ExpiryDate { get; set; }
    public string? Notes { get; set; }
    public Guid CreatedBy { get; set; }
    
    // Navigation properties
    public virtual Customer Customer { get; set; }
    public virtual Employee Creator { get; set; }
    
    // Computed properties
    public bool IsEarn => TransactionType == LoyaltyTransactionType.Earn;
    public bool IsRedeem => TransactionType == LoyaltyTransactionType.Redeem;
    public bool IsExpired => ExpiryDate.HasValue && ExpiryDate.Value < DateTime.UtcNow;
    public bool HasReference => !string.IsNullOrEmpty(ReferenceType) && ReferenceId.HasValue;
    public int NetPoints => IsEarn ? Points : -Points;
}
```

### 2.8 Employee Entity

```dart
// Flutter/Dart Employee Entity

class EmployeeEntity {
  final UUID id;
  final String name;
  final PhoneNumber? phone;
  final Email? email;
  final UserRole role;
  final String? pin;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final SyncStatus syncStatus;

  EmployeeEntity({
    required this.id,
    required this.name,
    this.phone,
    this.email,
    this.role = UserRole.cashier,
    this.pin,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
    this.version = 1,
    this.syncStatus = SyncStatus.pending,
  });

  // Computed properties
  bool get isAdmin => role == UserRole.admin;
  bool get isManager => role == UserRole.manager;
  bool get isCashier => role == UserRole.cashier;
  bool get isInventory => role == UserRole.inventory;
  bool get hasPin => pin != null && pin!.isNotEmpty;
}
```

```csharp
// .NET/C# Employee Entity

public class Employee : BaseEntity
{
    public string Name { get; set; } = string.Empty;
    public string? Phone { get; set; }
    public string? Email { get; set; }
    public UserRole Role { get; set; } = UserRole.Cashier;
    public string? Pin { get; set; }
    public bool IsActive { get; set; } = true;
    
    // Navigation properties
    public virtual ICollection<Shift> Shifts { get; set; }
    public virtual ICollection<Attendance> Attendances { get; set; }
    public virtual ICollection<Bill> Bills { get; set; }
    
    // Computed properties
    public bool IsAdmin => Role == UserRole.Admin;
    public bool IsManager => Role == UserRole.Manager;
    public bool IsCashier => Role == UserRole.Cashier;
    public bool IsInventory => Role == UserRole.Inventory;
    public bool HasPin => !string.IsNullOrEmpty(Pin);
}
```

### 2.9 Shift Entity

```dart
// Flutter/Dart Shift Entity

class ShiftEntity {
  final UUID id;
  final UUID employeeId;
  final DateTime shiftDate;
  final DateTime? startTime;
  final DateTime? endTime;
  final ShiftStatus status;
  final DateTime createdAt;

  ShiftEntity({
    required this.id,
    required this.employeeId,
    required this.shiftDate,
    this.startTime,
    this.endTime,
    this.status = ShiftStatus.scheduled,
    required this.createdAt,
  });

  // Computed properties
  bool get isScheduled => status == ShiftStatus.scheduled;
  bool get isInProgress => status == ShiftStatus.inProgress;
  bool get isCompleted => status == ShiftStatus.completed;
  Duration? get duration => 
      startTime != null && endTime != null 
          ? endTime!.difference(startTime!) 
          : null;
}
```

```csharp
// .NET/C# Shift Entity

public class Shift : BaseEntity
{
    public Guid EmployeeId { get; set; }
    public DateTime ShiftDate { get; set; }
    public DateTime? StartTime { get; set; }
    public DateTime? EndTime { get; set; }
    public ShiftStatus Status { get; set; } = ShiftStatus.Scheduled;
    
    // Navigation properties
    public virtual Employee Employee { get; set; }
    
    // Computed properties
    public bool IsScheduled => Status == ShiftStatus.Scheduled;
    public bool IsInProgress => Status == ShiftStatus.InProgress;
    public bool IsCompleted => Status == ShiftStatus.Completed;
    public TimeSpan? Duration => 
        StartTime.HasValue && EndTime.HasValue 
            ? EndTime.Value - StartTime.Value 
            : null;
}
```

### 2.10 Attendance Entity

```dart
// Flutter/Dart Attendance Entity

class AttendanceEntity {
  final UUID id;
  final UUID employeeId;
  final DateTime attendanceDate;
  final DateTime? clockIn;
  final DateTime? clockOut;
  final AttendanceStatus status;
  final String? notes;
  final DateTime createdAt;

  AttendanceEntity({
    required this.id,
    required this.employeeId,
    required this.attendanceDate,
    this.clockIn,
    this.clockOut,
    this.status = AttendanceStatus.present,
    this.notes,
    required this.createdAt,
  });

  // Computed properties
  bool get isPresent => status == AttendanceStatus.present;
  bool get isAbsent => status == AttendanceStatus.absent;
  bool get isLate => status == AttendanceStatus.late;
  bool get isOnLeave => status == AttendanceStatus.onLeave;
  Duration? get workDuration => 
      clockIn != null && clockOut != null 
          ? clockOut!.difference(clockIn!) 
          : null;
}
```

```csharp
// .NET/C# Attendance Entity

public class Attendance : BaseEntity
{
    public Guid EmployeeId { get; set; }
    public DateTime AttendanceDate { get; set; }
    public DateTime? ClockIn { get; set; }
    public DateTime? ClockOut { get; set; }
    public AttendanceStatus Status { get; set; } = AttendanceStatus.Present;
    public string? Notes { get; set; }
    
    // Navigation properties
    public virtual Employee Employee { get; set; }
    
    // Computed properties
    public bool IsPresent => Status == AttendanceStatus.Present;
    public bool IsAbsent => Status == AttendanceStatus.Absent;
    public bool IsLate => Status == AttendanceStatus.Late;
    public bool IsOnLeave => Status == AttendanceStatus.OnLeave;
    public TimeSpan? WorkDuration => 
        ClockIn.HasValue && ClockOut.HasValue 
            ? ClockOut.Value - ClockIn.Value 
            : null;
}
```

### 2.11 Sync Queue Entity

```dart
// Flutter/Dart Sync Queue Entity

class SyncQueueEntity {
  final UUID id;
  final EntityType entityType;
  final UUID entityId;
  final OperationType operation;
  final String payload;
  final SyncStatus status;
  final int retryCount;
  final int maxRetries;
  final DateTime createdAt;
  final DateTime? lastAttemptAt;
  final DateTime? completedAt;
  final String? error;

  SyncQueueEntity({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.operation,
    required this.payload,
    this.status = SyncStatus.pending,
    this.retryCount = 0,
    this.maxRetries = 3,
    required this.createdAt,
    this.lastAttemptAt,
    this.completedAt,
    this.error,
  });

  // Computed properties
  bool get isPending => status == SyncStatus.pending;
  bool get isInProgress => status == SyncStatus.inProgress;
  bool get isCompleted => status == SyncStatus.completed;
  bool get isFailed => status == SyncStatus.failed;
  bool get canRetry => retryCount < maxRetries;
  bool get hasExceededRetries => retryCount >= maxRetries;
}
```

```csharp
// .NET/C# Sync Queue Entity

public class SyncQueue : BaseEntity
{
    public EntityType EntityType { get; set; }
    public Guid EntityId { get; set; }
    public OperationType Operation { get; set; }
    public string Payload { get; set; } = string.Empty;
    public SyncStatus Status { get; set; } = SyncStatus.Pending;
    public int RetryCount { get; set; } = 0;
    public int MaxRetries { get; set; } = 3;
    public DateTime? LastAttemptAt { get; set; }
    public DateTime? CompletedAt { get; set; }
    public string? Error { get; set; }
    
    // Computed properties
    public bool IsPending => Status == SyncStatus.Pending;
    public bool IsInProgress => Status == SyncStatus.InProgress;
    public bool IsCompleted => Status == SyncStatus.Completed;
    public bool IsFailed => Status == SyncStatus.Failed;
    public bool CanRetry => RetryCount < MaxRetries;
    public bool HasExceededRetries => RetryCount >= MaxRetries;
}
```

### 2.12 Audit Log Entity

```dart
// Flutter/Dart Audit Log Entity

class AuditLogEntity {
  final UUID id;
  final UUID? userId;
  final String action;
  final String? entityType;
  final UUID? entityId;
  final String? oldValue;
  final String? newValue;
  final String? ipAddress;
  final String? deviceId;
  final DateTime createdAt;

  AuditLogEntity({
    required this.id,
    this.userId,
    required this.action,
    this.entityType,
    this.entityId,
    this.oldValue,
    this.newValue,
    this.ipAddress,
    this.deviceId,
    required this.createdAt,
  });

  // Computed properties
  bool get hasUser => userId != null;
  bool get hasEntity => entityType != null && entityId != null;
  bool get hasChanges => oldValue != null || newValue != null;
  bool get hasDeviceInfo => ipAddress != null || deviceId != null;
}
```

```csharp
// .NET/C# Audit Log Entity

public class AuditLog : BaseEntity
{
    public Guid? UserId { get; set; }
    public string Action { get; set; } = string.Empty;
    public string? EntityType { get; set; }
    public Guid? EntityId { get; set; }
    public string? OldValue { get; set; }
    public string? NewValue { get; set; }
    public string? IpAddress { get; set; }
    public string? DeviceId { get; set; }
    
    // Navigation properties
    public virtual Employee? User { get; set; }
    
    // Computed properties
    public bool HasUser => UserId.HasValue;
    public bool HasEntity => !string.IsNullOrEmpty(EntityType) && EntityId.HasValue;
    public bool HasChanges => !string.IsNullOrEmpty(OldValue) || !string.IsNullOrEmpty(NewValue);
    public bool HasDeviceInfo => !string.IsNullOrEmpty(IpAddress) || !string.IsNullOrEmpty(DeviceId);
}
```

### 2.13 Settings Entity

```dart
// Flutter/Dart Settings Entity

class SettingsEntity {
  final UUID id;
  final String key;
  final String value;
  final String? category;
  final DateTime updatedAt;

  SettingsEntity({
    required this.id,
    required this.key,
    required this.value,
    this.category,
    required this.updatedAt,
  });

  // Computed properties
  bool get hasCategory => category != null && category!.isNotEmpty;
  
  // Type conversion helpers
  String get stringValue => value;
  int? get intValue => int.tryParse(value);
  double? get doubleValue => double.tryParse(value);
  bool? get boolValue => value.toLowerCase() == 'true' ? true : 
      value.toLowerCase() == 'false' ? false : null;
}
```

```csharp
// .NET/C# Settings Entity

public class Settings : BaseEntity
{
    public string Key { get; set; } = string.Empty;
    public string Value { get; set; } = string.Empty;
    public string? Category { get; set; }
    
    // Computed properties
    public bool HasCategory => !string.IsNullOrEmpty(Category);
    
    // Type conversion helpers
    public string StringValue => Value;
    public int? IntValue => int.TryParse(Value, out var result) ? result : null;
    public double? DoubleValue => double.TryParse(Value, out var result) ? result : null;
    public bool? BoolValue => Value.ToLowerInvariant() switch
    {
        "true" => true,
        "false" => false,
        _ => null
    };
}
```

## 3. Complex Types

### 3.1 GST Calculation Type

```dart
// Flutter/Dart GST Calculation Type

class GSTCalculation {
  final Money basePrice;
  final double cgstRate;
  final double sgstRate;
  final double igstRate;
  final Money cgstAmount;
  final Money sgstAmount;
  final Money igstAmount;
  final Money totalTax;
  final Money priceWithTax;

  GSTCalculation({
    required this.basePrice,
    required this.cgstRate,
    required this.sgstRate,
    required this.igstRate,
    required this.cgstAmount,
    required this.sgstAmount,
    required this.igstAmount,
    required this.totalTax,
    required this.priceWithTax,
  });

  factory GSTCalculation.calculate({
    required Money basePrice,
    required double taxRate,
    required bool isInterstate,
  }) {
    final cgstRate = isInterstate ? 0.0 : taxRate / 2;
    final sgstRate = isInterstate ? 0.0 : taxRate / 2;
    final igstRate = isInterstate ? taxRate : 0.0;
    
    final cgstAmount = Money(
      amount: (basePrice.amount * cgstRate / 100).round(),
      currency: basePrice.currency,
    );
    final sgstAmount = Money(
      amount: (basePrice.amount * sgstRate / 100).round(),
      currency: basePrice.currency,
    );
    final igstAmount = Money(
      amount: (basePrice.amount * igstRate / 100).round(),
      currency: basePrice.currency,
    );
    
    final totalTax = cgstAmount + sgstAmount + igstAmount;
    final priceWithTax = basePrice + totalTax;
    
    return GSTCalculation(
      basePrice: basePrice,
      cgstRate: cgstRate,
      sgstRate: sgstRate,
      igstRate: igstRate,
      cgstAmount: cgstAmount,
      sgstAmount: sgstAmount,
      igstAmount: igstAmount,
      totalTax: totalTax,
      priceWithTax: priceWithTax,
    );
  }
}
```

```csharp
// .NET/C# GST Calculation Type

public record GSTCalculation
{
    public Money BasePrice { get; init; }
    public double CgstRate { get; init; }
    public double SgstRate { get; init; }
    public double IgstRate { get; init; }
    public Money CgstAmount { get; init; }
    public Money SgstAmount { get; init; }
    public Money IgstAmount { get; init; }
    public Money TotalTax { get; init; }
    public Money PriceWithTax { get; init; }
    
    public static GSTCalculation Calculate(
        Money basePrice,
        double taxRate,
        bool isInterstate)
    {
        var cgstRate = isInterstate ? 0.0 : taxRate / 2;
        var sgstRate = isInterstate ? 0.0 : taxRate / 2;
        var igstRate = isInterstate ? taxRate : 0.0;
        
        var cgstAmount = Money.FromDecimal(
            basePrice.ToDecimal() * (decimal)cgstRate / 100);
        var sgstAmount = Money.FromDecimal(
            basePrice.ToDecimal() * (decimal)sgstRate / 100);
        var igstAmount = Money.FromDecimal(
            basePrice.ToDecimal() * (decimal)igstRate / 100);
        
        var totalTax = cgstAmount + sgstAmount + igstAmount;
        var priceWithTax = basePrice + totalTax;
        
        return new GSTCalculation
        {
            BasePrice = basePrice,
            CgstRate = cgstRate,
            SgstRate = sgstRate,
            IgstRate = igstRate,
            CgstAmount = cgstAmount,
            SgstAmount = sgstAmount,
            IgstAmount = igstAmount,
            TotalTax = totalTax,
            PriceWithTax = priceWithTax
        };
    }
}
```

### 3.2 Bill Summary Type

```dart
// Flutter/Dart Bill Summary Type

class BillSummary {
  final int totalItems;
  final Quantity totalQuantity;
  final Money subtotal;
  final Money totalDiscount;
  final Money totalTax;
  final Money roundOff;
  final Money grandTotal;
  final Money paidAmount;
  final Money dueAmount;
  final Map<String, Money> taxBreakdown;

  BillSummary({
    required this.totalItems,
    required this.totalQuantity,
    required this.subtotal,
    required this.totalDiscount,
    required this.totalTax,
    required this.roundOff,
    required this.grandTotal,
    required this.paidAmount,
    required this.dueAmount,
    required this.taxBreakdown,
  });
}
```

```csharp
// .NET/C# Bill Summary Type

public record BillSummary
{
    public int TotalItems { get; init; }
    public double TotalQuantity { get; init; }
    public Money Subtotal { get; init; }
    public Money TotalDiscount { get; init; }
    public Money TotalTax { get; init; }
    public Money RoundOff { get; init; }
    public Money GrandTotal { get; init; }
    public Money PaidAmount { get; init; }
    public Money DueAmount { get; init; }
    public Dictionary<string, Money> TaxBreakdown { get; init; }
}
```

### 3.3 Stock Summary Type

```dart
// Flutter/Dart Stock Summary Type

class StockSummary {
  final UUID productId;
  final String productName;
  final int totalQuantity;
  final int reservedQuantity;
  final int availableQuantity;
  final int reorderLevel;
  final bool isLowStock;
  final bool isOutOfStock;
  final List<StockBatch> batches;

  StockSummary({
    required this.productId,
    required this.productName,
    required this.totalQuantity,
    required this.reservedQuantity,
    required this.availableQuantity,
    required this.reorderLevel,
    required this.isLowStock,
    required this.isOutOfStock,
    required this.batches,
  });
}

class StockBatch {
  final String? batchNumber;
  final int quantity;
  final DateTime? expiryDate;
  final String locationId;

  StockBatch({
    this.batchNumber,
    required this.quantity,
    this.expiryDate,
    required this.locationId,
  });
}
```

```csharp
// .NET/C# Stock Summary Type

public record StockSummary
{
    public Guid ProductId { get; init; }
    public string ProductName { get; init; }
    public int TotalQuantity { get; init; }
    public int ReservedQuantity { get; init; }
    public int AvailableQuantity { get; init; }
    public int ReorderLevel { get; init; }
    public bool IsLowStock { get; init; }
    public bool IsOutOfStock { get; init; }
    public List<StockBatch> Batches { get; init; }
}

public record StockBatch
{
    public string? BatchNumber { get; init; }
    public int Quantity { get; init; }
    public DateTime? ExpiryDate { get; init; }
    public string LocationId { get; init; }
}
```

### 3.4 Loyalty Balance Type

```dart
// Flutter/Dart Loyalty Balance Type

class LoyaltyBalance {
  final UUID customerId;
  final String customerName;
  final int totalPointsEarned;
  final int totalPointsRedeemed;
  final int currentBalance;
  final int pendingPoints;
  final int expiringPoints;
  final DateTime? nextExpiryDate;
  final List<LoyaltyTransaction> recentTransactions;

  LoyaltyBalance({
    required this.customerId,
    required this.customerName,
    required this.totalPointsEarned,
    required this.totalPointsRedeemed,
    required this.currentBalance,
    required this.pendingPoints,
    required this.expiringPoints,
    this.nextExpiryDate,
    required this.recentTransactions,
  });
}
```

```csharp
// .NET/C# Loyalty Balance Type

public record LoyaltyBalance
{
    public Guid CustomerId { get; init; }
    public string CustomerName { get; init; }
    public int TotalPointsEarned { get; init; }
    public int TotalPointsRedeemed { get; init; }
    public int CurrentBalance { get; init; }
    public int PendingPoints { get; init; }
    public int ExpiringPoints { get; init; }
    public DateTime? NextExpiryDate { get; init; }
    public List<LoyaltyTransaction> RecentTransactions { get; init; }
}
```

## 4. Request/Response Types

### 4.1 API Request Types

```dart
// Flutter/Dart API Request Types

class LoginRequest {
  final String username;
  final String password;
  final String? deviceId;

  LoginRequest({
    required this.username,
    required this.password,
    this.deviceId,
  });
}

class CreateBillRequest {
  final UUID? customerId;
  final DateTime billDate;
  final List<BillItemRequest> items;
  final PaymentMode paymentMode;
  final Money? paidAmount;
  final String? notes;

  CreateBillRequest({
    this.customerId,
    required this.billDate,
    required this.items,
    this.paymentMode = PaymentMode.cash,
    this.paidAmount,
    this.notes,
  });
}

class BillItemRequest {
  final UUID productId;
  final Quantity quantity;
  final Money? unitPrice;
  final double? discountPercent;
  final Money? discountAmount;
  final String? batchNumber;

  BillItemRequest({
    required this.productId,
    required this.quantity,
    this.unitPrice,
    this.discountPercent,
    this.discountAmount,
    this.batchNumber,
  });
}

class SyncUploadRequest {
  final EntityType entityType;
  final UUID entityId;
  final OperationType operation;
  final String payload;
  final DateTime clientTimestamp;

  SyncUploadRequest({
    required this.entityType,
    required this.entityId,
    required this.operation,
    required this.payload,
    required this.clientTimestamp,
  });
}

class ImportProductsRequest {
  final String fileUrl;
  final String? mappingTemplate;
  final bool updateExisting;
  final bool skipDuplicates;

  ImportProductsRequest({
    required this.fileUrl,
    this.mappingTemplate,
    this.updateExisting = false,
    this.skipDuplicates = true,
  });
}
```

```csharp
// .NET/C# API Request Types

public record LoginRequest
{
    public string Username { get; init; }
    public string Password { get; init; }
    public string? DeviceId { get; init; }
}

public record CreateBillRequest
{
    public Guid? CustomerId { get; init; }
    public DateTime BillDate { get; init; }
    public List<BillItemRequest> Items { get; init; }
    public PaymentMode PaymentMode { get; init; }
    public Money? PaidAmount { get; init; }
    public string? Notes { get; init; }
}

public record BillItemRequest
{
    public Guid ProductId { get; init; }
    public double Quantity { get; init; }
    public Money? UnitPrice { get; init; }
    public double? DiscountPercent { get; init; }
    public Money? DiscountAmount { get; init; }
    public string? BatchNumber { get; init; }
}

public record SyncUploadRequest
{
    public EntityType EntityType { get; init; }
    public Guid EntityId { get; init; }
    public OperationType Operation { get; init; }
    public string Payload { get; init; }
    public DateTime ClientTimestamp { get; init; }
}

public record ImportProductsRequest
{
    public string FileUrl { get; init; }
    public string? MappingTemplate { get; init; }
    public bool UpdateExisting { get; init; }
    public bool SkipDuplicates { get; init; }
}
```

### 4.2 API Response Types

```dart
// Flutter/Dart API Response Types

class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final String? error;
  final Meta? meta;

  ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.error,
    this.meta,
  });
}

class Meta {
  final DateTime timestamp;
  final int version;
  final Pagination? pagination;

  Meta({
    required this.timestamp,
    required this.version,
    this.pagination,
  });
}

class Pagination {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;

  Pagination({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
  });
}

class SyncDownloadResponse {
  final List<SyncItem> items;
  final DateTime serverTimestamp;
  final int totalItems;

  SyncDownloadResponse({
    required this.items,
    required this.serverTimestamp,
    required this.totalItems,
  });
}

class SyncItem {
  final EntityType entityType;
  final UUID entityId;
  final OperationType operation;
  final String payload;
  final DateTime serverTimestamp;
  final int version;

  SyncItem({
    required this.entityType,
    required this.entityId,
    required this.operation,
    required this.payload,
    required this.serverTimestamp,
    required this.version,
  });
}
```

```csharp
// .NET/C# API Response Types

public record ApiResponse<T>
{
    public bool Success { get; init; }
    public T? Data { get; init; }
    public string? Message { get; init; }
    public string? Error { get; init; }
    public Meta? Meta { get; init; }
}

public record Meta
{
    public DateTime Timestamp { get; init; }
    public int Version { get; init; }
    public Pagination? Pagination { get; init; }
}

public record Pagination
{
    public int Page { get; init; }
    public int PerPage { get; init; }
    public int Total { get; init; }
    public int TotalPages { get; init; }
}

public record SyncDownloadResponse
{
    public List<SyncItem> Items { get; init; }
    public DateTime ServerTimestamp { get; init; }
    public int TotalItems { get; init; }
}

public record SyncItem
{
    public EntityType EntityType { get; init; }
    public Guid EntityId { get; init; }
    public OperationType Operation { get; init; }
    public string Payload { get; init; }
    public DateTime ServerTimestamp { get; init; }
    public int Version { get; init; }
}
```

## 5. Database Schema Types

### 5.1 SQLite Schema Types

```sql
-- SQLite Schema Types

-- TEXT for UUIDs, dates (ISO 8601), and strings
-- INTEGER for booleans (0/1), counts, and version numbers
-- REAL for decimal numbers (avoid MONEY - use INTEGER paise)
-- BLOB for large binary data

-- Example column types:
-- id TEXT PRIMARY KEY
-- name TEXT NOT NULL
-- is_active INTEGER DEFAULT 1
-- created_at TEXT NOT NULL
-- quantity INTEGER NOT NULL
-- price INTEGER NOT NULL  -- in paise/cents
-- tax_rate REAL DEFAULT 0.0
-- version INTEGER DEFAULT 1
-- sync_status TEXT DEFAULT 'pending'
```

### 5.2 PostgreSQL Schema Types

```sql
-- PostgreSQL Schema Types

-- UUID for primary keys
-- VARCHAR for fixed-length strings
-- TEXT for variable-length strings
-- BOOLEAN for true/false values
-- TIMESTAMP WITH TIME ZONE for dates
-- BIGINT for large numbers
-- NUMERIC for precise decimals
-- JSONB for flexible data

-- Example column types:
-- id UUID PRIMARY KEY DEFAULT gen_random_uuid()
-- name VARCHAR(255) NOT NULL
-- is_active BOOLEAN DEFAULT TRUE
-- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
-- quantity INTEGER NOT NULL
-- price NUMERIC(12,2) NOT NULL
-- tax_rate NUMERIC(5,2) DEFAULT 0.0
-- version INTEGER DEFAULT 1
-- sync_status VARCHAR(20) DEFAULT 'pending'
-- metadata JSONB
```

## 6. Validation Types

### 6.1 Validation Rules

```dart
// Flutter/Dart Validation Rules

class ValidationRules {
  // Product validations
  static const int productNameMinLength = 2;
  static const int productNameMaxLength = 255;
  static const int skuMaxLength = 50;
  static const int barcodeMaxLength = 13;
  static const int hsnCodeMaxLength = 8;
  static const double minPrice = 0.0;
  static const double maxPrice = 9999999.99;
  static const int minReorderLevel = 0;
  static const int maxReorderLevel = 99999;
  
  // Customer validations
  static const int customerNameMinLength = 2;
  static const int customerNameMaxLength = 255;
  static const int phoneLength = 10;
  static const int gstinLength = 15;
  static const int pincodeLength = 6;
  static const double maxCreditLimit = 9999999.99;
  
  // Bill validations
  static const int maxBillItems = 100;
  static const double minBillAmount = 0.01;
  static const double maxBillAmount = 9999999.99;
  static const int maxDiscountPercent = 100;
  
  // Loyalty validations
  static const int minPointsForRedemption = 10;
  static const int maxPointsRedemptionPercent = 50;
  static const int pointsExpiryDays = 365;
  
  // Employee validations
  static const int pinLength = 4;
  static const int employeeNameMinLength = 2;
  static const int employeeNameMaxLength = 255;
  
  // Import validations
  static const int maxImportRows = 10000;
  static const int batchSize = 100;
}
```

```csharp
// .NET/C# Validation Rules

public static class ValidationRules
{
    // Product validations
    public const int ProductNameMinLength = 2;
    public const int ProductNameMaxLength = 255;
    public const int SkuMaxLength = 50;
    public const int BarcodeMaxLength = 13;
    public const int HsnCodeMaxLength = 8;
    public const decimal MinPrice = 0.0m;
    public const decimal MaxPrice = 9999999.99m;
    public const int MinReorderLevel = 0;
    public const int MaxReorderLevel = 99999;
    
    // Customer validations
    public const int CustomerNameMinLength = 2;
    public const int CustomerNameMaxLength = 255;
    public const int PhoneLength = 10;
    public const int GstinLength = 15;
    public const int PincodeLength = 6;
    public const decimal MaxCreditLimit = 9999999.99m;
    
    // Bill validations
    public const int MaxBillItems = 100;
    public const decimal MinBillAmount = 0.01m;
    public const decimal MaxBillAmount = 9999999.99m;
    public const int MaxDiscountPercent = 100;
    
    // Loyalty validations
    public const int MinPointsForRedemption = 10;
    public const int MaxPointsRedemptionPercent = 50;
    public const int PointsExpiryDays = 365;
    
    // Employee validations
    public const int PinLength = 4;
    public const int EmployeeNameMinLength = 2;
    public const int EmployeeNameMaxLength = 255;
    
    // Import validations
    public const int MaxImportRows = 10000;
    public const int BatchSize = 100;
}
```

This comprehensive data types document provides a complete foundation for all data structures used in the SS MART retail ERP system, ensuring consistency between Flutter/Dart and .NET/C# implementations.
