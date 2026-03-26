

select
    customer_id,
    count(event_id) as total_events,
    min(event_timestamp) as first_active_at,
    max(event_timestamp) as last_active_at
from "dev"."main"."stg_events"



group by 1