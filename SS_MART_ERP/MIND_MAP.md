# SS MART - Project Mind Map

## 1. System Overview Mind Map

```
SS MART Retail ERP System
│
├─── OFFLINE-FIRST ARCHITECTURE
│    ├─── Local SQLite Database
│    │    ├─── Products Table
│    │    ├─── Customers Table
│    │    ├─── Bills Table
│    │    ├─── Stock Table
│    │    ├─── Loyalty Table
│    │    ├─── Employees Table
│    │    └─── Audit Logs Table
│    │
│    ├─── Background Sync Service
│    │    ├─── Queue Manager
│    │    ├─── Network Monitor
│    │    ├─── Retry Logic
│    │    └─── Conflict Resolution
│    │
│    └─── Offline Capabilities
│         ├─── Billing Without Internet
│         ├─── Customer Lookup
│         ├─── Stock Updates
│         ├─── Loyalty Earning
│         └─── Receipt Generation
│
├─── CORE MODULES
│    ├─── Billing/POS Module
│    │    ├─── Quick Billing
│    │    ├─── Barcode Scanning
│    │    ├─── Product Search
│    │    ├─── Cart Management
│    │    ├─── GST Calculation
│    │    ├─── Payment Processing
│    │    ├─── Invoice Generation
│    │    └─── Receipt Printing
│    │
│    ├─── Inventory Module
│    │    ├─── Product Master
│    │    ├─── Stock Management
│    │    ├─── Batch Tracking
│    │    ├─── Expiry Management
│    │    ├─── Stock Transfers
│    │    ├─── Stock Adjustments
│    │    ├─── Reorder Alerts
│    │    └─── Inventory Reports
│    │
│    ├─── Customer CRM Module
│    │    ├─── Customer Profiles
│    │    ├─── Purchase History
│    │    ├─── Outstanding Tracking
│    │    ├─── Credit Management
│    │    ├─── Customer Groups
│    │    ├─── Communication History
│    │    └─── Customer Reports
│    │
│    ├─── Loyalty Module
│    │    ├─── Points Earning Rules
│    │    ├─── Points Redemption
│    │    ├─── Loyalty Balance
│    │    ├─── Expiry Management
│    │    ├─── Loyalty Cards
│    │    └─── Loyalty Reports
│    │
│    ├─── Purchase Module
│    │    ├─── Supplier Management
│    │    ├─── Purchase Orders
│    │    ├─── Purchase Invoices
│    │    ├─── Stock Receiving
│    │    ├─── Supplier Dues
│    │    └─── Purchase Reports
│    │
│    ├─── Employee Module
│    │    ├─── Employee Profiles
│    │    ├─── Role Management
│    │    ├─── PIN Authentication
│    │    ├─── Attendance Tracking
│    │    ├─── Shift Scheduling
│    │    ├─── Performance Tracking
│    │    └─── Employee Reports
│    │
│    ├─── Reports Module
│    │    ├─── Sales Reports
│    │    ├─── Inventory Reports
│    │    ├─── Financial Reports
│    │    ├─── Tax Reports (GST)
│    │    ├─── Customer Reports
│    │    ├─── Loyalty Reports
│    │    ├─── Employee Reports
│    │    └─── Custom Reports
│    │
│    └─── Admin Module
│         ├─── Company Settings
│         ├─── Tax Configuration
│         ├─── User Management
│         ├─── Permissions Control
│         ├─── Backup/Restore
│         ├─── Import/Export
│         ├─── Audit Logs
│         └─── System Settings
│
├─── TECHNOLOGY STACK
│    ├─── Frontend: Flutter
│    │    ├─── Mobile (Android/iOS)
│    │    ├─── Desktop (Windows/macOS/Linux)
│    │    ├─── Shared Codebase
│    │    └─── Platform-Specific Features
│    │
│    ├─── Backend: .NET 8 ASP.NET Core
│    │    ├─── REST API
│    │    ├─── JWT Authentication
│    │    ├─── Role-Based Access
│    │    ├─── Background Services
│    │    └─── Health Checks
│    │
│    ├─── Database: PostgreSQL
│    │    ├─── Server Database
│    │    ├─── Data Replication
│    │    ├─── Backup/Restore
│    │    └─── Performance Tuning
│    │
│    ├─── Local Database: SQLite + Drift
│    │    ├─── Offline Storage
│    │    ├─── Data Synchronization
│    │    ├─── Query Optimization
│    │    └─── Migration Support
│    │
│    └─── Infrastructure
│         ├─── Redis (Cache/Queue)
│         ├─── S3 Storage (Files)
│         ├─── Docker Containers
│         ├─── CI/CD Pipeline
│         └─── Monitoring & Logging
│
└─── KEY FEATURES
     ├─── Offline-First Design
     ├─── Real-Time Sync
     ├─── Conflict Resolution
     ├─── Multi-Platform Support
     ├─── Role-Based Security
     ├─── Audit Logging
     ├─── Data Backup/Restore
     ├─── Import/Export
     ├─── GST Compliance
     ├─── HSN/SAC Support
     ├─── B2B/B2C Support
     ├─── Credit Management
     ├─── Loyalty Program
     ├─── Multi-Location Stock
     ├─── Batch/Expiry Tracking
     ├─── Employee Management
     ├─── Shift Scheduling
     ├─── Attendance Tracking
     ├─── Performance Analytics
     └─── Custom Reports
```

