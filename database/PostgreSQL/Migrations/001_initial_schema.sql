-- SS MART Database Schema (PostgreSQL)

-- Products Table
CREATE TABLE IF NOT EXISTS products (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    sku VARCHAR(50),
    barcode VARCHAR(20),
    hsn_code VARCHAR(20) NOT NULL,
    unit VARCHAR(10) DEFAULT 'PCS',
    pack_size DECIMAL(10,2) DEFAULT 1.0,
    mrp DECIMAL(12,2) NOT NULL,
    selling_price DECIMAL(12,2) NOT NULL,
    purchase_price DECIMAL(12,2),
    tax_rate DECIMAL(5,2) DEFAULT 0.0,
    tax_type VARCHAR(10) DEFAULT 'GST',
    category_id UUID,
    supplier_id UUID,
    reorder_level INTEGER DEFAULT 10,
    current_stock INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL,
    version INTEGER DEFAULT 1,
    sync_status VARCHAR(20) DEFAULT 'pending',
    deleted_at TIMESTAMP WITH TIME ZONE
);

-- Customers Table
CREATE TABLE IF NOT EXISTS customers (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(255),
    address TEXT,
    city VARCHAR(100),
    state VARCHAR(100),
    pincode VARCHAR(10),
    gstin VARCHAR(15),
    type VARCHAR(10) DEFAULT 'B2C',
    credit_limit DECIMAL(12,2) DEFAULT 0,
    current_balance DECIMAL(12,2) DEFAULT 0,
    loyalty_points INTEGER DEFAULT 0,
    loyalty_card_number VARCHAR(50),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL,
    version INTEGER DEFAULT 1,
    sync_status VARCHAR(20) DEFAULT 'pending',
    deleted_at TIMESTAMP WITH TIME ZONE
);

-- Bills Table
CREATE TABLE IF NOT EXISTS bills (
    id UUID PRIMARY KEY,
    bill_number VARCHAR(50) NOT NULL,
    invoice_number VARCHAR(50),
    customer_id UUID REFERENCES customers(id),
    bill_date TIMESTAMP WITH TIME ZONE NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,
    tax_amount DECIMAL(12,2) DEFAULT 0,
    discount_amount DECIMAL(12,2) DEFAULT 0,
    round_off DECIMAL(12,2) DEFAULT 0,
    total_amount DECIMAL(12,2) NOT NULL,
    paid_amount DECIMAL(12,2) DEFAULT 0,
    due_amount DECIMAL(12,2) DEFAULT 0,
    payment_mode VARCHAR(20) DEFAULT 'CASH',
    status VARCHAR(20) DEFAULT 'completed',
    is_return BOOLEAN DEFAULT FALSE,
    reference_bill_id UUID,
    created_by UUID,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL,
    version INTEGER DEFAULT 1,
    sync_status VARCHAR(20) DEFAULT 'pending',
    deleted_at TIMESTAMP WITH TIME ZONE
);

-- Bill Items Table
CREATE TABLE IF NOT EXISTS bill_items (
    id UUID PRIMARY KEY,
    bill_id UUID NOT NULL REFERENCES bills(id),
    product_id UUID NOT NULL REFERENCES products(id),
    quantity DECIMAL(10,2) NOT NULL,
    unit_price DECIMAL(12,2) NOT NULL,
    discount_percent DECIMAL(5,2) DEFAULT 0,
    discount_amount DECIMAL(12,2) DEFAULT 0,
    tax_amount DECIMAL(12,2) DEFAULT 0,
    total_amount DECIMAL(12,2) NOT NULL,
    batch_number VARCHAR(50),
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL,
    version INTEGER DEFAULT 1,
    sync_status VARCHAR(20) DEFAULT 'pending',
    deleted_at TIMESTAMP WITH TIME ZONE
);

-- Stock Table
CREATE TABLE IF NOT EXISTS stock (
    id UUID PRIMARY KEY,
    product_id UUID NOT NULL REFERENCES products(id),
    location_id VARCHAR(50) DEFAULT 'MAIN',
    quantity INTEGER NOT NULL DEFAULT 0,
    reserved_quantity INTEGER DEFAULT 0,
    batch_number VARCHAR(50),
    expiry_date TIMESTAMP WITH TIME ZONE,
    last_updated TIMESTAMP WITH TIME ZONE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL,
    version INTEGER DEFAULT 1,
    sync_status VARCHAR(20) DEFAULT 'pending',
    deleted_at TIMESTAMP WITH TIME ZONE
);

