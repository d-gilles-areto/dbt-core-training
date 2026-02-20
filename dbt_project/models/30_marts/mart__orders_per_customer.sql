WITH orders AS (
    SELECT * FROM {{ ref('fact__orders') }}
),

customer AS (
    SELECT * FROM {{ ref('dim__customer') }}
)

SELECT
    customer.custkey,
    customer.name,
    customer.mktsegment,
    EXTRACT(YEAR FROM orders.orderdate) AS order_year,
    COUNT(*) AS total_orders

FROM orders
LEFT JOIN customer ON orders.custkey = customer.custkey

GROUP BY
    customer.custkey,
    customer.name,
    customer.mktsegment,
    EXTRACT(YEAR FROM orders.orderdate)

ORDER BY
    customer.custkey,
