SELECT
    custkey     AS customer_id,
    name        AS customer_name,
    address,
    phone,
    acctbal     AS account_balance,
    mktsegment  AS market_segment,
    comment     AS customer_comment,
    nationkey   AS nation_id,
    created_at
FROM {{ ref('stg__customer') }}