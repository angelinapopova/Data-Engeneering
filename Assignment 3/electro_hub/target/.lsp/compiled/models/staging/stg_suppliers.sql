with source as (
    select 1 as supplier_id, 'TechWorld' as supplier_name, 'Ukraine' as supplier_country
    union all
    select 2, 'GlobalParts', 'Germany'
)
select * from source