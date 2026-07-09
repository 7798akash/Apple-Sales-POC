SELECT *
FROM (
    SELECT SUM(amount) AS total_amount
    FROM {{ ref('stg_sales') }}
) t
WHERE total_amount <= 0