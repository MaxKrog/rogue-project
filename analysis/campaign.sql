with metrics as (

    select *
    from {{ ref('linkedin__master') }}

)

SELECT * FROM metrics
