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
    customer.nation,
    customer.region,
    COUNT(*) AS total_orders,
    SUM(orders.order_net_amount) AS total_revenue,
    ROUND(AVG(orders.order_net_amount)::numeric, 2) AS avg_order_value
FROM orders
    LEFT JOIN customer
        ON orders.custkey = customer.customer_id
GROUP BY
    customer.customer_id,
    customer.customer_name,
    customer.market_segment,
    customer.nation,
    customer.region
ORDER BY total_revenue DESC
