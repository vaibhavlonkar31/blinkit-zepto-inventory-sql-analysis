-- Dashboard Dataset 1: Product Status Summary

SELECT *
FROM view_product_status
ORDER BY total_quantity_sold DESC;


-- Dashboard Dataset 2: Category Stock-Out Summary

SELECT *
FROM view_category_stockout_summary;


-- Dashboard Dataset 3: Store Stock-Out Summary

SELECT *
FROM view_store_stockout_summary;


-- Dashboard Dataset 4: Fast-Moving Products

SELECT *
FROM view_product_status
WHERE product_status = 'Fast Moving'
ORDER BY total_quantity_sold DESC;


-- Dashboard Dataset 5: Dead Inventory Products

SELECT *
FROM view_product_status
WHERE product_status = 'Dead Inventory'
ORDER BY avg_stock_qty DESC;


-- Dashboard Dataset 6: Reorder Needed Products

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