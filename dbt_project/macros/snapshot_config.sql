{# macros/snapshot_config.sql #}
{# Zentrale Snapshot-Konfiguration für Konsistenz und Wartbarkeit #}

{% macro get_snapshot_config(snapshot_name) %}
    {%- set snapshot_configs = {
        'snap__customer': {
            'unique_key': 'custkey',
            'strategy': 'check',
            'check_cols': ['address', 'phone', 'acctbal'],
            'target_schema': 'snapshots',
            'invalidate_hard_deletes': false
        },
        'snap__orders': {
            'unique_key': 'orderkey',
            'strategy': 'timestamp',
            'updated_at': 'created_at',
            'target_schema': 'snapshots',
            'invalidate_hard_deletes': false
        },
        'snap__region': {
            'unique_key': 'regionkey',
            'strategy': 'timestamp',
            'updated_at': 'created_at',
            'target_schema': 'snapshots',
            'invalidate_hard_deletes': false
        }
    } -%}
    
    {%- if snapshot_name in snapshot_configs -%}
        {{ snapshot_configs[snapshot_name] }}
    {%- else -%}
        {# Default config #}
        {
            'unique_key': 'id',
            'strategy': 'timestamp',
            'updated_at': 'created_at',
            'target_schema': 'snapshots',
            'invalidate_hard_deletes': false
        }
    {%- endif -%}
{% endmacro %}

{% macro render_snapshot_config(config_dict) %}
    {{ config(
        unique_key = config_dict.unique_key,
        strategy = config_dict.strategy,
        {% if config_dict.strategy == 'check' and config_dict.check_cols is defined %}
            check_cols = config_dict.check_cols,
        {% elif config_dict.strategy == 'timestamp' and config_dict.updated_at is defined %}
            updated_at = config_dict.updated_at,
        {% endif %}
        target_schema = config_dict.target_schema,
        invalidate_hard_deletes = config_dict.invalidate_hard_deletes
    ) }}
{% endmacro %}
