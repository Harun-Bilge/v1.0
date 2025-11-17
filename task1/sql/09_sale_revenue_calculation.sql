-- Computes final monetization output for the sale scenario.

IF OBJECT_ID('dbo.revenue_sale') IS NOT NULL DROP TABLE dbo.revenue_sale;

SELECT
    revenue_sale_prep.variant,
    revenue_sale_prep.day,
    revenue_sale_prep.dau,
    revenue_sale_prep.dau * revenue_sale_prep.effective_purchase_rate AS iap_revenue,
    (revenue_sale_prep.dau * revenue_sale_prep.ad_impressions * revenue_sale_prep.ecpm / 1000) AS ad_revenue,
    revenue_sale_prep.dau * revenue_sale_prep.effective_purchase_rate
      + (revenue_sale_prep.dau * revenue_sale_prep.ad_impressions * revenue_sale_prep.ecpm / 1000) AS total_revenue
INTO dbo.revenue_sale
FROM dbo.revenue_sale_prep AS revenue_sale_prep;
