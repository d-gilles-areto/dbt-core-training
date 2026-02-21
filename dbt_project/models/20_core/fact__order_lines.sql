{{ config(
    materialized = 'incremental'
	) 
}}

WITH orders AS (
    SELECT * FROM {{ ref('stg__orders') }}
),

lineitem AS (
    SELECT * FROM {{ ref('stg__lineitem') }}
)

SELECT
    lineitem.orderkey       AS order_id,
    lineitem.linenumber     AS line_number,
    orders.custkey          AS customer_id,
    orders.orderdate        AS order_date,
    lineitem.shipdate       AS ship_date,
    lineitem.commitdate     AS commit_date,
    lineitem.receiptdate    AS receipt_date,
    orders.orderstatus      AS order_status,
    orders.orderpriority    AS order_priority,
    lineitem.returnflag     AS return_flag,
    lineitem.linestatus     AS line_status,
    lineitem.shipmode       AS ship_mode,
    lineitem.quantity,
    lineitem.extendedprice  AS extended_price,
    lineitem.discount,
    lineitem.tax,
    lineitem.extendedprice * (1 - lineitem.discount)                        AS net_amount,
    lineitem.extendedprice * lineitem.discount                              AS discount_amount,
    (lineitem.extendedprice * (1 - lineitem.discount)) * (1 + lineitem.tax) AS net_amount_incl_tax,
    CASE
        WHEN lineitem.shipdate > lineitem.commitdate 
            THEN true
        ELSE false
    END AS is_late_shipment,
    (lineitem.shipdate - orders.orderdate)      AS days_to_ship,
    (lineitem.receiptdate - orders.orderdate)   AS days_to_receive,
    lineitem.created_at
FROM lineitem
    LEFT JOIN orders ON lineitem.orderkey = orders.orderkey