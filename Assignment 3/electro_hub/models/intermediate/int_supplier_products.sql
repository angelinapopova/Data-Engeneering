select 
    p.product_id,
    p.product_name,
    s.supplier_name,
    s.supplier_country
from {{ ref('stg_products') }} p
cross join {{ ref('stg_suppliers') }} s 
where p.product_id % 2 = s.supplier_id % 2 
