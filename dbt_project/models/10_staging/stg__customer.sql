SELECT
    c_custkey AS custkey,
    c_mktsegment AS mktsegment,
    c_nationkey AS nationkey,
    c_name AS name,
    c_address AS address,
    c_phone AS phone,
    c_acctbal AS acctbal,
    c_comment AS comment
FROM {{ ref('snap__customer') }} -- Nachdem die Quelle für Customers über den Snapshot (./snapshots/snap__customer.sql) gem. SCD2 historisiert wurde, wollen wir nun die historisierte Quelle in der weiteren Pipeline benutzen.
