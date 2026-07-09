{{ config(
    schema='gold',
    materialized='table'
) }}

SELECT DISTINCT

    sale_date AS date_key,

    EXTRACT(YEAR FROM sale_date) AS year,

    EXTRACT(MONTH FROM sale_date) AS month,

    EXTRACT(DAY FROM sale_date) AS day,

    TO_CHAR(sale_date, 'Month') AS month_name,

    TO_CHAR(sale_date, 'Day') AS day_name

FROM {{ ref('stg_sales') }}

ORDER BY sale_date