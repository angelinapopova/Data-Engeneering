select 
    f.*,
    c.user_name,
    c.country,
    c.email
from "dev"."main"."fct_orders" f
left join "dev"."main"."dim_customers" c on f.customer_id = c.customer_id