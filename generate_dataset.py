import pandas as pd
import random
from datetime import datetime, timedelta

# -----------------------------
# Load master data
# -----------------------------
products = pd.read_csv("dataset/products.csv")
stores = pd.read_csv("dataset/stores.csv")

# -----------------------------
# Date range
# -----------------------------
start_date = datetime(2026, 6, 1)
end_date = datetime(2026, 6, 30)

dates = []
current_date = start_date

while current_date <= end_date:
    dates.append(current_date)
    current_date += timedelta(days=1)

# -----------------------------
# Category behavior
# -----------------------------
fast_moving_categories = ["Dairy", "Bakery", "Snacks", "Beverages", "Packaged Food"]
slow_moving_categories = ["Personal Care", "Household", "Grocery"]

inventory_rows = []
order_rows = []
restock_rows = []

order_id = 1
restock_id = 1

# -----------------------------
# Generate data
# -----------------------------
for _, store in stores.iterrows():
    store_id = store["store_id"]

    for _, product in products.iterrows():
        product_id = product["product_id"]
        category = product["category"]
        unit_price = product["unit_price"]

        # Initial stock based on category
        if category in fast_moving_categories:
            stock_qty = random.randint(20, 50)
            reorder_level = random.randint(8, 15)
        else:
            stock_qty = random.randint(30, 70)
            reorder_level = random.randint(5, 12)

        for date in dates:
            # Generate sales
            if category in fast_moving_categories:
                quantity_sold = random.randint(0, 8)
            else:
                quantity_sold = random.randint(0, 3)

            # Make some products dead inventory
            if product_id in ["P015", "P019"]:
                quantity_sold = random.choice([0, 0, 0, 1])

            # Sales cannot be more than available stock
            quantity_sold = min(quantity_sold, stock_qty)

            if quantity_sold > 0:
                order_rows.append([
                    f"O{order_id:05d}",
                    date.strftime("%Y-%m-%d"),
                    store_id,
                    product_id,
                    quantity_sold,
                    unit_price
                ])
                order_id += 1

            # Reduce stock after sale
            stock_qty -= quantity_sold

            # Create inventory snapshot after sales
            inventory_rows.append([
                date.strftime("%Y-%m-%d"),
                store_id,
                product_id,
                stock_qty,
                reorder_level
            ])

            # Restock if stock falls below reorder level
            if stock_qty <= reorder_level:
                restock_qty = random.randint(20, 60)

                restock_rows.append([
                    f"R{restock_id:05d}",
                    date.strftime("%Y-%m-%d"),
                    store_id,
                    product_id,
                    restock_qty
                ])

                restock_id += 1
                stock_qty += restock_qty

# -----------------------------
# Create DataFrames
# -----------------------------
inventory_df = pd.DataFrame(
    inventory_rows,
    columns=["snapshot_date", "store_id", "product_id", "stock_qty", "reorder_level"]
)

orders_df = pd.DataFrame(
    order_rows,
    columns=["order_id", "order_date", "store_id", "product_id", "quantity_sold", "selling_price"]
)

restocks_df = pd.DataFrame(
    restock_rows,
    columns=["restock_id", "restock_date", "store_id", "product_id", "restock_qty"]
)

# -----------------------------
# Save CSV files
# -----------------------------
inventory_df.to_csv("dataset/inventory_snapshots.csv", index=False)
orders_df.to_csv("dataset/orders.csv", index=False)
restocks_df.to_csv("dataset/restocks.csv", index=False)

print("Dataset generated successfully!")
print("inventory_snapshots.csv rows:", len(inventory_df))
print("orders.csv rows:", len(orders_df))
print("restocks.csv rows:", len(restocks_df))