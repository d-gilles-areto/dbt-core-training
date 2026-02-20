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
        COUNT(*) AS line_count,
        SUM(net_amount) AS total_net_amount,
        SUM(discount_amount) AS total_discount_amount,
        SUM(net_amount_incl_tax) AS total_net_amount_incl_tax,
        MAX(CASE WHEN is_late_shipment = TRUE THEN 1 ELSE 0 END) = 1 AS has_late_shipment
    FROM {{ ref('fact__order_lines') }}
    GROUP BY orderkey
)

SELECT
    orders.orderkey,
    orders.custkey,
    orders.orderdate,
    orders.orderstatus,
    orders.orderpriority,
    line_aggs.line_count,
    line_aggs.total_net_amount,
    line_aggs.total_discount_amount,
    line_aggs.total_net_amount_incl_tax,
    line_aggs.has_late_shipment,
    orders.created_at
FROM orders
    LEFT JOIN line_aggs ON orders.orderkey = line_aggs.orderkey

{% if is_incremental() %}
    WHERE orders.created_at > (SELECT MAX(created_at) FROM {{ this }})
{% endif %}