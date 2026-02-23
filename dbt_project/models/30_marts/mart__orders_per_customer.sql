WITH orders AS (
    SELECT * FROM {{ ref('fact__orders') }}
),

customer AS (
    SELECT * FROM {{ ref('dim__customer') }}
)

SELECT
    customer.customer_id,
    customer.customer_name,
    customer.market_segment,
    COUNT(*) AS total_orders
FROM orders
    LEFT JOIN customer ON orders.customer_id = customer.customer_id
GROUP BY
    customer.customer_id,
    customer.customer_name,
    customer.market_segment
ORDER BY
    customer.customer_id