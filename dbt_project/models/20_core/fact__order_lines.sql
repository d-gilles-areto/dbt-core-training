WITH orders AS (
    SELECT * FROM {{ ref('stg__orders') }}
),

lines AS (
    SELECT * FROM {{ ref('stg__lineitem') }}
)

SELECT
    lines.orderkey,
    lines.linenumber,
    orders.custkey,
    orders.orderdate,
    lines.shipdate,
    lines.commitdate,
    lines.receiptdate,
    orders.orderstatus,
    orders.orderpriority,
    lines.returnflag,
    lines.linestatus,
    lines.shipmode,
    lines.quantity,
    lines.extendedprice,
    lines.discount,
    lines.tax,
    lines.extendedprice * (1 - lines.discount) AS net_amount,
    lines.extendedprice * lines.discount AS discount_amount,
    (lines.extendedprice * (1 - lines.discount)) * (1 + lines.tax) AS net_amount_incl_tax,
    CASE
        WHEN lines.shipdate > lines.commitdate THEN true
        ELSE false
    END AS is_late_shipment,
    (lines.shipdate - orders.orderdate) AS days_to_ship,
    (lines.receiptdate - orders.orderdate) AS days_to_receive,
    lines.created_at
FROM lines
    LEFT JOIN orders ON lines.orderkey = orders.orderkey