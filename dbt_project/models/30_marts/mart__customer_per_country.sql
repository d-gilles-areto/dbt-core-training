SELECT
    geo.nation,
    geo.region,
    COUNT(*) AS customer_count
FROM {{ ref('dim__customer') }} AS customer
    LEFT JOIN {{ ref('dim__geo') }} AS geo
        ON customer.nation_id = geo.nationkey
GROUP BY geo.nation, geo.region
ORDER BY geo.region, geo.nation
