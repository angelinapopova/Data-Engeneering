select
    order_id,
    customer_id,
    order_date,
    status,
    case 
        when status = 'pending' and order_date < current_date - 3 then 'Delayed'
        when status = 'completed' then 'Delivered'
        else 'On Time'
    end as delivery_status
from {{ ref('stg_orders') }}