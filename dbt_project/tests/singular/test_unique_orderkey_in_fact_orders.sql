-- Dieser Test prüft, ob jeder orderkey in fact__orders nur einmal vorkommt.
-- Wenn Rows zurückkommen, gibt es Duplikate.

SELECT
    orderkey,
    COUNT(*) AS row_count
FROM {{ ref('fact__orders') }}
    GROUP BY orderkey
        HAVING COUNT(*) > 1
