{{ config(
    materialized = 'incremental',
    incremental_strategy = 'merge',
    unique_key = 'orderkey'
	) 
}}

WITH orders AS (
    SELECT * FROM {{ ref('stg__orders') }}
),

line_aggs AS (
    SELECT
        orderkey,
        COUNT(*) AS order_line_count,
        SUM(net_amount) AS order_net_amount,
        SUM(discount_amount) AS order_discount_amount,
        SUM(net_amount_incl_tax) AS order_net_amount_incl_tax,
        MAX(CASE WHEN is_late_shipment = TRUE THEN 1 ELSE 0 END) = 1 AS has_late_shipment
    FROM {{ ref('fact__order_lines') }}
    	GROUP BY orderkey
)

SELECT
    orders.orderkey AS order_id,
    orders.custkey AS customer_id,
    orders.orderdate AS order_date,
    orders.orderstatus AS order_status,
    orders.orderpriority AS order_priority,
    line_aggs.order_line_count,
    line_aggs.order_net_amount,
    line_aggs.order_discount_amount,
    line_aggs.order_net_amount_incl_tax,
    line_aggs.has_late_shipment
FROM orders
    LEFT JOIN line_aggs ON orders.orderkey = line_aggs.orderkey

{% if is_incremental() %}
    WHERE orders.orderdate > (SELECT MAX(orderdate) FROM {{ this }})
{% endif %}