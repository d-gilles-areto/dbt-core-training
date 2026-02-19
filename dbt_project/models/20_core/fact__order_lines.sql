{{ config(
    materialized = 'incremental',
    incremental_strategy = 'merge',
    unique_key = ['order_id', 'line_number']
	) 
}}

WITH orders AS (
    SELECT * FROM {{ ref('stg__orders') }}
),

lines AS (
    SELECT * FROM {{ ref('stg__lineitem') }}
)

SELECT
    lines.orderkey              AS order_id,
    lines.linenumber            AS line_number,
    orders.custkey              AS customer_id,

    orders.orderdate            AS order_date,
    lines.shipdate              AS ship_date,
    lines.commitdate            AS commit_date,
    lines.receiptdate           AS receipt_date,

    orders.orderstatus          AS order_status,
    orders.orderpriority        AS order_priority,

    lines.returnflag            AS return_flag,
    lines.linestatus            AS line_status,
    lines.shipmode              AS ship_mode,

    lines.quantity,
    lines.extendedprice         AS extended_price,
    lines.discount,
    lines.tax,

    lines.extendedprice * (1 - lines.discount)                      AS net_amount,
    lines.extendedprice * lines.discount                            AS discount_amount,
    (lines.extendedprice * (1 - lines.discount)) * (1 + lines.tax) AS net_amount_incl_tax,

    CASE
        WHEN lines.shipdate > lines.commitdate THEN true
        ELSE false
    END AS is_late_shipment,

    (lines.shipdate - orders.orderdate)     AS days_to_ship,
    (lines.receiptdate - orders.orderdate)  AS days_to_receive

FROM lines
    LEFT JOIN orders ON lines.orderkey = orders.orderkey

{% if is_incremental() %}
    WHERE lines.shipdate > (SELECT MAX(ship_date) FROM {{ this }})
{% endif %}