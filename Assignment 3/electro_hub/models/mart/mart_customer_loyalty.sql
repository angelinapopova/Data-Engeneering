select
    customer_id,
    user_name,
    max(customer_order_seq) as total_orders_count,
    case when max(customer_order_seq) > 1 then 'Repeat Customer' else 'New Customer' end as loyalty_status
from {{ ref('int_customer_orders_history') }}
group by 1, 2