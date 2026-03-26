select 
    p.*,
    s.supplier_name
from {{ ref('stg_products') }} p
left join {{ ref('int_supplier_products') }} s on p.product_id = s.product_id