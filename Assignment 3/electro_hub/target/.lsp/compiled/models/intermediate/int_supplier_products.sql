select 
    p.product_id,
    p.product_name,
    s.supplier_name,
    s.supplier_country
from "dev"."main"."stg_products" p
cross join "dev"."main"."stg_suppliers" s 
where p.product_id % 2 = s.supplier_id % 2 