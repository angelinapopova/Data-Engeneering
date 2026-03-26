with source as (
    select * from {{ source('raw_data', 'raw_products') }}
)

select
    product_id,
    product_name,
    -- Чистимо категорії (Style Guide)
    upper(category) as category_name,
    coalesce(base_price, 0) as base_price
from source
where base_price >= 0 -- Відсікаємо аномалії (Broken Item)