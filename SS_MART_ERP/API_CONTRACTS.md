# SS MART - API Contract Specifications

## 1. Authentication API

### 1.1 Login

**Endpoint:** `POST /api/auth/login`

**Request:**
```json
{
  "username": "string",
  "password": "string",
  "deviceId": "string (optional)"
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "accessToken": "string",
    "refreshToken": "string",
    "expiresIn": 900,
    "user": {
      "id": "uuid",
      "name": "string",
      "role": "cashier",
      "storeId": "uuid"
    }
  },
  "meta": {
    "timestamp": "2026-07-24T10:30:00Z",
    "version": 1
  }
}
```

**Response (401 Unauthorized):**
```json
{
  "success": false,
  "error": "Invalid credentials",
  "message": "Username or password is incorrect"
}
```

### 1.2 Refresh Token

**Endpoint:** `POST /api/auth/refresh`

**Request:**
```json
{
  "refreshToken": "string"
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "accessToken": "string",
    "refreshToken": "string",
    "expiresIn": 900
  }
}
```

### 1.3 Validate PIN

**Endpoint:** `POST /api/auth/validate-pin`

**Request:**
```json
{
  "employeeId": "uuid",
  "pin": "string"
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "valid": true,
    "employee": {
      "id": "uuid",
      "name": "string",
      "role": "cashier"
    }
  }
}
```

### 1.4 Logout

**Endpoint:** `POST /api/auth/logout`

**Headers:**
```
Authorization: Bearer {accessToken}
```

**Response (200 OK):**
```json
{
  "success": true,
  "message": "Logged out successfully"
}
```

## 2. Products API

### 2.1 Get Products List

**Endpoint:** `GET /api/products`

**Query Parameters:**
- `page` (int, default: 1)
- `perPage` (int, default: 20, max: 100)
- `search` (string, optional)
- `category` (uuid, optional)
- `supplier` (uuid, optional)
- `isActive` (boolean, optional)
- `sortBy` (string: name, price, stock, createdAt)
- `sortOrder` (string: asc, desc)

**Headers:**
```
Authorization: Bearer {accessToken}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": [
    {
      "id": "uuid",
      "name": "Product Name",
      "sku": "SKU001",
      "barcode": "8901234567890",
      "hsnCode": "8471",
      "unit": "pcs",
      "packSize": 1.0,
      "mrp": {
        "amount": 10000,
        "currency": "INR"
      },
      "sellingPrice": {
        "amount": 9500,
        "currency": "INR"
      },
      "purchasePrice": {
        "amount": 7000,
        "currency": "INR"
      },
      "taxRate": 18.0,
      "taxType": "gst",
      "categoryId": "uuid",
      "categoryName": "Electronics",
      "supplierId": "uuid",
      "supplierName": "Supplier Name",
      "reorderLevel": 10,
      "currentStock": 50,
      "isActive": true,
      "createdAt": "2026-07-24T10:30:00Z",
      "updatedAt": "2026-07-24T10:30:00Z",
      "version": 1,
      "syncStatus": "completed"
    }
  ],
  "meta": {
    "timestamp": "2026-07-24T10:30:00Z",
    "version": 1,
    "pagination": {
      "page": 1,
      "perPage": 20,
      "total": 100,
      "totalPages": 5
    }
  }
}
```

### 2.2 Get Product by ID

**Endpoint:** `GET /api/products/{id}`

**Headers:**
```
Authorization: Bearer {accessToken}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "name": "Product Name",
    "sku": "SKU001",
    "barcode": "8901234567890",
    "hsnCode": "8471",
    "unit": "pcs",
    "packSize": 1.0,
    "mrp": {
      "amount": 10000,
      "currency": "INR"
    },
    "sellingPrice": {
      "amount": 9500,
      "currency": "INR"
    },
    "purchasePrice": {
      "amount": 7000,
      "currency": "INR"
    },
    "taxRate": 18.0,
    "taxType": "gst",
    "categoryId": "uuid",
    "categoryName": "Electronics",
    "supplierId": "uuid",
    "supplierName": "Supplier Name",
    "reorderLevel": 10,
    "currentStock": 50,
    "isActive": true,
    "createdAt": "2026-07-24T10:30:00Z",
    "updatedAt": "2026-07-24T10:30:00Z",
    "version": 1,
    "syncStatus": "completed"
  }
}
```

### 2.3 Create Product

**Endpoint:** `POST /api/products`

**Headers:**
```
Authorization: Bearer {accessToken}
Content-Type: application/json
```

**Request:**
```json
{
  "name": "Product Name",
  "sku": "SKU001",
  "barcode": "8901234567890",
  "hsnCode": "8471",
  "unit": "pcs",
  "packSize": 1.0,
  "mrp": {
    "amount": 10000,
    "currency": "INR"
  },
  "sellingPrice": {
    "amount": 9500,
    "currency": "INR"
  },
  "purchasePrice": {
    "amount": 7000,
    "currency": "INR"
  },
  "taxRate": 18.0,
  "taxType": "gst",
  "categoryId": "uuid",
  "supplierId": "uuid",
  "reorderLevel": 10,
  "currentStock": 50
}
```

**Response (201 Created):**
```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "name": "Product Name",
    "sku": "SKU001",
    "barcode": "8901234567890",
    "hsnCode": "8471",
    "unit": "pcs",
    "packSize": 1.0,
    "mrp": {
      "amount": 10000,
      "currency": "INR"
    },
    "sellingPrice": {
      "amount": 9500,
      "currency": "INR"
    },
    "purchasePrice": {
      "amount": 7000,
      "currency": "INR"
    },
    "taxRate": 18.0,
    "taxType": "gst",
    "categoryId": "uuid",
    "categoryName": "Electronics",
    "supplierId": "uuid",
    "supplierName": "Supplier Name",
    "reorderLevel": 10,
    "currentStock": 50,
    "isActive": true,
    "createdAt": "2026-07-24T10:30:00Z",
    "updatedAt": "2026-07-24T10:30:00Z",
    "version": 1,
    "syncStatus": "pending"
  },
  "message": "Product created successfully"
}
```

