SELECT
    regionkey   AS region_id,
    name        AS region_name,
    comment     AS region_comment,
    created_at
FROM {{ ref('stg__region') }}
