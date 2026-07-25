# SS MART ERP — Version Plan: Marg ERP Feature Parity

> **Branch:** `feature/v2-marg-parity`  
> **Target:** Full Marg ERP 9+ feature parity for Indian retail/pharma/FMCG  
> **Created:** 2026-07-25  
> **Author:** SS MART Development Team

---

## Executive Summary

This document defines every feature gap between SS MART ERP v1.0 (current) and Marg ERP 9+ (the gold standard for Indian retail ERP). Each feature is categorized by priority, complexity, and affected modules. This is the single source of truth for all development work on this branch.

---

## Current State (v1.0 — 32 tables, 240+ files)

### What's Working
- Auth with PIN-based login
- Products with basic pricing (MRP, selling price, purchase price)
- Billing/POS with basic GST (CGST/SGST/IGST)
- Inventory with batch/expiry tracking
- Customers with groups and tags
- Employees with attendance and shifts
- Purchases with supplier management
- 19 report types with Excel/PDF export
- Loyalty points (basic earn/redeem)
- Offline-first with sync queue
- Barcode scanner (camera-based)
- Receipt printing (PDF-based)
- Import/Export (CSV, DBF, Excel)
- Backup/Restore
- Settings with tax config

### Critical Gaps (vs Marg ERP 9+)
1. **No multi-rate pricing** — Marg supports Rate A/B/C, wholesale, retail, MRP
2. **No bundle packs/formulas** — Marg can group items into sellable bundles
3. **No scheme management** — Marg has Buy X Get Y, date-wise, qty-wise schemes
4. **No custom invoice designer** — Marg has GUI/DMP format designers
5. **No custom label/barcode designer** — Marg can create custom barcode labels
6. **No challan management** — Marg tracks delivery challans separately from bills
7. **No proper GST engine** — Missing HSN lookup, rate-wise GST, TDS/TCS, e-invoice
8. **No purchase deal history** — Marg shows last 4 deals at time of billing
9. **No party-wise pricing** — Marg allows per-customer pricing overrides
10. **No multi-discount system** — Marg supports 4 discounts per bill + item-wise discounts

---

## Feature Catalog (All Missing Features)

### Module 1: Rate & Pricing Engine

| ID | Feature | Priority | Complexity | Status |
|----|---------|----------|------------|--------|
| R-01 | Multi-rate pricing (Rate A/B/C/D) per product | P0 | Medium | Missing |
| R-02 | Wholesale / Retail / Special rate tiers | P0 | Medium | Missing |
| R-03 | Party-wise rate override (per customer pricing) | P0 | Medium | Missing |
| R-04 | Company-wise special rates | P1 | Medium | Missing |
| R-05 | Quantity-wise rate breaks (volume pricing) | P1 | Medium | Missing |
| R-06 | Self-defined price list formulas | P1 | High | Missing |
| R-07 | Price list with conversion quantity view | P1 | Low | Missing |
| R-08 | Import item rates from Excel | P2 | Low | Missing |
| R-09 | Print item price list | P2 | Low | Missing |
| R-10 | Export price list to Excel | P2 | Low | Missing |

**Database Changes:**
- New table: `ProductRates` (product_id, rate_type, rate_name, rate_value, min_qty, max_qty, effective_from, effective_to)
- New table: `PartyRates` (customer_id, product_id, rate_type, rate_value, effective_from, effective_to)
- Modify `Products`: Add `rateA`, `rateB`, `rateC`, `wholesaleRate`, `specialRate` columns

---

### Module 2: Discount & Scheme Engine

| ID | Feature | Priority | Complexity | Status |
|----|---------|----------|------------|--------|
| D-01 | Item-wise double percentage discount | P0 | Medium | Missing |
| D-02 | Item-wise double volume discount | P0 | Medium | Missing |
| D-03 | Four different discounts on complete bill | P0 | Medium | Missing |
| D-04 | Party-wise discounts pre-fixing | P0 | Medium | Missing |
| D-05 | Date-wise schemes (seasonal offers) | P1 | Medium | Missing |
| D-06 | Quantity-based rate & discounts | P1 | Medium | Missing |
| D-07 | Buy X Get Y free schemes | P1 | Medium | Missing |
| D-08 | Group-wise scheme management | P1 | Medium | Missing |
| D-09 | Bill-value-wise discount tiers | P1 | Low | Missing |
| D-10 | Party categorization for discounts | P2 | Low | Missing |
| D-11 | Company-wise party discount | P2 | Low | Missing |
| D-12 | Sales scheme on purchase discount | P2 | Medium | Missing |
| D-13 | My own sales scheme (custom schemes) | P2 | Medium | Missing |
| D-14 | Special rates / discounts management | P1 | Medium | Missing |

