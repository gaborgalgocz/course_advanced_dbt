{{ 
    config(
        materialized='incremental',
        unique_key='event_id',
    ) 
}}

SELECT
    session_id,
    created_at,
    user_id,
    event_name,
    event_id

FROM {{ ref('stg_bingeflix__events') }}

{% if is_incremental() %}
WHERE created_at > (SELECT max(created_at) FROM {{ this }} ) - INTERVAL '3 days'
{% endif %}