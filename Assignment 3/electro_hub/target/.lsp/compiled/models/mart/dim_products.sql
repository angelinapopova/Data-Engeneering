select 
    p.*,
    s.supplier_name
from "dev"."main"."stg_products" p
left join "dev"."main"."int_supplier_products" s on p.product_id = s.product_id