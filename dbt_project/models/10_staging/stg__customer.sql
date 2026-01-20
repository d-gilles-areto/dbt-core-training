SELECT
    c_custkey AS custkey,
    c_mktsegment AS mktsegment,
    c_nationkey AS nationkey,
    c_name AS name,
    c_address AS address,
    c_phone AS phone,
    c_acctbal AS acctbal,
    c_comment AS comment
FROM {{ source('tpch', 'customer_tpch') }}

-- bisherige Namenskonvention: c_ Präfix entfernt
    -- sobald die Cases und Aufgaben definiert haben, können wir Namenskonventon erweitern
        -- snake_case für Spalten
        -- Abkürzungen ausschreiben
        -- id statt key