-- Combines old and new DAU, then applies purchase rates and sale boost.

IF OBJECT_ID('dbo.new_revenue_prep') IS NOT NULL DROP TABLE dbo.new_revenue_prep;

SELECT
    d.variant,
    d.day,

    -- total DAU = previous DAU + new source DAU
    d.dau + ns.dau AS dau,

    CASE 
        WHEN d.day BETWEEN 15 AND 25 
        THEN p.purchase_rate + 0.01
        ELSE p.purchase_rate
    END AS effective_purchase_rate,

    p.ecpm,
    p.ad_impressions

INTO dbo.new_revenue_prep
FROM dbo.dau d
JOIN dbo.new_source_dau ns
      ON ns.variant = d.variant AND ns.day = d.day
JOIN (
    SELECT DISTINCT variant, purchase_rate, ecpm, ad_impressions
    FROM dbo.parameters
    WHERE retention_day = 1
) p ON p.variant = d.variant;
