with orders as (
    select * from "dev"."main"."stg_orders"
),

customers as (
    select * from "dev"."main"."stg_users"
),

final as (
    select
        o.order_id,
        o.customer_id,
        c.user_name,
        o.order_date,
        o.status,
        --  Window Function (номер замовлення для кожного клієнта)
        row_number() over (partition by o.customer_id order by o.order_date) as customer_order_seq,
        
        -- Попередній статус замовлення (lag)
        lag(o.status) over (partition by o.customer_id order by o.order_date) as previous_order_status
    from orders o
    left join customers c on o.customer_id = c.customer_id
)

select * from final