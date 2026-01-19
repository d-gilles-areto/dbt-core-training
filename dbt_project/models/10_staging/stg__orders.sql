SELECT
    o_orderdate AS orderdate,
    o_orderkey AS orderkey,
    o_custkey AS custkey,
    o_orderpriority AS orderpriority,
    o_shippriority AS shippriority,
    o_clerk AS clerk,
    o_orderstatus AS orderstatus,
    o_comment AS comment
FROM {{ source('tpch', 'orders_tpch') }}