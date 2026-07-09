{{ config(
    schema='gold',
    materialized='table'
) }}

SELECT

    s.transaction_id,

    d.date_key,

    st.store_key,

    p.product_key,

    s.quantity,

    s.unit_price,

    s.discount_percent,

    s.tax,

    s.amount,

    s.payment_mode,

    s.customer_type,

    s.employee_id

FROM {{ ref('stg_sales') }} s

JOIN {{ ref('dim_store') }} st
    ON s.store_name = st.store_name

JOIN {{ ref('dim_product') }} p
    ON s.product_name = p.product_name

JOIN {{ ref('dim_date') }} d
    ON s.sale_date = d.date_key