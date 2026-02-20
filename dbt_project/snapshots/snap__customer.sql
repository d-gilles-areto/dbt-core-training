{% snapshot snap__customer %}

{%- set config = get_snapshot_config('snap__customer') -%}

{{ render_snapshot_config(config) }}

SELECT
    custkey,
    name,
    address,
    phone,
    acctbal,
    mktsegment,
    comment,
    nationkey,
    created_at
FROM {{ source('tpch', 'customer_tpch') }}
