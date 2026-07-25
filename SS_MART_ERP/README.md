# SS MART - Sai Sangameshwara Mart Retail ERP System

## Overview

SS MART is an offline-first retail ERP/POS system designed for Indian retail operations. Built with Flutter for cross-platform mobile/desktop applications and .NET 8 for the backend API, it provides comprehensive billing, inventory, customer management, loyalty points, and analytics capabilities.

## Key Features

### Core Features
- **Offline-First Billing**: Full billing capability without internet
- **Real-Time Inventory**: Stock tracking with batch and expiry management
- **Customer CRM**: Customer profiles, purchase history, and outstanding tracking
- **Loyalty Points**: Earn and redeem points with flexible rules
- **GST Compliance**: Automated GST calculations and reporting
- **Employee Management**: Shift scheduling and attendance tracking

### Technical Features
- **Offline-First Architecture**: Local SQLite database with background sync
- **Conflict Resolution**: Intelligent sync with conflict detection and resolution
- **Cross-Platform**: Single codebase for Android, iOS, Windows, macOS, Linux
- **Role-Based Access**: Secure authentication with PIN-based login
- **Audit Logging**: Complete audit trail for all sensitive operations

## Technology Stack

| Layer | Technology | Purpose |
|-------|------------|---------|
| **Frontend** | Flutter 3.x | Cross-platform UI |
| **Local Database** | SQLite + Drift | Offline storage |
| **Backend** | .NET 8 ASP.NET Core | REST API |
| **Server Database** | PostgreSQL 15+ | Server storage |
| **Auth** | JWT + Role-Based | Security |
| **Sync** | Background Queue | Offline sync |
| **Storage** | S3-compatible | File storage |

## Project Structure

```
SS_MART_ERP/
├── Mobile_App/           # Flutter Mobile Application
├── Desktop_App/          # Flutter Desktop Application
├── Backend_API/          # .NET 8 ASP.NET Core API
├── Shared_Libraries/     # Shared code
├── Database/             # Database schemas
├── Documentation/        # Project docs
├── Scripts/              # Build scripts
├── Tests/                # Test projects
└── Tools/                # Development tools
```

## Getting Started

### Prerequisites

1. **Flutter SDK** (3.x or later)
   - Install from: https://flutter.dev/docs/get-started/install
   - Run: `flutter doctor` to verify installation

2. **.NET SDK** (8.0 or later)
   - Install from: https://dotnet.microsoft.com/download
   - Run: `dotnet --version` to verify

3. **PostgreSQL** (15 or later)
   - Install from: https://www.postgresql.org/download/

4. **Android Studio / Xcode** (for mobile development)
5. **Visual Studio Code** or **Visual Studio** (for development)

### Installation

#### 1. Clone the Repository
```bash
git clone https://github.com/your-repo/ss-mart-erp.git
cd ss-mart-erp
```

#### 2. Set Up Backend API
```bash
cd Backend_API
dotnet restore
dotnet build
dotnet run --project SS_MART_API
```

#### 3. Set Up Database
```bash
# Create PostgreSQL database
createdb ss_mart_db

# Run migrations
cd Database/PostgreSQL
psql -d ss_mart_db -f migrations/001_initial_schema.sql
```

#### 4. Set Up Flutter App
```bash
cd Mobile_App
flutter pub get
flutter run
```

### Environment Variables

Create `.env` file in Backend_API:
```env
# Database
DATABASE_URL=Host=localhost;Database=ss_mart_db;Username=postgres;Password=your_password

# JWT
JWT_SECRET=your_super_secret_key
JWT_EXPIRY_MINUTES=15
REFRESH_TOKEN_EXPIRY_DAYS=7

# Storage
STORAGE_BUCKET=ss-mart-storage
STORAGE_ENDPOINT=https://your-s3-endpoint

# Redis
REDIS_CONNECTION=localhost:6379
```

## Development Workflow

### 1. Feature Development
```bash
# Create feature branch
git checkout -b feature/feature-name

# Make changes
# ...

# Run tests
flutter test
dotnet test

# Commit changes
git add .
git commit -m "feat: add feature description"

# Push to remote
git push origin feature/feature-name

# Create pull request
```

### 2. Testing
```bash
# Run Flutter tests
flutter test

# Run .NET tests
dotnet test

# Run integration tests
flutter test integration_test
```

### 3. Building
```bash
# Build Flutter app
flutter build apk --release
flutter build ios --release
flutter build windows --release

# Build .NET API
dotnet publish -c Release
```

## API Documentation

### Authentication
- `POST /api/auth/login` - User login
- `POST /api/auth/refresh` - Refresh token
- `POST /api/auth/validate-pin` - Validate employee PIN

### Products
- `GET /api/products` - Get products list
- `GET /api/products/{id}` - Get product by ID
- `POST /api/products` - Create product
- `PUT /api/products/{id}` - Update product
- `DELETE /api/products/{id}` - Delete product
- `GET /api/products/search?q={query}` - Search products

### Customers
- `GET /api/customers` - Get customers list
- `GET /api/customers/{id}` - Get customer by ID
- `POST /api/customers` - Create customer
- `PUT /api/customers/{id}` - Update customer
- `GET /api/customers/{id}/history` - Get purchase history
- `GET /api/customers/{id}/loyalty` - Get loyalty balance

### Bills
- `GET /api/bills` - Get bills list
- `GET /api/bills/{id}` - Get bill by ID
- `POST /api/bills` - Create bill
- `POST /api/bills/{id}/return` - Return bill
- `GET /api/bills/{id}/print` - Get bill for printing

### Inventory
- `GET /api/inventory` - Get stock list
- `POST /api/inventory/adjust` - Adjust stock
- `POST /api/inventory/transfer` - Transfer stock
- `GET /api/inventory/low-stock` - Get low stock products

### Loyalty
- `GET /api/loyalty/{customerId}` - Get loyalty balance
- `POST /api/loyalty/earn` - Earn points
- `POST /api/loyalty/redeem` - Redeem points

### Sync
- `POST /api/sync/upload` - Upload sync data
- `POST /api/sync/download` - Download sync data
- `GET /api/sync/status` - Get sync status

## Database Schema

### Core Tables
- `products` - Product master
- `customers` - Customer master
- `bills` - Sales bills
- `bill_items` - Bill line items
- `stock` - Inventory stock
- `stock_movements` - Stock movement history
- `loyalty_transactions` - Loyalty points history
- `employees` - Employee master
- `shifts` - Shift assignments
- `attendance` - Employee attendance
- `audit_logs` - Audit trail
- `sync_queue` - Sync queue
- `settings` - System settings

## Configuration

### Company Settings
- Store name and address
- GSTIN and tax configuration
- Invoice numbering
- Loyalty points rules
- Credit limit settings

### Tax Configuration
- GST rates (0%, 5%, 12%, 18%, 28%)
- HSN/SAC codes
- Interstate/intrastate tax rules
- Tax-inclusive/exclusive pricing

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and queries:
- Email: support@ssmart.com
- Phone: +91 9876543210
- Documentation: docs.ssmart.com

## Acknowledgments

- Flutter team for the amazing framework
- .NET team for the robust backend framework
- PostgreSQL team for the reliable database
- All contributors and supporters

---

**SS MART** - Empowering Indian Retail with Technology
