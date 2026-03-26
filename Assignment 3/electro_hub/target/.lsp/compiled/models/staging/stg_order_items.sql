

with source as (
    select * from "dev"."main"."raw_order_items"
)

select
    item_id,
    order_id,
    product_id,
    quantity,
    unit_price,
    quantity * unit_price as total_item_price
from source