**Database Changes:**
- New table: `DiscountRules` (id, rule_name, discount_type, discount_value, applies_to, min_qty, min_amount, party_id, product_id, category_id, start_date, end_date, priority)
- New table: `SchemeRules` (id, scheme_name, scheme_type, trigger_qty, free_qty, discount_percent, applies_to, start_date, end_date, priority, is_active)
- Modify `BillItems`: Add `discount1`, `discount2`, `discount3`, `discount4` columns
- Modify `Bills`: Add `discount1`, `discount2`, `discount3`, `discount4` columns

---

### Module 3: Custom Invoice & Print Format Designer

| ID | Feature | Priority | Complexity | Status |
|----|---------|----------|------------|--------|
| F-01 | GUI invoice format designer (visual) | P0 | Very High | Missing |
| F-02 | DMP invoice format designer (text-based) | P1 | High | Missing |
| F-03 | Thermal receipt format designer | P0 | High | Missing |
| F-04 | A4/A3/A5/Legal/Letter page support | P0 | Medium | Missing |
| F-05 | Header / Item / Grand Total sections | P0 | Medium | Missing |
| F-06 | Variable commands (bill no, date, party, etc.) | P0 | Medium | Missing |
| F-07 | Font / color / size customization | P1 | Medium | Missing |
| F-08 | Horizontal/vertical line drawing | P1 | Low | Missing |
| F-09 | Amount in words | P0 | Low | Missing |
| F-10 | Multiple format support (invoice, challan, estimate) | P1 | Medium | Missing |
| F-11 | Import/Export format files | P2 | Medium | Missing |
| F-12 | Copy format between document types | P2 | Low | Missing |
| F-13 | Pre-printed stationery support | P1 | Low | Missing |
| F-14 | Multiple taxes in single invoice | P0 | Medium | Missing |
| F-15 | Tax inclusive / exclusive / MRP billing modes | P0 | Medium | Missing |
| F-16 | Export invoice & packing slip | P1 | Medium | Missing |
| F-17 | Manufacturing/Trading excise invoice | P2 | High | Missing |

---

### Module 4: Barcode & Label Printing

| ID | Feature | Priority | Complexity | Status |
|----|---------|----------|------------|--------|
| B-01 | GS1 barcode generation | P0 | Medium | Missing |
| B-02 | Serial barcode generation | P0 | Low | Missing |
| B-03 | Shuffle barcode creation | P1 | Medium | Missing |
| B-04 | Composite barcode creation | P1 | High | Missing |
| B-05 | Custom barcode label designer | P0 | Very High | Missing |
| B-06 | Label size templates (58mm, 70mm, A4) | P0 | Medium | Missing |
| B-07 | Batch barcode printing | P0 | Medium | Missing |
| B-08 | Auto barcode from purchase bill | P1 | Medium | Missing |
| B-09 | Self-defined barcode format | P1 | Medium | Missing |
| B-10 | Barcode search by item, batch, MRP | P0 | Low | Missing |
| B-11 | Item search by name for missing barcodes | P1 | Low | Missing |
| B-12 | Print barcode on laser/deskjet printers | P1 | Medium | Missing |
| B-13 | Barcode printing on thermal printers | P0 | High | Missing |
| B-14 | Label template management (save/load) | P1 | Medium | Missing |

---

### Module 5: Challan & Delivery Management

| ID | Feature | Priority | Complexity | Status |
|----|---------|----------|------------|--------|
| CH-01 | Challan creation (delivery note) | P0 | Medium | Missing |
| CH-02 | Challan to bill conversion (partial/full) | P0 | Medium | Missing |
| CH-03 | Pending challan tracking | P0 | Low | Missing |
| CH-04 | Challan affects inventory, not accounts | P0 | Medium | Missing |
| CH-05 | Dispatch summary printing | P1 | Low | Missing |
| CH-06 | Packing slip generation | P1 | Medium | Missing |
| CH-07 | Gate pass generation | P2 | Low | Missing |
| CH-08 | Cover note generation | P2 | Low | Missing |
| CH-09 | Bill audit (dispatch management) | P1 | Medium | Missing |

---

### Module 6: Order Management

