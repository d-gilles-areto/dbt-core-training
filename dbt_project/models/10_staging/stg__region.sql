SELECT
    r_regionkey AS regionkey,
    r_name AS name,
    r_comment AS comment,
    created_at
FROM {{ source('tpch', 'region_tpch') }}