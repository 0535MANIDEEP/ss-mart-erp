# SS MART - Complete System Architecture

## 1. System Overview

**SS MART** (Sai Sangameshwara Mart) is an offline-first retail ERP/POS system designed for Indian retail operations. The system prioritizes local-first operations with background synchronization to ensure uninterrupted business operations even without internet connectivity.

### Core Principles
- **Offline-First**: All critical operations work without internet
- **Local-First Writes**: SQLite database for immediate local storage
- **Background Sync**: Queue-based synchronization when online
- **Idempotent Operations**: Safe retry mechanisms
- **Conflict Resolution**: Smart merge strategies for concurrent edits
- **Indian Retail Focus**: GST, HSN/SAC, B2B/B2C support

## 2. High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        SS MART ERP SYSTEM                       │
├─────────────────────────────────────────────────────────────────┤
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐        │
│  │   Flutter    │    │   .NET 8    │    │  PostgreSQL  │        │
│  │   Mobile     │◄──►│   ASP.NET   │◄──►│   Server     │        │
│  │   Desktop    │    │   Core API  │    │   Database   │        │
│  └──────┬──────┘    └──────┬──────┘    └─────────────┘        │
│         │                  │                                    │
│         ▼                  ▼                                    │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐        │
│  │   SQLite    │    │    Redis    │    │     S3      │        │
│  │   Local DB  │    │    Cache    │    │  Object     │        │
│  │   + Drift   │    │             │    │  Storage    │        │
│  └─────────────┘    └─────────────┘    └─────────────┘        │
└─────────────────────────────────────────────────────────────────┘
```

## 3. Technology Stack

| Layer | Technology | Purpose |
|-------|------------|---------|
| **Frontend** | Flutter 3.x | Cross-platform UI (Mobile + Desktop) |
| **Local Database** | SQLite + Drift | Offline data storage |
| **Backend** | .NET 8 ASP.NET Core | REST API server |
| **Server Database** | PostgreSQL 15+ | Server-side data storage |
| **Auth** | JWT + Role-Based | Authentication & Authorization |
| **Sync** | Background Queue | Offline sync engine |
| **Storage** | S3-compatible | File/image storage |
| **Cache/Queue** | Redis | Caching & message queue |

## 4. Module Architecture

### 4.1 Core Modules

```
SS_MART_ERP/
├── Core Modules
│   ├── Billing/POS
│   ├── Inventory Management
│   ├── Purchase Management
│   ├── Customer CRM
│   ├── Loyalty Points
│   ├── Employee Management
│   ├── Shift Management
│   ├── GST/Tax Engine
│   ├── Reports & Analytics
│   ├── Backup/Restore
│   ├── Data Migration
│   ├── Audit Logs
│   ├── Admin/Permissions
│   └── Sync Engine
```

### 4.2 Module Dependencies

```
┌─────────────────────────────────────────────────────────────┐
│                    MODULE DEPENDENCY GRAPH                   │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌──────────┐     ┌──────────┐     ┌──────────┐           │
│  │ Product  │────►│ Billing  │────►│ Loyalty  │           │
│  │ Master   │     │   POS    │     │ Points   │           │
│  └──────────┘     └────┬─────┘     └──────────┘           │
│       │                │                                    │
│       ▼                ▼                                    │
│  ┌──────────┐     ┌──────────┐     ┌──────────┐           │
│  │Inventory │────►│Purchase  │────►│ Reports  │           │
│  │Management│     │Management│     │Analytics │           │
│  └──────────┘     └──────────┘     └──────────┘           │
│       │                │                                    │
│       ▼                ▼                                    │
│  ┌──────────┐     ┌──────────┐     ┌──────────┐           │
│  │ Customer │────►│ Employee │────►│  Audit   │           │
│  │   CRM    │     │Management│     │   Logs   │           │
│  └──────────┘     └──────────┘     └──────────┘           │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## 5. Data Flow Architecture

### 5.1 Offline-First Data Flow

