

with source as (
    select * from "dev"."main"."raw_orders"

    
),

renamed as (
    select
        order_id,
        user_id as customer_id,
        order_date,
        status,
        row_number() over (partition by order_id order by order_date desc) as row_num
    from source
)

select * from renamed
where row_num = 1