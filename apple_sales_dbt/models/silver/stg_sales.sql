WITH ranked_sales AS (

    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY transaction_id
            ORDER BY created_at DESC
        ) AS rn

    FROM {{ source('bronze', 'sales') }}

)

SELECT

    transaction_id,

    sale_date,

    sale_time,

    CASE
        WHEN UPPER(store_name) = 'PUNE' THEN 'Pune'
        WHEN UPPER(store_name) = 'DELHI' THEN 'Delhi'
        WHEN UPPER(store_name) = 'NOIDA' THEN 'Noida'
        WHEN UPPER(store_name) = 'MUMBAI' THEN 'Mumbai'
        ELSE store_name
    END AS store_name,

    product_name,

    category,

    quantity,

    unit_price,

    discount_percent,

    tax,

    amount,

    payment_mode,

    customer_type,

    employee_id,

    created_at

FROM ranked_sales

WHERE rn = 1
  AND product_name IS NOT NULL
  AND amount >= 0