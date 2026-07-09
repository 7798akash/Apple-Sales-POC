import duckdb

con = duckdb.connect()

# Install PostgreSQL Extension
con.execute("INSTALL postgres")
con.execute("LOAD postgres")

# Connect PostgreSQL
con.execute("""
ATTACH '
host=localhost
port=5432
dbname=apple_sales
user=postgres
password=Akash
' AS pg_db (TYPE POSTGRES);
""")

# Insert Data
con.execute("""
INSERT INTO pg_db.bronze.sales

SELECT *

FROM read_csv_auto(
'data/apple_sales.csv',
HEADER=TRUE
);
""")

print("Data Loaded Successfully into bronze.sales")