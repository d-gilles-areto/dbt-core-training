SELECT
    l_shipdate      AS shipdate,
    l_orderkey      AS orderkey,
    l_discount      AS discount,
    l_extendedprice AS extendedprice,
    l_suppkey       AS suppkey,
    l_quantity      AS quantity,
    l_returnflag    AS returnflag,
    l_partkey       AS partkey,
    l_linestatus    AS linestatus,
    l_tax           AS tax,
    l_commitdate    AS commitdate,
    l_receiptdate   AS receiptdate,
    l_shipmode      AS shipmode,
    l_linenumber    AS linenumber,
    l_shipinstruct  AS shipinstruct,
    l_comment       AS comment
    created_at
FROM {{ source('tpch', 'lineitem_tpch') }}