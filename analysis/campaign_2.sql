with metrics as (

    select *
    from {{ ref('linkedin__master') }}

)

SELECT
    date_day,
    objective_type,

    SUM(cost) AS cost,
    SUM(impressions) AS impressions,
    SUM(clicks) AS clicks

FROM metrics

GROUP BY 1, 2
