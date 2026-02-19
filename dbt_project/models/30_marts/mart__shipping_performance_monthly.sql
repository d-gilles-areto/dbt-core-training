SELECT
    DATE_TRUNC('month', shipdate)::date AS ship_month,
    COUNT(*) AS total_lines,
    SUM(CASE WHEN is_late_shipment THEN 1 ELSE 0 END) AS late_lines,
    ROUND(AVG(CASE WHEN is_late_shipment THEN 1.0 ELSE 0.0 END) * 100, 2) AS late_line_rate_pct,
    ROUND(AVG(days_to_ship), 1) AS avg_days_to_ship,
    SUM(net_amount) AS revenue_net
FROM {{ ref('fact__order_lines') }}
    GROUP BY DATE_TRUNC('month', shipdate)
    ORDER BY ship_month
