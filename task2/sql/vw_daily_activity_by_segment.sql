-- Purpose: Shows daily gameplay activity metrics grouped by user engagement segment

CREATE VIEW vw_daily_activity_by_segment AS
SELECT
    event_date,
    engagement_segment,
    COUNT(DISTINCT user_id) AS dau,
    SUM(CAST(total_session_count AS int)) AS total_sessions,
    SUM(CAST(total_session_duration AS float)) AS total_session_duration,
    SUM(CAST(match_start_count AS int)) AS match_starts,
    SUM(CAST(match_end_count AS int)) AS match_ends,
    SUM(CAST(victory_count AS int)) AS victories,
    SUM(CAST(defeat_count AS int)) AS defeats
FROM enriched_dataset
GROUP BY
    event_date,
    engagement_segment;