| ID | Feature | Priority | Complexity | Status |
|----|---------|----------|------------|--------|
| O-01 | Sales order creation | P0 | Medium | Missing |
| O-02 | Purchase order creation | P0 | Medium | Missing |
| O-03 | Partial order loading (full/partial delivery) | P0 | Medium | Missing |
| O-04 | Pending order reports | P0 | Low | Missing |
| O-05 | Order to bill conversion | P0 | Medium | Missing |
| O-06 | Order status tracking | P0 | Low | Missing |
| O-07 | Sales order management (S.O.M) | P1 | Medium | Missing |
| O-08 | Outstanding purchase order reports | P1 | Low | Missing |
| O-09 | Bill convert on amount/days basis | P2 | Medium | Missing |

---

### Module 7: GST & Tax Compliance

| ID | Feature | Priority | Complexity | Status |
|----|---------|----------|------------|--------|
| G-01 | Rate-wise GST (per-rate tax configuration) | P0 | Medium | Missing |
| G-02 | HSN code master with lookup | P0 | Medium | Missing |
| G-03 | SAC code support (services) | P1 | Low | Missing |
| G-04 | GST e-return file generation (GSTR-1, GSTR-3B) | P0 | High | Missing |
| G-05 | E-invoice generation | P0 | Very High | Missing |
| G-06 | E-way bill generation | P0 | Very High | Missing |
| G-07 | TDS (Tax Deducted at Source) | P1 | Medium | Missing |
| G-08 | TCS (Tax Collected at Source) | P1 | Medium | Missing |
| G-09 | Multiple taxes in single invoice | P0 | Medium | Missing |
| G-10 | Tax inclusive billing | P0 | Medium | Missing |
| G-11 | Tax exclusive billing | P0 | Medium | Missing |
| G-12 | GST portal upload (Excel/JSON/CSV) | P1 | High | Missing |
| G-13 | Tax summary reconciliation | P1 | Medium | Missing |
| G-14 | GST 2.0 compliance (Sep 2025 update) | P0 | Medium | Missing |

---

### Module 8: Purchase & Costing

| ID | Feature | Priority | Complexity | Status |
|----|---------|----------|------------|--------|
| P-01 | Last 4 deals display at billing time | P0 | Medium | Missing |
| P-02 | Last 4 deals display at purchase time | P0 | Medium | Missing |
| P-03 | Purchase cost comparison | P1 | Medium | Missing |
| P-04 | Purchase planning | P1 | Medium | Missing |
| P-05 | Online shortage management | P1 | Low | Missing |
| P-06 | Purchase claim tracking | P1 | Medium | Missing |
| P-07 | Sale claim tracking | P1 | Medium | Missing |
| P-08 | Fix sales rates at time of purchase | P1 | Medium | Missing |
| P-09 | Auto barcode/label printing from purchase | P1 | Medium | Missing |
| P-10 | Online import purchase (Excel/CSV) | P1 | Medium | Missing |
| P-11 | Purchase costing with GST breakdown | P0 | Medium | Missing |
| P-12 | Sale/purchase return replacement | P0 | Medium | Missing |
| P-13 | Price difference adjustment notes | P1 | Medium | Missing |
| P-14 | Debit/Credit note management | P0 | Medium | Missing |

---

### Module 9: CRM & Party Management

| ID | Feature | Priority | Complexity | Status |
|----|---------|----------|------------|--------|
| C-01 | Party history dashboard on selection | P0 | Medium | Missing |
| C-02 | Last 4 deals at time of billing | P0 | Low | Missing |
| C-03 | Outstanding days-wise tracking | P0 | Low | Missing |
| C-04 | Credit limit live monitoring | P0 | Medium | Missing |
| C-05 | Live notification when limit reached | P0 | Medium | Missing |
| C-06 | Auto payment reminders | P1 | Medium | Missing |
| C-07 | Area/Route/Salesman wise outstanding | P1 | Medium | Missing |
| C-08 | Tagging and collection system | P1 | High | Missing |
| C-09 | Customer categorization | P1 | Low | Missing |
| C-10 | Reminder letters (payment, ST forms) | P2 | Low | Missing |
| C-11 | Party dashboard (purchase trends, payments) | P1 | Medium | Missing |
| C-12 | Live credit limit in billing screen | P0 | Medium | Missing |

---

### Module 10: Bundle Pack & Formula Management

