{{ config(
    materialized='incremental', 
    unique_key='customer_id') 
}}

select
    customer_id,
    count(event_id) as total_events,
    min(event_timestamp) as first_active_at,
    max(event_timestamp) as last_active_at
from {{ ref('stg_events') }}

{% if is_incremental() %}
    where event_timestamp > (select max(last_active_at) from {{ this }})
{% endif %}

group by 1
