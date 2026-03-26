select
    category_name,
    count(product_id) as unique_products_sold,
    sum(total_qty_sold) as total_units_sold
from {{ ref('int_product_performance') }}
group by 1