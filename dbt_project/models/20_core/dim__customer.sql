WITH customer AS (
    -- Core-Harmonisierung: technisches TPCH-Key-Feld aus Staging
    -- wird in eine fachlich sprechende Entitäts-ID überführt.
    SELECT *
    FROM {{ ref('stg__customer') }}
),

geo AS (
    SELECT *
    FROM {{ ref('dim__geo') }}
)

SELECT
    customer.custkey AS customer_id,
    customer.name AS customer_name,
    customer.address,
    customer.phone,
    customer.acctbal AS account_balance,
    customer.mktsegment AS market_segment,
    customer.comment AS customer_comment,
    customer.nationkey AS nation_id,
    geo.nation,
    geo.region
FROM customer
    LEFT JOIN geo
        ON customer.nationkey = geo.nationkey