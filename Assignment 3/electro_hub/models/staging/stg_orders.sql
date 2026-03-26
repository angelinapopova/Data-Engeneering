{{
  config(
    materialized = 'incremental',
    unique_key = 'order_id'
  )
}}

with source as (
    select * from {{ source('raw_data', 'raw_orders') }}

    {% if is_incremental() %}
      where order_date > (select max(order_date) from {{ this }})
    {% endif %}
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