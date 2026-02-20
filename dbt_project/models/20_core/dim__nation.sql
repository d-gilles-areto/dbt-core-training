SELECT
    nationkey  AS nation_id,
    name       AS nation_name,
    regionkey  AS region_id,
    comment    AS nation_comment,
    created_at
FROM {{ ref('stg__nation') }}
