import pandas as pd
import random
from faker import Faker
from datetime import datetime, timedelta
import uuid
import os

fake = Faker()

# ------------------------
# Master Data
# ------------------------

stores = ["Pune", "Delhi", "Noida", "Mumbai"]

products = [
    ("iPhone 16", "iPhone", 80000),
    ("iPhone 16 Pro", "iPhone", 120000),
    ("iPhone 16 Pro Max", "iPhone", 150000),
    ("iPhone 15", "iPhone", 70000),
    ("iPad Air", "iPad", 60000),
    ("iPad Pro", "iPad", 110000),
    ("MacBook Air M4", "Mac", 125000),
    ("MacBook Pro M4", "Mac", 220000),
    ("Apple Watch Series 10", "Watch", 50000),
    ("Apple Watch Ultra", "Watch", 90000),
    ("AirPods 4", "Audio", 15000),
    ("AirPods Pro", "Audio", 25000),
    ("Apple Pencil Pro", "Accessory", 12000),
    ("Apple TV", "Accessory", 18000),
    ("HomePod", "Accessory", 30000)
]

payment_modes = [
    "UPI",
    "Credit Card",
    "Debit Card",
    "Cash",
    "Apple Pay",
    "Net Banking"
]

customer_types = [
    "New",
    "Existing",
    "Corporate"
]

# ------------------------
# Generate Data
# ------------------------

start_date = datetime(2026, 7, 1)
end_date = datetime(2026, 7, 31)

rows = []

current_date = start_date

while current_date <= end_date:

    for store in stores:

        transactions = random.randint(80, 120)

        for _ in range(transactions):

            product = random.choice(products)

            qty = random.randint(1, 10)

            price = product[2]

            discount = random.randint(0, 15)

            gross_amount = qty * price

            discount_amount = gross_amount * discount / 100

            net_amount = gross_amount - discount_amount

            tax = round(net_amount * 0.18, 2)

            final_amount = round(net_amount + tax, 2)

            rows.append({

                "transaction_id": str(uuid.uuid4()),

                "sale_date": current_date.date(),

                "sale_time": fake.time(),

                "store_name": store,

                "product_name": product[0],

                "category": product[1],

                "quantity": qty,

                "unit_price": price,

                "discount_percent": discount,

                "tax": tax,

                "amount": final_amount,

                "payment_mode": random.choice(payment_modes),

                "customer_type": random.choice(customer_types),

                "employee_id": random.randint(1001,1100),

                "created_at": fake.date_time_between(
                    start_date=current_date,
                    end_date=current_date + timedelta(days=1)
                )
            })

    current_date += timedelta(days=1)

df = pd.DataFrame(rows)

# ----------------------------------
# Add Few Bad Records for dbt Tests
# ----------------------------------

# Duplicate rows
df = pd.concat([df, df.iloc[:3]], ignore_index=True)

# Negative Amount
df.loc[5, "amount"] = -5000

# Null Product
df.loc[10, "product_name"] = None

# Store Name Issue
df.loc[20, "store_name"] = "PUNE"

# ----------------------------------

os.makedirs("../data", exist_ok=True)

df.to_csv("../data/apple_sales.csv", index=False)

print("===================================")
print("Apple Sales Data Generated")
print(df.shape)
print("Saved -> data/apple_sales.csv")
print("===================================")