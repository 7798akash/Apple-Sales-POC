SELECT *
FROM {{ ref('stg_sales') }}
WHERE amount < 0