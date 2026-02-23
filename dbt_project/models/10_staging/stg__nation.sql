SELECT
    CAST(n_nationkey AS INTEGER)   AS nationkey,
    CAST(n_name      AS TEXT)      AS name,
    CAST(n_regionkey AS INTEGER)   AS regionkey,
    CAST(n_comment   AS TEXT)      AS comment,
    CAST(created_at  AS TIMESTAMP) AS created_at
FROM {{ source('tpch', 'nation_tpch') }}