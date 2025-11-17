-- Prepares monetization inputs for the 10-day sale scenario.

IF OBJECT_ID('dbo.revenue_sale_prep') IS NOT NULL DROP TABLE dbo.revenue_sale_prep;

SELECT 
    dau.variant,
    dau.day,
    dau.dau,
    CASE 
        WHEN dau.day BETWEEN 15 AND 25 
        THEN parameters.purchase_rate + 0.01
        ELSE parameters.purchase_rate
    END AS effective_purchase_rate,
    parameters.ecpm,
    parameters.ad_impressions
INTO dbo.revenue_sale_prep
FROM dbo.dau AS dau
JOIN (
    SELECT DISTINCT variant, purchase_rate, ecpm, ad_impressions
    FROM dbo.parameters
    WHERE retention_day = 1
) AS parameters
    ON parameters.variant = dau.variant;
