select
    c.customer_key,
    c.customer_id,
    c.user_name,
    c.email,
    c.country,
    b.total_events,
    b.last_active_at
from {{ ref('stg_users') }} c
left join {{ ref('int_user_behavior_metrics') }} b on c.customer_id = b.customer_id