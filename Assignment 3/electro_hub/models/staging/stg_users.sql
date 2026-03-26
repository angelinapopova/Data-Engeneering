with source as (
    select * from {{ source('raw_data', 'raw_user') }}
),

renamed as (
    select
        user_id as customer_id,
        user_name,
        lower(email) as email,
        coalesce(country, 'Unknown') as country,
        signup_date,
        -- Використовуємо віконну функцію для дедуплікації
        row_number() over (partition by user_id order by signup_date desc) as row_num
    from source
)

select 
    -- Генеруємо сурогатний ключ за допомогою нашого макросу
    {{ generate_surrogate_key(['customer_id', 'email']) }} as customer_key,
    customer_id,
    user_name,
    email,
    country,
    signup_date
from renamed
where row_num = 1 -- Залишаємо тільки одну версію юзера