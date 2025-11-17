-- Converts combined DAU into revenue for new source scenario.

IF OBJECT_ID('dbo.new_revenue') IS NOT NULL DROP TABLE dbo.new_revenue;

SELECT
    variant,
    day,
    dau,
    dau * effective_purchase_rate AS iap_revenue,
    (dau * ad_impressions * ecpm / 1000) AS ad_revenue,
    (dau * effective_purchase_rate)
      + (dau * ad_impressions * ecpm / 1000) AS total_revenue
INTO dbo.new_revenue
FROM dbo.new_revenue_prep;
