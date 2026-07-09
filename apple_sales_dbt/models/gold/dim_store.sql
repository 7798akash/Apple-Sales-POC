{{ config(
    schema='gold',
    materialized='table'
) }}

SELECT
    ROW_NUMBER() OVER (ORDER BY store_name) AS store_key,
    store_name
FROM (
    SELECT DISTINCT store_name
    FROM {{ ref('stg_sales') }}
) s
ORDER BY store_name