## 2. Data Flow Mind Map

```
Data Flow Architecture
│
├─── USER INTERACTIONS
│    ├─── Cashier Actions
│    │    ├─── Scan Barcode
│    │    ├─── Search Product
│    │    ├─── Add to Cart
│    │    ├─── Apply Discount
│    │    ├─── Select Customer
│    │    ├─── Process Payment
│    │    └─── Print Receipt
│    │
│    ├─── Manager Actions
│    │    ├─── Stock Adjustment
│    │    ├─── Price Changes
│    │    ├─── Discount Approval
│    │    ├─── Return Processing
│    │    ├─── Report Generation
│    │    └─── Employee Management
│    │
│    └─── Admin Actions
│         ├─── System Configuration
│         ├─── User Management
│         ├─── Backup/Restore
│         ├─── Data Import/Export
│         ├─── Audit Log Review
│         └─── System Maintenance
│
├─── DATA PROCESSING
│    ├─── Local Processing (SQLite)
│    │    ├─── Write Operations
│    │    │    ├─── Create Bill
│    │    │    ├─── Update Stock
│    │    │    ├─── Add Customer
│    │    │    ├─── Earn Points
│    │    │    └─── Log Audit
│    │    │
│    │    ├─── Read Operations
│    │    │    ├─── Product Search
│    │    │    ├─── Customer Lookup
│    │    │    ├─── Stock Check
│    │    │    ├─── Bill History
│    │    │    └─── Reports
│    │    │
│    │    └─── Sync Queue
│    │         ├─── Add to Queue
│    │         ├─── Set Priority
│    │         ├─── Mark Pending
│    │         └─── Track Status
│    │
│    └─── Server Processing (PostgreSQL)
│         ├─── Data Validation
│         ├─── Conflict Detection
│         ├─── Version Control
│         ├─── Data Merge
│         └─── Response Generation
│
├─── SYNC ENGINE
│    ├─── Upload Process
│    │    ├─── Check Network
│    │    ├─── Get Pending Items
│    │    ├─── Group by Type
│    │    ├─── Send to Server
│    │    ├─── Handle Response
│    │    └─── Update Status
│    │
│    ├─── Download Process
│    │    ├─── Check Last Sync
│    │    ├─── Request Updates
│    │    ├─── Receive Data
│    │    ├─── Apply Changes
│    │    └─── Update Local
│    │
│    └─── Conflict Resolution
│         ├─── Version Conflict
│         ├─── Timestamp Conflict
│         ├─── Field Conflict
│         ├─── Resolution Strategy
│         └─── Audit Logging
│
└─── BUSINESS PROCESSES
     ├─── Sales Process
     │    ├─── Product Selection
     │    ├─── Cart Building
     │    ├─── Price Calculation
     │    ├─── Tax Application
     │    ├─── Discount Application
     │    ├─── Payment Processing
     │    ├─── Bill Generation
     │    ├─── Stock Update
     │    ├─── Loyalty Update
     │    └─── Receipt Printing
     │
     ├─── Purchase Process
     │    ├─── Supplier Selection
     │    ├─── Product Selection
     │    ├─── Order Creation
     │    ├─── Stock Receiving
     │    ├─── Quality Check
     │    ├─── Invoice Matching
     │    ├─── Payment Processing
     │    └─── Stock Update
     │
     └─── Inventory Process
          ├─── Stock Monitoring
          ├─── Reorder Alerts
          ├─── Stock Transfer
          ├─── Stock Adjustment
          ├─── Batch Management
          ├─── Expiry Management
          ├─── Physical Count
          └─── Discrepancy Resolution
```

