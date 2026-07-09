# 🍎 Apple Sales Data Engineering POC

An End-to-End Data Engineering Proof of Concept (POC) built using **Python, DuckDB, PostgreSQL, and dbt** following the **Medallion Architecture (Bronze → Silver → Gold)**.

The project simulates Apple retail sales across multiple stores and demonstrates modern data engineering concepts such as data generation, ingestion, transformation, testing, dimensional modeling, and reporting.

---

# 📌 Project Architecture

```
Python + Faker
        │
        ▼
Generated CSV
        │
        ▼
DuckDB
        │
        ▼
PostgreSQL
        │
        ▼
Bronze Layer (Raw Data)
        │
        ▼
dbt Transformations
        │
        ▼
Silver Layer (Clean Data)
        │
        ▼
Gold Layer (Business Models)
        │
        ▼
Business Reports / KPIs
```

---

# 🚀 Tech Stack

- Python
- Faker
- DuckDB
- PostgreSQL
- dbt (Data Build Tool)
- SQL
- Git
- GitHub

---

# 📂 Project Structure

```
Apple-Sales-POC
│
├── apple_sales_dbt
│   ├── models
│   │   ├── bronze
│   │   ├── silver
│   │   └── gold
│   ├── tests
│   ├── macros
│   └── dbt_project.yml
│
├── data
│
├── data_generator
│
├── duckdb
│
├── requirements.txt
│
└── README.md
```

---

# 🥉 Bronze Layer

Raw sales data is generated using Python and Faker and loaded into PostgreSQL using DuckDB.

No transformations are performed in this layer.

---

# 🥈 Silver Layer

Data quality and cleansing performed using dbt.

Transformations include:

- Removing duplicate transactions
- Removing NULL product names
- Removing negative sales amounts
- Standardizing store names
- Data validation

---

# ✅ dbt Data Quality Tests

Built-in Tests

- Not Null
- Unique

Custom Tests

- No Negative Amount
- Total Sales Validation
- Average Sales Validation

---

# 🥇 Gold Layer

Business-ready Star Schema containing:

### Dimension Tables

- dim_store
- dim_product
- dim_date

### Fact Table

- fct_sales

### Reporting Models

- daily_sales_summary
- store_daily_sales_summary
- store_product_sales_summary

---

# 📊 KPIs

The project provides business insights including:

- Total Sales
- Total Transactions
- Total Quantity Sold
- Average Sales Amount
- Store-wise Sales
- Product-wise Sales
- Store Product Sales
- Daily Revenue

---

# ▶️ How to Run

### Generate Sample Data

```bash
python data_generator/generate_sales.py
```

### Load Data into PostgreSQL

```bash
python duckdb/load_to_postgres.py
```

### Run dbt Models

```bash
dbt run
```

### Run dbt Tests

```bash
dbt test
```

---

# 📈 Future Enhancements

- Airflow Orchestration
- Incremental dbt Models
- CI/CD Pipeline
- Power BI Dashboard
- Data Freshness Checks
- Monitoring & Alerts

---

# 👨‍💻 Author

**Akash Rajpoot**

Senior Data Engineer
