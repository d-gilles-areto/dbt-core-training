SELECT
    orderkey AS order_id,
    custkey AS customer_id,
    orderdate AS order_date,
    orderstatus AS order_status,
    orderpriority AS order_priority,
    created_at
FROM {{ ref('stg__orders') }}