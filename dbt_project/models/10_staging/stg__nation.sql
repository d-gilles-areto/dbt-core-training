SELECT
    n_nationkey AS nationkey,
    n_name      AS name,
    n_regionkey AS regionkey,
    n_comment   AS comment,
    created_at
FROM {{ source('tpch', 'nation_tpch') }}