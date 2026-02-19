WITH customer AS (
    SELECT *
    FROM {{ ref('stg__customer') }}
)

SELECT
    customer.custkey AS customer_id,
    customer.name AS customer_name,
    customer.address,
    customer.phone,
    customer.acctbal AS account_balance,
    customer.mktsegment AS market_segment,
    customer.comment AS customer_comment,
    customer.nationkey AS nation_id
FROM customer