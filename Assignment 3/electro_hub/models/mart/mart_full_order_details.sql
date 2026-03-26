select 
    f.*,
    c.user_name,
    c.country,
    c.email
from {{ ref('fct_orders') }} f
left join {{ ref('dim_customers') }} c on f.customer_id = c.customer_id