| ID | Feature | Priority | Complexity | Status |
|----|---------|----------|------------|--------|
| F-01 | Create bundle packs (Set of Items) | P0 | Medium | Missing |
| F-02 | Bundle pack formula (composition) | P0 | Medium | Missing |
| F-03 | Load bundle in billing | P0 | Medium | Missing |
| F-04 | Suggested item billing | P1 | Medium | Missing |
| F-05 | Composition of item modification | P1 | Medium | Missing |
| F-06 | Sale bundle formula creation | P1 | Medium | Missing |
| F-07 | Item composition (recipe/BOM) | P1 | Medium | Missing |

**Database Changes:**
- New table: `BundlePacks` (id, name, description, total_price, is_active)
- New table: `BundlePackItems` (id, bundle_id, product_id, quantity, price_override)

---

### Module 11: Manufacturing & Production

| ID | Feature | Priority | Complexity | Status |
|----|---------|----------|------------|--------|
| M-01 | Bill of Material (BOM) | P1 | High | Missing |
| M-02 | Manufacturing formula record | P1 | High | Missing |
| M-03 | Production planning | P1 | High | Missing |
| M-04 | Production costing | P1 | Medium | Missing |
| M-05 | Raw material management | P1 | Medium | Missing |
| M-06 | Finished goods tracking | P1 | Medium | Missing |
| M-07 | Production order management | P1 | High | Missing |
| M-08 | Quality control tracking | P2 | High | Missing |

---

### Module 12: Multi-Store & Chain Management

| ID | Feature | Priority | Complexity | Status |
|----|---------|----------|------------|--------|
| S-01 | Multi-store inventory view | P1 | High | Missing |
| S-02 | Godown-wise billing | P1 | Medium | Missing |
| S-03 | Godown-wise stock position | P1 | Medium | Missing |
| S-04 | Merge stock reports for chain stores | P2 | High | Missing |
| S-05 | Stock transfer memo between stores | P1 | Medium | Missing |
| S-06 | Centralized reporting across stores | P2 | High | Missing |

---

### Module 13: Salesman & Route Management

| ID | Feature | Priority | Complexity | Status |
|----|---------|----------|------------|--------|
| SL-01 | Salesman-wise billing & reports | P1 | Medium | Missing |
| SL-02 | Route-wise billing & reports | P1 | Medium | Missing |
| SL-03 | Area-wise billing & reports | P1 | Medium | Missing |
| SL-04 | Salesman target tracking | P1 | Medium | Missing |
| SL-05 | GPS tracking for field staff | P2 | High | Missing |

---

### Module 14: Document Printing

| ID | Feature | Priority | Complexity | Status |
|----|---------|----------|------------|--------|
| DP-01 | Bank letter printing | P2 | Low | Missing |
| DP-02 | Packing slip printing | P1 | Low | Missing |
| DP-03 | Cover note printing | P2 | Low | Missing |
| DP-04 | Gate pass printing | P2 | Low | Missing |
| DP-05 | Envelope printing | P2 | Low | Missing |
| DP-06 | Accounts voucher printing | P1 | Low | Missing |
| DP-07 | Cheque printing | P2 | Medium | Missing |
| DP-08 | Debit/Credit note printing | P1 | Low | Missing |
| DP-09 | Receipt/Payment advice printing | P1 | Low | Missing |
| DP-10 | TDS certificate printing | P2 | Low | Missing |
| DP-11 | Export invoice & packing slip | P1 | Medium | Missing |
| DP-12 | Reminder letter printing | P2 | Low | Missing |

---

### Module 15: Advanced Reporting & Analytics

| ID | Feature | Priority | Complexity | Status |
|----|---------|----------|------------|--------|
| R-01 | Cash flow statement | P0 | Medium | Missing |
| R-02 | Funds flow statement | P1 | Medium | Missing |
| R-03 | Ratio analysis | P2 | Medium | Missing |
| R-04 | Budget vs actual comparison | P1 | Medium | Missing |
| R-05 | Target tracking reports | P1 | Medium | Missing |
| R-06 | ABC analysis (fast/slow moving) | P1 | Medium | Missing |
| R-07 | Purchase costing comparison reports | P1 | Medium | Missing |
| R-08 | Salesman/route/area wise reports | P1 | Medium | Missing |
| R-09 | Merge reports (chain stores) | P2 | High | Missing |
| R-10 | Online graphs and charts | P1 | Medium | Missing |
| R-11 | Currency reports (balance sheet) | P0 | High | Missing |
| R-12 | Ledger/trial balance/P&L | P0 | High | Missing |
| R-13 | Bank reconciliation report | P1 | High | Missing |
| R-14 | Budget/cost center reports | P2 | Medium | Missing |
| R-15 | Operator log book report | P2 | Low | Missing |
| R-16 | Operator worksheet report | P2 | Low | Missing |

