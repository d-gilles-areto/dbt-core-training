{% snapshot snap__customer %}

{{
  config(
    unique_key = 'c_custkey',
    strategy = 'timestamp',
    updated_at = 'created_at'
  )
}}

SELECT
    c_custkey,
    c_name,
    c_address,
    c_phone,
    c_acctbal,
    c_mktsegment,
    c_comment,
    c_nationkey,
    created_at
FROM {{ source('tpch', 'customer_tpch') }}

{% endsnapshot %}