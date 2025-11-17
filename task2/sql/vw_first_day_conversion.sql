-- Purpose: Connect first-day engagement metrics with lifetime revenue per user

CREATE VIEW vw_first_day_conversion AS
SELECT
    user_id,
    engagement_segment,
    CAST(total_session_count AS int) AS first_day_sessions,
    CAST(total_session_duration AS float) AS first_day_duration,
    CAST(victory_count AS int) AS first_day_victories,
    CAST(defeat_count AS int) AS first_day_defeats,
    SUM(CAST(iap_revenue AS float)) AS total_iap_revenue,
    SUM(CAST(ad_revenue AS float)) AS total_ad_revenue,
    SUM(CAST(iap_revenue AS float) + CAST(ad_revenue AS float)) AS total_revenue
FROM enriched_dataset
GROUP BY
    user_id,
    engagement_segment,
    total_session_count,
    total_session_duration,
    victory_count,
    defeat_count;
