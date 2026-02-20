{% snapshot snap__customer %}

{{ config(
    unique_key = 'c_custkey',
    strategy = 'check',
    check_cols = ['c_address', 'c_phone', 'c_acctbal']
) }}

SELECT * FROM {{ source('tpch', 'customer_tpch') }}

{% endsnapshot %}