## 3. Module Dependencies Mind Map

```
Module Dependencies
│
├─── CORE DEPENDENCIES
│    ├─── Authentication Module
│    │    ├─── Depends On: User Management
│    │    ├─── Provides: JWT Tokens
│    │    ├─── Provides: Role Validation
│    │    └─── Used By: All Modules
│    │
│    ├─── Product Module
│    │    ├─── Depends On: Category Module
│    │    ├─── Depends On: Supplier Module
│    │    ├─── Provides: Product Data
│    │    └─── Used By: Billing, Inventory, Purchase
│    │
│    └─── Customer Module
│         ├─── Depends On: Address Module
│         ├─── Provides: Customer Data
│         └─── Used By: Billing, Loyalty, Reports
│
├─── BILLING DEPENDENCIES
│    ├─── Billing Module
│    │    ├─── Depends On: Product Module
│    │    ├─── Depends On: Customer Module
│    │    ├─── Depends On: Tax Module
│    │    ├─── Depends On: Discount Module
│    │    ├─── Depends On: Payment Module
│    │    ├─── Provides: Bill Data
│    │    └─── Used By: Reports, Loyalty, Inventory
│    │
│    ├─── Tax Module (GST)
│    │    ├─── Depends On: HSN/SAC Module
│    │    ├─── Depends On: Location Module
│    │    ├─── Provides: Tax Calculations
│    │    └─── Used By: Billing, Purchase, Reports
│    │
│    └─── Payment Module
│         ├─── Depends On: Customer Module
│         ├─── Provides: Payment Processing
│         └─── Used By: Billing, Purchase
│
├─── INVENTORY DEPENDENCIES
│    ├─── Inventory Module
│    │    ├─── Depends On: Product Module
│    │    ├─── Depends On: Location Module
│    │    ├─── Depends On: Batch Module
│    │    ├─── Provides: Stock Data
│    │    └─── Used By: Billing, Purchase, Reports
│    │
│    ├─── Purchase Module
│    │    ├─── Depends On: Product Module
│    │    ├─── Depends On: Supplier Module
│    │    ├─── Depends On: Inventory Module
│    │    ├─── Provides: Purchase Data
│    │    └─── Used By: Inventory, Reports
│    │
│    └─── Batch Module
│         ├─── Depends On: Product Module
│         ├─── Provides: Batch Data
│         └─── Used By: Inventory, Billing
│
├─── LOYALTY DEPENDENCIES
│    ├─── Loyalty Module
│    │    ├─── Depends On: Customer Module
│    │    ├─── Depends On: Billing Module
│    │    ├─── Depends On: Rules Engine
│    │    ├─── Provides: Loyalty Data
│    │    └─── Used By: Billing, Reports
│    │
│    └─── Rules Engine
│         ├─── Provides: Business Rules
│         └─── Used By: Loyalty, Discount, Tax
│
└─── EMPLOYEE DEPENDENCIES
     ├─── Employee Module
     │    ├─── Depends On: User Management
     │    ├─── Provides: Employee Data
     │    └─── Used By: Billing, Reports
     │
     ├─── Shift Module
     │    ├─── Depends On: Employee Module
     │    ├─── Provides: Shift Data
     │    └─── Used By: Attendance, Reports
     │
     └─── Attendance Module
          ├─── Depends On: Employee Module
          ├─── Depends On: Shift Module
          ├─── Provides: Attendance Data
          └─── Used By: Reports, Payroll
```

## 4. User Roles Mind Map

