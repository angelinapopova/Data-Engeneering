select 
    order_date,
    count(order_id) as daily_orders,
    sum(gross_revenue) as daily_revenue
from "dev"."main"."fct_orders"
group by 1