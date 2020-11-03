with master as (

    select *
    from {{ ref('linkedin__master') }}

)

SELECT
    date_day,
    campaign_name,
    campaign_id,
    
    cost

FROM master
