# SS MART - Complete Folder Structure

## 1. Root Project Structure

```
SS_MART_ERP/
├── 📁 Mobile_App/                    # Flutter Mobile Application
├── 📁 Desktop_App/                   # Flutter Desktop Application
├── 📁 Backend_API/                   # .NET 8 ASP.NET Core API
├── 📁 Shared_Libraries/              # Shared code between apps
├── 📁 Database/                      # Database schemas and migrations
├── 📁 Documentation/                 # Project documentation
├── 📁 Scripts/                       # Build and deployment scripts
├── 📁 Tests/                         # Test projects
├── 📁 Tools/                         # Development tools
├── docker-compose.yml                # Docker configuration
├── .gitignore                        # Git ignore file
├── README.md                         # Project readme
└── SOLUTION.md                       # Solution architecture
```

## 2. Flutter Mobile App Structure

```
Mobile_App/
├── 📁 lib/
│   ├── 📁 core/
│   │   ├── 📁 config/
│   │   │   ├── app_config.dart
│   │   │   ├── theme_config.dart
│   │   │   └── environment_config.dart
│   │   ├── 📁 constants/
│   │   │   ├── app_constants.dart
│   │   │   ├── api_constants.dart
│   │   │   └── database_constants.dart
│   │   ├── 📁 error/
│   │   │   ├── exceptions.dart
│   │   │   ├── failures.dart
│   │   │   └── error_handler.dart
│   │   ├── 📁 network/
│   │   │   ├── api_client.dart
│   │   │   ├── network_info.dart
│   │   │   └── interceptors/
│   │   │       ├── auth_interceptor.dart
│   │   │       └── logging_interceptor.dart
│   │   ├── 📁 usecases/
│   │   │   └── base_usecase.dart
│   │   └── 📁 utils/
│   │       ├── validators.dart
│   │       ├── formatters.dart
│   │       └── helpers.dart
│   │
│   ├── 📁 features/
│   │   ├── 📁 auth/
│   │   │   ├── 📁 data/
│   │   │   │   ├── 📁 datasources/
│   │   │   │   │   ├── auth_local_datasource.dart
│   │   │   │   │   └── auth_remote_datasource.dart
│   │   │   │   ├── 📁 models/
│   │   │   │   │   ├── user_model.dart
│   │   │   │   │   └── auth_response_model.dart
│   │   │   │   └── 📁 repositories/
│   │   │   │       └── auth_repository_impl.dart
│   │   │   ├── 📁 domain/
│   │   │   │   ├── 📁 entities/
│   │   │   │   │   └── user_entity.dart
│   │   │   │   ├── 📁 repositories/
│   │   │   │   │   └── auth_repository.dart
│   │   │   │   └── 📁 usecases/
│   │   │   │       ├── login_usecase.dart
│   │   │   │       └── logout_usecase.dart
│   │   │   └── 📁 presentation/
│   │   │       ├── 📁 bloc/
│   │   │       │   ├── auth_bloc.dart
│   │   │       │   ├── auth_event.dart
│   │   │       │   └── auth_state.dart
│   │   │       ├── 📁 pages/
│   │   │       │   ├── login_page.dart
│   │   │       │   └── splash_page.dart
│   │   │       └── 📁 widgets/
│   │   │           ├── login_form.dart
│   │   │           └── pin_input.dart
│   │   │
│   │   ├── 📁 billing/
│   │   │   ├── 📁 data/
│   │   │   │   ├── 📁 datasources/
│   │   │   │   │   ├── billing_local_datasource.dart
│   │   │   │   │   └── billing_remote_datasource.dart
│   │   │   │   ├── 📁 models/
│   │   │   │   │   ├── bill_model.dart
│   │   │   │   │   └── bill_item_model.dart
│   │   │   │   └── 📁 repositories/
│   │   │   │       └── billing_repository_impl.dart
│   │   │   ├── 📁 domain/
│   │   │   │   ├── 📁 entities/
│   │   │   │   │   ├── bill_entity.dart
│   │   │   │   │   └── bill_item_entity.dart
│   │   │   │   ├── 📁 repositories/
│   │   │   │   │   └── billing_repository.dart
│   │   │   │   └── 📁 usecases/
│   │   │   │       ├── create_bill_usecase.dart
│   │   │   │       ├── get_bill_usecase.dart
│   │   │   │       └── return_bill_usecase.dart
│   │   │   └── 📁 presentation/
│   │   │       ├── 📁 bloc/
│   │   │       │   ├── billing_bloc.dart
│   │   │       │   ├── billing_event.dart
│   │   │       │   └── billing_state.dart
│   │   │       ├── 📁 pages/
│   │   │       │   ├── billing_page.dart
│   │   │       │   ├── cart_page.dart
│   │   │       │   └── payment_page.dart
│   │   │       └── 📁 widgets/
│   │   │           ├── product_search.dart
│   │   │           ├── cart_item.dart
│   │   │           ├── payment_method.dart
│   │   │           └── bill_summary.dart
│   │   │
│   │   ├── 📁 products/
│   │   │   ├── 📁 data/
│   │   │   │   ├── 📁 datasources/
│   │   │   │   │   ├── product_local_datasource.dart
│   │   │   │   │   └── product_remote_datasource.dart
│   │   │   │   ├── 📁 models/
│   │   │   │   │   └── product_model.dart
│   │   │   │   └── 📁 repositories/
│   │   │   │       └── product_repository_impl.dart
│   │   │   ├── 📁 domain/
│   │   │   │   ├── 📁 entities/
│   │   │   │   │   └── product_entity.dart
│   │   │   │   ├── 📁 repositories/
│   │   │   │   │   └── product_repository.dart
│   │   │   │   └── 📁 usecases/
│   │   │   │       ├── get_products_usecase.dart
│   │   │   │       ├── add_product_usecase.dart
│   │   │   │       └── search_products_usecase.dart
│   │   │   └── 📁 presentation/
│   │   │       ├── 📁 bloc/
│   │   │       │   ├── product_bloc.dart
│   │   │       │   ├── product_event.dart
│   │   │       │   └── product_state.dart
│   │   │       ├── 📁 pages/
│   │   │       │   ├── product_list_page.dart
│   │   │       │   ├── product_detail_page.dart
│   │   │       │   └── add_product_page.dart
│   │   │       └── 📁 widgets/
│   │   │           ├── product_card.dart
│   │   │           └── product_form.dart
│   │   │
│   │   ├── 📁 customers/
│   │   │   ├── 📁 data/
│   │   │   │   ├── 📁 datasources/
│   │   │   │   │   ├── customer_local_datasource.dart
│   │   │   │   │   └── customer_remote_datasource.dart
│   │   │   │   ├── 📁 models/
│   │   │   │   │   └── customer_model.dart
│   │   │   │   └── 📁 repositories/
│   │   │   │       └── customer_repository_impl.dart
│   │   │   ├── 📁 domain/
│   │   │   │   ├── 📁 entities/
│   │   │   │   │   └── customer_entity.dart
│   │   │   │   ├── 📁 repositories/
│   │   │   │   │   └── customer_repository.dart
│   │   │   │   └── 📁 usecases/
│   │   │   │       ├── get_customers_usecase.dart
│   │   │   │       ├── add_customer_usecase.dart
│   │   │   │       └── search_customers_usecase.dart
│   │   │   └── 📁 presentation/
│   │   │       ├── 📁 bloc/
│   │   │       │   ├── customer_bloc.dart
│   │   │       │   ├── customer_event.dart
│   │   │       │   └── customer_state.dart
│   │   │       ├── 📁 pages/
│   │   │       │   ├── customer_list_page.dart
│   │   │       │   ├── customer_detail_page.dart
│   │   │       │   └── add_customer_page.dart
│   │   │       └── 📁 widgets/
│   │   │           ├── customer_card.dart
│   │   │           └── customer_form.dart
│   │   │
│   │   ├── 📁 inventory/
│   │   │   ├── 📁 data/
│   │   │   │   ├── 📁 datasources/
│   │   │   │   │   ├── inventory_local_datasource.dart
│   │   │   │   │   └── inventory_remote_datasource.dart
│   │   │   │   ├── 📁 models/
│   │   │   │   │   └── stock_model.dart
│   │   │   │   └── 📁 repositories/
│   │   │   │       └── inventory_repository_impl.dart
│   │   │   ├── 📁 domain/
│   │   │   │   ├── 📁 entities/
│   │   │   │   │   └── stock_entity.dart
│   │   │   │   ├── 📁 repositories/
│   │   │   │   │   └── inventory_repository.dart
│   │   │   │   └── 📁 usecases/
│   │   │   │       ├── get_stock_usecase.dart
│   │   │   │       ├── adjust_stock_usecase.dart
│   │   │   │       └── transfer_stock_usecase.dart
│   │   │   └── 📁 presentation/
│   │   │       ├── 📁 bloc/
│   │   │       │   ├── inventory_bloc.dart
│   │   │       │   ├── inventory_event.dart
│   │   │       │   └── inventory_state.dart
│   │   │       ├── 📁 pages/
│   │   │       │   ├── inventory_page.dart
│   │   │       │   ├── stock_adjustment_page.dart
│   │   │       │   └── stock_transfer_page.dart
│   │   │       └── 📁 widgets/
│   │   │           ├── stock_card.dart
│   │   │           └── stock_adjustment_form.dart
│   │   │
│   │   ├── 📁 purchases/
│   │   │   ├── 📁 data/
│   │   │   │   ├── 📁 datasources/
│   │   │   │   │   ├── purchase_local_datasource.dart
│   │   │   │   │   └── purchase_remote_datasource.dart
│   │   │   │   ├── 📁 models/
│   │   │   │   │   ├── purchase_model.dart
│   │   │   │   │   └── purchase_item_model.dart
│   │   │   │   └── 📁 repositories/
│   │   │   │       └── purchase_repository_impl.dart
│   │   │   ├── 📁 domain/
│   │   │   │   ├── 📁 entities/
│   │   │   │   │   ├── purchase_entity.dart
│   │   │   │   │   └── purchase_item_entity.dart
│   │   │   │   ├── 📁 repositories/
│   │   │   │   │   └── purchase_repository.dart
│   │   │   │   └── 📁 usecases/
│   │   │   │       ├── create_purchase_usecase.dart
│   │   │   │       └── receive_stock_usecase.dart
│   │   │   └── 📁 presentation/
│   │   │       ├── 📁 bloc/
│   │   │       │   ├── purchase_bloc.dart
│   │   │       │   ├── purchase_event.dart
│   │   │       │   └── purchase_state.dart
│   │   │       ├── 📁 pages/
│   │   │       │   ├── purchase_list_page.dart
│   │   │       │   ├── purchase_detail_page.dart
│   │   │       │   └── create_purchase_page.dart
│   │   │       └── 📁 widgets/
│   │   │           ├── purchase_card.dart
│   │   │           └── purchase_form.dart
│   │   │
│   │   ├── 📁 loyalty/
│   │   │   ├── 📁 data/
│   │   │   │   ├── 📁 datasources/
│   │   │   │   │   ├── loyalty_local_datasource.dart
│   │   │   │   │   └── loyalty_remote_datasource.dart
│   │   │   │   ├── 📁 models/
│   │   │   │   │   └── loyalty_transaction_model.dart
│   │   │   │   └── 📁 repositories/
│   │   │   │       └── loyalty_repository_impl.dart
│   │   │   ├── 📁 domain/
│   │   │   │   ├── 📁 entities/
│   │   │   │   │   └── loyalty_transaction_entity.dart
│   │   │   │   ├── 📁 repositories/
│   │   │   │   │   └── loyalty_repository.dart
│   │   │   │   └── 📁 usecases/
│   │   │   │       ├── earn_points_usecase.dart
│   │   │   │       ├── redeem_points_usecase.dart
│   │   │   │       └── get_loyalty_balance_usecase.dart
│   │   │   └── 📁 presentation/
│   │   │       ├── 📁 bloc/
│   │   │       │   ├── loyalty_bloc.dart
│   │   │       │   ├── loyalty_event.dart
│   │   │       │   └── loyalty_state.dart
│   │   │       ├── 📁 pages/
│   │   │       │   ├── loyalty_page.dart
│   │   │       │   └── loyalty_history_page.dart
│   │   │       └── 📁 widgets/
│   │   │           ├── loyalty_balance_card.dart
│   │   │           └── loyalty_history_item.dart
│   │   │
│   │   ├── 📁 employees/
│   │   │   ├── 📁 data/
│   │   │   │   ├── 📁 datasources/
│   │   │   │   │   ├── employee_local_datasource.dart
│   │   │   │   │   └── employee_remote_datasource.dart
│   │   │   │   ├── 📁 models/
│   │   │   │   │   └── employee_model.dart
│   │   │   │   └── 📁 repositories/
│   │   │   │       └── employee_repository_impl.dart
│   │   │   ├── 📁 domain/
│   │   │   │   ├── 📁 entities/
│   │   │   │   │   └── employee_entity.dart
│   │   │   │   ├── 📁 repositories/
│   │   │   │   │   └── employee_repository.dart
│   │   │   │   └── 📁 usecases/
│   │   │   │       ├── get_employees_usecase.dart
│   │   │   │       ├── clock_in_usecase.dart
│   │   │   │       └── clock_out_usecase.dart
│   │   │   └── 📁 presentation/
│   │   │       ├── 📁 bloc/
│   │   │       │   ├── employee_bloc.dart
│   │   │       │   ├── employee_event.dart
│   │   │       │   └── employee_state.dart
│   │   │       ├── 📁 pages/
│   │   │       │   ├── employee_list_page.dart
│   │   │       │   └── attendance_page.dart
│   │   │       └── 📁 widgets/
│   │   │           ├── employee_card.dart
│   │   │           └── attendance_card.dart
│   │   │
│   │   ├── 📁 reports/
│   │   │   ├── 📁 data/
│   │   │   │   ├── 📁 datasources/
│   │   │   │   │   └── report_remote_datasource.dart
│   │   │   │   └── 📁 models/
│   │   │   │       └── report_model.dart
│   │   │   ├── 📁 domain/
│   │   │   │   ├── 📁 entities/
│   │   │   │   │   └── report_entity.dart
│   │   │   │   └── 📁 usecases/
│   │   │   │       ├── get_sales_report_usecase.dart
│   │   │   │       ├── get_inventory_report_usecase.dart
│   │   │   │       └── get_financial_report_usecase.dart
│   │   │   └── 📁 presentation/
│   │   │       ├── 📁 bloc/
│   │   │       │   ├── report_bloc.dart
│   │   │       │   ├── report_event.dart
│   │   │       │   └── report_state.dart
│   │   │       └── 📁 pages/
│   │   │           ├── reports_page.dart
│   │   │           ├── sales_report_page.dart
│   │   │           └── inventory_report_page.dart
│   │   │
│   │   ├── 📁 settings/
│   │   │   ├── 📁 data/
│   │   │   │   ├── 📁 datasources/
│   │   │   │   │   └── settings_local_datasource.dart
│   │   │   │   └── 📁 models/
│   │   │   │       └── settings_model.dart
│   │   │   ├── 📁 domain/
│   │   │   │   └── 📁 entities/
│   │   │   │       └── settings_entity.dart
│   │   │   └── 📁 presentation/
│   │   │       ├── 📁 bloc/
│   │   │       │   ├── settings_bloc.dart
│   │   │       │   ├── settings_event.dart
│   │   │       │   └── settings_state.dart
│   │   │       └── 📁 pages/
│   │   │           ├── settings_page.dart
│   │   │           ├── company_settings_page.dart
│   │   │           ├── tax_settings_page.dart
│   │   │           └── backup_restore_page.dart
│   │   │
│   │   └── 📁 sync/
│   │       ├── 📁 data/
│   │       │   ├── 📁 datasources/
│   │       │   │   ├── sync_local_datasource.dart
│   │       │   │   └── sync_remote_datasource.dart
│   │       │   ├── 📁 models/
│   │       │   │   └── sync_queue_model.dart
│   │       │   └── 📁 repositories/
│   │       │       └── sync_repository_impl.dart
│   │       ├── 📁 domain/
│   │       │   ├── 📁 entities/
│   │       │   │   └── sync_queue_entity.dart
│   │       │   ├── 📁 repositories/
│   │       │   │   └── sync_repository.dart
│   │       │   └── 📁 usecases/
│   │       │       ├── sync_data_usecase.dart
│   │       │       └── get_sync_status_usecase.dart
│   │       └── 📁 presentation/
│   │           ├── 📁 bloc/
│   │           │   ├── sync_bloc.dart
│   │           │   ├── sync_event.dart
│   │           │   └── sync_state.dart
│   │           └── 📁 pages/
│   │               └── sync_page.dart
│   │
│   ├── 📁 shared/
│   │   ├── 📁 widgets/
│   │   │   ├── app_bar.dart
│   │   │   ├── bottom_nav.dart
│   │   │   ├── loading_widget.dart
│   │   │   ├── error_widget.dart
│   │   │   ├── empty_state.dart
│   │   │   ├── search_bar.dart
│   │   │   ├── confirm_dialog.dart
│   │   │   └── snackbar.dart
│   │   ├── 📁 utils/
│   │   │   ├── date_utils.dart
│   │   │   ├── currency_utils.dart
│   │   │   ├── validation_utils.dart
│   │   │   └── connectivity_utils.dart
│   │   └── 📁 extensions/
│   │       ├── string_extensions.dart
│   │       ├── date_extensions.dart
│   │       └── double_extensions.dart
│   │
│   ├── 📁 injection/
│   │   ├── injection_container.dart
│   │   └── injection.dart
│   │
│   ├── 📁 routes/
│   │   ├── app_router.dart
│   │   └── route_names.dart
│   │
│   └── main.dart
│
├── 📁 test/
│   ├── 📁 unit/
│   ├── 📁 integration/
│   └── 📁 widget/
│
├── 📁 android/
├── 📁 ios/
├── 📁 windows/
├── 📁 macos/
├── 📁 linux/
│
├── pubspec.yaml
├── analysis_options.yaml
└── README.md
```

