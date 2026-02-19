-- Dieser Test prüft, ob es negative Preise in den Order Lines gibt.
-- Wenn Rows zurückkommen, gibt es fehlerhafte Daten.

SELECT
    orderkey,
    linenumber,
    extendedprice,
    net_amount
FROM {{ ref('fact__order_lines') }}
WHERE net_amount < 0
   OR extendedprice < 0
