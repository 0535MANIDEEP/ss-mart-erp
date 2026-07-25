# SS MART - Complete Solution Architecture

## 1. Project Summary

**Project Name:** SS MART (Sai Sangameshwara Mart) Retail ERP System
**Purpose:** Offline-first retail ERP/POS system for Indian retail operations
**Target Users:** Retail stores, supermarkets, grocery stores
**Key Differentiator:** Offline-first design with intelligent sync

## 2. Architecture Overview

### 2.1 System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    SS MART SYSTEM ARCHITECTURE               │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌─────────────────────────────────────────────────────┐   │
│  │                 CLIENT LAYER                         │   │
│  │  ┌─────────────────────────────────────────────┐   │   │
│  │  │  Flutter App (Mobile + Desktop)              │   │   │
│  │  │  ├─── UI Components                         │   │   │
│  │  │  ├─── Business Logic                        │   │   │
│  │  │  ├─── Local Database (SQLite + Drift)       │   │   │
│  │  │  ├─── Sync Queue                            │   │   │
│  │  │  └─── Background Services                   │   │   │
│  │  └─────────────────────────────────────────────┘   │   │
│  └─────────────────────────────────────────────────────┘   │
│                          │                                    │
│                          ▼                                    │
│  ┌─────────────────────────────────────────────────────┐   │
│  │                 API LAYER                            │   │
│  │  ┌─────────────────────────────────────────────┐   │   │
│  │  │  .NET 8 ASP.NET Core API                    │   │   │
│  │  │  ├─── REST Endpoints                        │   │   │
│  │  │  ├─── JWT Authentication                    │   │   │
│  │  │  ├─── Role-Based Access Control             │   │   │
│  │  │  ├─── Business Logic Services               │   │   │
│  │  │  └─── Background Sync Services              │   │   │
│  │  └─────────────────────────────────────────────┘   │   │
│  └─────────────────────────────────────────────────────┘   │
│                          │                                    │
│                          ▼                                    │
│  ┌─────────────────────────────────────────────────────┐   │
│  │                 DATA LAYER                           │   │
│  │  ┌─────────────────────────────────────────────┐   │   │
│  │  │  PostgreSQL Server Database                 │   │   │
│  │  │  ├─── All Master Data                       │   │   │
│  │  │  ├─── All Transactions                      │   │   │
│  │  │  ├─── Version Tracking                      │   │   │
│  │  │  └─── Audit Logs                            │   │   │
│  │  └─────────────────────────────────────────────┘   │   │
│  │  ┌─────────────────────────────────────────────┐   │   │
│  │  │  Redis Cache/Queue                          │   │   │
│  │  │  ├─── Session Cache                         │   │   │
│  │  │  ├─── Query Cache                           │   │   │
│  │  │  └─── Message Queue                         │   │   │
│  │  └─────────────────────────────────────────────┘   │   │
│  │  ┌─────────────────────────────────────────────┐   │   │
│  │  │  S3 Object Storage                          │   │   │
│  │  │  ├─── File Storage                          │   │   │
│  │  │  ├─── Backups                               │   │   │
│  │  │  └─── Exports                               │   │   │
│  │  └─────────────────────────────────────────────┘   │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### 2.2 Data Flow

