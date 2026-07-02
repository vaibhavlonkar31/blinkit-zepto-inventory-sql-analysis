# Blinkit / Zepto Style Inventory Analysis using SQL

## Problem Statement

Quick-commerce platforms such as Blinkit and Zepto operate with fast delivery expectations, limited dark-store inventory space, and high customer demand for frequently purchased products. In such businesses, poor inventory planning can lead to stock-outs, missed sales, overstocking, dead inventory, and reduced customer satisfaction.This project analyzes a synthetic quick-commerce inventory dataset to identify frequently out-of-stock products, fast-moving products, slow-moving products, dead inventory, and products that require timely restocking.The main goal of this project is to use SQL to generate business insights that can help an inventory or operations team improve stock availability, reduce dead inventory, and make better restocking decisions.

## Business Questions

1. Which products go out of stock most frequently?
2. Which products are fast-moving based on sales quantity?
3. Which products have high stock but low or zero sales?
4. Which categories face the highest stock-out issues?
5. Which products need immediate restocking?
6. Which stores or locations have more inventory problems?
7. Which products should be prioritized for better inventory planning?

## Tools and Technologies Used

* SQL Database: PostgreSQL / MySQL
* SQL Concepts: Joins, GROUP BY, HAVING, CASE WHEN, Subqueries, Aggregate Functions
* Dataset Format: CSV / Excel
* Analysis Tool: SQL
* Dashboard Tool: Power BI / Excel
* Documentation: GitHub README
* Optional: Python for synthetic dataset generation

## 4. Dataset Description

This project uses a synthetic quick-commerce inventory dataset. The dataset is designed to represent inventory and sales activity for products sold through fast-delivery platforms.

The dataset includes product details, store locations, daily inventory snapshots, customer orders, and restocking records.

The main tables used in this project are:

* products
* stores
* inventory_snapshots
* orders
* restocks

These tables help answer business questions related to stock-outs, fast-moving products, dead inventory, reorder planning, and category-level inventory performance.

## 5. Database Schema
The database schema is designed to connect product details, store locations, inventory records, order transactions, and restocking activity.

The project uses five main tables:

### products

The `products` table stores product-level information such as product name, category, brand, and unit price.

Primary key:

* `product_id`

### stores

The `stores` table stores store or dark-store location details such as city and area.

Primary key:

* `store_id`

### inventory_snapshots

The `inventory_snapshots` table stores daily stock availability for each product in each store.

This table helps identify stock-outs, stock-risk situations, and reorder requirements.

Foreign keys:

* `product_id` references `products(product_id)`
* `store_id` references `stores(store_id)`

### orders

The `orders` table stores product sales transactions, including order date, product sold, store location, quantity sold, and selling price.

Foreign keys:

* `product_id` references `products(product_id)`
* `store_id` references `stores(store_id)`

### restocks

The `restocks` table stores restocking activity, including restock date, product restocked, store location, and restock quantity.

Foreign keys:

* `product_id` references `products(product_id)`
* `store_id` references `stores(store_id)`

### Table Relationships

* One product can appear in many orders.
* One product can appear in many inventory snapshots.
* One product can be restocked multiple times.
* One store can process many orders.
* One store can have many inventory snapshot records.
* One store can receive multiple restocks.

This relational structure helps analyze product movement, stock availability, stock-risk patterns, and restocking performance.


## 6. SQL Analysis

The SQL analysis was divided into multiple stages to answer the main business questions of the project.

### Data Validation

Initial SQL queries were used to check whether all CSV files were imported correctly into PostgreSQL.

Validation checks included:

* Total number of products
* Total number of stores
* Total inventory records
* Total orders
* Total restock records

### Basic Sales Analysis

Basic SQL queries were used to calculate overall sales performance.

This included:

* Total quantity sold
* Total revenue
* Product-wise sales
* Category-wise sales
* Store-wise sales

### Inventory Analysis

Inventory queries were used to analyze product stock levels and stock-risk situations.

This included:

* Average stock quantity by product
* Products below reorder level
* Products with stock-risk records
* Products with repeated stock availability issues

### Fast-Moving Product Analysis

Fast-moving products were identified based on total quantity sold.

Products with high sales quantity were classified as high-demand products that require regular monitoring and faster replenishment.

### Dead Inventory Analysis

Dead inventory products were identified using stock and sales behavior.

Products with available stock but low sales movement were classified as dead inventory because they block storage space and reduce inventory efficiency.

### Category-Wise Stock-Risk Analysis

Category-level analysis was performed to identify which product categories had the highest stock-risk records.

This helps improve category-wise demand planning and reorder strategy.

### Store-Wise Stock-Risk Analysis

Store-level analysis was performed to identify which store locations faced more stock-risk issues.

This helps understand location-specific demand and restocking problems.

### Product Classification Using CASE WHEN

Products were classified into different movement categories using SQL `CASE WHEN` logic:

* Fast Moving
* Medium Moving
* Slow Moving
* Dead Inventory

### SQL Views

Final SQL views were created to store reusable business analysis outputs.

The main views created were:

* `view_product_sales_summary`
* `view_inventory_summary`
* `view_restock_summary`
* `view_product_status`
* `view_category_stockout_summary`
* `view_store_stockout_summary`

These views were later exported as CSV files and used in Power BI for dashboard creation.
* SELECT statements for data extraction
* JOINs to combine product, store, order, inventory, and restock tables
* GROUP BY for product-wise, category-wise, and store-wise aggregation
* HAVING for filtering grouped results
* CASE WHEN for product classification
* Subqueries for above-average sales analysis
* Aggregate functions such as SUM, COUNT, AVG, MIN, and MAX
* SQL views for reusable business analysis outputs

## 7. Key Insights
* Fast-moving products need higher reorder levels and regular monitoring.
* Frequently out-of-stock products can cause missed sales and poor customer experience.
* Dead inventory products block storage space and reduce inventory efficiency.
* Category-wise stock-out analysis helps improve demand planning.
* Store-wise stock-out analysis helps identify location-specific inventory issues.

## 8. Business Recommendations
* Increase safety stock for high-demand products.
* Reduce purchase quantity for low-selling products.
* Use separate reorder levels for each category.
* Monitor store-wise stock-out patterns regularly.
* Prioritize replenishment for products with repeated stock-out history.

## 9. Dashboard Preview

### Inventory Dashboard

![Inventory Dashboard](screenshots/inventory_dashboard_page_1.png)

### Insights & Recommendations

![Insights and Recommendations](screenshots/insights_recommendations_page_2.png)

## 10. Conclusion
This project demonstrates how SQL can be used to solve real-world inventory and stock-risk problems in a quick-commerce business model.

By analyzing sales, inventory snapshots, restocking activity, and product movement, the project identifies fast-moving products, dead inventory, reorder-needed products, category-wise stock issues, and store-level inventory risks.

The final Power BI dashboard helps convert SQL analysis into business-friendly insights that can support better inventory planning, improved stock availability, and reduced missed sales.
:::

---

# 11: Final README Checklist

Check that your README has:

```text id="fp3x6i"
✅ Project title
✅ Problem statement
✅ Business questions
✅ Tools used
✅ Dataset description
✅ SQL concepts used
✅ Dashboard screenshots
✅ Key insights
✅ Business recommendations
✅ Folder structure
✅ Conclusion