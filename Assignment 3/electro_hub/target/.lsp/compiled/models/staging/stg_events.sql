

with source as (
    select * from "dev"."main"."raw_events"
)

select
    event_id,
    user_id as customer_id,
    event_type,
    event_timestamp
from source

