WITH orders AS (
    SELECT * FROM {{ ref('fact__orders') }}
),

customer AS (
    SELECT * FROM {{ ref('dim__customer') }}
),

geo AS (
    SELECT * FROM {{ ref('dim__geo') }}
)

SELECT
    orders.order_id,
    customer.customer_name,
    customer.market_segment,
    geo.nation,
    geo.region,
    orders.order_date,
    orders.order_status,
    orders.line_count,
    orders.total_net_amount,
    orders.has_late_shipment
FROM orders
    LEFT JOIN customer ON orders.customer_id = customer.customer_id
    LEFT JOIN geo ON customer.nation_id = geo.nation_id
ORDER BY orders.order_date DESC