```
User Roles & Permissions
│
├─── ADMIN ROLE
│    ├─── Full System Access
│    ├─── User Management
│    │    ├─── Create Users
│    │    ├─── Edit Users
│    │    ├─── Delete Users
│    │    └─── Assign Roles
│    ├─── System Configuration
│    │    ├─── Company Settings
│    │    ├─── Tax Configuration
│    │    ├─── Numbering Settings
│    │    └─── Permission Settings
│    ├─── Data Management
│    │    ├─── Backup/Restore
│    │    ├─── Import/Export
│    │    └─── Data Migration
│    ├─── Audit Access
│    │    ├─── View Audit Logs
│    │    ├─── Export Audit Logs
│    │    └─── Investigate Issues
│    └─── Override Capabilities
│         ├─── Override Transactions
│         ├─── Override Permissions
│         └─── Emergency Access
│
├─── MANAGER ROLE
│    ├─── Billing Operations
│    │    ├─── Create Bills
│    │    ├─── Edit Bills
│    │    ├─── Cancel Bills
│    │    └─── Process Returns
│    ├─── Inventory Management
│    │    ├─── Stock Adjustments
│    │    ├─── Stock Transfers
│    │    ├─── Price Changes
│    │    └─── Product Management
│    ├─── Customer Management
│    │    ├─── Create Customers
│    │    ├─── Edit Customers
│    │    ├─── Credit Approval
│    │    └─── Loyalty Management
│    ├─── Reports Access
│    │    ├─── Sales Reports
│    │    ├─── Inventory Reports
│    │    ├─── Financial Reports
│    │    └─── Employee Reports
│    └─── Employee Oversight
│         ├─── View Employee Activity
│         ├─── Approve Shifts
│         └─── Performance Review
│
├─── CASHIER ROLE
│    ├─── Billing Only
│    │    ├─── Create Bills
│    │    ├─── Process Payments
│    │    └─── Print Receipts
│    ├─── Customer Lookup
│    │    ├─── Search Customers
│    │    ├─── View Customer Info
│    │    └─── Add New Customers
│    ├─── Limited Inventory View
│    │    ├─── Check Stock
│    │    └─── View Product Info
│    └─── No System Settings
│         ├─── Cannot Access Settings
│         ├─── Cannot Modify Config
│         └─── Cannot View Reports
│
├─── INVENTORY ROLE
│    ├─── Stock Management
│    │    ├─── Stock Adjustments
│    │    ├─── Stock Transfers
│    │    ├─── Physical Count
│    │    └─── Discrepancy Resolution
│    ├─── Purchase Management
│    │    ├─── Create Purchase Orders
│    │    ├─── Receive Stock
│    │    └─── Supplier Management
│    ├─── Product Management
│    │    ├─── Add Products
│    │    ├─── Edit Products
│    │    ├─── Manage Categories
│    │    └─── Manage Suppliers
│    └─── Inventory Reports
│         ├─── Stock Reports
│         ├─── Purchase Reports
│         └─── Movement Reports
│
└─── VIEWER ROLE
     ├─── Read-Only Access
     │    ├─── View Reports
     │    ├─── View Dashboard
     │    └─── View Analytics
     ├─── No Modifications
     │    ├─── Cannot Create
     │    ├─── Cannot Edit
     │    └─── Cannot Delete
     └─── Limited Access
          ├─── No Sensitive Data
          ├─── No Financial Data
          └─── No Employee Data
```

## 5. Screen Navigation Mind Map

