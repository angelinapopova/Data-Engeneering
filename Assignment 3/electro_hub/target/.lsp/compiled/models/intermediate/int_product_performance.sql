with items as (
    select * from "dev"."main"."stg_order_items"
),
products as (
    select * from "dev"."main"."stg_products"
)

select
    p.product_id,
    p.product_name,
    p.category_name,
    count(items.item_id) as times_ordered,
    sum(items.quantity) as total_qty_sold,
    -- Рейтинг товару в межах його категорії
    rank() over (partition by p.category_name order by sum(items.quantity) desc) as category_rank
from products p
left join items on p.product_id = items.product_id
group by 1, 2, 3