## 3. .NET Backend API Structure

```
Backend_API/
├── 📁 SS_MART_API/
│   ├── 📁 Controllers/
│   │   ├── AuthController.cs
│   │   ├── ProductsController.cs
│   │   ├── CustomersController.cs
│   │   ├── BillsController.cs
│   │   ├── InventoryController.cs
│   │   ├── PurchasesController.cs
│   │   ├── LoyaltyController.cs
│   │   ├── EmployeesController.cs
│   │   ├── ReportsController.cs
│   │   ├── SyncController.cs
│   │   ├── ImportController.cs
│   │   ├── ExportController.cs
│   │   └── SettingsController.cs
│   │
│   ├── 📁 Core/
│   │   ├── 📁 Domain/
│   │   │   ├── 📁 Entities/
│   │   │   │   ├── BaseEntity.cs
│   │   │   │   ├── Product.cs
│   │   │   │   ├── Customer.cs
│   │   │   │   ├── Bill.cs
│   │   │   │   ├── BillItem.cs
│   │   │   │   ├── Stock.cs
│   │   │   │   ├── StockMovement.cs
│   │   │   │   ├── Purchase.cs
│   │   │   │   ├── PurchaseItem.cs
│   │   │   │   ├── LoyaltyTransaction.cs
│   │   │   │   ├── Employee.cs
│   │   │   │   ├── Shift.cs
│   │   │   │   ├── Attendance.cs
│   │   │   │   ├── AuditLog.cs
│   │   │   │   ├── SyncQueue.cs
│   │   │   │   └── Settings.cs
│   │   │   ├── 📁 Enums/
│   │   │   │   ├── EntityType.cs
│   │   │   │   ├── SyncStatus.cs
│   │   │   │   ├── PaymentMode.cs
│   │   │   │   ├── BillStatus.cs
│   │   │   │   ├── StockMovementType.cs
│   │   │   │   ├── LoyaltyTransactionType.cs
│   │   │   │   └── UserRole.cs
│   │   │   └── 📁 Interfaces/
│   │   │       ├── IRepository.cs
│   │   │       ├── IUnitOfWork.cs
│   │   │       └── IDateTime.cs
│   │   │
│   │   ├── 📁 Application/
│   │   │   ├── 📁 Interfaces/
│   │   │   │   ├── IProductService.cs
│   │   │   │   ├── ICustomerService.cs
│   │   │   │   ├── IBillService.cs
│   │   │   │   ├── IInventoryService.cs
│   │   │   │   ├── IPurchaseService.cs
│   │   │   │   ├── ILoyaltyService.cs
│   │   │   │   ├── IEmployeeService.cs
│   │   │   │   ├── IReportService.cs
│   │   │   │   ├── ISyncService.cs
│   │   │   │   ├── IImportService.cs
│   │   │   │   └── IAuthService.cs
│   │   │   ├── 📁 Services/
│   │   │   │   ├── ProductService.cs
│   │   │   │   ├── CustomerService.cs
│   │   │   │   ├── BillService.cs
│   │   │   │   ├── InventoryService.cs
│   │   │   │   ├── PurchaseService.cs
│   │   │   │   ├── LoyaltyService.cs
│   │   │   │   ├── EmployeeService.cs
│   │   │   │   ├── ReportService.cs
│   │   │   │   ├── SyncService.cs
│   │   │   │   ├── ImportService.cs
│   │   │   │   └── AuthService.cs
│   │   │   └── 📁 DTOs/
│   │   │       ├── ProductDto.cs
│   │   │       ├── CustomerDto.cs
│   │   │       ├── BillDto.cs
│   │   │       ├── StockDto.cs
│   │   │       ├── LoyaltyDto.cs
│   │   │       ├── EmployeeDto.cs
│   │   │       └── ReportDto.cs
│   │   │
│   │   └── 📁 Infrastructure/
│   │       ├── 📁 Data/
│   │       │   ├── AppDbContext.cs
│   │       │   ├── 📁 Configurations/
│   │       │   │   ├── ProductConfiguration.cs
│   │       │   │   ├── CustomerConfiguration.cs
│   │       │   │   ├── BillConfiguration.cs
│   │       │   │   └── ...
│   │       │   ├── 📁 Migrations/
│   │       │   └── 📁 Repositories/
│   │       │       ├── Repository.cs
│   │       │       ├── ProductRepository.cs
│   │       │       ├── CustomerRepository.cs
│   │       │       └── ...
│   │       ├── 📁 Services/
│   │       │   ├── JwtService.cs
│   │       │   ├── FileStorageService.cs
│   │       │   └── EmailService.cs
│   │       └── 📁 Extensions/
│   │           ├── ServiceCollectionExtensions.cs
│   │           └── MiddlewareExtensions.cs
│   │
│   ├── 📁 Common/
│   │   ├── 📁 Behaviors/
│   │   │   ├── ValidationBehavior.cs
│   │   │   └── LoggingBehavior.cs
│   │   ├── 📁 Exceptions/
│   │   │   ├── BadRequestException.cs
│   │   │   ├── NotFoundException.cs
│   │   │   └── ConflictException.cs
│   │   └── 📁 Models/
│   │       ├── Result.cs
│   │       ├── PagedResult.cs
│   │       └── ApiResponse.cs
│   │
│   ├── 📁 Extensions/
│   │   ├── AuthenticationExtensions.cs
│   │   ├── AuthorizationExtensions.cs
│   │   ├── HealthCheckExtensions.cs
│   │   └── SwaggerExtensions.cs
│   │
│   ├── 📁 Middleware/
│   │   ├── ExceptionHandlingMiddleware.cs
│   │   ├── RequestLoggingMiddleware.cs
│   │   └── RateLimitingMiddleware.cs
│   │
│   ├── 📁 Filters/
│   │   ├── ValidationFilter.cs
│   │   └── LoggingFilter.cs
│   │
│   ├── appsettings.json
│   ├── appsettings.Development.json
│   ├── appsettings.Production.json
│   ├── Program.cs
│   └── SS_MART_API.csproj
│
├── 📁 SS_MART_API.Tests/
│   ├── 📁 Unit/
│   ├── 📁 Integration/
│   └── 📁 Functional/
│
├── 📁 SS_MART.Shared/
│   ├── 📁 DTOs/
│   ├── 📁 Enums/
│   └── 📁 Constants/
│
├── SS_MART_API.sln
├── .gitignore
└── README.md
```

