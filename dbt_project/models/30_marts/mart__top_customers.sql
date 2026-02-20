WITH orders AS (
    SELECT * FROM {{ ref('fact_orders') }}  -- BUG: Missing double underscore
),

customer AS (
    SELECT * FROM {{ ref('dim__customer') }}
)

SELECT
    customer.custkey,
    customer.customer_name,  -- BUG: Wrong column name (should be 'name')
    customer.mktsegment,
    COUNT(*) AS total_orders,
    SUM(orders.total_net_amount) AS total_revenue,
    ROUND(
        AVG(orders.total_net_amount)::numeric,
        2
    ) AS avg_order_value

FROM orders
    LEFT JOIN customer ON orders.custkey = customer.custkey
    
GROUP BY
    customer.custkey,
    customer.customer_name,
    customer.mktsegment
ORDER BY total_revenue DESC
