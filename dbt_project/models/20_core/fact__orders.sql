{{ config(
    materialized = 'incremental',
    incremental_strategy = 'merge',
    unique_key = 'order_id'
	) 
}}

WITH orders AS (
    SELECT * FROM {{ ref('stg__orders') }}
),

order_lines AS (
    SELECT * FROM {{ ref('fact__order_lines') }}
),

line_aggs AS (
    SELECT
        order_id,
        COUNT(*) AS line_count,
        SUM(net_amount) AS total_net_amount,
        SUM(discount_amount) AS total_discount_amount,
        SUM(net_amount_incl_tax) AS total_net_amount_incl_tax,
        MAX(CASE WHEN is_late_shipment = TRUE THEN 1 ELSE 0 END) = 1 AS has_late_shipment
    FROM order_lines
        GROUP BY order_id
)

SELECT
    orders.orderkey         AS order_id,
    orders.custkey          AS customer_id,
    orders.orderdate        AS order_date,
    orders.orderstatus      AS order_status,
    orders.orderpriority    AS order_priority,
    line_aggs.line_count,
    line_aggs.total_net_amount,
    line_aggs.total_discount_amount,
    line_aggs.total_net_amount_incl_tax,
    line_aggs.has_late_shipment,
    orders.created_at
FROM orders
    LEFT JOIN line_aggs ON orders.orderkey = line_aggs.order_id

{% if is_incremental() %}
    WHERE orders.created_at > (SELECT MAX(created_at) FROM {{ this }})
{% endif %}