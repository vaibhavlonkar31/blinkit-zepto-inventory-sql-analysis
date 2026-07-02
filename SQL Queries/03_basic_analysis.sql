-- View products data
SELECT * 
FROM products
LIMIT 10;

-- View stores data
SELECT * 
FROM stores;

-- View inventory data
SELECT * 
FROM inventory_snapshots
LIMIT 10;

-- View orders data
SELECT * 
FROM orders
LIMIT 10;

-- View restocks data
SELECT * 
FROM restocks
LIMIT 10;

-- Total Sales Quantity

SELECT 
    SUM(quantity_sold) AS total_quantity_sold
FROM orders;

-- Total Revenue
SELECT 
    SUM(quantity_sold * selling_price) AS total_revenue
FROM orders;

-- Product-Wise Sales
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    SUM(o.quantity_sold) AS total_quantity_sold,
    SUM(o.quantity_sold * o.selling_price) AS total_revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY 
    p.product_id,
    p.product_name,
    p.category
ORDER BY total_quantity_sold DESC;

-- Category-Wise Sales

SELECT 
    p.category,
    SUM(o.quantity_sold) AS total_quantity_sold,
    SUM(o.quantity_sold * o.selling_price) AS total_revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_quantity_sold DESC;

-- Store-Wise Sales
SELECT 
    s.store_id,
    s.city,
    s.area,
    SUM(o.quantity_sold) AS total_quantity_sold,
    SUM(o.quantity_sold * o.selling_price) AS total_revenue
FROM orders o
JOIN stores s
    ON o.store_id = s.store_id
GROUP BY 
    s.store_id,
    s.city,
    s.area
ORDER BY total_revenue DESC;

-- Average Stock by Product
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    ROUND(AVG(i.stock_qty), 2) AS avg_stock_qty
FROM inventory_snapshots i
JOIN products p
    ON i.product_id = p.product_id
GROUP BY 
    p.product_id,
    p.product_name,
    p.category
ORDER BY avg_stock_qty DESC;

-- Restock Count by Product

SELECT 
    p.product_id,
    p.product_name,
    p.category,
    COUNT(r.restock_id) AS total_restock_count,
    SUM(r.restock_qty) AS total_restock_quantity
FROM restocks r
JOIN products p
    ON r.product_id = p.product_id
GROUP BY 
    p.product_id,
    p.product_name,
    p.category
ORDER BY total_restock_count DESC;