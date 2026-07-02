# Dataset Schema

This project uses a synthetic quick-commerce inventory dataset inspired by Blinkit and Zepto-style operations.

The dataset is designed to analyze product sales, stock levels, stock-outs, restocking patterns, and dead inventory.

## Tables Used

The project contains five main tables:

1. products
2. stores
3. inventory_snapshots
4. orders
5. restocks

---

## 1. products Table

This table stores product-level information.

| Column Name  | Description                                       |
| ------------ | ------------------------------------------------- |
| product_id   | Unique ID of each product                         |
| product_name | Name of the product                               |
| category     | Product category such as Dairy, Snacks, Beverages |
| brand        | Product brand                                     |
| unit_price   | Selling price per unit                            |

---

## 2. stores Table

This table stores dark store or location details.

| Column Name | Description                     |
| ----------- | ------------------------------- |
| store_id    | Unique ID of each store         |
| city        | City where the store is located |
| area        | Local area of the store         |

---

## 3. inventory_snapshots Table

This table stores daily stock availability of each product in each store.

| Column Name   | Description                                  |
| ------------- | -------------------------------------------- |
| snapshot_date | Date of inventory record                     |
| store_id      | Store ID                                     |
| product_id    | Product ID                                   |
| stock_qty     | Available stock quantity on that date        |
| reorder_level | Minimum stock level before reorder is needed |

---

## 4. orders Table

This table stores product sales transactions.

| Column Name   | Description                            |
| ------------- | -------------------------------------- |
| order_id      | Unique order ID                        |
| order_date    | Date of order                          |
| store_id      | Store ID where the order was fulfilled |
| product_id    | Product ID sold                        |
| quantity_sold | Number of units sold                   |
| selling_price | Selling price per unit                 |

---

## 5. restocks Table

This table stores restocking activity.

| Column Name  | Description                 |
| ------------ | --------------------------- |
| restock_id   | Unique restock ID           |
| restock_date | Date of restock             |
| store_id     | Store ID                    |
| product_id   | Product ID restocked        |
| restock_qty  | Quantity added to inventory |

---

## Relationship Between Tables

* products.product_id connects with orders.product_id
* products.product_id connects with inventory_snapshots.product_id
* products.product_id connects with restocks.product_id
* stores.store_id connects with orders.store_id
* stores.store_id connects with inventory_snapshots.store_id
* stores.store_id connects with restocks.store_id