## 4. Database Structure

```
Database/
├── 📁 SQLite/
│   ├── 📁 Migrations/
│   │   ├── 001_initial_schema.sql
│   │   ├── 002_add_indexes.sql
│   │   └── 003_add_triggers.sql
│   ├── 📁 Seeds/
│   │   ├── default_settings.sql
│   │   └── sample_data.sql
│   └── schema.sql
│
├── 📁 PostgreSQL/
│   ├── 📁 Migrations/
│   │   ├── 001_initial_schema.sql
│   │   ├── 002_add_indexes.sql
│   │   ├── 003_add_partitions.sql
│   │   └── 004_add_rls_policies.sql
│   ├── 📁 Seeds/
│   │   └── default_data.sql
│   └── schema.sql
│
└── 📁 Scripts/
    ├── backup_database.sh
    ├── restore_database.sh
    └── migrate_database.sh
```

## 5. Shared Libraries Structure

```
Shared_Libraries/
├── 📁 Models/
│   ├── 📁 Entities/
│   │   ├── Product.cs
│   │   ├── Customer.cs
│   │   └── ...
│   ├── 📁 Enums/
│   │   ├── EntityType.cs
│   │   └── ...
│   └── 📁 Constants/
│       ├── AppConstants.cs
│       └── ...
│
├── 📁 Interfaces/
│   ├── IRepository.cs
│   ├── IService.cs
│   └── ...
│
└── 📁 Utils/
    ├── ValidationUtils.cs
    └── FormatUtils.cs
```

