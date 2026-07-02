-- Create products table
CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    brand VARCHAR(50),
    unit_price NUMERIC(10,2)
);

-- Create stores table
CREATE TABLE stores (
    store_id VARCHAR(10) PRIMARY KEY,
    city VARCHAR(50),
    area VARCHAR(50)
);

-- Create inventory_snapshots table
CREATE TABLE inventory_snapshots (
    snapshot_date DATE,
    store_id VARCHAR(10),
    product_id VARCHAR(10),
    stock_qty INT,
    reorder_level INT,
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Create orders table
CREATE TABLE orders (
    order_id VARCHAR(20) PRIMARY KEY,
    order_date DATE,
    store_id VARCHAR(10),
    product_id VARCHAR(10),
    quantity_sold INT,
    selling_price NUMERIC(10,2),
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Create restocks table
CREATE TABLE restocks (
    restock_id VARCHAR(20) PRIMARY KEY,
    restock_date DATE,
    store_id VARCHAR(10),
    product_id VARCHAR(10),
    restock_qty INT,
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);