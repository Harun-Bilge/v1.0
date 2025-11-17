-- Prepares monetization inputs.
-- Applies sale effect: purchase_rate + 1% between days 15–25.

IF OBJECT_ID('dbo.revenue_prep') IS NOT NULL DROP TABLE dbo.revenue_prep;

SELECT 
    d.variant,
    d.day,
    d.dau,
    CASE 
        WHEN d.day BETWEEN 15 AND 25 
        THEN p.purchase_rate + 0.01
        ELSE p.purchase_rate 
    END AS effective_purchase_rate,
    p.ecpm,
    p.ad_impressions
INTO dbo.revenue_prep
FROM dbo.dau d
JOIN (
    SELECT DISTINCT variant, purchase_rate, ecpm, ad_impressions
    FROM dbo.parameters
    WHERE retention_day = 1
) p ON p.variant = d.variant;
