{% snapshot snap__customer %}

{{ config(
    target_schema = generate_schema_name('snapshots'),
    unique_key = 'c_custkey',
    strategy = 'check',
    check_cols = ['c_address', 'c_phone', 'c_acctbal']
) }}

SELECT * FROM {{ source('tpch', 'customer_tpch') }}

{% endsnapshot %}
