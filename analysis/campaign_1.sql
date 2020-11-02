with metrics as (

    select *
    from {{ ref('linkedin__master') }}

)

SELECT
    date_day,
    campaign_group_name,
    campaign_group_id,
    campaign_name,
    campaign_id,
    campaign_format,
    objective_type,

    cost,
    impressions,
    clicks

FROM metrics
