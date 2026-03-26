{{
  config(
    materialized = 'incremental',
    unique_key = 'item_id'
  )
}}

with source as (
    select * from {{ source('raw_data', 'raw_order_items') }}
)

select
    item_id,
    order_id,
    product_id,
    quantity,
    unit_price,
    quantity * unit_price as total_item_price
from source

{% if is_incremental() %}
  where item_id > (select max(item_id) from {{ this }})
{% endif %}