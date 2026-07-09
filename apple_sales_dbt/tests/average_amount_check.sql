SELECT *
FROM (
    SELECT AVG(amount) AS avg_amount
    FROM {{ ref('stg_sales') }}
) t
WHERE avg_amount <= 0