---

### Module 16: Financial Accounting

| ID | Feature | Priority | Complexity | Status |
|----|---------|----------|------------|--------|
| A-01 | Complete ledger system | P0 | High | Missing |
| A-02 | Trial balance | P0 | High | Missing |
| A-03 | Profit & Loss statement | P0 | High | Missing |
| A-04 | Balance sheet | P0 | High | Missing |
| A-05 | Bank reconciliation | P1 | High | Missing |
| A-06 | Interest calculation | P2 | Medium | Missing |
| A-07 | Ledger/Group monthly summaries | P1 | Medium | Missing |
| A-08 | Journal entries | P0 | Medium | Missing |
| A-09 | Contra entries | P1 | Medium | Missing |
| A-10 | Payment/Receipt vouchers | P0 | Medium | Missing |
| A-11 | Debit/Credit notes | P0 | Medium | Missing |

---

### Module 17: Communication & Notifications

| ID | Feature | Priority | Complexity | Status |
|----|---------|----------|------------|--------|
| N-01 | SMS invoice details | P1 | Medium | Missing |
| N-02 | SMS payment confirmation | P1 | Medium | Missing |
| N-03 | SMS outstanding reminders | P1 | Medium | Missing |
| N-04 | Email invoice softcopy | P0 | Medium | Missing |
| N-05 | Email outstanding reports | P1 | Medium | Missing |
| N-06 | WhatsApp invoice sending | P0 | Medium | Missing |
| N-07 | WhatsApp outstanding reports | P1 | Medium | Missing |
| N-08 | New product launch notifications | P2 | Low | Missing |
| N-09 | Seasonal greetings via SMS | P2 | Low | Missing |
| N-10 | Auto email/SMS on bill creation | P1 | Medium | Missing |

---

### Module 18: Advanced Settings & Configuration

| ID | Feature | Priority | Complexity | Status |
|----|---------|----------|------------|--------|
| T-01 | Auto generate different bill types | P1 | Medium | Missing |
| T-02 | Operator power & boundations | P1 | Medium | Missing |
| T-03 | Inventory & accounting approval system | P1 | High | Missing |
| T-04 | Side display at time of billing (customer display) | P2 | Medium | Missing |
| T-05 | Virtual keyboard system | P2 | Medium | Missing |
| T-06 | Virtual/popup item billing | P2 | Medium | Missing |
| T-07 | Shortcut keys & recently viewed reports | P1 | Medium | Missing |
| T-08 | F3 & F4 key support in bill | P1 | Low | Missing |
| T-09 | Sale return via * key in bill | P1 | Low | Missing |
| T-10 | Show last & old deals at billing | P0 | Medium | Missing |
| T-11 | Show last & old deals in purchase | P0 | Medium | Missing |
| T-12 | Counter sale entry provision | P1 | Medium | Missing |
| T-13 | Provision to load item from other bill | P2 | Medium | Missing |
| T-14 | Negative stock billing facility | P1 | Low | Missing |
| T-15 | Godown wise billing | P1 | Medium | Missing |
| T-16 | Back date stock position at billing | P2 | Medium | Missing |
| T-17 | Switch over from bill to bill anywhere | P1 | Medium | Missing |
| T-18 | Show pending KOT/Challans | P1 | Low | Missing |
| T-19 | Cursor to report navigation | P2 | Low | Missing |

---

### Module 19: Budget & Cost Centers

| ID | Feature | Priority | Complexity | Status |
|----|---------|----------|------------|--------|
| BC-01 | Budget management | P2 | Medium | Missing |
| BC-02 | Cost center tracking | P2 | Medium | Missing |
| BC-03 | Budget vs actual reports | P2 | Medium | Missing |
| BC-04 | Department-wise budgeting | P2 | Medium | Missing |

---

### Module 20: Special Industry Features

| ID | Feature | Priority | Complexity | Status |
|----|---------|----------|------------|--------|
| SP-01 | Chit fund / Kitty management | P3 | High | Missing |
| SP-02 | Mortgage (Girvi) management | P3 | High | Missing |
| SP-03 | Caret issue & receive management | P3 | High | Missing |
| SP-04 | OPD/Reki management | P3 | High | Missing |
| SP-05 | Prescription management (pharma) | P3 | Medium | Missing |
| SP-06 | Pharmacopoeia master | P3 | Medium | Missing |

---

