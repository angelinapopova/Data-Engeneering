{{ config(
    materialized='incremental', 
    unique_key='order_id') 
}}

select
    o.order_id,
    o.customer_id,
    o.order_date,
    o.status,
    s.gross_revenue,
    s.total_items
from {{ ref('stg_orders') }} o
left join {{ ref('int_order_items_summary') }} s on o.order_id = s.order_id

{% if is_incremental() %}
    where o.order_date > (select max(order_date) from {{ this }})
{% endif %}