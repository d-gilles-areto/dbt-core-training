SELECT
    custkey,
    mktsegment,
    nationkey,
    name,
    address,
    phone,
    acctbal,
    comment
FROM {{ ref('stg__customer') }}