```
┌─────────────────────────────────────────────────────────────┐
│                    DATA FLOW ARCHITECTURE                     │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Offline Mode:                                              │
│  ┌─────────┐    ┌─────────┐    ┌─────────┐    ┌─────────┐│
│  │  User   │───►│ Flutter │───►│ SQLite  │───►│  Sync   ││
│  │ Action  │    │   App   │    │   DB    │    │  Queue  ││
│  └─────────┘    └─────────┘    └─────────┘    └─────────┘│
│                                                      │      │
│                                                      ▼      │
│                                            ┌─────────────┐ │
│                                            │  Background  │ │
│                                            │    Sync      │ │
│                                            └─────────────┘ │
│                                                      │      │
│  Online Mode:                                             │
│                                            ┌─────────────┐ │
│                                            │  .NET API   │ │
│                                            └─────────────┘ │
│                                                      │      │
│                                                      ▼      │
│                                            ┌─────────────┐ │
│                                            │ PostgreSQL  │ │
│                                            └─────────────┘ │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## 3. Core Modules

### 3.1 Module Summary

| Module | Description | Priority | Phase |
|--------|-------------|----------|-------|
| **Billing/POS** | Core billing with GST, payments, invoicing | High | 1 |
| **Inventory** | Stock management, batch/expiry tracking | High | 1 |
| **Products** | Product master with HSN, tax, pricing | High | 1 |
| **Customers** | Customer profiles, history, outstanding | High | 1 |
| **Loyalty** | Points earning, redemption, management | Medium | 2 |
| **Purchases** | Purchase orders, receiving, supplier management | Medium | 3 |
| **Employees** | Employee profiles, roles, PIN auth | Medium | 3 |
| **Shifts** | Shift scheduling, attendance tracking | Low | 4 |
| **Reports** | Sales, inventory, financial, tax reports | Medium | 4 |
| **Sync Engine** | Offline sync, conflict resolution | High | 2 |
| **Admin** | Settings, permissions, backup/restore | Medium | 4 |
| **Import/Export** | Data migration, Excel/CSV import | Low | 5 |

### 3.2 Module Dependencies

```
Product Module ──────────────────────────────┐
    │                                        │
    ├──► Billing Module ◄───────────────────┤
    │        │                              │
    │        ├──► Loyalty Module            │
    │        │                              │
    │        └──► Reports Module            │
    │                                        │
    ├──► Inventory Module ◄─────────────────┤
    │        │                              │
    │        └──► Purchase Module           │
    │                                        │
    └──► Customer Module ◄──────────────────┘
             │
             └──► Loyalty Module
