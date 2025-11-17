-- Prepares monetization inputs for the base scenario (no sale).

IF OBJECT_ID('dbo.revenue_prep') IS NOT NULL DROP TABLE dbo.revenue_prep;

SELECT 
    dau.variant,
    dau.day,
    dau.dau,
    parameters.purchase_rate AS effective_purchase_rate,
    parameters.ecpm,
    parameters.ad_impressions
INTO dbo.revenue_prep
FROM dbo.dau AS dau
JOIN (
    SELECT DISTINCT variant, purchase_rate, ecpm, ad_impressions
    FROM dbo.parameters
    WHERE retention_day = 1
) AS parameters
    ON parameters.variant = dau.variant;