```
┌─────────────────────────────────────────────────────────────┐
│                 OFFLINE-FIRST DATA FLOW                      │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  User Action                                                │
│       │                                                      │
│       ▼                                                      │
│  ┌─────────────────────────────────────────┐               │
│  │  Flutter App (Local Processing)         │               │
│  │  ┌─────────────────────────────────┐   │               │
│  │  │  1. Validate Input              │   │               │
│  │  │  2. Generate UUID               │   │               │
│  │  │  3. Write to SQLite             │   │               │
│  │  │  4. Add to Sync Queue           │   │               │
│  │  └─────────────────────────────────┘   │               │
│  └─────────────────────────────────────────┘               │
│       │                                                      │
│       ▼                                                      │
│  ┌─────────────────────────────────────────┐               │
│  │  Background Sync Service                │               │
│  │  ┌─────────────────────────────────┐   │               │
│  │  │  1. Check Network Status        │   │               │
│  │  │  2. Process Sync Queue          │   │               │
│  │  │  3. Send to Server API          │   │               │
│  │  │  4. Handle Response             │   │               │
│  │  │  5. Update Sync Status          │   │               │
│  │  └─────────────────────────────────┘   │               │
│  └─────────────────────────────────────────┘               │
│       │                                                      │
│       ▼                                                      │
│  ┌─────────────────────────────────────────┐               │
│  │  Server (.NET 8 API)                   │               │
│  │  ┌─────────────────────────────────┐   │               │
│  │  │  1. Validate & Process          │   │               │
│  │  │  2. Check Conflicts             │   │               │
│  │  │  3. Apply Changes              │   │               │
│  │  │  4. Return Response            │   │               │
│  │  └─────────────────────────────────┘   │               │
│  └─────────────────────────────────────────┘               │
│       │                                                      │
│       ▼                                                      │
│  ┌─────────────────────────────────────────┐               │
│  │  PostgreSQL Server Database            │               │
│  └─────────────────────────────────────────┘               │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### 5.2 Billing Transaction Flow

```
┌─────────────────────────────────────────────────────────────┐
│                   BILLING TRANSACTION FLOW                   │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  1. Customer Lookup                                          │
│     │  - Phone search (offline capable)                     │
│     │  - Customer ID scan                                   │
│     │  - Walk-in (no customer)                              │
│     ▼                                                        │
│  2. Product Selection                                        │
│     │  - Barcode scan                                       │
│     │  - Product search                                     │
│     │  - Category browse                                    │
│     ▼                                                        │
│  3. Cart Management                                          │
│     │  - Add items                                          │
│     │  - Update quantities                                  │
│     │  - Apply discounts                                    │
│     │  - Apply schemes                                      │
│     ▼                                                        │
│  4. Price Calculation                                        │
│     │  - Base price                                         │
│     │  - Tax calculation (GST)                              │
│     │  - Discount application                               │
│     │  - Round-off                                          │
│     │  - Total calculation                                  │
│     ▼                                                        │
│  5. Payment Processing                                       │
│     │  - Cash payment                                       │
│     │  - UPI payment                                        │
│     │  - Card payment                                       │
│     │  - Wallet payment                                     │
│     │  - Split payment                                      │
│     │  - Credit payment                                     │
│     ▼                                                        │
│  6. Transaction Completion                                   │
│     │  - Save bill to SQLite                                │
│     │  - Update stock locally                               │
│     │  - Add loyalty points                                 │
│     │  - Add to sync queue                                  │
│     │  - Generate invoice                                   │
│     │  - Print/Share invoice                                │
│     ▼                                                        │
│  7. Post-Transaction                                         │
│        - Update customer history                             │
│        - Update reports                                      │
│        - Schedule sync                                       │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## 6. Sync Engine Design

### 6.1 Sync Queue Structure

```typescript
interface SyncQueueItem {
  id: string;                    // UUID
  entityType: EntityType;        // 'bill', 'product', 'customer', etc.
  entityId: string;              // UUID of the entity
  operation: OperationType;      // 'create', 'update', 'delete'
  payload: any;                  // JSON data
  status: SyncStatus;           // 'pending', 'in_progress', 'completed', 'failed'
  retryCount: number;           // Number of retry attempts
  maxRetries: number;           // Maximum allowed retries
  createdAt: DateTime;          // When the item was created
  lastAttemptAt: DateTime;      // Last sync attempt time
  completedAt: DateTime;        // When sync completed
  error?: string;               // Error message if failed
  metadata: Record<string, any>; // Additional data
}

type SyncStatus = 'pending' | 'in_progress' | 'completed' | 'failed' | 'cancelled';
type OperationType = 'create' | 'update' | 'delete';
type EntityType = 'bill' | 'product' | 'customer' | 'stock' | 'loyalty' | 'employee' | 'shift';
```

### 6.2 Conflict Resolution Strategy

