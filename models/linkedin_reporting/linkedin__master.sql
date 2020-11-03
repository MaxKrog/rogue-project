with metrics as (

    select *
    from {{ ref('stg_linkedin__ad_analytics_by_creative') }}

), creatives as (

    select *
    from {{ ref('stg_linkedin__creative_history') }}

), campaigns as (

    select *
    from {{ ref('stg_linkedin__campaign_history') }}

), campaign_groups as (

    select *
    from {{ ref('stg_linkedin__campaign_group_history') }}

), accounts as (

    select *
    from {{ ref('stg_linkedin__account_history') }}

), joined as (

    select

        metrics.date_day,

        accounts.account_name,
        accounts.account_id,

        campaign_groups.campaign_group_name,
        campaign_groups.campaign_group_id,

        campaigns.campaign_name,
        campaigns.campaign_id,
        campaigns.nc_market,
        campaigns.nc_area,
        campaigns.nc_a,
        campaigns.nc_b,
        campaigns.nc_c,
        campaigns.version_tag,
        campaigns.cost_type,
        campaigns.creative_selection,
        campaigns.campaign_format,
        campaigns.objective_type,
        campaigns.optimization_target_type,

        metrics.daily_creative_id,
        metrics.creative_id,
        creatives.creative_type,
        creatives.base_url,
        creatives.url_host,
        creatives.url_path,
        creatives.utm_source,
        creatives.utm_medium,
        creatives.utm_campaign,
        creatives.utm_content,
        creatives.utm_term,

        metrics.cost,
        metrics.impressions,
        metrics.clicks,

        metrics.action_clicks,
        metrics.ad_unit_clicks,
        metrics.approximate_unique_impressions,
        metrics.card_impressions,
        metrics.card_clicks,


        metrics.comment_likes,
        metrics.comments,
        metrics.company_page_clicks,
        metrics.conversion_value_in_local_currency,
        metrics.cost_in_local_currency,
        metrics.cost_in_usd,
        metrics.external_website_conversions,
        metrics.external_website_post_click_conversions,
        metrics.external_website_post_view_conversions,
        metrics.follows,
        metrics.full_screen_plays,

        metrics.landing_page_clicks,
        metrics.lead_generation_mail_contact_info_shares,
        metrics.lead_generation_mail_interested_clicks,
        metrics.likes,
        metrics.one_click_lead_form_opens,
        metrics.one_click_leads,
        metrics.opens,
        metrics.other_engagements,
        metrics.shares,
        metrics.text_url_clicks,
        metrics.total_engagements,

        metrics.video_starts,
        metrics.video_views,
        metrics.video_first_quartile_completions,
        metrics.video_midpoint_completions,
        metrics.video_third_quartile_completions,
        metrics.video_completions,

        metrics.viral_card_clicks,
        metrics.viral_card_impressions,
        metrics.viral_clicks,
        metrics.viral_comment_likes,
        metrics.viral_comments,
        metrics.viral_company_page_clicks,
        metrics.viral_external_website_conversions,
        metrics.viral_external_website_post_click_conversions,
        metrics.viral_external_website_post_view_conversions,
        metrics.viral_follows,
        metrics.viral_full_screen_plays,
        metrics.viral_impressions,
        metrics.viral_landing_page_clicks,
        metrics.viral_likes,
        metrics.viral_one_click_lead_form_opens,
        metrics.viral_one_click_leads,
        metrics.viral_other_engagements,
        metrics.viral_shares,
        metrics.viral_total_engagements,
        metrics.viral_video_completions,
        metrics.viral_video_first_quartile_completions,
        metrics.viral_video_midpoint_completions,
        metrics.viral_video_starts,
        metrics.viral_video_third_quartile_completions,
        metrics.viral_video_views

    from metrics
    left join creatives
        on metrics.creative_id = creatives.creative_id
        and {{ timestamp_add('day', 1, 'metrics.date_day') }} >= creatives.valid_from
        and {{ timestamp_add('day', 1, 'metrics.date_day') }} <= coalesce(creatives.valid_to, {{ timestamp_add('day', 1, dbt_utils.current_timestamp()) }})
    left join campaigns
        on creatives.campaign_id = campaigns.campaign_id
        and {{ timestamp_add('day', 1, 'metrics.date_day') }} >= campaigns.valid_from
        and {{ timestamp_add('day', 1, 'metrics.date_day') }} <= coalesce(campaigns.valid_to, {{ timestamp_add('day', 1, dbt_utils.current_timestamp()) }})
    left join campaign_groups
        on campaigns.campaign_group_id = campaign_groups.campaign_group_id
        and {{ timestamp_add('day', 1, 'metrics.date_day') }} >= campaign_groups.valid_from
        and {{ timestamp_add('day', 1, 'metrics.date_day') }} <= coalesce(campaign_groups.valid_to, {{ timestamp_add('day', 1, dbt_utils.current_timestamp()) }})
    left join accounts
        on campaign_groups.account_id = accounts.account_id
        and {{ timestamp_add('day', 1, 'metrics.date_day') }} >= accounts.valid_from
        and {{ timestamp_add('day', 1, 'metrics.date_day') }} <= coalesce(accounts.valid_to, {{ timestamp_add('day', 1, dbt_utils.current_timestamp()) }})

)

select *
from joined