### Module 21: ERP Integration & Connectivity

| ID | Feature | Priority | Complexity | Status |
|----|---------|----------|------------|--------|
| E-01 | ERP-to-ERP ordering | P3 | Very High | Missing |
| E-02 | Cloud backup (automatic) | P2 | Medium | Missing |
| E-03 | MargPay integration | P3 | Very High | Missing |
| E-04 | ICICI banking integration | P3 | Very High | Missing |
| E-05 | QR code for shop (product listing) | P2 | Medium | Missing |
| E-06 | Direct calling facility from system | P2 | Medium | Missing |
| E-07 | PDF bill import | P2 | Medium | Missing |

---

## Priority Legend

| Priority | Description |
|----------|-------------|
| **P0** | Critical — Must have for basic Marg parity |
| **P1** | Important — Needed for competitive feature set |
| **P2** | Nice-to-have — Adds value, can defer |
| **P3** | Specialized — Industry-specific, defer to v3 |

---

## Implementation Phases

### Phase 1: Core Business Logic (Weeks 1-3)
**Goal:** Multi-rate pricing, discount engine, bundle packs, scheme management

**Chunks:**
1. Database schema migration for new tables (ProductRates, PartyRates, DiscountRules, SchemeRules, BundlePacks, BundlePackItems)
2. Rate engine — multi-rate pricing with party-wise overrides
3. Discount engine — 4-level bill discounts + item-wise discounts
4. Scheme engine — Buy X Get Y, date-wise, qty-wise
5. Bundle pack management — create, edit, load in billing
6. UI for all new master screens
7. Integration into billing page

### Phase 2: GST & Compliance (Weeks 4-6)
**Goal:** Proper GST engine, HSN/SAC, TDS/TCS, e-invoice readiness

**Chunks:**
1. HSN/SAC code master with search
2. Rate-wise GST configuration
3. Tax inclusive/exclusive/MRP billing modes
4. Multi-tax support in single invoice
5. GST return data generation (GSTR-1, GSTR-3B export)
6. E-invoice field preparation
7. E-way bill field preparation
8. TDS/TCS calculation engine

### Phase 3: Print & Label Design (Weeks 7-9)
**Goal:** Custom invoice designer, barcode label designer, all document types

**Chunks:**
1. Invoice format designer (visual drag-and-drop)
2. Thermal receipt format designer
3. Variable command system (bill no, date, party, amounts)
4. Font/color/size customization
5. Barcode label designer with templates
6. Batch barcode printing
7. Challan/packing slip/gate pass printing
8. Document template management (save/load/import/export)

### Phase 4: Purchase & Costing (Weeks 10-12)
**Goal:** Last 4 deals, purchase costing, shortage management

**Chunks:**
1. Purchase deal history tracking
2. Last 4 deals display at billing/purchase time
3. Purchase cost comparison reports
4. Online shortage management
5. Purchase/sale claim tracking
6. Debit/Credit note management
7. Price difference adjustment notes
8. Fix sales rates at time of purchase

### Phase 5: Orders & Challans (Weeks 13-15)
**Goal:** Sales/purchase orders, challan management

**Chunks:**
1. Sales order creation and management
2. Purchase order creation and management
3. Partial order loading
4. Order to bill conversion
5. Challan creation (delivery notes)
6. Challan to bill conversion (partial/full)
7. Pending challan tracking
8. Dispatch management and tracking

### Phase 6: CRM & Advanced Features (Weeks 16-18)
**Goal:** Party dashboard, credit monitoring, multi-store

**Chunks:**
1. Party history dashboard
2. Credit limit live monitoring with notifications
3. Outstanding tracking (days/area/salesman wise)
4. Salesman/route/area management
5. Multi-store inventory view
6. Stock transfer between stores
7. Operator boundations and approval system

### Phase 7: Accounting & Reports (Weeks 19-21)
**Goal:** Financial accounting, advanced reports

**Chunks:**
1. Ledger system
2. Journal/contra entries
3. Payment/receipt vouchers
4. Trial balance
5. P&L and balance sheet
6. Bank reconciliation
7. ABC analysis reports
8. Budget vs actual comparison

---

## Database Migration Plan

### New Tables Required (v3)

