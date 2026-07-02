-- Check total records in each table in one output

SELECT 'products' AS table_name, COUNT(*) AS total_records FROM products
UNION ALL
SELECT 'stores' AS table_name, COUNT(*) AS total_records FROM stores
UNION ALL
SELECT 'inventory_snapshots' AS table_name, COUNT(*) AS total_records FROM inventory_snapshots
UNION ALL
SELECT 'orders' AS table_name, COUNT(*) AS total_records FROM orders
UNION ALL
SELECT 'restocks' AS table_name, COUNT(*) AS total_records FROM restocks;