### 2.4 Update Product

**Endpoint:** `PUT /api/products/{id}`

**Headers:**
```
Authorization: Bearer {accessToken}
Content-Type: application/json
```

**Request:**
```json
{
  "name": "Updated Product Name",
  "sku": "SKU001",
  "barcode": "8901234567890",
  "hsnCode": "8471",
  "unit": "pcs",
  "packSize": 1.0,
  "mrp": {
    "amount": 10000,
    "currency": "INR"
  },
  "sellingPrice": {
    "amount": 9500,
    "currency": "INR"
  },
  "purchasePrice": {
    "amount": 7000,
    "currency": "INR"
  },
  "taxRate": 18.0,
  "taxType": "gst",
  "categoryId": "uuid",
  "supplierId": "uuid",
  "reorderLevel": 10,
  "isActive": true,
  "version": 1
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "name": "Updated Product Name",
    "sku": "SKU001",
    "barcode": "8901234567890",
    "hsnCode": "8471",
    "unit": "pcs",
    "packSize": 1.0,
    "mrp": {
      "amount": 10000,
      "currency": "INR"
    },
    "sellingPrice": {
      "amount": 9500,
      "currency": "INR"
    },
    "purchasePrice": {
      "amount": 7000,
      "currency": "INR"
    },
    "taxRate": 18.0,
    "taxType": "gst",
    "categoryId": "uuid",
    "categoryName": "Electronics",
    "supplierId": "uuid",
    "supplierName": "Supplier Name",
    "reorderLevel": 10,
    "currentStock": 50,
    "isActive": true,
    "createdAt": "2026-07-24T10:30:00Z",
    "updatedAt": "2026-07-24T10:30:00Z",
    "version": 2,
    "syncStatus": "pending"
  },
  "message": "Product updated successfully"
}
```

### 2.5 Delete Product

**Endpoint:** `DELETE /api/products/{id}`

**Headers:**
```
Authorization: Bearer {accessToken}
```

**Response (200 OK):**
```json
{
  "success": true,
  "message": "Product deleted successfully"
}
```

### 2.6 Search Products

**Endpoint:** `GET /api/products/search`

**Query Parameters:**
- `q` (string, required) - Search query
- `limit` (int, default: 20, max: 50)

**Headers:**
```
Authorization: Bearer {accessToken}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": [
    {
      "id": "uuid",
      "name": "Product Name",
      "sku": "SKU001",
      "barcode": "8901234567890",
      "sellingPrice": {
        "amount": 9500,
        "currency": "INR"
      },
      "currentStock": 50
    }
  ]
}
```

### 2.7 Get Product by Barcode

**Endpoint:** `GET /api/products/barcode/{barcode}`

**Headers:**
```
Authorization: Bearer {accessToken}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "name": "Product Name",
    "sku": "SKU001",
    "barcode": "8901234567890",
    "hsnCode": "8471",
    "unit": "pcs",
    "packSize": 1.0,
    "mrp": {
      "amount": 10000,
      "currency": "INR"
    },
    "sellingPrice": {
      "amount": 9500,
      "currency": "INR"
    },
    "taxRate": 18.0,
    "taxType": "gst",
    "currentStock": 50,
    "isActive": true
  }
}
```

## 3. Customers API

### 3.1 Get Customers List

**Endpoint:** `GET /api/customers`

**Query Parameters:**
- `page` (int, default: 1)
- `perPage` (int, default: 20, max: 100)
- `search` (string, optional)
- `type` (string: B2B, B2C, optional)
- `isActive` (boolean, optional)
- `sortBy` (string: name, phone, createdAt)
- `sortOrder` (string: asc, desc)

**Headers:**
```
Authorization: Bearer {accessToken}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": [
    {
      "id": "uuid",
      "name": "Customer Name",
      "phone": "9876543210",
      "email": "customer@example.com",
      "address": "123 Main Street",
      "city": "Mumbai",
      "state": "Maharashtra",
      "pincode": "400001",
      "gstin": "27AAPFU0939F1ZV",
      "type": "B2C",
      "creditLimit": {
        "amount": 5000000,
        "currency": "INR"
      },
      "currentBalance": {
        "amount": 1500000,
        "currency": "INR"
      },
      "loyaltyPoints": 1500,
      "loyaltyCardNumber": "LOY001",
      "isActive": true,
      "createdAt": "2026-07-24T10:30:00Z",
      "updatedAt": "2026-07-24T10:30:00Z",
      "version": 1,
      "syncStatus": "completed"
    }
  ],
  "meta": {
    "timestamp": "2026-07-24T10:30:00Z",
    "version": 1,
    "pagination": {
      "page": 1,
      "perPage": 20,
      "total": 100,
      "totalPages": 5
    }
  }
}
```

### 3.2 Get Customer by ID

**Endpoint:** `GET /api/customers/{id}`

**Headers:**
```
Authorization: Bearer {accessToken}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "name": "Customer Name",
    "phone": "9876543210",
    "email": "customer@example.com",
    "address": "123 Main Street",
    "city": "Mumbai",
    "state": "Maharashtra",
    "pincode": "400001",
    "gstin": "27AAPFU0939F1ZV",
    "type": "B2C",
    "creditLimit": {
      "amount": 5000000,
      "currency": "INR"
    },
    "currentBalance": {
      "amount": 1500000,
      "currency": "INR"
    },
    "loyaltyPoints": 1500,
    "loyaltyCardNumber": "LOY001",
    "isActive": true,
    "createdAt": "2026-07-24T10:30:00Z",
    "updatedAt": "2026-07-24T10:30:00Z",
    "version": 1,
    "syncStatus": "completed"
  }
}
```

### 3.3 Create Customer

**Endpoint:** `POST /api/customers`