```
┌─────────────────────────────────────────────────────────────┐
│                 CONFLICT RESOLUTION STRATEGY                 │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Conflict Detection:                                        │
│  ┌─────────────────────────────────────────┐               │
│  │  1. Version-based detection             │               │
│  │  2. Timestamp comparison                │               │
│  │  3. Field-level change detection        │               │
│  └─────────────────────────────────────────┘               │
│       │                                                      │
│       ▼                                                      │
│  Resolution Strategies:                                     │
│  ┌─────────────────────────────────────────┐               │
│  │  1. Last-Write-Wins (LWW)              │               │
│  │     - Most recent timestamp wins        │               │
│  │     - Used for non-critical data        │               │
│  │                                         │               │
│  │  2. Field-Level Merge                   │               │
│  │     - Merge different fields            │               │
│  │     - Used for customer profiles        │               │
│  │                                         │               │
│  │  3. Manual Resolution                   │               │
│  │     - Flag for user review              │               │
│  │     - Used for critical conflicts       │               │
│  │                                         │               │
│  │  4. Business Rule Resolution            │               │
│  │     - Apply predefined rules            │               │
│  │     - Used for inventory conflicts      │               │
│  └─────────────────────────────────────────┘               │
│       │                                                      │
│       ▼                                                      │
│  Resolution Implementation:                                 │
│  ┌─────────────────────────────────────────┐               │
│  │  - Server timestamp as authority        │               │
│  │  - Client-side merge for offline edits  │               │
│  │  - Conflict queue for manual review     │               │
│  │  - Audit log for all resolutions        │               │
│  └─────────────────────────────────────────┘               │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## 7. Security Architecture

### 7.1 Authentication Flow

```
┌─────────────────────────────────────────────────────────────┐
│                  AUTHENTICATION FLOW                          │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  1. Login Request                                           │
│     │  - Username/Phone                                     │
│     │  - Password/PIN                                       │
│     ▼                                                        │
│  2. Server Validation                                        │
│     │  - Check credentials                                  │
│     │  - Verify user status                                 │
│     │  - Check device whitelist                             │
│     ▼                                                        │
│  3. Token Generation                                        │
│     │  - Generate JWT access token (15 min)                 │
│     │  - Generate refresh token (7 days)                    │
│     │  - Store tokens securely                              │
│     ▼                                                        │
│  4. Offline Authentication                                   │
│        - Cached credentials (encrypted)                     │
│        - Offline PIN validation                             │
│        - Limited offline access                             │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### 7.2 Role-Based Permissions

```
┌─────────────────────────────────────────────────────────────┐
│                ROLE-BASED PERMISSION MATRIX                  │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Role: Admin                                                 │
│  ┌─────────────────────────────────────────┐               │
│  │  - Full system access                   │               │
│  │  - User management                      │               │
│  │  - Settings configuration               │               │
│  │  - Data backup/restore                  │               │
│  │  - Audit log access                     │               │
│  │  - Override permissions                 │               │
│  └─────────────────────────────────────────┘               │
│                                                              │
│  Role: Manager                                               │
│  ┌─────────────────────────────────────────┐               │
│  │  - Billing operations                   │               │
│  │  - Inventory management                 │               │
│  │  - Customer management                  │               │
│  │  - Reports access                       │               │
│  │  - Employee oversight                   │               │
│  │  - Stock adjustments                    │               │
│  └─────────────────────────────────────────┘               │
│                                                              │
│  Role: Cashier                                               │
│  ┌─────────────────────────────────────────┐               │
│  │  - Billing only                         │               │
│  │  - Customer lookup                      │               │
│  │  - Limited inventory view               │               │
│  │  - No system settings                   │               │
│  └─────────────────────────────────────────┘               │
│                                                              │
│  Role: Inventory                                              │
│  ┌─────────────────────────────────────────┐               │
│  │  - Stock management                     │               │
│  │  - Purchase management                  │               │
│  │  - Product management                   │               │
│  │  - Stock reports                        │               │
│  └─────────────────────────────────────────┘               │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## 8. Database Architecture

### 8.1 SQLite (Local) Schema Design

```sql
-- Core Tables Structure (Local SQLite)

-- Products Table
CREATE TABLE products (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    sku TEXT UNIQUE,
    barcode TEXT,
    hsn_code TEXT,
    unit TEXT DEFAULT 'PCS',
    pack_size REAL DEFAULT 1,
    mrp REAL NOT NULL,
    selling_price REAL NOT NULL,
    purchase_price REAL,
    tax_rate REAL DEFAULT 0,
    tax_type TEXT DEFAULT 'GST',
    category_id TEXT,
    supplier_id TEXT,
    reorder_level INTEGER DEFAULT 10,
    current_stock INTEGER DEFAULT 0,
    is_active INTEGER DEFAULT 1,
    created_at TEXT,
    updated_at TEXT,
    version INTEGER DEFAULT 1,
    sync_status TEXT DEFAULT 'pending'
);

-- Customers Table
CREATE TABLE customers (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    phone TEXT UNIQUE,
    email TEXT,
    address TEXT,
    city TEXT,
    state TEXT,
    pincode TEXT,
    gstin TEXT,
    type TEXT DEFAULT 'B2C',
    credit_limit REAL DEFAULT 0,
    current_balance REAL DEFAULT 0,
    loyalty_points INTEGER DEFAULT 0,
    loyalty_card_number TEXT,
    is_active INTEGER DEFAULT 1,
    created_at TEXT,
    updated_at TEXT,
    version INTEGER DEFAULT 1,
    sync_status TEXT DEFAULT 'pending'
);

-- Bills Table
CREATE TABLE bills (
    id TEXT PRIMARY KEY,
    bill_number TEXT NOT NULL,
    invoice_number TEXT,
    customer_id TEXT,
    bill_date TEXT NOT NULL,
    due_date TEXT,
    subtotal REAL NOT NULL,
    tax_amount REAL DEFAULT 0,
    discount_amount REAL DEFAULT 0,
    round_off REAL DEFAULT 0,
    total_amount REAL NOT NULL,
    paid_amount REAL DEFAULT 0,
    due_amount REAL DEFAULT 0,
    payment_mode TEXT DEFAULT 'CASH',
    status TEXT DEFAULT 'completed',
    is_return INTEGER DEFAULT 0,
    reference_bill_id TEXT,
    created_by TEXT,
    created_at TEXT,
    updated_at TEXT,
    version INTEGER DEFAULT 1,
    sync_status TEXT DEFAULT 'pending'
);

