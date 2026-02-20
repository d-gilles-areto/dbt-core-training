SELECT
    geo.nation,
    geo.region,
    COUNT(*)        AS customer_count

FROM {{ ref('dim__customer') }} AS customer
LEFT JOIN {{ ref('dim__geo') }} AS geo ON customer.nationkey = geo.nationkey
