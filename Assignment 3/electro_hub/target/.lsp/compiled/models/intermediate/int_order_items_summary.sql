with order_items as (
    select * from "dev"."main"."stg_order_items"
),

aggregated as (
    select
        order_id,
        count(item_id) as total_items,
        sum(total_item_price) as gross_revenue,
        row_number() over (partition by order_id order by sum(total_item_price) desc) as row_num
    from order_items
    group by order_id
)

select 
    order_id,
    total_items,
    gross_revenue
from aggregated
where row_num = 1 