**Headers:**
```
Authorization: Bearer {accessToken}
Content-Type: application/json
```

**Request:**
```json
{
  "name": "Customer Name",
  "phone": "9876543210",
  "email": "customer@example.com",
  "address": "123 Main Street",
  "city": "Mumbai",
  "state": "Maharashtra",
  "pincode": "400001",
  "gstin": "27AAPFU0939F1ZV",
  "type": "B2C",
  "creditLimit": {
    "amount": 5000000,
    "currency": "INR"
  },
  "loyaltyCardNumber": "LOY001"
}
```

**Response (201 Created):**
```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "name": "Customer Name",
    "phone": "9876543210",
    "email": "customer@example.com",
    "address": "123 Main Street",
    "city": "Mumbai",
    "state": "Maharashtra",
    "pincode": "400001",
    "gstin": "27AAPFU0939F1ZV",
    "type": "B2C",
    "creditLimit": {
      "amount": 5000000,
      "currency": "INR"
    },
    "currentBalance": {
      "amount": 0,
      "currency": "INR"
    },
    "loyaltyPoints": 0,
    "loyaltyCardNumber": "LOY001",
    "isActive": true,
    "createdAt": "2026-07-24T10:30:00Z",
    "updatedAt": "2026-07-24T10:30:00Z",
    "version": 1,
    "syncStatus": "pending"
  },
  "message": "Customer created successfully"
}
```

### 3.4 Update Customer

**Endpoint:** `PUT /api/customers/{id}`

**Headers:**
```
Authorization: Bearer {accessToken}
Content-Type: application/json
```

**Request:**
```json
{
  "name": "Updated Customer Name",
  "phone": "9876543210",
  "email": "customer@example.com",
  "address": "123 Main Street",
  "city": "Mumbai",
  "state": "Maharashtra",
  "pincode": "400001",
  "gstin": "27AAPFU0939F1ZV",
  "type": "B2C",
  "creditLimit": {
    "amount": 5000000,
    "currency": "INR"
  },
  "loyaltyCardNumber": "LOY001",
  "isActive": true,
  "version": 1
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "name": "Updated Customer Name",
    "phone": "9876543210",
    "email": "customer@example.com",
    "address": "123 Main Street",
    "city": "Mumbai",
    "state": "Maharashtra",
    "pincode": "400001",
    "gstin": "27AAPFU0939F1ZV",
    "type": "B2C",
    "creditLimit": {
      "amount": 5000000,
      "currency": "INR"
    },
    "currentBalance": {
      "amount": 1500000,
      "currency": "INR"
    },
    "loyaltyPoints": 1500,
    "loyaltyCardNumber": "LOY001",
    "isActive": true,
    "createdAt": "2026-07-24T10:30:00Z",
    "updatedAt": "2026-07-24T10:30:00Z",
    "version": 2,
    "syncStatus": "pending"
  },
  "message": "Customer updated successfully"
}
```

### 3.5 Delete Customer

**Endpoint:** `DELETE /api/customers/{id}`

**Headers:**
```
Authorization: Bearer {accessToken}
```

**Response (200 OK):**
```json
{
  "success": true,
  "message": "Customer deleted successfully"
}
```

### 3.6 Search Customers

**Endpoint:** `GET /api/customers/search`

**Query Parameters:**
- `q` (string, required) - Search query (phone, name, or loyalty card)
- `limit` (int, default: 20, max: 50)

**Headers:**
```
Authorization: Bearer {accessToken}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": [
    {
      "id": "uuid",
      "name": "Customer Name",
      "phone": "9876543210",
      "type": "B2C",
      "loyaltyPoints": 1500,
      "loyaltyCardNumber": "LOY001"
    }
  ]
}
```

### 3.7 Get Customer Purchase History

**Endpoint:** `GET /api/customers/{id}/history`

**Query Parameters:**
- `page` (int, default: 1)
- `perPage` (int, default: 20)
- `startDate` (string, optional) - ISO 8601 date
- `endDate` (string, optional) - ISO 8601 date

**Headers:**
```
Authorization: Bearer {accessToken}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": [
    {
      "id": "uuid",
      "billNumber": "BILL-001",
      "billDate": "2026-07-24T10:30:00Z",
      "totalAmount": {
        "amount": 250000,
        "currency": "INR"
      },
      "paidAmount": {
        "amount": 250000,
        "currency": "INR"
      },
      "status": "completed",
      "items": [
        {
          "productName": "Product 1",
          "quantity": 2,
          "unitPrice": {
            "amount": 5000,
            "currency": "INR"
          },
          "totalAmount": {
            "amount": 10000,
            "currency": "INR"
          }
        }
      ]
    }
  ],
  "meta": {
    "pagination": {
      "page": 1,
      "perPage": 20,
      "total": 50,
      "totalPages": 3
    }
  }
}
```

### 3.8 Get Customer Loyalty History

**Endpoint:** `GET /api/customers/{id}/loyalty`

**Headers:**
```
Authorization: Bearer {accessToken}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "customerId": "uuid",
    "customerName": "Customer Name",
    "totalPointsEarned": 5000,
    "totalPointsRedeemed": 3500,
    "currentBalance": 1500,
    "pendingPoints": 0,
    "expiringPoints": 200,
    "nextExpiryDate": "2026-08-15T00:00:00Z",
    "recentTransactions": [
      {
        "id": "uuid",
        "transactionType": "earn",
        "points": 250,
        "referenceType": "bill",
        "referenceId": "uuid",
        "createdAt": "2026-07-24T10:30:00Z"
      }
    ]
  }
}
```

## 4. Bills API

### 4.1 Get Bills List

**Endpoint:** `GET /api/bills`

**Query Parameters:**
- `page` (int, default: 1)
- `perPage` (int, default: 20, max: 100)
- `customerId` (uuid, optional)
- `startDate` (string, optional)
- `endDate` (string, optional)
- `status` (string: completed, cancelled, returned, optional)
- `paymentMode` (string, optional)
- `sortBy` (string: billDate, totalAmount)
- `sortOrder` (string: asc, desc)

