-- Purpose: Analyze decay trend of session duration over time across engagement segments

CREATE VIEW vw_session_fatigue_analysis AS
SELECT
    event_date,
    engagement_segment,
    AVG(CAST(total_session_duration AS float)) AS avg_session_duration
FROM enriched_dataset
GROUP BY
    event_date,
    engagement_segment;
