

select
    o.order_id,
    o.customer_id,
    o.order_date,
    o.status,
    s.gross_revenue,
    s.total_items
from "dev"."main"."stg_orders" o
left join "dev"."main"."int_order_items_summary" s on o.order_id = s.order_id