**Headers:**
```
Authorization: Bearer {accessToken}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": [
    {
      "id": "uuid",
      "billNumber": "BILL-001",
      "invoiceNumber": "INV-001",
      "customerId": "uuid",
      "customerName": "Customer Name",
      "billDate": "2026-07-24T10:30:00Z",
      "subtotal": {
        "amount": 21200,
        "currency": "INR"
      },
      "taxAmount": {
        "amount": 3816,
        "currency": "INR"
      },
      "discountAmount": {
        "amount": 500,
        "currency": "INR"
      },
      "roundOff": {
        "amount": 16,
        "currency": "INR"
      },
      "totalAmount": {
        "amount": 24516,
        "currency": "INR"
      },
      "paidAmount": {
        "amount": 24516,
        "currency": "INR"
      },
      "dueAmount": {
        "amount": 0,
        "currency": "INR"
      },
      "paymentMode": "cash",
      "status": "completed",
      "isReturn": false,
      "createdBy": "uuid",
      "createdByName": "Cashier Name",
      "createdAt": "2026-07-24T10:30:00Z",
      "updatedAt": "2026-07-24T10:30:00Z",
      "version": 1,
      "syncStatus": "completed"
    }
  ],
  "meta": {
    "timestamp": "2026-07-24T10:30:00Z",
    "version": 1,
    "pagination": {
      "page": 1,
      "perPage": 20,
      "total": 100,
      "totalPages": 5
    }
  }
}
```

### 4.2 Get Bill by ID

**Endpoint:** `GET /api/bills/{id}`

**Headers:**
```
Authorization: Bearer {accessToken}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "billNumber": "BILL-001",
    "invoiceNumber": "INV-001",
    "customerId": "uuid",
    "customerName": "Customer Name",
    "customerPhone": "9876543210",
    "billDate": "2026-07-24T10:30:00Z",
    "subtotal": {
      "amount": 21200,
      "currency": "INR"
    },
    "taxAmount": {
      "amount": 3816,
      "currency": "INR"
    },
    "discountAmount": {
      "amount": 500,
      "currency": "INR"
    },
    "roundOff": {
      "amount": 16,
      "currency": "INR"
    },
    "totalAmount": {
      "amount": 24516,
      "currency": "INR"
    },
    "paidAmount": {
      "amount": 24516,
      "currency": "INR"
    },
    "dueAmount": {
      "amount": 0,
      "currency": "INR"
    },
    "paymentMode": "cash",
    "status": "completed",
    "isReturn": false,
    "createdBy": "uuid",
    "createdByName": "Cashier Name",
    "createdAt": "2026-07-24T10:30:00Z",
    "updatedAt": "2026-07-24T10:30:00Z",
    "version": 1,
    "syncStatus": "completed",
    "items": [
      {
        "id": "uuid",
        "productId": "uuid",
        "productName": "Product 1",
        "quantity": 2,
        "unitPrice": {
          "amount": 5000,
          "currency": "INR"
        },
        "discountPercent": 5.0,
        "discountAmount": {
          "amount": 500,
          "currency": "INR"
        },
        "taxAmount": {
          "amount": 1800,
          "currency": "INR"
        },
        "totalAmount": {
          "amount": 11300,
          "currency": "INR"
        },
        "batchNumber": "BATCH001",
        "expiryDate": "2027-12-31T00:00:00Z"
      }
    ],
    "taxBreakdown": {
      "CGST": {
        "amount": 900,
        "currency": "INR"
      },
      "SGST": {
        "amount": 900,
        "currency": "INR"
      }
    }
  }
}
```

### 4.3 Create Bill

**Endpoint:** `POST /api/bills`

**Headers:**
```
Authorization: Bearer {accessToken}
Content-Type: application/json
```

**Request:**
```json
{
  "customerId": "uuid",
  "billDate": "2026-07-24T10:30:00Z",
  "items": [
    {
      "productId": "uuid",
      "quantity": 2,
      "unitPrice": {
        "amount": 5000,
        "currency": "INR"
      },
      "discountPercent": 5.0,
      "batchNumber": "BATCH001"
    }
  ],
  "paymentMode": "cash",
  "paidAmount": {
    "amount": 24516,
    "currency": "INR"
  },
  "notes": "Optional notes"
}
```

**Response (201 Created):**
```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "billNumber": "BILL-001",
    "invoiceNumber": "INV-001",
    "customerId": "uuid",
    "customerName": "Customer Name",
    "billDate": "2026-07-24T10:30:00Z",
    "subtotal": {
      "amount": 21200,
      "currency": "INR"
    },
    "taxAmount": {
      "amount": 3816,
      "currency": "INR"
    },
    "discountAmount": {
      "amount": 500,
      "currency": "INR"
    },
    "roundOff": {
      "amount": 16,
      "currency": "INR"
    },
    "totalAmount": {
      "amount": 24516,
      "currency": "INR"
    },
    "paidAmount": {
      "amount": 24516,
      "currency": "INR"
    },
    "dueAmount": {
      "amount": 0,
      "currency": "INR"
    },
    "paymentMode": "cash",
    "status": "completed",
    "isReturn": false,
    "createdBy": "uuid",
    "createdByName": "Cashier Name",
    "createdAt": "2026-07-24T10:30:00Z",
    "updatedAt": "2026-07-24T10:30:00Z",
    "version": 1,
    "syncStatus": "pending",
    "items": [
      {
        "id": "uuid",
        "productId": "uuid",
        "productName": "Product 1",
        "quantity": 2,
        "unitPrice": {
          "amount": 5000,
          "currency": "INR"
        },
        "discountPercent": 5.0,
        "discountAmount": {
          "amount": 500,
          "currency": "INR"
        },
        "taxAmount": {
          "amount": 1800,
          "currency": "INR"
        },
        "totalAmount": {
          "amount": 11300,
          "currency": "INR"
        },
        "batchNumber": "BATCH001",
        "expiryDate": "2027-12-31T00:00:00Z"
      }
    ],
    "taxBreakdown": {
      "CGST": {
        "amount": 900,
        "currency": "INR"
      },
      "SGST": {
        "amount": 900,
        "currency": "INR"
      }
    },
    "loyaltyPointsEarned": 245
  },
  "message": "Bill created successfully"
}
```

