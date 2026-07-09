{{ config(
    schema='gold',
    materialized='table'
) }}

SELECT

    d.date_key AS sale_date,

    COUNT(DISTINCT f.transaction_id) AS total_transactions,

    SUM(f.quantity) AS total_quantity,

    SUM(f.amount) AS total_sales,

    ROUND(AVG(f.amount), 2) AS avg_sale_amount

FROM {{ ref('fct_sales') }} f

JOIN {{ ref('dim_date') }} d
    ON f.date_key = d.date_key

GROUP BY d.date_key

ORDER BY d.date_key