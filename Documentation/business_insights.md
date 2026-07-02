# Business Insights

## Project Name

Blinkit / Zepto Style Inventory Analysis using SQL

---

## 1. Fast-Moving Products

Fast-moving products were identified based on total quantity sold.

These products have high sales demand and should be prioritized for regular stock monitoring and faster replenishment.

Top Fast-Moving Products:
1. Lays Classic Salted Chips - 646 Units sold
2. AmulMilk 1L - 645 Units sold
3. Maggie Noodles 70g - 634 Units sold

### Observation

The top-selling products are mainly from frequently purchased categories such as Dairy, Bakery, Snacks, Beverages, and Packaged Food.

### Business Meaning

Fast-moving products generate consistent sales, but they also have a higher risk of stock-outs if inventory is not replenished on time.

### Recommendation

Maintain higher reorder levels for fast-moving products and monitor their stock daily.

---

## 2. Frequently Out-of-Stock Products

Products with the highest number of stock-out days were identified using daily inventory snapshots.


### Observation

Some products repeatedly reached zero stock during the analysis period.

### Business Meaning

Frequent stock-outs can lead to missed sales, poor customer experience, and loss of repeat customers.

### Recommendation

Increase safety stock and improve restocking frequency for products that repeatedly go out of stock.

---

## 3. Dead Inventory Products

Dead inventory products were identified as products with available stock but low sales quantity.

### Observation

Some products had higher average stock levels but very low sales movement.

### Business Meaning

Dead inventory blocks storage space and working capital. In quick-commerce businesses, this is risky because dark-store space is limited.

### Recommendation

Reduce future purchase quantity for dead inventory products, run discounts, or replace them with better-performing products.

---

## 4. Category-Wise Stock-Out Analysis

Category-level stock-out analysis helps identify which product categories face the most availability issues.

### Observation

Fast-consumption categories usually show higher stock-out counts because customer demand is frequent.

### Business Meaning

Categories with high stock-outs need better demand forecasting and inventory planning.

### Recommendation

Create category-wise reorder rules instead of using the same reorder level for all products.

---

## 5. Store-Wise Stock-Out Analysis

Store-wise stock-out analysis helps identify locations where inventory planning is weak.

### Observation

Some store locations may show higher stock-out counts compared to others.

### Business Meaning

High stock-outs in a store may indicate poor demand forecasting, delayed restocking, or higher local demand.

### Recommendation

Use store-level sales trends to plan inventory separately for each location.

---

## Final Conclusion

This project shows how SQL can be used to solve real-world inventory problems in a quick-commerce business model.

Using SQL queries, joins, aggregate functions, CASE WHEN, HAVING, subqueries, and views, the project identifies fast-moving products, dead inventory, stock-out patterns, reorder requirements, and category/store-level inventory issues.

The insights generated from this analysis can help businesses improve stock availability, reduce missed sales, optimize inventory space, and make better restocking decisions.