### 4.4 Return Bill

**Endpoint:** `POST /api/bills/{id}/return`

**Headers:**
```
Authorization: Bearer {accessToken}
Content-Type: application/json
```

**Request:**
```json
{
  "items": [
    {
      "productId": "uuid",
      "quantity": 1,
      "reason": "Defective product"
    }
  ],
  "reason": "Customer returned defective item"
}
```

**Response (201 Created):**
```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "billNumber": "RET-001",
    "invoiceNumber": "RET-INV-001",
    "referenceBillId": "uuid",
    "customerId": "uuid",
    "customerName": "Customer Name",
    "billDate": "2026-07-24T10:30:00Z",
    "subtotal": {
      "amount": 5000,
      "currency": "INR"
    },
    "taxAmount": {
      "amount": 900,
      "currency": "INR"
    },
    "totalAmount": {
      "amount": 5900,
      "currency": "INR"
    },
    "paymentMode": "cash",
    "status": "completed",
    "isReturn": true,
    "items": [
      {
        "id": "uuid",
        "productId": "uuid",
        "productName": "Product 1",
        "quantity": 1,
        "unitPrice": {
          "amount": 5000,
          "currency": "INR"
        },
        "taxAmount": {
          "amount": 900,
          "currency": "INR"
        },
        "totalAmount": {
          "amount": 5900,
          "currency": "INR"
        }
      }
    ]
  },
  "message": "Return bill created successfully"
}
```

### 4.5 Get Bill for Print

**Endpoint:** `GET /api/bills/{id}/print`

**Headers:**
```
Authorization: Bearer {accessToken}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "store": {
      "name": "SS MART",
      "address": "Store Address",
      "phone": "9876543210",
      "gstin": "27AAPFU0939F1ZV"
    },
    "bill": {
      "billNumber": "BILL-001",
      "invoiceNumber": "INV-001",
      "billDate": "2026-07-24T10:30:00Z",
      "customer": {
        "name": "Customer Name",
        "phone": "9876543210",
        "gstin": "27AAPFU0939F1ZV"
      },
      "items": [
        {
          "name": "Product 1",
          "quantity": 2,
          "unitPrice": 50.00,
          "discount": 5.00,
          "tax": 18.00,
          "total": 113.00
        }
      ],
      "subtotal": 212.00,
      "tax": 38.16,
      "discount": 5.00,
      "roundOff": 0.16,
      "total": 245.16,
      "paidAmount": 245.16,
      "dueAmount": 0.00,
      "paymentMode": "Cash"
    },
    "qrCode": "base64_encoded_qr_code"
  }
}
```

## 5. Inventory API

### 5.1 Get Stock List

**Endpoint:** `GET /api/inventory`

**Query Parameters:**
- `page` (int, default: 1)
- `perPage` (int, default: 20)
- `locationId` (string, optional)
- `lowStockOnly` (boolean, optional)
- `expiredOnly` (boolean, optional)

**Headers:**
```
Authorization: Bearer {accessToken}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": [
    {
      "productId": "uuid",
      "productName": "Product 1",
      "totalQuantity": 100,
      "reservedQuantity": 10,
      "availableQuantity": 90,
      "reorderLevel": 20,
      "isLowStock": false,
      "isOutOfStock": false,
      "batches": [
        {
          "batchNumber": "BATCH001",
          "quantity": 50,
          "expiryDate": "2027-12-31T00:00:00Z",
          "locationId": "MAIN"
        }
      ]
    }
  ],
  "meta": {
    "pagination": {
      "page": 1,
      "perPage": 20,
      "total": 100,
      "totalPages": 5
    }
  }
}
```

### 5.2 Get Stock by Product ID

**Endpoint:** `GET /api/inventory/{productId}`

**Headers:**
```
Authorization: Bearer {accessToken}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "productId": "uuid",
    "productName": "Product 1",
    "totalQuantity": 100,
    "reservedQuantity": 10,
    "availableQuantity": 90,
    "reorderLevel": 20,
    "isLowStock": false,
    "isOutOfStock": false,
    "batches": [
      {
        "batchNumber": "BATCH001",
        "quantity": 50,
        "expiryDate": "2027-12-31T00:00:00Z",
        "locationId": "MAIN"
      }
    ],
    "movements": [
      {
        "id": "uuid",
        "movementType": "purchase",
        "quantity": 50,
        "referenceType": "purchase",
        "referenceId": "uuid",
        "createdAt": "2026-07-24T10:30:00Z"
      }
    ]
  }
}
```

### 5.3 Adjust Stock

**Endpoint:** `POST /api/inventory/adjust`

**Headers:**
```
Authorization: Bearer {accessToken}
Content-Type: application/json
```

**Request:**
```json
{
  "productId": "uuid",
  "adjustmentType": "add",
  "quantity": 10,
  "reason": "Stock count correction",
  "batchNumber": "BATCH001",
  "notes": "Adjustment after physical count"
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "productId": "uuid",
    "previousQuantity": 90,
    "adjustedQuantity": 100,
    "adjustmentType": "add",
    "movementId": "uuid"
  },
  "message": "Stock adjusted successfully"
}
```

### 5.4 Transfer Stock

**Endpoint:** `POST /api/inventory/transfer`

**Headers:**
```
Authorization: Bearer {accessToken}
Content-Type: application/json
```

