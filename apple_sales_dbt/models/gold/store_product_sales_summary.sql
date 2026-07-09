{{ config(
    schema='gold',
    materialized='table'
) }}

SELECT

    d.date_key AS sale_date,

    st.store_name,

    p.product_name,

    COUNT(DISTINCT f.transaction_id) AS total_transactions,

    SUM(f.quantity) AS total_quantity,

    SUM(f.amount) AS total_sales,

    ROUND(AVG(f.amount),2) AS average_sale

FROM {{ ref('fct_sales') }} f

JOIN {{ ref('dim_date') }} d
    ON f.date_key = d.date_key

JOIN {{ ref('dim_store') }} st
    ON f.store_key = st.store_key

JOIN {{ ref('dim_product') }} p
    ON f.product_key = p.product_key

GROUP BY

    d.date_key,
    st.store_name,
    p.product_name

ORDER BY

    d.date_key,
    st.store_name,
    p.product_name