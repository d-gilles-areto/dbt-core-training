WITH customer AS (
    SELECT *
    FROM {{ ref('stg__customer') }}
)

SELECT
    customer.custkey,
    customer.name,
    customer.address,
    customer.phone,
    customer.acctbal,
    customer.mktsegment,
    customer.comment,
    customer.nationkey,
    customer.created_at
FROM customer