```sql
-- Module 1: Rate & Pricing
CREATE TABLE product_rates (
  id TEXT PRIMARY KEY,
  product_id TEXT NOT NULL,
  rate_type TEXT NOT NULL, -- 'A', 'B', 'C', 'wholesale', 'special'
  rate_name TEXT NOT NULL,
  rate_value INTEGER NOT NULL, -- in paise
  min_qty REAL DEFAULT 1.0,
  max_qty REAL,
  effective_from TEXT,
  effective_to TEXT,
  is_active INTEGER DEFAULT 1,
  FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE party_rates (
  id TEXT PRIMARY KEY,
  customer_id TEXT NOT NULL,
  product_id TEXT NOT NULL,
  rate_type TEXT NOT NULL,
  rate_value INTEGER NOT NULL,
  effective_from TEXT,
  effective_to TEXT,
  is_active INTEGER DEFAULT 1,
  FOREIGN KEY (customer_id) REFERENCES customers(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Module 2: Discounts & Schemes
CREATE TABLE discount_rules (
  id TEXT PRIMARY KEY,
  rule_name TEXT NOT NULL,
  discount_type TEXT NOT NULL, -- 'percentage', 'fixed', 'buy_x_get_y'
  discount_value REAL NOT NULL,
  applies_to TEXT NOT NULL, -- 'bill', 'item', 'category', 'product'
  min_qty REAL,
  min_amount INTEGER,
  party_id TEXT,
  product_id TEXT,
  category_id TEXT,
  start_date TEXT,
  end_date TEXT,
  priority INTEGER DEFAULT 0,
  is_active INTEGER DEFAULT 1
);

CREATE TABLE scheme_rules (
  id TEXT PRIMARY KEY,
  scheme_name TEXT NOT NULL,
  scheme_type TEXT NOT NULL, -- 'buy_x_get_y', 'qty_rate', 'discount', 'combo'
  trigger_qty REAL NOT NULL,
  free_qty REAL DEFAULT 0,
  discount_percent REAL DEFAULT 0,
  discount_amount INTEGER DEFAULT 0,
  applies_to TEXT NOT NULL,
  product_id TEXT,
  category_id TEXT,
  start_date TEXT,
  end_date TEXT,
  priority INTEGER DEFAULT 0,
  is_active INTEGER DEFAULT 1
);

-- Module 10: Bundle Packs
CREATE TABLE bundle_packs (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  total_price INTEGER NOT NULL,
  is_active INTEGER DEFAULT 1,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  version INTEGER DEFAULT 1,
  sync_status TEXT DEFAULT 'pending'
);

CREATE TABLE bundle_pack_items (
  id TEXT PRIMARY KEY,
  bundle_id TEXT NOT NULL,
  product_id TEXT NOT NULL,
  quantity REAL NOT NULL,
  price_override INTEGER,
  FOREIGN KEY (bundle_id) REFERENCES bundle_packs(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Module 3: Invoice Formats
CREATE TABLE invoice_formats (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  format_type TEXT NOT NULL, -- 'gui', 'dmp', 'thermal'
  document_type TEXT NOT NULL, -- 'invoice', 'challan', 'estimate', 'label'
  page_size TEXT NOT NULL, -- 'A4', 'A3', 'A5', 'legal', 'letter', 'thermal_58', 'thermal_72'
  content TEXT NOT NULL, -- JSON definition of layout
  is_default INTEGER DEFAULT 0,
  is_active INTEGER DEFAULT 1,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

-- Module 4: Barcode Labels
CREATE TABLE barcode_label_templates (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  template_type TEXT NOT NULL, -- 'barcode', 'price_tag', 'shelf_label'
  barcode_format TEXT NOT NULL, -- 'CODE128', 'EAN13', 'QR', 'GS1'
  width REAL NOT NULL, -- mm
  height REAL NOT NULL, -- mm
  content TEXT NOT NULL, -- JSON layout definition
  is_default INTEGER DEFAULT 0,
  is_active INTEGER DEFAULT 1,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

-- Module 5: Challans
CREATE TABLE challans (
  id TEXT PRIMARY KEY,
  challan_number TEXT NOT NULL,
  customer_id TEXT,
  customer_name TEXT,
  challan_date TEXT NOT NULL,
  subtotal INTEGER NOT NULL,
  tax_amount INTEGER DEFAULT 0,
  total_amount INTEGER NOT NULL,
  status TEXT DEFAULT 'pending', -- 'pending', 'partial', 'converted', 'cancelled'
  reference_bill_id TEXT,
  notes TEXT,
  created_by TEXT NOT NULL,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  version INTEGER DEFAULT 1,
  sync_status TEXT DEFAULT 'pending'
);

CREATE TABLE challan_items (
  id TEXT PRIMARY KEY,
  challan_id TEXT NOT NULL,
  product_id TEXT NOT NULL,
  product_name TEXT NOT NULL,
  quantity REAL NOT NULL,
  unit_price INTEGER NOT NULL,
  tax_rate REAL DEFAULT 0.0,
  tax_amount INTEGER DEFAULT 0,
  total_amount INTEGER NOT NULL,
  batch_number TEXT,
  converted_quantity REAL DEFAULT 0,
  FOREIGN KEY (challan_id) REFERENCES challans(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Module 6: Orders
CREATE TABLE sales_orders (
  id TEXT PRIMARY KEY,
  order_number TEXT NOT NULL,
  customer_id TEXT,
  customer_name TEXT,
  order_date TEXT NOT NULL,
  expected_delivery_date TEXT,
  subtotal INTEGER NOT NULL,
  tax_amount INTEGER DEFAULT 0,
  discount_amount INTEGER DEFAULT 0,
  total_amount INTEGER NOT NULL,
  status TEXT DEFAULT 'pending', -- 'pending', 'partial', 'confirmed', 'delivered', 'cancelled'
  notes TEXT,
  created_by TEXT NOT NULL,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  version INTEGER DEFAULT 1,
  sync_status TEXT DEFAULT 'pending'
);

CREATE TABLE purchase_orders (
  id TEXT PRIMARY KEY,
  order_number TEXT NOT NULL,
  supplier_id TEXT,
  supplier_name TEXT,
  order_date TEXT NOT NULL,
  expected_delivery_date TEXT,
  subtotal INTEGER NOT NULL,
  tax_amount INTEGER DEFAULT 0,
  discount_amount INTEGER DEFAULT 0,
  total_amount INTEGER NOT NULL,
  status TEXT DEFAULT 'pending',
  notes TEXT,
  created_by TEXT NOT NULL,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  version INTEGER DEFAULT 1,
  sync_status TEXT DEFAULT 'pending'
);
```

