-- Products that go out of stock most frequently

SELECT 
    p.product_id,
    p.product_name,
    p.category,
    COUNT(*) AS stockout_days
FROM inventory_snapshots i
JOIN products p
    ON i.product_id = p.product_id
WHERE i.stock_qty = 0
GROUP BY 
    p.product_id,
    p.product_name,
    p.category
ORDER BY stockout_days DESC;

-- Fast-moving products based on total quantity sold

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
ORDER BY total_quantity_sold DESC
LIMIT 10;


-- Dead inventory: products with stock but very low sales

SELECT 
    p.product_id,
    p.product_name,
    p.category,
    ROUND(AVG(i.stock_qty), 2) AS avg_stock_qty,
    COALESCE(SUM(o.quantity_sold), 0) AS total_quantity_sold
FROM products p
LEFT JOIN inventory_snapshots i
    ON p.product_id = i.product_id
LEFT JOIN orders o
    ON p.product_id = o.product_id
GROUP BY 
    p.product_id,
    p.product_name,
    p.category
HAVING 
    ROUND(AVG(i.stock_qty), 2) > 20
    AND COALESCE(SUM(o.quantity_sold), 0) < 100
ORDER BY avg_stock_qty DESC;


-- Products that need immediate reorder

SELECT 
    i.snapshot_date,
    s.city,
    s.area,
    p.product_id,
    p.product_name,
    p.category,
    i.stock_qty,
    i.reorder_level,
    CASE
        WHEN i.stock_qty = 0 THEN 'Out of Stock'
        WHEN i.stock_qty <= i.reorder_level THEN 'Reorder Needed'
        ELSE 'Stock Available'
    END AS stock_status
FROM inventory_snapshots i
JOIN products p
    ON i.product_id = p.product_id
JOIN stores s
    ON i.store_id = s.store_id
WHERE i.stock_qty <= i.reorder_level
ORDER BY 
    i.snapshot_date DESC,
    i.stock_qty ASC;

-- Category-wise stock-out analysis

SELECT 
    p.category,
    COUNT(*) AS stockout_count
FROM inventory_snapshots i
JOIN products p
    ON i.product_id = p.product_id
WHERE i.stock_qty = 0
GROUP BY p.category
ORDER BY stockout_count DESC;

-- Store-wise stock-out analysis

SELECT 
    s.store_id,
    s.city,
    s.area,
    COUNT(*) AS stockout_count
FROM inventory_snapshots i
JOIN stores s
    ON i.store_id = s.store_id
WHERE i.stock_qty = 0
GROUP BY 
    s.store_id,
    s.city,
    s.area
ORDER BY stockout_count DESC;


-- Product classification using CASE WHEN

SELECT 
    p.product_id,
    p.product_name,
    p.category,
    COALESCE(SUM(o.quantity_sold), 0) AS total_quantity_sold,
    ROUND(AVG(i.stock_qty), 2) AS avg_stock_qty,
    CASE
        WHEN COALESCE(SUM(o.quantity_sold), 0) >= 500 THEN 'Fast Moving'
        WHEN COALESCE(SUM(o.quantity_sold), 0) BETWEEN 200 AND 499 THEN 'Medium Moving'
        WHEN COALESCE(SUM(o.quantity_sold), 0) < 200 
             AND ROUND(AVG(i.stock_qty), 2) > 20 THEN 'Dead Inventory'
        ELSE 'Slow Moving'
    END AS product_status
FROM products p
LEFT JOIN orders o
    ON p.product_id = o.product_id
LEFT JOIN inventory_snapshots i
    ON p.product_id = i.product_id
GROUP BY 
    p.product_id,
    p.product_name,
    p.category
ORDER BY total_quantity_sold DESC;

-- Products selling above average quantity

SELECT 
    p.product_id,
    p.product_name,
    p.category,
    SUM(o.quantity_sold) AS total_quantity_sold
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY 
    p.product_id,
    p.product_name,
    p.category
HAVING SUM(o.quantity_sold) > (
    SELECT AVG(product_total)
    FROM (
        SELECT 
            product_id,
            SUM(quantity_sold) AS product_total
        FROM orders
        GROUP BY product_id
    ) AS product_sales
)
ORDER BY total_quantity_sold DESC;