```
App Navigation Structure
│
├─── LOGIN SCREEN
│    ├─── Username/Phone Input
│    ├─── Password/PIN Input
│    ├─── Remember Me
│    ├─── Forgot Password
│    └─── Login Button
│
├─── DASHBOARD (Main Screen)
│    ├─── Today's Summary
│    │    ├─── Total Sales
│    │    ├─── Total Bills
│    │    ├─── Total Customers
│    │    └─── Low Stock Alerts
│    ├─── Quick Actions
│    │    ├─── New Bill
│    │    ├─── Search Product
│    │    ├─── Search Customer
│    │    └─── View Reports
│    ├─── Recent Activity
│    │    ├─── Recent Bills
│    │    ├─── Recent Customers
│    │    └─── Recent Products
│    └─── Navigation Menu
│         ├─── Billing
│         ├─── Products
│         ├─── Customers
│         ├─── Inventory
│         ├─── Purchases
│         ├─── Loyalty
│         ├─── Employees
│         ├─── Reports
│         └─── Settings
│
├─── BILLING SCREEN
│    ├─── Customer Selection
│    │    ├─── Search by Phone
│    │    ├─── Search by Name
│    │    ├─── Scan Loyalty Card
│    │    └─── Walk-in Customer
│    ├─── Product Selection
│    │    ├─── Barcode Scanner
│    │    ├─── Product Search
│    │    ├─── Category Browse
│    │    └─── Recent Products
│    ├─── Cart Management
│    │    ├─── Add Items
│    │    ├─── Update Quantity
│    │    ├─── Remove Items
│    │    ├─── Apply Discount
│    │    └─── Apply Scheme
│    ├─── Price Summary
│    │    ├─── Subtotal
│    │    ├─── Tax (GST)
│    │    ├─── Discount
│    │    ├─── Round Off
│    │    └─── Grand Total
│    ├─── Payment Processing
│    │    ├─── Cash Payment
│    │    ├─── UPI Payment
│    │    ├─── Card Payment
│    │    ├─── Credit Payment
│    │    └─── Split Payment
│    └─── Bill Actions
│         ├─── Save Bill
│         ├─── Print Receipt
│         ├─── WhatsApp Receipt
│         ├─── Email Receipt
│         └─── Clear Bill
│
├─── PRODUCTS SCREEN
│    ├─── Product List
│    │    ├─── Search Products
│    │    ├─── Filter by Category
│    │    ├─── Sort by Name/Price
│    │    └─── View Product Details
│    ├─── Add/Edit Product
│    │    ├─── Basic Info
│    │    │    ├─── Name
│    │    │    ├─── SKU
│    │    │    ├─── Barcode
│    │    │    └─── HSN Code
│    │    ├─── Pricing Info
│    │    │    ├─── MRP
│    │    │    ├─── Selling Price
│    │    │    ├─── Purchase Price
│    │    │    └─── Tax Rate
│    │    ├─── Stock Info
│    │    │    ├─── Current Stock
│    │    │    ├─── Reorder Level
│    │    │    └─── Unit Type
│    │    └─── Other Info
│    │         ├─── Category
│    │         ├─── Supplier
│    │         └─── Description
│    └─── Product Actions
│         ├─── View Stock
│         ├─── Stock History
│         ├─── Price History
│         └─── Sales History
│
├─── CUSTOMERS SCREEN
│    ├─── Customer List
│    │    ├─── Search Customers
│    │    ├─── Filter by Type
│    │    ├─── Sort by Name/Phone
│    │    └─── View Customer Details
│    ├─── Add/Edit Customer
│    │    ├─── Basic Info
│    │    │    ├─── Name
│    │    │    ├─── Phone
│    │    │    ├─── Email
│    │    │    └─── Address
│    │    ├─── Business Info
│    │    │    ├─── GSTIN
│    │    │    ├─── Customer Type
│    │    │    └─── Credit Limit
│    │    └─── Loyalty Info
│    │         ├─── Loyalty Card Number
│    │         └─── Loyalty Points
│    └─── Customer Actions
│         ├─── Purchase History
│         ├─── Outstanding Balance
│         ├─── Loyalty Balance
│         ├─── Communication History
│         └─── Send Statement
│
├─── INVENTORY SCREEN
│    ├─── Stock Summary
│    │    ├─── Total Products
│    │    ├─── Total Stock Value
│    │    ├─── Low Stock Items
│    │    └─── Out of Stock Items
│    ├─── Stock List
│    │    ├─── Search Products
│    │    ├─── Filter by Location
│    │    ├─── Filter by Batch
│    │    └─── View Stock Details
│    ├─── Stock Operations
│    │    ├─── Stock Adjustment
│    │    │    ├─── Add Stock
│    │    │    ├─── Remove Stock
│    │    │    └─── Reason for Adjustment
│    │    ├─── Stock Transfer
│    │    │    ├─── From Location
│    │    │    ├─── To Location
│    │    │    └─── Quantity
│    │    └─── Physical Count
│    │        ├─── Count Sheet
│    │        ├─── Enter Counts
│    │        └─── Variance Report
│    └─── Stock Reports
│         ├─── Stock Statement
│         ├─── Stock Movement
│         ├─── Batch Report
│         └─── Expiry Report
│
├─── PURCHASES SCREEN
│    ├─── Purchase List
│    │    ├─── Search Purchases
│    │    ├─── Filter by Supplier
│    │    ├─── Filter by Date
│    │    └─── View Purchase Details
│    ├─── Create Purchase
│    │    ├─── Select Supplier
│    │    ├─── Add Products
│    │    ├─── Enter Quantities
│    │    ├─── Enter Prices
│    │    └─── Save Purchase Order
│    ├─── Receive Stock
│    │    ├─── Select Purchase Order
│    │    ├─── Enter Received Qty
│    │    ├─── Check Quality
│    │    └─── Update Stock
│    └─── Purchase Reports
│         ├─── Purchase Summary
│         ├─── Supplier Report
│         ├─── Outstanding Report
│         └─── Stock Received Report
│
├─── LOYALTY SCREEN
│    ├─── Loyalty Summary
│    │    ├─── Total Points Issued
│    │    ├─── Total Points Redeemed
│    │    ├─── Outstanding Points
│    │    └─── Expiring Points
│    ├─── Customer Loyalty
│    │    ├─── Search Customer
│    │    ├─── View Balance
│    │    ├─── Earn Points
│    │    ├─── Redeem Points
│    │    └─── View History
│    ├─── Loyalty Rules
│    │    ├─── Earning Rules
│    │    ├─── Redemption Rules
│    │    ├─── Expiry Rules
│    │    └─── Bonus Rules
│    └─── Loyalty Reports
│         ├─── Points Summary
│         ├─── Redemption Report
│         ├─── Expiry Report
│         └─── Customer Wise Report
│
├─── EMPLOYEES SCREEN
│    ├─── Employee List
│    │    ├─── Search Employees
│    │    ├─── Filter by Role
│    │    ├─── View Employee Details
│    │    └─── View Attendance
│    ├─── Add/Edit Employee
│    │    ├─── Basic Info
│    │    │    ├─── Name
│    │    │    ├─── Phone
│    │    │    ├─── Email
│    │    │    └─── Role
│    │    ├─── Authentication
│    │    │    ├─── Username
│    │    │    ├─── Password
│    │    │    └─── PIN
│    │    └─── Work Info
│    │        ├─── Shift
│    │        ├─── Department
│    │        └─── Salary
│    └─── Employee Actions
│         ├─── Clock In/Out
│         ├─── View Attendance
│         ├─── View Schedule
│         └─── View Performance
│
├─── REPORTS SCREEN
│    ├─── Sales Reports
│    │    ├─── Daily Sales
│    │    ├─── Monthly Sales
│    │    ├─── Product Wise Sales
│    │    ├─── Category Wise Sales
│    │    ├─── Employee Wise Sales
│    │    └─── Sales Comparison
│    ├─── Inventory Reports
│    │    ├─── Stock Statement
│    │    ├─── Stock Movement
│    │    ├─── Low Stock Report
│    │    ├─── Expiry Report
│    │    ├─── Batch Report
│    │    └─── Valuation Report
│    ├─── Financial Reports
│    │    ├─── Profit & Loss
│    │    ├─── Cash Flow
│    │    ├─── Outstanding Report
│    │    ├─── Credit Report
│    │    └─── Tax Report
│    ├─── Customer Reports
│    │    ├─── Customer List
│    │    ├─── Purchase History
│    │    ├─── Outstanding Balance
│    │    ├─── Loyalty Summary
│    │    └─── Customer Analytics
│    └─── Employee Reports
│         ├─── Attendance Report
│         ├─── Performance Report
│         ├─── Sales by Employee
│         ├─── Shift Report
│         └─── Hours Worked
│
└─── SETTINGS SCREEN
     ├─── Company Settings
     │    ├─── Store Name
     │    ├─── Address
     │    ├─── Phone
     │    ├─── Email
     │    ├─── GSTIN
     │    └─── Logo
     ├─── Tax Settings
     │    ├─── GST Rates
     │    ├─── HSN/SAC Codes
     │    ├─── Tax Types
     │    └─── Tax Rules
     ├─── Numbering Settings
     │    ├─── Invoice Numbering
     │    ├─── Purchase Numbering
     │    ├─── Customer Numbering
     │    └─── Product Numbering
     ├─── User Management
     │    ├─── Add Users
     │    ├─── Edit Users
     │    ├─── Delete Users
     │    └─── Assign Roles
     ├─── Backup/Restore
     │    ├─── Create Backup
     │    ├─── Restore Backup
     │    ├─── Auto Backup
     │    └─── Export Data
     ├─── Import/Export
     │    ├─── Import Products
     │    ├─── Import Customers
     │    ├─── Import Stock
     │    ├─── Export Data
     │    └─── Export Reports
     └─── Audit Logs
          ├─── View Logs
          ├─── Filter Logs
          ├─── Export Logs
          └─── Clear Logs
```

This comprehensive mind map provides a visual representation of the SS MART retail ERP system architecture, data flows, module dependencies, user roles, and screen navigation.