---

## Error Handling & User Guidance Requirements

### Every error must be:
1. **Descriptive** — "Product barcode already exists (Code: BAR-12345)" not "Error"
2. **Actionable** — Tell user what to do: "Check the barcode number and try again"
3. **Categorized** — Show error type: `[Hardware Issue]`, `[Data Issue]`, `[Network Issue]`
4. **Logged** — Every error logged to AuditLogs for debugging
5. **Non-technical** — A shop owner should understand it without a developer

### Example error messages:
```
[Printer Offline] Receipt printer is not responding.
Fix: Check printer power cable and USB connection, then click "Test Printer" in Settings > Printer.

[Stock Conflict] Product "Parle-G" has insufficient stock (2 units available, 5 requested).
Fix: Reduce quantity to 2 or less, or adjust stock via Inventory > Stock Adjustment.

[GST Config Error] HSN code "2106" has no GST rate configured.
Fix: Go to Settings > Tax Configuration and set the GST rate for HSN code 2106.
```

---

## Documentation Requirements

### Every file must have:
1. **File-level doc comment** — What this file does, why it exists
2. **Class-level doc comment** — What this class represents
3. **Method-level doc comment** — What this method does, params, returns, throws
4. **Error handling docs** — What errors can occur and how they're handled
5. **Usage examples** — For complex APIs, show example usage
6. **Complexity notes** — For non-obvious business logic, explain the rule

---

## Testing Requirements

### Every chunk must include:
1. **Unit tests** for business logic
2. **Integration tests** for database operations
3. **Error case tests** — Test every error path
4. **Edge case tests** — Zero quantities, negative balances, etc.

---

## Acceptance Criteria for v2.0 Release

- [ ] Multi-rate pricing working with party-wise overrides
- [ ] 4-level discount system operational
- [ ] Scheme management with at least 3 scheme types
- [ ] Bundle pack creation and billing
- [ ] Custom invoice format designer functional
- [ ] Barcode label designer with batch printing
- [ ] Challan management with bill conversion
- [ ] Sales/purchase order management
- [ ] GST engine with HSN/SAC lookup
- [ ] Last 4 deals visible at billing/purchase
- [ ] Purchase cost comparison reports
- [ ] Debit/Credit note management
- [ ] Party history dashboard
- [ ] Credit limit monitoring with alerts
- [ ] All new error messages follow guidance rules
- [ ] All new files documented
- [ ] All new features have tests
- [ ] Zero compile errors
- [ ] Windows build successful

---

**Next Step:** Begin Phase 1 — Database schema migration and rate engine implementation.
