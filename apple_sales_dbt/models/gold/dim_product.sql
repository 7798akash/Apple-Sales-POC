{{ config(
    schema='gold',
    materialized='table'
) }}

SELECT
    ROW_NUMBER() OVER (ORDER BY product_name) AS product_key,
    product_name,
    category
FROM (
    SELECT DISTINCT
        product_name,
        category
    FROM {{ ref('stg_sales') }}
) p
ORDER BY product_name