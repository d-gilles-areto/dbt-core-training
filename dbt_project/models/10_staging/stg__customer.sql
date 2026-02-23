SELECT
    CAST(c_custkey    AS INTEGER)   AS custkey,
    CAST(c_mktsegment AS TEXT)      AS mktsegment,
    CAST(c_nationkey  AS INTEGER)   AS nationkey,
    CAST(c_name       AS TEXT)      AS name,
    CAST(c_address    AS TEXT)      AS address,
    CAST(c_phone      AS TEXT)      AS phone,
    CAST(c_acctbal    AS NUMERIC)   AS acctbal,
    CAST(c_comment    AS TEXT)      AS comment,
    CAST(created_at   AS TIMESTAMP) AS created_at
FROM {{ ref('snap__customer') }} -- Nachdem die Quelle für Customers über den Snapshot (./snapshots/snap__customer.sql) gem. SCD2 historisiert wurde, wollen wir nun die historisierte Quelle in der weiteren Pipeline benutzen.
