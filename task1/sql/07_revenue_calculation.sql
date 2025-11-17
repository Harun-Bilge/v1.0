-- Computes final monetization output for the base scenario.

IF OBJECT_ID('dbo.revenue') IS NOT NULL DROP TABLE dbo.revenue;

SELECT
    revenue_prep.variant,
    revenue_prep.day,
    revenue_prep.dau,
    revenue_prep.dau * revenue_prep.effective_purchase_rate AS iap_revenue,
    (revenue_prep.dau * revenue_prep.ad_impressions * revenue_prep.ecpm / 1000) AS ad_revenue,
    revenue_prep.dau * revenue_prep.effective_purchase_rate
      + (revenue_prep.dau * revenue_prep.ad_impressions * revenue_prep.ecpm / 1000) AS total_revenue
INTO dbo.revenue
FROM dbo.revenue_prep AS revenue_prep;