```

## 4. Database Schema

### 4.1 Entity Relationship Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    ENTITY RELATIONSHIPS                       │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Products ──────┬────── Bill Items ◄────── Bills            │
│      │          │                              │             │
│      │          └────── Purchase Items ◄───── Purchases     │
│      │                                         │             │
│      └────── Stock Movements ◄──── Stock                  │
│                                                              │
│  Customers ─────┬────── Bills                                │
│      │          │                                            │
│      │          └────── Loyalty Transactions                │
│      │                                                       │
│      └────── Outstanding Entries                             │
│                                                              │
│  Employees ─────┬────── Shifts                               │
│      │          │                                            │
│      │          └────── Attendance                           │
│      │                                                       │
│      └────── Bills (created_by)                              │
│                                                              │
│  Suppliers ─────┬────── Products                             │
│      │          │                                            │
│      │          └────── Purchases                            │
│      │                                                       │
│      └────── Purchase Invoices                               │
│                                                              │
│  Categories ──── Products                                    │
│                                                              │
│  Audit Logs ──── All Entities                                │
│                                                              │
│  Sync Queue ──── All Entities                                │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### 4.2 Core Tables

| Table | Purpose | Key Fields |
|-------|---------|------------|
| `products` | Product master | id, name, sku, barcode, hsn_code, mrp, selling_price, tax_rate |
| `customers` | Customer master | id, name, phone, email, gstin, credit_limit, loyalty_points |
| `bills` | Sales bills | id, bill_number, customer_id, total_amount, payment_mode, status |
| `bill_items` | Bill line items | id, bill_id, product_id, quantity, unit_price, tax_amount |
| `stock` | Inventory stock | id, product_id, quantity, batch_number, expiry_date |
| `stock_movements` | Stock history | id, product_id, movement_type, quantity, reference_id |
| `loyalty_transactions` | Loyalty history | id, customer_id, transaction_type, points, reference_id |
| `employees` | Employee master | id, name, phone, role, pin, is_active |
| `shifts` | Shift assignments | id, employee_id, shift_date, start_time, end_time |
| `attendance` | Attendance records | id, employee_id, clock_in, clock_out, status |
| `audit_logs` | Audit trail | id, user_id, action, entity_type, entity_id, old_value, new_value |
| `sync_queue` | Sync queue | id, entity_type, entity_id, operation, status, retry_count |
| `settings` | System settings | id, key, value, category |

## 5. API Contracts

### 5.1 Core API Endpoints

| Module | Endpoint | Method | Description |
|--------|----------|--------|-------------|
| **Auth** | `/api/auth/login` | POST | User login |
| **Auth** | `/api/auth/refresh` | POST | Refresh token |
| **Auth** | `/api/auth/validate-pin` | POST | Validate employee PIN |
| **Products** | `/api/products` | GET | Get products list |
| **Products** | `/api/products/{id}` | GET | Get product by ID |
| **Products** | `/api/products` | POST | Create product |
| **Products** | `/api/products/{id}` | PUT | Update product |
| **Products** | `/api/products/search` | GET | Search products |
| **Customers** | `/api/customers` | GET | Get customers list |
| **Customers** | `/api/customers/{id}` | GET | Get customer by ID |
| **Customers** | `/api/customers` | POST | Create customer |
| **Customers** | `/api/customers/{id}/history` | GET | Get purchase history |
| **Bills** | `/api/bills` | GET | Get bills list |
| **Bills** | `/api/bills/{id}` | GET | Get bill by ID |
| **Bills** | `/api/bills` | POST | Create bill |
| **Bills** | `/api/bills/{id}/return` | POST | Return bill |
| **Inventory** | `/api/inventory` | GET | Get stock list |
| **Inventory** | `/api/inventory/adjust` | POST | Adjust stock |
| **Inventory** | `/api/inventory/transfer` | POST | Transfer stock |
| **Loyalty** | `/api/loyalty/{customerId}` | GET | Get loyalty balance |
| **Loyalty** | `/api/loyalty/earn` | POST | Earn points |
| **Loyalty** | `/api/loyalty/redeem` | POST | Redeem points |
| **Sync** | `/api/sync/upload` | POST | Upload sync data |
| **Sync** | `/api/sync/download` | POST | Download sync data |

### 5.2 Request/Response Format

```json
// Standard API Response
{
  "success": true,
  "data": {
    "id": "uuid",
    "attributes": {}
  },
  "meta": {
    "timestamp": "2026-07-24T10:30:00Z",
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

## 6. Sync Engine Design

### 6.1 Sync Process

```
┌─────────────────────────────────────────────────────────────┐
│                    SYNC ENGINE PROCESS                        │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  1. Data Write (Offline)                                    │
│     └──► Write to SQLite + Add to Sync Queue                │
│                                                              │
│  2. Queue Management                                        │
│     └──► Priority Queue (HIGH/MEDIUM/LOW)                   │
│                                                              │
│  3. Network Check                                           │
│     └──► Online/Offline Detection                           │
│                                                              │
│  4. Process Queue                                           │
│     └──► Group by Entity Type + Process in Order            │
│                                                              │
│  5. Send to Server                                          │
│     └──► POST /api/sync/upload                              │
│                                                              │
│  6. Server Processing                                       │
│     └──► Validate + Check Conflicts + Apply Changes         │
│                                                              │
│  7. Handle Response                                         │
│     └──► Success: Update Status | Conflict: Resolve         │
│                                                              │
│  8. Retry Logic                                             │
│     └──► Exponential Backoff (2^n seconds)                  │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### 6.2 Conflict Resolution

| Strategy | Description | Use Case |
|----------|-------------|----------|
| **Last Write Wins** | Most recent timestamp wins | Non-critical data |
| **Field Level Merge** | Merge different fields | Customer profiles |
| **Server Wins** | Server version always wins | Critical data |
| **Client Wins** | Client version always wins | Offline edits |
| **Manual Resolution** | Flag for user review | Critical conflicts |

## 7. Offline-First Features

### 7.1 Capabilities

- **Billing Without Internet**: Full billing capability offline
- **Customer Lookup**: Search customers by phone/name offline
- **Stock Updates**: Record stock changes offline
- **Loyalty Earning**: Earn points offline
- **Receipt Generation**: Generate receipts offline
- **Data Sync**: Background sync when online

### 7.2 Storage Strategy

| Storage Type | Technology | Purpose |
|--------------|------------|---------|
| **Local Database** | SQLite + Drift | All master data and transactions |
| **File System** | App Directory | Invoices, images, backups |
| **Secure Storage** | Keychain/Keystore | Tokens, credentials |

## 8. Security Features

### 8.1 Authentication

- JWT-based authentication
- Role-based access control
- PIN-based employee login
- Session management
- Device whitelisting

### 8.2 Data Security

- Encrypted local storage
- Secure API communication (HTTPS)
- Password hashing (bcrypt)
- Sensitive data encryption
- Audit logging

## 9. Development Workflow

### 9.1 Branch Strategy

```
main (production)
├── develop (development)
│   ├── feature/billing
│   ├── feature/inventory
│   ├── feature/loyalty
│   └── feature/sync-engine
├── release/v1.0
└── hotfix/bug-fix
```

### 9.2 Commit Convention

```
feat: add billing module
fix: resolve sync conflict issue
docs: update API documentation
test: add unit tests for inventory
refactor: optimize database queries
chore: update dependencies
```

## 10. Testing Strategy

### 10.1 Test Types

| Type | Coverage | Tools |
|------|----------|-------|
| **Unit Tests** | 80%+ | Flutter test, xUnit |
| **Integration Tests** | Core flows | Integration test |
| **E2E Tests** | Critical paths | Flutter Driver |
| **Performance Tests** | Key operations | Load testing |

### 10.2 Test Scenarios

- Offline billing flow
- Sync conflict resolution
- Stock accuracy
- Loyalty calculations
- GST calculations
- Payment processing

## 11. Deployment

### 11.1 Environments

| Environment | Purpose | Database |
|-------------|---------|----------|
| **Development** | Local development | SQLite |
| **Testing** | QA testing | PostgreSQL (Test) |
| **Staging** | Pre-production | PostgreSQL (Staging) |
| **Production** | Live system | PostgreSQL (Production) |

### 11.2 Deployment Process

1. Code review and approval
2. Automated testing
3. Build and package
4. Deploy to staging
5. UAT testing
6. Deploy to production
7. Monitor and validate

## 12. Monitoring & Support

### 12.1 Monitoring

- Application performance monitoring
- Error tracking and alerting
- Database performance monitoring
- Sync queue monitoring
- User activity logging

### 12.2 Support

- Documentation and guides
- In-app help system
- Email support
- Phone support
- Remote assistance

## 13. Future Enhancements

### Version 2.0
- Multi-branch support
- Advanced analytics
- AI-powered insights
- Mobile app enhancements

### Version 3.0
- E-commerce integration
- Advanced reporting
- Machine learning features
- International expansion

---

## Document Index

| Document | Description |
|----------|-------------|
| `ARCHITECTURE.md` | Complete system architecture |
| `FOLDER_STRUCTURE.md` | Project folder structure |
| `DATA_TYPES.md` | Data types and entity definitions |
| `API_CONTRACTS.md` | API endpoint specifications |
| `SYNC_ENGINE.md` | Sync engine design |
| `ROADMAP.md` | Project roadmap and phases |
| `MIND_MAP.md` | Visual mind maps |
| `SOLUTION.md` | This document |

---

**SS MART** - Empowering Indian Retail with Technology

*Built with love for the Indian retail ecosystem*
