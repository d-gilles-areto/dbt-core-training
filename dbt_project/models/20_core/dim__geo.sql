SELECT
    nation.nationkey,
    nation.name AS nation,
    region.name AS region
FROM {{ ref('stg__nation') }} AS nation
    LEFT JOIN {{ ref('stg__region') }} AS region
        ON nation.regionkey = region.regionkey