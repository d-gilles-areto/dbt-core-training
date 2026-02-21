{% snapshot snap__customer %}

SELECT
    custkey,
    name,
    address,
    phone,
    acctbal,
    mktsegment,
    comment,
    nationkey,
    created_at
FROM {{ source('tpch', 'customer_tpch') }}
