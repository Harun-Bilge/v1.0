-- Purpose: Maps each user to an engagement segment based on first-day session count

CREATE VIEW vw_user_segments AS
SELECT
    user_id,
    total_session_count AS first_day_sessions,
    engagement_segment
FROM enriched_dataset
GROUP BY user_id, total_session_count, engagement_segment;
