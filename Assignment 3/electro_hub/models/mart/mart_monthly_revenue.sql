select
    date_trunc('month', order_date) as order_month,
    sum(gross_revenue) as monthly_revenue,
    count(order_id) as total_orders
from {{ ref('fct_orders') }}
where status = 'completed'
group by 1