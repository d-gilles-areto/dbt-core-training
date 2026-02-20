SELECT
    orderkey,
    custkey,
    orderdate,
    orderstatus,
    orderpriority,
    created_at
FROM {{ ref('stg__orders') }}