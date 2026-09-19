<div align="center">

# SS MART ERP

### Offline-First Retail ERP/POS System for Indian Retail

**A complete retail management system with Flutter mobile/desktop client, .NET 8 backend API, and PostgreSQL database — built for Indian retail operations with GST, HSN/SAC, and offline-first architecture.**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![.NET](https://img.shields.io/badge/.NET-8-512BD4?logo=dotnet&logoColor=white)](https://dotnet.microsoft.com)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-4169E1?logo=postgresql&logoColor=white)](https://postgresql.org)
[![License](https://img.shields.io/badge/License-MIT-blue)](LICENSE)

</div>

---

> ⚠️ **STATUS: Architecture & API specification only — no runtime code yet.**  
> This repository contains the system design, API contracts, and data models.  
> Implementation repositories are tracked separately (see below).

---

## What is SS MART?

SS MART (Sai Sangameshwara Mart) is a **designed** retail ERP/POS system for Indian retail operations. It is designed to handle everything from billing and inventory to accounting, loyalty programs, and employee management — all while working offline-first so your shop never stops even without internet.

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                     SS MART ERP SYSTEM                          │
├─────────────────────────────────────────────────────────────────┤
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐        │
│  │   Flutter    │    │   .NET 8    │    │  PostgreSQL  │        │
│  │   Mobile     │◄──►│   ASP.NET   │◄──►│   Server     │        │
│  │   Desktop    │    │   Core API  │    │   Database   │        │
│  └──────┬──────┘    └──────┬──────┘    └─────────────┘        │
│         │                  │                                    │
│         ▼                  ▼                                    │
│  ┌─────────────┐    ┌─────────────┐                            │
│  │   SQLite    │    │    Redis    │                            │
│  │   Local DB  │    │    Cache    │                            │
│  │   + Drift   │    │             │                            │
│  └─────────────┘    └─────────────┘                            │
└─────────────────────────────────────────────────────────────────┘
```

## Core Principles

- **Offline-First** — All critical operations work without internet
- **Local-First Writes** — SQLite database for immediate local storage
- **Background Sync** — Queue-based synchronization when online
- **Idempotent Operations** — Safe retry mechanisms
- **Conflict Resolution** — Smart merge strategies for concurrent edits
- **Indian Retail Focus** — GST, HSN/SAC, B2B/B2C support

## Modules (Designed)

| Module | Description |
|--------|-------------|
| Billing/POS | Invoice generation, GST calculations, multiple payment methods |
| Inventory | Stock tracking, low-stock alerts, barcode support |
| Purchase Management | Supplier orders, receiving, challan tracking |
| Customer CRM | Customer profiles, purchase history, communication |
| Loyalty Points | Earn/redeem points, tier-based rewards |
| Employee Management | Staff profiles, roles, permissions |
| Shift Management | Shift scheduling, attendance tracking |
| GST/Tax Engine | CGST/SGST/IGST, HSN/SAC codes, tax reports |
| Reports & Analytics | Sales reports, profit/loss, inventory valuation |
| Backup/Restore | Automated backups, data export/import |
| Data Migration | Import from existing systems |
| Audit Logs | Complete activity trail |
| Admin/Permissions | Role-based access control |
| Sync Engine | Offline-to-online data synchronization |

## Repositories (Planned)

The following repositories will contain the implementation. Currently they are tracked separately and may not yet contain code:

| Repo | Description | Tech | Status |
|------|-------------|------|--------|
| [ss-mart-erp](https://github.com/0535MANIDEEP/ss-mart-erp) | Architecture docs & system design | Documentation | ✅ Design complete |
| [ss-mart-erp-backend](https://github.com/0535MANIDEEP/ss-mart-erp-backend) | REST API server | .NET 8, EF Core, PostgreSQL | 🚧 Not started |
| [ss-mart-erp-mobile](https://github.com/0535MANIDEEP/ss-mart-erp-mobile) | Mobile & desktop client | Flutter, SQLite, Drift | 🚧 Not started |

> **Note:** Implementation repositories are not yet initialized. See `PROJECT_CHECKLIST.md` for current progress.

## Getting Started

### Backend

```bash
cd ss-mart-erp-backend/SS_MART_API
dotnet restore
dotnet run
```

API runs at `https://localhost:5001` with Swagger docs at `/swagger`.

### Mobile

```bash
cd ss-mart-erp-mobile
flutter pub get
flutter run
```

## Documentation

- [Architecture Overview](ARCHITECTURE.md) — full system design (1100+ lines)
- [API Contracts](API_CONTRACTS.md) — endpoint specifications
- [Data Types](DATA_TYPES.md) — data models and validation rules
- [Roadmap](ROADMAP.md) — 9-phase development plan
- [Sync Engine](SYNC_ENGINE.md) — offline synchronization design
- [Mind Map](MIND_MAP.md) — visual system overview

## Author

**Manideep Daram** — [GitHub](https://github.com/0535MANIDEEP) · [Email](mailto:darammanideep@gmail.com)
