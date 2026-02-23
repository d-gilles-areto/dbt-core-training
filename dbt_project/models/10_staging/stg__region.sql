SELECT
    CAST(r_regionkey AS INTEGER)   AS regionkey,
    CAST(r_name      AS TEXT)      AS name,
    CAST(r_comment   AS TEXT)      AS comment,
    CAST(created_at  AS TIMESTAMP) AS created_at
FROM {{ source('tpch', 'region_tpch') }}