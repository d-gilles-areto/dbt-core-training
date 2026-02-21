-- Dieser Test prüft, ob es negative Preise in den Order Lines gibt.
-- Wenn Rows zurückkommen, gibt es fehlerhafte Daten.

SELECT
    order_id,
    line_number,
    extended_price,
    net_amount
FROM {{ ref('fact__order_lines') }}
    WHERE net_amount < 0
        OR extended_price < 0
