with base as (

    select *
    from {{ source('linkedin','ad_analytics_by_creative') }}

), fields as (

    select
        creative_id,
        day as date_day,

        {% if var('linkedin__use_local_currency') %}
        cost_in_local_currency as cost
        {% else %}
        cost_in_usd as cost
        {% endif %},

        impressions,
        clicks,

        action_clicks,
        ad_unit_clicks,
        approximate_unique_impressions,
        card_clicks,
        card_impressions,

        comment_likes,
        comments,
        company_page_clicks,
        conversion_value_in_local_currency,
        cost_in_local_currency,
        cost_in_usd,
        external_website_conversions,
        external_website_post_click_conversions,
        external_website_post_view_conversions,
        follows,
        full_screen_plays,

        landing_page_clicks,
        lead_generation_mail_contact_info_shares,
        lead_generation_mail_interested_clicks,
        likes,
        one_click_lead_form_opens,
        one_click_leads,
        opens,
        other_engagements,
        shares,
        text_url_clicks,
        total_engagements,
        video_completions,
        video_first_quartile_completions,
        video_midpoint_completions,
        video_starts,
        video_third_quartile_completions,
        video_views,
        viral_card_clicks,
        viral_card_impressions,
        viral_clicks,
        viral_comment_likes,
        viral_comments,
        viral_company_page_clicks,
        viral_external_website_conversions,
        viral_external_website_post_click_conversions,
        viral_external_website_post_view_conversions,
        viral_follows,
        viral_full_screen_plays,
        viral_impressions,
        viral_landing_page_clicks,
        viral_likes,
        viral_one_click_lead_form_opens,
        viral_one_click_leads,
        viral_other_engagements,
        viral_shares,
        viral_total_engagements,
        viral_video_completions,
        viral_video_first_quartile_completions,
        viral_video_midpoint_completions,
        viral_video_starts,
        viral_video_third_quartile_completions,
        viral_video_views

    from base

), surrogate_key as (

    select
        *,
        {{ dbt_utils.surrogate_key(['date_day','creative_id']) }} as daily_creative_id
    from fields

)

select *
from surrogate_key
