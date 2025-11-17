-- Purpose: Revenue breakdown (IAP + Ads) per engagement segment

CREATE VIEW vw_revenue_by_segment AS
SELECT
    engagement_segment,
    SUM(CAST(iap_revenue AS float)) AS total_iap_revenue,
    SUM(CAST(ad_revenue AS float)) AS total_ad_revenue,
    SUM(CAST(iap_revenue AS float) + CAST(ad_revenue AS float)) AS total_revenue
FROM enriched_dataset
GROUP BY engagement_segment;