## 6. Tests Structure

```
Tests/
├── 📁 Unit/
│   ├── 📁 Mobile_App/
│   │   ├── 📁 Features/
│   │   │   ├── 📁 Auth/
│   │   │   ├── 📁 Billing/
│   │   │   ├── 📁 Products/
│   │   │   └── ...
│   │   └── 📁 Core/
│   │
│   └── 📁 Backend_API/
│       ├── 📁 Services/
│       ├── 📁 Controllers/
│       └── 📁 Repositories/
│
├── 📁 Integration/
│   ├── 📁 API/
│   │   ├── AuthApiTests.cs
│   │   ├── ProductApiTests.cs
│   │   └── ...
│   └── 📁 Database/
│       ├── ProductRepositoryTests.cs
│       └── ...
│
└── 📁 E2E/
    ├── 📁 BillingFlow/
    ├── 📁 InventoryFlow/
    └── 📁 CustomerFlow/
```

## 7. Documentation Structure

```
Documentation/
├── 📁 Architecture/
│   ├── ARCHITECTURE.md
│   ├── DATA_FLOW.md
│   └── SECURITY.md
│
├── 📁 API/
│   ├── api_documentation.md
│   └── postman_collection.json
│
├── 📁 User_Guides/
│   ├── billing_guide.md
│   ├── inventory_guide.md
│   └── admin_guide.md
│
├── 📁 Developer/
│   ├── setup_guide.md
│   ├── coding_standards.md
│   └── contribution_guide.md
│
└── 📁 Database/
    ├── schema_documentation.md
    └── data_dictionary.md
```

## 8. Scripts Structure

```
Scripts/
├── 📁 Build/
│   ├── build_mobile.sh
│   ├── build_desktop.sh
│   └── build_api.sh
│
├── 📁 Deploy/
│   ├── deploy_staging.sh
│   └── deploy_production.sh
│
├── 📁 Database/
│   ├── backup.sh
│   ├── restore.sh
│   └── migrate.sh
│
└── 📁 Utilities/
    ├── generate_api_client.sh
    └── clean_build.sh
```

## 9. Tools Structure

```
Tools/
├── 📁 ApiClientGenerator/
│   └── generate_client.dart
│
├── 📁 DatabaseDesigner/
│   └── schema_generator.dart
│
├── 📁 TestDataGenerator/
│   └── generate_test_data.dart
│
└── 📁 CodeGenerator/
    └── generate_code.dart
```

## 10. Configuration Files

```
SS_MART_ERP/
├── .gitignore
├── .editorconfig
├── .env.example
├── docker-compose.yml
├── docker-compose.development.yml
├── docker-compose.production.yml
├── Makefile
├── README.md
└── SOLUTION.md
```

This comprehensive folder structure provides a well-organized foundation for the SS MART retail ERP system, following clean architecture principles and best practices for both Flutter and .NET development.