**Request:**
```json
{
  "productId": "uuid",
  "quantity": 10,
  "fromLocationId": "MAIN",
  "toLocationId": "WAREHOUSE",
  "batchNumber": "BATCH001",
  "notes": "Transfer to warehouse"
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "transferId": "uuid",
    "productId": "uuid",
    "quantity": 10,
    "fromLocation": "MAIN",
    "toLocation": "WAREHOUSE",
    "status": "completed"
  },
  "message": "Stock transferred successfully"
}
```

### 5.5 Get Low Stock Products

**Endpoint:** `GET /api/inventory/low-stock`

**Headers:**
```
Authorization: Bearer {accessToken}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": [
    {
      "productId": "uuid",
      "productName": "Product 1",
      "currentStock": 5,
      "reorderLevel": 20,
      "shortage": 15
    }
  ]
}
```

## 6. Purchases API

### 6.1 Get Purchases List

**Endpoint:** `GET /api/purchases`

**Query Parameters:**
- `page` (int, default: 1)
- `perPage` (int, default: 20)
- `supplierId` (uuid, optional)
- `startDate` (string, optional)
- `endDate` (string, optional)
- `status` (string: pending, received, cancelled, optional)

**Headers:**
```
Authorization: Bearer {accessToken}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": [
    {
      "id": "uuid",
      "purchaseNumber": "PUR-001",
      "supplierId": "uuid",
      "supplierName": "Supplier Name",
      "purchaseDate": "2026-07-24T10:30:00Z",
      "subtotal": {
        "amount": 500000,
        "currency": "INR"
      },
      "taxAmount": {
        "amount": 90000,
        "currency": "INR"
      },
      "totalAmount": {
        "amount": 590000,
        "currency": "INR"
      },
      "status": "pending",
      "createdAt": "2026-07-24T10:30:00Z",
      "updatedAt": "2026-07-24T10:30:00Z",
      "version": 1,
      "syncStatus": "completed"
    }
  ],
  "meta": {
    "pagination": {
      "page": 1,
      "perPage": 20,
      "total": 50,
      "totalPages": 3
    }
  }
}
```

### 6.2 Create Purchase

**Endpoint:** `POST /api/purchases`

**Headers:**
```
Authorization: Bearer {accessToken}
Content-Type: application/json
```

**Request:**
```json
{
  "supplierId": "uuid",
  "purchaseDate": "2026-07-24T10:30:00Z",
  "items": [
    {
      "productId": "uuid",
      "quantity": 100,
      "unitPrice": {
        "amount": 5000,
        "currency": "INR"
      },
      "taxRate": 18.0,
      "batchNumber": "BATCH001",
      "expiryDate": "2027-12-31T00:00:00Z"
    }
  ],
  "notes": "Monthly stock replenishment"
}
```

**Response (201 Created):**
```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "purchaseNumber": "PUR-001",
    "supplierId": "uuid",
    "supplierName": "Supplier Name",
    "purchaseDate": "2026-07-24T10:30:00Z",
    "subtotal": {
      "amount": 500000,
      "currency": "INR"
    },
    "taxAmount": {
      "amount": 90000,
      "currency": "INR"
    },
    "totalAmount": {
      "amount": 590000,
      "currency": "INR"
    },
    "status": "pending",
    "createdAt": "2026-07-24T10:30:00Z",
    "updatedAt": "2026-07-24T10:30:00Z",
    "version": 1,
    "syncStatus": "pending",
    "items": [
      {
        "id": "uuid",
        "productId": "uuid",
        "productName": "Product 1",
        "quantity": 100,
        "unitPrice": {
          "amount": 5000,
          "currency": "INR"
        },
        "taxRate": 18.0,
        "taxAmount": {
          "amount": 90000,
          "currency": "INR"
        },
        "totalAmount": {
          "amount": 590000,
          "currency": "INR"
        },
        "batchNumber": "BATCH001",
        "expiryDate": "2027-12-31T00:00:00Z"
      }
    ]
  },
  "message": "Purchase created successfully"
}
```

### 6.3 Receive Purchase

**Endpoint:** `POST /api/purchases/{id}/receive`

**Headers:**
```
Authorization: Bearer {accessToken}
Content-Type: application/json
```

**Request:**
```json
{
  "receivedItems": [
    {
      "productId": "uuid",
      "receivedQuantity": 100,
      "batchNumber": "BATCH001"
    }
  ],
  "notes": "Full stock received"
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "purchaseNumber": "PUR-001",
    "status": "received",
    "receivedAt": "2026-07-24T10:30:00Z",
    "stockUpdated": true
  },
  "message": "Purchase received and stock updated"
}
```

## 7. Loyalty API

### 7.1 Get Loyalty Balance

**Endpoint:** `GET /api/loyalty/{customerId}`

**Headers:**
```
Authorization: Bearer {accessToken}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "customerId": "uuid",
    "customerName": "Customer Name",
    "totalPointsEarned": 5000,
    "totalPointsRedeemed": 3500,
    "currentBalance": 1500,
    "pendingPoints": 0,
    "expiringPoints": 200,
    "nextExpiryDate": "2026-08-15T00:00:00Z"
  }
}
```

### 7.2 Earn Points

**Endpoint:** `POST /api/loyalty/earn`

**Headers:**
```
Authorization: Bearer {accessToken}
Content-Type: application/json
```

**Request:**
```json
{
  "customerId": "uuid",
  "points": 250,
  "referenceType": "bill",
  "referenceId": "uuid",
  "notes": "Points earned from bill"
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "transactionId": "uuid",
    "customerId": "uuid",
    "pointsEarned": 250,
    "newBalance": 1750,
    "expiryDate": "2027-07-24T00:00:00Z"
  },
  "message": "Points earned successfully"
}
```

### 7.3 Redeem Points

**Endpoint:** `POST /api/loyalty/redeem`

**Headers:**
```
Authorization: Bearer {accessToken}
Content-Type: application/json
```

