-- Purpose: Revenue contribution by country to identify high-value regions

CREATE VIEW vw_country_revenue AS
SELECT
    country,
    SUM(CAST(iap_revenue AS float)) AS total_iap_revenue,
    SUM(CAST(ad_revenue AS float)) AS total_ad_revenue,
    SUM(CAST(iap_revenue AS float) + CAST(ad_revenue AS float)) AS total_revenue
FROM enriched_dataset
GROUP BY country;
