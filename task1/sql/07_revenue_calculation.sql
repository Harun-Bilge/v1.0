-- Computes final monetization output: IAP + Ads

IF OBJECT_ID('dbo.revenue') IS NOT NULL DROP TABLE dbo.revenue;

SELECT
    variant,
    day,
    dau,
    dau * effective_purchase_rate AS iap_revenue,
    (dau * ad_impressions * ecpm / 1000) AS ad_revenue,
    (dau * effective_purchase_rate)
      + (dau * ad_impressions * ecpm / 1000) AS total_revenue
INTO dbo.revenue
FROM dbo.revenue_prep;