**Request:**
```json
{
  "customerId": "uuid",
  "points": 500,
  "referenceType": "bill",
  "referenceId": "uuid",
  "notes": "Points redeemed for discount"
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "transactionId": "uuid",
    "customerId": "uuid",
    "pointsRedeemed": 500,
    "discountAmount": {
      "amount": 5000,
      "currency": "INR"
    },
    "newBalance": 1000
  },
  "message": "Points redeemed successfully"
}
```

### 7.4 Get Loyalty History

**Endpoint:** `GET /api/loyalty/history/{customerId}`

**Query Parameters:**
- `page` (int, default: 1)
- `perPage` (int, default: 20)
- `type` (string: earn, redeem, optional)

**Headers:**
```
Authorization: Bearer {accessToken}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": [
    {
      "id": "uuid",
      "transactionType": "earn",
      "points": 250,
      "referenceType": "bill",
      "referenceId": "uuid",
      "expiryDate": "2027-07-24T00:00:00Z",
      "createdAt": "2026-07-24T10:30:00Z"
    }
  ],
  "meta": {
    "pagination": {
      "page": 1,
      "perPage": 20,
      "total": 50,
      "totalPages": 3
    }
  }
}
```

## 8. Employees API

### 8.1 Get Employees List

**Endpoint:** `GET /api/employees`

**Query Parameters:**
- `page` (int, default: 1)
- `perPage` (int, default: 20)
- `role` (string, optional)
- `isActive` (boolean, optional)

**Headers:**
```
Authorization: Bearer {accessToken}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": [
    {
      "id": "uuid",
      "name": "Employee Name",
      "phone": "9876543210",
      "email": "employee@example.com",
      "role": "cashier",
      "isActive": true,
      "createdAt": "2026-07-24T10:30:00Z",
      "updatedAt": "2026-07-24T10:30:00Z",
      "version": 1,
      "syncStatus": "completed"
    }
  ],
  "meta": {
    "pagination": {
      "page": 1,
      "perPage": 20,
      "total": 10,
      "totalPages": 1
    }
  }
}
```

### 8.2 Create Employee

**Endpoint:** `POST /api/employees`

**Headers:**
```
Authorization: Bearer {accessToken}
Content-Type: application/json
```

**Request:**
```json
{
  "name": "Employee Name",
  "phone": "9876543210",
  "email": "employee@example.com",
  "role": "cashier",
  "pin": "1234"
}
```

**Response (201 Created):**
```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "name": "Employee Name",
    "phone": "9876543210",
    "email": "employee@example.com",
    "role": "cashier",
    "isActive": true,
    "createdAt": "2026-07-24T10:30:00Z",
    "updatedAt": "2026-07-24T10:30:00Z",
    "version": 1,
    "syncStatus": "pending"
  },
  "message": "Employee created successfully"
}
```

### 8.3 Clock In

**Endpoint:** `POST /api/employees/{id}/clock-in`

**Headers:**
```
Authorization: Bearer {accessToken}
Content-Type: application/json
```

**Request:**
```json
{
  "pin": "1234",
  "timestamp": "2026-07-24T10:30:00Z"
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "attendanceId": "uuid",
    "employeeId": "uuid",
    "clockIn": "2026-07-24T10:30:00Z",
    "status": "present"
  },
  "message": "Clocked in successfully"
}
```

### 8.4 Clock Out

**Endpoint:** `POST /api/employees/{id}/clock-out`

**Headers:**
```
Authorization: Bearer {accessToken}
Content-Type: application/json
```

**Request:**
```json
{
  "pin": "1234",
  "timestamp": "2026-07-24T18:30:00Z"
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "attendanceId": "uuid",
    "employeeId": "uuid",
    "clockIn": "2026-07-24T10:30:00Z",
    "clockOut": "2026-07-24T18:30:00Z",
    "workDuration": "8:00:00",
    "status": "present"
  },
  "message": "Clocked out successfully"
}
```

## 9. Reports API

### 9.1 Get Sales Report

**Endpoint:** `GET /api/reports/sales`

**Query Parameters:**
- `startDate` (string, required) - ISO 8601 date
- `endDate` (string, required) - ISO 8601 date
- `groupBy` (string: day, week, month, optional)
- `employeeId` (uuid, optional)

**Headers:**
```
Authorization: Bearer {accessToken}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "summary": {
      "totalSales": {
        "amount": 15000000,
        "currency": "INR"
      },
      "totalBills": 150,
      "averageBillValue": {
        "amount": 100000,
        "currency": "INR"
      },
      "totalItemsSold": 500,
      "totalTax": {
        "amount": 2700000,
        "currency": "INR"
      },
      "totalDiscount": {
        "amount": 500000,
        "currency": "INR"
      }
    },
    "dailyBreakdown": [
      {
        "date": "2026-07-24",
        "sales": {
          "amount": 500000,
          "currency": "INR"
        },
        "bills": 5,
        "items": 20
      }
    ],
    "topProducts": [
      {
        "productId": "uuid",
        "productName": "Product 1",
        "quantitySold": 100,
        "totalSales": {
          "amount": 500000,
          "currency": "INR"
        }
      }
    ]
  }
}
```

### 9.2 Get Inventory Report

**Endpoint:** `GET /api/reports/inventory`

**Query Parameters:**
- `locationId` (string, optional)
- `category` (uuid, optional)

**Headers:**
```
Authorization: Bearer {accessToken}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "summary": {
      "totalProducts": 500,
      "totalStockValue": {
        "amount": 50000000,
        "currency": "INR"
      },
      "lowStockProducts": 10,
      "outOfStockProducts": 2,
      "expiringProducts": 5
    },
    "categoryBreakdown": [
      {
        "categoryId": "uuid",
        "categoryName": "Electronics",
        "productCount": 100,
        "stockValue": {
          "amount": 20000000,
          "currency": "INR"
        }
      }
    ],
    "lowStockAlerts": [
      {
        "productId": "uuid",
        "productName": "Product 1",
        "currentStock": 5,
        "reorderLevel": 20
      }
    ]
  }
}
```

