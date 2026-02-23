SELECT
    CAST(c_custkey    AS INTEGER)   AS custkey,
    CAST(c_mktsegment AS TEXT)      AS mktsegment,
    CAST(c_nationkey  AS INTEGER)   AS nationkey,
    CAST(c_name       AS TEXT)      AS name,
    CAST(c_address    AS TEXT)      AS address,
    CAST(c_phone      AS TEXT)      AS phone,
    CAST(c_acctbal    AS NUMERIC)   AS acctbal,
    CAST(c_comment    AS TEXT)      AS comment,
    CAST(created_at   AS TIMESTAMP) AS created_at
FROM {{ source('tpch', 'customer_tpch') }}