-- Stock Movements Table
CREATE TABLE IF NOT EXISTS stock_movements (
    id UUID PRIMARY KEY,
    product_id UUID NOT NULL REFERENCES products(id),
    movement_type VARCHAR(50) NOT NULL,
    quantity DECIMAL(10,2) NOT NULL,
    reference_type VARCHAR(50),
    reference_id UUID,
    notes TEXT,
    created_by UUID,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL,
    version INTEGER DEFAULT 1,
    sync_status VARCHAR(20) DEFAULT 'pending',
    deleted_at TIMESTAMP WITH TIME ZONE
);

-- Loyalty Transactions Table
CREATE TABLE IF NOT EXISTS loyalty_transactions (
    id UUID PRIMARY KEY,
    customer_id UUID NOT NULL REFERENCES customers(id),
    transaction_type VARCHAR(20) NOT NULL,
    points INTEGER NOT NULL,
    reference_type VARCHAR(50),
    reference_id UUID,
    expiry_date TIMESTAMP WITH TIME ZONE,
    notes TEXT,
    created_by UUID,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL,
    version INTEGER DEFAULT 1,
    sync_status VARCHAR(20) DEFAULT 'pending',
    deleted_at TIMESTAMP WITH TIME ZONE
);

-- Employees Table
CREATE TABLE IF NOT EXISTS employees (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(255),
    role VARCHAR(20) DEFAULT 'cashier',
    pin VARCHAR(10),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL,
    version INTEGER DEFAULT 1,
    sync_status VARCHAR(20) DEFAULT 'pending',
    deleted_at TIMESTAMP WITH TIME ZONE
);

-- Sync Queue Table
CREATE TABLE IF NOT EXISTS sync_queue (
    id UUID PRIMARY KEY,
    entity_type VARCHAR(50) NOT NULL,
    entity_id UUID NOT NULL,
    operation VARCHAR(20) NOT NULL,
    payload TEXT NOT NULL,
    status VARCHAR(20) DEFAULT 'pending',
    retry_count INTEGER DEFAULT 0,
    max_retries INTEGER DEFAULT 3,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    last_attempt_at TIMESTAMP WITH TIME ZONE,
    completed_at TIMESTAMP WITH TIME ZONE,
    error TEXT
);

-- Audit Logs Table
CREATE TABLE IF NOT EXISTS audit_logs (
    id UUID PRIMARY KEY,
    user_id UUID,
    action VARCHAR(100) NOT NULL,
    entity_type VARCHAR(50),
    entity_id UUID,
    old_value TEXT,
    new_value TEXT,
    ip_address VARCHAR(50),
    device_id VARCHAR(100),
    created_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Settings Table
CREATE TABLE IF NOT EXISTS settings (
    id UUID PRIMARY KEY,
    key VARCHAR(100) UNIQUE NOT NULL,
    value TEXT NOT NULL,
    category VARCHAR(50),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Create Indexes
CREATE INDEX IF NOT EXISTS idx_products_barcode ON products(barcode);
CREATE INDEX IF NOT EXISTS idx_products_sku ON products(sku);
CREATE INDEX IF NOT EXISTS idx_products_hsn ON products(hsn_code);
CREATE INDEX IF NOT EXISTS idx_customers_phone ON customers(phone);
CREATE INDEX IF NOT EXISTS idx_bills_customer ON bills(customer_id);
CREATE INDEX IF NOT EXISTS idx_bills_date ON bills(bill_date);
CREATE INDEX IF NOT EXISTS idx_bills_number ON bills(bill_number);
CREATE INDEX IF NOT EXISTS idx_bill_items_bill ON bill_items(bill_id);
CREATE INDEX IF NOT EXISTS idx_bill_items_product ON bill_items(product_id);
CREATE INDEX IF NOT EXISTS idx_stock_product ON stock(product_id);
CREATE INDEX IF NOT EXISTS idx_stock_location ON stock(location_id);
CREATE INDEX IF NOT EXISTS idx_loyalty_customer ON loyalty_transactions(customer_id);
CREATE INDEX IF NOT EXISTS idx_sync_queue_status ON sync_queue(status);
CREATE INDEX IF NOT EXISTS idx_sync_queue_entity ON sync_queue(entity_type, entity_id);
CREATE INDEX IF NOT EXISTS idx_audit_logs_user ON audit_logs(user_id);
CREATE INDEX IF NOT EXISTS idx_audit_logs_entity ON audit_logs(entity_type, entity_id);
