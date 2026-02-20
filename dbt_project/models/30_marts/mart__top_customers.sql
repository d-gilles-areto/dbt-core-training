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
    COUNT(*) AS total_orders,
    SUM(orders.total_net_amount) AS total_revenue,
    ROUND(
        AVG(orders.total_net_amount)::numeric,
        2
    ) AS avg_order_value

FROM orders
    LEFT JOIN customer ON orders.customer_id = customer.customer_id
    
GROUP BY
    customer.customer_id,
    customer.customer_name,
    customer.market_segment
ORDER BY total_revenue DESC