### 9.3 Get Tax Report

**Endpoint:** `GET /api/reports/tax`

**Query Parameters:**
- `startDate` (string, required)
- `endDate` (string, required)
- `taxType` (string: GST, IGST, optional)

**Headers:**
```
Authorization: Bearer {accessToken}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "summary": {
      "totalTaxableSales": {
        "amount": 15000000,
        "currency": "INR"
      },
      "totalTaxCollected": {
        "amount": 2700000,
        "currency": "INR"
      },
      "totalInputTaxCredit": {
        "amount": 1800000,
        "currency": "INR"
      },
      "netTaxPayable": {
        "amount": 900000,
        "currency": "INR"
      }
    },
    "hsnBreakdown": [
      {
        "hsnCode": "8471",
        "description": "Computers",
        "taxableAmount": {
          "amount": 5000000,
          "currency": "INR"
        },
        "taxRate": 18.0,
        "taxAmount": {
          "amount": 900000,
          "currency": "INR"
        }
      }
    ],
    "stateBreakdown": [
      {
        "stateCode": "27",
        "stateName": "Maharashtra",
        "taxableAmount": {
          "amount": 10000000,
          "currency": "INR"
        },
        "cgst": {
          "amount": 900000,
          "currency": "INR"
        },
        "sgst": {
          "amount": 900000,
          "currency": "INR"
        }
      }
    ]
  }
}
```

## 10. Sync API

### 10.1 Upload Sync Data

**Endpoint:** `POST /api/sync/upload`

**Headers:**
```
Authorization: Bearer {accessToken}
Content-Type: application/json
```

**Request:**
```json
{
  "items": [
    {
      "entityType": "bill",
      "entityId": "uuid",
      "operation": "create",
      "payload": "{\"billNumber\":\"BILL-001\",...}",
      "clientTimestamp": "2026-07-24T10:30:00Z"
    }
  ]
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "processed": 1,
    "failed": 0,
    "conflicts": 0,
    "results": [
      {
        "entityType": "bill",
        "entityId": "uuid",
        "status": "completed",
        "serverTimestamp": "2026-07-24T10:30:05Z"
      }
    ]
  },
  "message": "Sync upload completed"
}
```

### 10.2 Download Sync Data

**Endpoint:** `POST /api/sync/download`

**Headers:**
```
Authorization: Bearer {accessToken}
Content-Type: application/json
```

**Request:**
```json
{
  "lastSyncTimestamp": "2026-07-24T10:00:00Z",
  "entityTypes": ["product", "customer", "bill"],
  "limit": 100
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "items": [
      {
        "entityType": "product",
        "entityId": "uuid",
        "operation": "update",
        "payload": "{\"name\":\"Updated Product\",...}",
        "serverTimestamp": "2026-07-24T10:30:00Z",
        "version": 2
      }
    ],
    "serverTimestamp": "2026-07-24T10:30:00Z",
    "totalItems": 1
  }
}
```

### 10.3 Get Sync Status

**Endpoint:** `GET /api/sync/status`

**Headers:**
```
Authorization: Bearer {accessToken}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "lastSyncAt": "2026-07-24T10:30:00Z",
    "pendingItems": 5,
    "failedItems": 0,
    "syncQueue": [
      {
        "id": "uuid",
        "entityType": "bill",
        "entityId": "uuid",
        "status": "pending",
        "retryCount": 0,
        "createdAt": "2026-07-24T10:30:00Z"
      }
    ]
  }
}
```

### 10.4 Resolve Conflict

**Endpoint:** `POST /api/sync/resolve-conflict`

**Headers:**
```
Authorization: Bearer {accessToken}
Content-Type: application/json
```

**Request:**
```json
{
  "conflictId": "uuid",
  "resolution": "client",
  "clientPayload": "{\"name\":\"Client Version\",...}",
  "serverPayload": "{\"name\":\"Server Version\",...}"
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "conflictId": "uuid",
    "resolution": "client",
    "resolvedAt": "2026-07-24T10:30:00Z"
  },
  "message": "Conflict resolved successfully"
}
```

## 11. Import API

### 11.1 Import Products

**Endpoint:** `POST /api/import/products`

**Headers:**
```
Authorization: Bearer {accessToken}
Content-Type: application/json
```

**Request:**
```json
{
  "fileUrl": "https://storage.example.com/imports/products.xlsx",
  "mappingTemplate": "default",
  "updateExisting": false,
  "skipDuplicates": true
}
```

**Response (202 Accepted):**
```json
{
  "success": true,
  "data": {
    "importId": "uuid",
    "status": "validating",
    "totalRows": 100,
    "estimatedTime": "2 minutes"
  },
  "message": "Import started"
}
```

### 11.2 Get Import Status

**Endpoint:** `GET /api/import/{importId}/status`

**Headers:**
```
Authorization: Bearer {accessToken}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "importId": "uuid",
    "status": "completed",
    "totalRows": 100,
    "processedRows": 95,
    "failedRows": 5,
    "errors": [
      {
        "row": 10,
        "column": "barcode",
        "error": "Invalid barcode format"
      }
    ],
    "createdAt": "2026-07-24T10:30:00Z",
    "completedAt": "2026-07-24T10:32:00Z"
  }
}
```

## 12. Export API

### 12.1 Export Data

**Endpoint:** `GET /api/export/{type}`

**Path Parameters:**
- `type` (string: products, customers, bills, inventory)

**Query Parameters:**
- `format` (string: excel, csv, pdf)
- `startDate` (string, optional)
- `endDate` (string, optional)

**Headers:**
```
Authorization: Bearer {accessToken}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "downloadUrl": "https://storage.example.com/exports/products.xlsx",
    "expiresAt": "2026-07-24T11:30:00Z",
    "fileSize": "1.5 MB",
    "recordCount": 500
  }
}
```

This comprehensive API contract specification provides all the endpoints needed for the SS MART retail ERP system, with detailed request/response formats for each operation.
