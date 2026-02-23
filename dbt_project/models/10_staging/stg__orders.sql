SELECT
    CAST(o_orderdate     AS DATE)      AS orderdate,
    CAST(o_orderkey      AS INTEGER)   AS orderkey,
    CAST(o_custkey       AS INTEGER)   AS custkey,
    CAST(o_orderpriority AS TEXT)      AS orderpriority,
    CAST(o_shippriority  AS INTEGER)   AS shippriority,
    CAST(o_clerk         AS TEXT)      AS clerk,
    CAST(o_orderstatus   AS TEXT)      AS orderstatus,
    CAST(o_totalprice    AS NUMERIC)   AS totalprice,
    CAST(o_comment       AS TEXT)      AS comment,
    CAST(created_at      AS TIMESTAMP) AS created_at
FROM {{ source('tpch', 'orders_tpch') }}