-- Bill Items Table
CREATE TABLE bill_items (
    id TEXT PRIMARY KEY,
    bill_id TEXT NOT NULL,
    product_id TEXT NOT NULL,
    quantity REAL NOT NULL,
    unit_price REAL NOT NULL,
    discount_percent REAL DEFAULT 0,
    discount_amount REAL DEFAULT 0,
    tax_amount REAL DEFAULT 0,
    total_amount REAL NOT NULL,
    batch_number TEXT,
    expiry_date TEXT,
    created_at TEXT,
    FOREIGN KEY (bill_id) REFERENCES bills(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Stock Table
CREATE TABLE stock (
    id TEXT PRIMARY KEY,
    product_id TEXT NOT NULL,
    location_id TEXT DEFAULT 'MAIN',
    quantity INTEGER NOT NULL,
    reserved_quantity INTEGER DEFAULT 0,
    available_quantity INTEGER GENERATED ALWAYS AS (quantity - reserved_quantity),
    batch_number TEXT,
    expiry_date TEXT,
    last_updated TEXT,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Stock Movements Table
CREATE TABLE stock_movements (
    id TEXT PRIMARY KEY,
    product_id TEXT NOT NULL,
    movement_type TEXT NOT NULL,
    quantity INTEGER NOT NULL,
    reference_type TEXT,
    reference_id TEXT,
    notes TEXT,
    created_by TEXT,
    created_at TEXT,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Loyalty Transactions Table
CREATE TABLE loyalty_transactions (
    id TEXT PRIMARY KEY,
    customer_id TEXT NOT NULL,
    transaction_type TEXT NOT NULL,
    points INTEGER NOT NULL,
    reference_type TEXT,
    reference_id TEXT,
    expiry_date TEXT,
    notes TEXT,
    created_by TEXT,
    created_at TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- Employees Table
CREATE TABLE employees (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    phone TEXT UNIQUE,
    email TEXT,
    role TEXT DEFAULT 'cashier',
    pin TEXT,
    is_active INTEGER DEFAULT 1,
    created_at TEXT,
    updated_at TEXT,
    version INTEGER DEFAULT 1,
    sync_status TEXT DEFAULT 'pending'
);

-- Shifts Table
CREATE TABLE shifts (
    id TEXT PRIMARY KEY,
    employee_id TEXT NOT NULL,
    shift_date TEXT NOT NULL,
    start_time TEXT,
    end_time TEXT,
    status TEXT DEFAULT 'scheduled',
    created_at TEXT,
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);

-- Attendance Table
CREATE TABLE attendance (
    id TEXT PRIMARY KEY,
    employee_id TEXT NOT NULL,
    attendance_date TEXT NOT NULL,
    clock_in TEXT,
    clock_out TEXT,
    status TEXT DEFAULT 'present',
    notes TEXT,
    created_at TEXT,
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);

-- Audit Logs Table
CREATE TABLE audit_logs (
    id TEXT PRIMARY KEY,
    user_id TEXT,
    action TEXT NOT NULL,
    entity_type TEXT,
    entity_id TEXT,
    old_value TEXT,
    new_value TEXT,
    ip_address TEXT,
    device_id TEXT,
    created_at TEXT
);

-- Sync Queue Table
CREATE TABLE sync_queue (
    id TEXT PRIMARY KEY,
    entity_type TEXT NOT NULL,
    entity_id TEXT NOT NULL,
    operation TEXT NOT NULL,
    payload TEXT NOT NULL,
    status TEXT DEFAULT 'pending',
    retry_count INTEGER DEFAULT 0,
    max_retries INTEGER DEFAULT 3,
    created_at TEXT,
    last_attempt_at TEXT,
    completed_at TEXT,
    error TEXT
);

-- Settings Table
CREATE TABLE settings (
    id TEXT PRIMARY KEY,
    key TEXT UNIQUE NOT NULL,
    value TEXT NOT NULL,
    category TEXT,
    updated_at TEXT
);
```

### 8.2 PostgreSQL (Server) Schema Design

```sql
-- Server Database Schema (PostgreSQL)

-- All tables include:
-- - UUID primary keys
-- - Timestamps (created_at, updated_at)
-- - Version column for optimistic locking
-- - Soft delete support (deleted_at)
-- - Audit fields

-- Similar structure to SQLite but with:
-- - Additional indexes for performance
-- - Foreign key constraints
-- - Check constraints
-- - Row-level security policies
-- - Partitioning for large tables (bills, stock_movements)
```

## 9. API Contract Design

### 9.1 Core API Endpoints

```
┌─────────────────────────────────────────────────────────────┐
│                    API ENDPOINT DESIGN                        │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Authentication                                             │
│  POST   /api/auth/login                                     │
│  POST   /api/auth/refresh                                   │
│  POST   /api/auth/logout                                    │
│  POST   /api/auth/validate-pin                              │
│                                                              │
│  Products                                                   │
│  GET    /api/products                                       │
│  GET    /api/products/{id}                                  │
│  POST   /api/products                                       │
│  PUT    /api/products/{id}                                  │
│  DELETE /api/products/{id}                                  │
│  GET    /api/products/search?q={query}                      │
│  GET    /api/products/barcode/{barcode}                     │
│                                                              │
│  Customers                                                  │
│  GET    /api/customers                                      │
│  GET    /api/customers/{id}                                 │
│  POST   /api/customers                                      │
│  PUT    /api/customers/{id}                                 │
│  DELETE /api/customers/{id}                                 │
│  GET    /api/customers/search?q={query}                     │
│  GET    /api/customers/{id}/history                         │
│  GET    /api/customers/{id}/loyalty                         │
│                                                              │
│  Bills                                                      │
│  GET    /api/bills                                          │
│  GET    /api/bills/{id}                                     │
│  POST   /api/bills                                          │
│  PUT    /api/bills/{id}                                     │
│  POST   /api/bills/{id}/return                              │
│  GET    /api/bills/{id}/print                               │
│                                                              │
│  Inventory                                                  │
│  GET    /api/inventory                                      │
│  GET    /api/inventory/{productId}                          │
│  POST   /api/inventory/adjust                               │
│  POST   /api/inventory/transfer                             │
│  GET    /api/inventory/low-stock                            │
│                                                              │
│  Purchases                                                  │
│  GET    /api/purchases                                      │
│  GET    /api/purchases/{id}                                 │
│  POST   /api/purchases                                      │
│  PUT    /api/purchases/{id}                                 │
│  POST   /api/purchases/{id}/receive                         │
│                                                              │
│  Loyalty                                                    │
│  GET    /api/loyalty/{customerId}                           │
│  POST   /api/loyalty/earn                                   │
│  POST   /api/loyalty/redeem                                 │
│  GET    /api/loyalty/history/{customerId}                   │
│                                                              │
│  Employees                                                  │
│  GET    /api/employees                                      │
│  GET    /api/employees/{id}                                 │
│  POST   /api/employees                                      │
│  PUT    /api/employees/{id}                                 │
│  POST   /api/employees/{id}/clock-in                        │
│  POST   /api/employees/{id}/clock-out                       │
│                                                              │
│  Reports                                                    │
│  GET    /api/reports/sales                                  │
│  GET    /api/reports/inventory                              │
│  GET    /api/reports/customers                              │
│  GET    /api/reports/loyalty                                │
│  GET    /api/reports/tax                                    │
│  GET    /api/reports/profit                                 │
│                                                              │
│  Sync                                                       │
│  POST   /api/sync/upload                                    │
│  POST   /api/sync/download                                  │
│  GET    /api/sync/status                                    │
│  POST   /api/sync/resolve-conflict                          │
│                                                              │
│  Import/Export                                              │
│  POST   /api/import/products                                │
│  POST   /api/import/customers                               │
│  POST   /api/import/stock                                   │
│  GET    /api/export/{type}                                  │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### 9.2 API Response Structure

```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "attributes": {}
  },
  "meta": {
    "timestamp": "2024-01-01T00:00:00Z",
    "version": 1
  },
  "pagination": {
    "page": 1,
    "per_page": 20,
    "total": 100,
    "total_pages": 5
  }
}
```

## 10. UI/UX Architecture

### 10.1 Navigation Structure

```
┌─────────────────────────────────────────────────────────────┐
│                   APP NAVIGATION STRUCTURE                    │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Login Screen                                                │
│       │                                                      │
│       ▼                                                      │
│  Dashboard (Main Screen)                                    │
│       │                                                      │
│       ├──► Billing/POS                                       │
│       │    └──► Quick Bill                                   │
│       │    └──► Return Bill                                  │
│       │    └──► Estimate                                     │
│       │                                                      │
│       ├──► Products                                          │
│       │    └──► Product List                                 │
│       │    └──► Add/Edit Product                             │
│       │    └──► Categories                                   │
│       │                                                      │
│       ├──► Customers                                         │
│       │    └──► Customer List                                │
│       │    └──► Add/Edit Customer                            │
│       │    └──► Customer History                             │
│       │                                                      │
│       ├──► Inventory                                         │
│       │    └──► Stock Summary                                │
│       │    └──► Stock Adjustment                             │
│       │    └──► Stock Transfer                               │
│       │                                                      │
│       ├──► Purchases                                         │
│       │    └──► Purchase List                                │
│       │    └──► Create Purchase                              │
│       │    └──► Receive Stock                                │
│       │                                                      │
│       ├──► Loyalty                                           │
│       │    └──► Points Summary                               │
│       │    └──► Redemption                                   │
│       │    └──► Loyalty Reports                              │
│       │                                                      │
│       ├──► Employees                                         │
│       │    └──► Employee List                                │
│       │    └──► Shift Management                             │
│       │    └──► Attendance                                   │
│       │                                                      │
│       ├──► Reports                                           │
│       │    └──► Sales Reports                                │
│       │    └──► Inventory Reports                            │
│       │    └──► Financial Reports                            │
│       │                                                      │
│       └──► Settings                                          │
│            └──► Company Settings                             │
│            └──► Tax Settings                                 │
│            └──► User Management                              │
│            └──► Backup/Restore                               │
│            └──► Import/Export                                 │
│            └──► Audit Logs                                   │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### 10.2 Screen Layouts

```
┌─────────────────────────────────────────────────────────────┐
│                    BILLING SCREEN LAYOUT                      │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────────────────────────────────────────────┐   │
│  │  SS MART - Billing                                  │   │
│  │  [Customer: Walk-in ▼]  [Date: 24/07/2026]         │   │
│  ├─────────────────────────────────────────────────────┤   │
│  │                                                     │   │
│  │  Product Search: [________________] [Scan] [Search] │   │
│  │                                                     │   │
│  │  ┌─────────────────────────────────────────────┐   │   │
│  │  │  Item      Qty   Price   Tax   Disc  Total  │   │   │
│  │  │  ─────────────────────────────────────────  │   │   │
│  │  │  Product 1  2    100     18    10    212    │   │   │
│  │  │  Product 2  1    250     18    0     295    │   │   │
│  │  │  Product 3  3    50      12    5     163    │   │   │
│  │  └─────────────────────────────────────────────┘   │   │
│  │                                                     │   │
│  ├─────────────────────────────────────────────────────┤   │
│  │  Subtotal:        ₹660.00                          │   │
│  │  Tax (GST):       ₹83.16                           │   │
│  │  Discount:        ₹15.00                           │   │
│  │  Round Off:       ₹0.16                            │   │
│  │  ─────────────────────────────────────────────     │   │
│  │  Total:           ₹728.00                          │   │
│  ├─────────────────────────────────────────────────────┤   │
│  │  Payment Mode: [Cash ▼] [UPI] [Card] [Credit]     │   │
│  │  Amount: [₹728.00]                                 │   │
│  │  [Save Bill]  [Print]  [WhatsApp]  [Clear]         │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## 11. Offline-First Implementation

### 11.1 Local Storage Strategy

```
┌─────────────────────────────────────────────────────────────┐
│               OFFLINE-FIRST STORAGE STRATEGY                 │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  SQLite Database (Drift ORM)                               │
│  ┌─────────────────────────────────────────┐               │
│  │  - All master data (products, customers)│               │
│  │  - All transactions (bills, stock)      │               │
│  │  - Loyalty points                       │               │
│  │  - Employee data                        │               │
│  │  - Audit logs                           │               │
│  │  - Sync queue                           │               │
│  └─────────────────────────────────────────┘               │
│       │                                                      │
│       ▼                                                      │
│  File System Storage                                        │
│  ┌─────────────────────────────────────────┐               │
│  │  - Invoice PDFs                         │               │
│  │  - Product images                       │               │
│  │  - Backup files                         │               │
│  │  - Import/Export files                  │               │
│  └─────────────────────────────────────────┘               │
│       │                                                      │
│       ▼                                                      │
│  Secure Storage (Keychain/Keystore)                         │
│  ┌─────────────────────────────────────────┐               │
│  │  - JWT tokens                           │               │
│  │  - Encryption keys                      │               │
│  │  - User credentials (hashed)            │               │
│  └─────────────────────────────────────────┘               │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### 11.2 Sync Queue Management

```
┌─────────────────────────────────────────────────────────────┐
│                 SYNC QUEUE MANAGEMENT                        │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Queue Processing Algorithm:                                │
│  ┌─────────────────────────────────────────┐               │
│  │  1. Check network connectivity          │               │
│  │  2. Get pending items (oldest first)    │               │
│  │  3. Group by entity type                │               │
│  │  4. Process in dependency order:        │               │
│  │     - Products first                    │               │
│  │     - Customers second                  │               │
│  │     - Bills/Stock third                 │               │
│  │  5. Handle conflicts                    │               │
│  │  6. Update sync status                  │               │
│  │  7. Retry failed items (max 3)          │               │
│  │  8. Log all sync activities             │               │
│  └─────────────────────────────────────────┘               │
│                                                              │
│  Priority Levels:                                           │
│  ┌─────────────────────────────────────────┐               │
│  │  HIGH: Bills, Payments, Stock Updates   │               │
│  │  MEDIUM: Customer updates, Loyalty      │               │
│  │  LOW: Reports, Settings, Audit logs     │               │
│  └─────────────────────────────────────────┘               │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## 12. Data Migration Strategy

### 12.1 Import Templates

```
┌─────────────────────────────────────────────────────────────┐
│                   DATA IMPORT TEMPLATES                      │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Product Import Template:                                   │
│  ┌─────────────────────────────────────────┐               │
│  │  Columns:                               │               │
│  │  - Product Name (Required)              │               │
│  │  - SKU (Optional)                       │               │
│  │  - Barcode (Optional)                   │               │
│  │  - HSN Code (Required)                  │               │
│  │  - Unit (PCS, KG, LTR, etc.)           │               │
│  │  - MRP (Required)                       │               │
│  │  - Selling Price (Required)             │               │
│  │  - Purchase Price (Optional)            │               │
│  │  - Tax Rate (%)                         │               │
│  │  - Category                             │               │
│  │  - Supplier Name                        │               │
│  │  - Reorder Level                        │               │
│  │  - Current Stock                        │               │
│  └─────────────────────────────────────────┘               │
│                                                              │
│  Customer Import Template:                                  │
│  ┌─────────────────────────────────────────┐               │
│  │  Columns:                               │               │
│  │  - Name (Required)                      │               │
│  │  - Phone (Required)                     │               │
│  │  - Email (Optional)                     │               │
│  │  - Address (Optional)                   │               │
│  │  - City (Optional)                      │               │
│  │  - State (Optional)                     │               │
│  │  - Pincode (Optional)                   │               │
│  │  - GSTIN (Optional)                     │               │
│  │  - Customer Type (B2B/B2C)              │               │
│  │  - Credit Limit (Default: 0)            │               │
│  │  - Loyalty Card Number (Optional)       │               │
│  └─────────────────────────────────────────┘               │
│                                                              │
│  Stock Import Template:                                     │
│  ┌─────────────────────────────────────────┐               │
│  │  Columns:                               │               │
│  │  - Product Name/ID (Required)           │               │
│  │  - Quantity (Required)                  │               │
│  │  - Location (Default: MAIN)             │               │
│  │  - Batch Number (Optional)              │               │
│  │  - Expiry Date (Optional)               │               │
│  └─────────────────────────────────────────┘               │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### 12.2 Import Process Flow

```
┌─────────────────────────────────────────────────────────────┐
│                   IMPORT PROCESS FLOW                        │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  1. File Upload                                             │
│     │  - Accept Excel, CSV, DBF                             │
│     │  - Validate file format                               │
│     │  - Parse data                                         │
│     ▼                                                        │
│  2. Column Mapping                                          │
│     │  - Auto-detect columns                                │
│     │  - Manual mapping interface                           │
│     │  - Save mapping templates                             │
│     ▼                                                        │
│  3. Data Validation                                         │
│     │  - Required field validation                          │
│     │  - Data type validation                               │
│     │  - Business rule validation                           │
│     │  - Duplicate detection                                │
│     ▼                                                        │
│  4. Preview & Confirmation                                  │
│     │  - Show preview table                                 │
│     │  - Highlight errors                                   │
│     │  - Allow edits                                        │
│     │  - Confirm import                                     │
│     ▼                                                        │
│  5. Import Execution                                         │
│     │  - Process in batches                                 │
│     │  - Handle duplicates (skip/update)                    │
│     │  - Generate import report                             │
│     │  - Add to sync queue                                  │
│     ▼                                                        │
│  6. Post-Import                                             │
│        - Update related data                                │
│        - Generate import summary                            │
│        - Log audit trail                                    │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## 13. Backup & Restore Strategy

### 13.1 Backup Types

```
┌─────────────────────────────────────────────────────────────┐
│                   BACKUP TYPES & SCHEDULES                   │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Full Backup                                                │
│  ┌─────────────────────────────────────────┐               │
│  │  - Complete database backup             │               │
│  │  - Includes all tables                  │               │
│  │  - Schedule: Daily at midnight          │               │
│  │  - Retention: 30 days                   │               │
│  └─────────────────────────────────────────┘               │
│                                                              │
│  Incremental Backup                                          │
│  ┌─────────────────────────────────────────┐               │
│  │  - Only changed data                    │               │
│  │  - Faster backup time                   │               │
│  │  - Schedule: Every 6 hours              │               │
│  │  - Retention: 7 days                    │               │
│  └─────────────────────────────────────────┘               │
│                                                              │
│  Transaction Log Backup                                     │
│  ┌─────────────────────────────────────────┐               │
│  │  - Transaction logs only                │               │
│  │  - Point-in-time recovery               │               │
│  │  - Schedule: Every hour                 │               │
│  │  - Retention: 48 hours                  │               │
│  └─────────────────────────────────────────┘               │
│                                                              │
│  Financial Year Backup                                      │
│  ┌─────────────────────────────────────────┐               │
│  │  - Year-end archival                    │               │
│  │  - Compressed storage                   │               │
│  │  - Schedule: End of financial year      │               │
│  │  - Retention: 7 years (legal)           │               │
│  └─────────────────────────────────────────┘               │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### 13.2 Restore Process

```
┌─────────────────────────────────────────────────────────────┐
│                   RESTORE PROCESS FLOW                       │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  1. Backup Selection                                        │
│     │  - List available backups                             │
│     │  - Show backup details                                │
│     │  - Select restore point                               │
│     ▼                                                        │
│  2. Pre-Restore Validation                                  │
│     │  - Check backup integrity                             │
│     │  - Verify compatibility                               │
│     │  - Create current backup                              │
│     ▼                                                        │
│  3. Restore Execution                                        │
│     │  - Stop sync services                                 │
│     │  - Restore database                                   │
│     │  - Verify data integrity                              │
│     │  - Restart services                                   │
│     ▼                                                        │
│  4. Post-Restore Validation                                  │
│        - Verify critical data                               │
│        - Test basic operations                              │
│        - Resume sync services                               │
│        - Generate restore report                            │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## 14. Testing Strategy

### 14.1 Test Types

```
┌─────────────────────────────────────────────────────────────┐
│                   TESTING STRATEGY                           │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Unit Tests                                                 │
│  ┌─────────────────────────────────────────┐               │
│  │  - Individual function testing          │               │
│  │  - Business logic validation            │               │
│  │  - Data model testing                   │               │
│  │  - Utility function testing             │               │
│  └─────────────────────────────────────────┘               │
│                                                              │
│  Integration Tests                                          │
│  ┌─────────────────────────────────────────┐               │
│  │  - API endpoint testing                 │               │
│  │  - Database operation testing           │               │
│  │  - Sync engine testing                  │               │
│  │  - Authentication flow testing          │               │
│  └─────────────────────────────────────────┘               │
│                                                              │
│  End-to-End Tests                                           │
│  ┌─────────────────────────────────────────┐               │
│  │  - Complete billing flow                │               │
│  │  - Offline/online transitions           │               │
│  │  - Data import/export flows             │               │
│  │  - Multi-user scenarios                 │               │
│  └─────────────────────────────────────────┘               │
│                                                              │
│  Performance Tests                                          │
│  ┌─────────────────────────────────────────┐               │
│  │  - Load testing                         │               │
│  │  - Stress testing                       │               │
│  │  - Offline performance                  │               │
│  │  - Sync performance                     │               │
│  └─────────────────────────────────────────┘               │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## 15. Deployment Strategy

### 15.1 Environment Setup

```
┌─────────────────────────────────────────────────────────────┐
│                   DEPLOYMENT ENVIRONMENTS                    │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Development Environment                                    │
│  ┌─────────────────────────────────────────┐               │
│  │  - Local development                    │               │
│  │  - SQLite database                      │               │
│  │  - Mock services                        │               │
│  │  - Debug logging                        │               │
│  └─────────────────────────────────────────┘               │
│                                                              │
│  Testing Environment                                         │
│  ┌─────────────────────────────────────────┐               │
│  │  - Test server                          │               │
│  │  - Test database                        │               │
│  │  - Automated tests                      │               │
│  │  - Test data seeding                    │               │
│  └─────────────────────────────────────────┘               │
│                                                              │
│  Staging Environment                                         │
│  ┌─────────────────────────────────────────┐               │
│  │  - Production-like setup                │               │
│  │  - Performance testing                  │               │
│  │  - User acceptance testing              │               │
│  │  - Pre-production validation            │               │
│  └─────────────────────────────────────────┘               │
│                                                              │
│  Production Environment                                     │
│  ┌─────────────────────────────────────────┐               │
│  │  - Live server                          │               │
│  │  - Production database                  │               │
│  │  - Monitoring and alerting              │               │
│  │  - Backup and recovery                  │               │
│  └─────────────────────────────────────────┘               │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## 16. Monitoring & Analytics

### 16.1 Key Metrics

```
┌─────────────────────────────────────────────────────────────┐
│                   MONITORING METRICS                         │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  System Metrics                                             │
│  ┌─────────────────────────────────────────┐               │
│  │  - API response times                   │               │
│  │  - Database query performance           │               │
│  │  - Sync queue length                    │               │
│  │  - Error rates                          │               │
│  │  - Uptime/downtime                      │               │
│  └─────────────────────────────────────────┘               │
│                                                              │
│  Business Metrics                                            │
│  ┌─────────────────────────────────────────┐               │
│  │  - Daily sales volume                   │               │
│  │  - Transaction success rate             │               │
│  │  - Offline usage percentage             │               │
│  │  - Sync success rate                    │               │
│  │  - User activity                        │               │
│  └─────────────────────────────────────────┘               │
│                                                              │
│  Security Metrics                                            │
│  ┌─────────────────────────────────────────┐               │
│  │  - Failed login attempts                │               │
│  │  - Permission violations                │               │
│  │  - Data access patterns                 │               │
│  │  - Audit log anomalies                  │               │
│  └─────────────────────────────────────────┘               │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

This architecture provides a comprehensive foundation for the SS MART retail ERP system. The design prioritizes offline-first operations, data integrity, and scalability while maintaining the flexibility needed for Indian retail operations.
