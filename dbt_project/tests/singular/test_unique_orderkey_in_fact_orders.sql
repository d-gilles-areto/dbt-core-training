-- Dieser Test prüft, ob jeder order_id in fact__orders nur einmal vorkommt.
-- Wenn Rows zurückkommen, gibt es Duplikate.

SELECT
    order_id,
    COUNT(*) AS row_count
FROM {{ ref('fact__orders') }}
    GROUP BY order_id
        HAVING COUNT(*) > 1
