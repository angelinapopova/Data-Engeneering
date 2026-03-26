select
    c.customer_key,
    c.customer_id,
    c.user_name,
    c.email,
    c.country,
    b.total_events,
    b.last_active_at
from "dev"."main"."stg_users" c
left join "dev"."main"."int_user_behavior_metrics" b on c.customer_id = b.customer_id