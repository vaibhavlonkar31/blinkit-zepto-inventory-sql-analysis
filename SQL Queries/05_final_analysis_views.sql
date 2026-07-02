-- View 1: Product-wise sales summary

CREATE OR REPLACE VIEW view_product_sales_summary AS
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.brand,
    SUM(o.quantity_sold) AS total_quantity_sold,
    SUM(o.quantity_sold * o.selling_price) AS total_revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY 
    p.product_id,
    p.product_name,
    p.category,
    p.brand;


-- View 2: Product-wise inventory summary

CREATE OR REPLACE VIEW view_inventory_summary AS
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    ROUND(AVG(i.stock_qty), 2) AS avg_stock_qty,
    COUNT(*) FILTER (WHERE i.stock_qty = 0) AS stockout_days,
    COUNT(*) FILTER (WHERE i.stock_qty <= i.reorder_level) AS reorder_needed_days
FROM inventory_snapshots i
JOIN products p
    ON i.product_id = p.product_id
GROUP BY 
    p.product_id,
    p.product_name,
    p.category;

-- View 3: Product-wise restock summary

CREATE OR REPLACE VIEW view_restock_summary AS
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
    p.category;


-- View 4: Final product classification

CREATE OR REPLACE VIEW view_product_status AS
SELECT 
    ps.product_id,
    ps.product_name,
    ps.category,
    ps.brand,
    COALESCE(ps.total_quantity_sold, 0) AS total_quantity_sold,
    COALESCE(ps.total_revenue, 0) AS total_revenue,
    COALESCE(inv.avg_stock_qty, 0) AS avg_stock_qty,
    COALESCE(inv.stockout_days, 0) AS stockout_days,
    COALESCE(inv.reorder_needed_days, 0) AS reorder_needed_days,
    COALESCE(rs.total_restock_count, 0) AS total_restock_count,
    CASE
        WHEN COALESCE(ps.total_quantity_sold, 0) >= 500 THEN 'Fast Moving'
        WHEN COALESCE(ps.total_quantity_sold, 0) BETWEEN 200 AND 499 THEN 'Medium Moving'
        WHEN COALESCE(ps.total_quantity_sold, 0) < 200 
             AND COALESCE(inv.avg_stock_qty, 0) > 20 THEN 'Dead Inventory'
        ELSE 'Slow Moving'
    END AS product_status
FROM view_product_sales_summary ps
LEFT JOIN view_inventory_summary inv
    ON ps.product_id = inv.product_id
LEFT JOIN view_restock_summary rs
    ON ps.product_id = rs.product_id;

-- View 5: Category-wise stock-out summary

CREATE OR REPLACE VIEW view_category_stockout_summary AS
SELECT 
    p.category,
    COUNT(*) AS stockout_count
FROM inventory_snapshots i
JOIN products p
    ON i.product_id = p.product_id
WHERE i.stock_qty = 0
GROUP BY p.category
ORDER BY stockout_count DESC;

-- View 6: Store-wise stock-out summary

CREATE OR REPLACE VIEW view_store_stockout_summary AS
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



SELECT * 
FROM view_product_sales_summary
ORDER BY total_quantity_sold DESC;

SELECT * 
FROM view_inventory_summary
ORDER BY stockout_days DESC;

SELECT * 
FROM view_product_status
ORDER BY total_quantity_sold DESC;

SELECT * 
FROM view_category_stockout_summary;

SELECT * 
FROM view_store_stockout_summary;