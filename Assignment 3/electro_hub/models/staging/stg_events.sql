{{
  config(
    materialized = 'incremental',
    unique_key = 'event_id'
  )
}}

with source as (
    select * from {{ source('raw_data', 'raw_events') }}
)

select
    event_id,
    user_id as customer_id,
    event_type,
    event_timestamp
from source

{% if is_incremental() %}
  where event_timestamp > (select max(event_timestamp) from {{ this }})
{% endif %}