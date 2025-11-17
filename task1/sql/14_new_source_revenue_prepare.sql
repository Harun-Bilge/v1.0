-- Combines adjusted old DAU and new source DAU, then applies base purchase rates.

IF OBJECT_ID('dbo.new_revenue_prep') IS NOT NULL DROP TABLE dbo.new_revenue_prep;

WITH adjusted_old_dau AS (
    SELECT
        dau.variant,
        dau.day,
        CASE
            WHEN dau.day < 20 THEN dau.dau
            ELSE dau.dau * 0.6   -- 12k / 20k = 0.6
        END AS dau_old_adjusted
    FROM dbo.dau AS dau
)

SELECT
    adjusted_old_dau.variant,
    adjusted_old_dau.day,

    -- total DAU = adjusted old source DAU + new source DAU
    adjusted_old_dau.dau_old_adjusted + new_source_dau.dau AS dau,

    parameter_values.purchase_rate AS effective_purchase_rate,
    parameter_values.ecpm,
    parameter_values.ad_impressions
INTO dbo.new_revenue_prep
FROM adjusted_old_dau
JOIN dbo.new_source_dau AS new_source_dau
      ON new_source_dau.variant = adjusted_old_dau.variant 
     AND new_source_dau.day = adjusted_old_dau.day
JOIN (
    SELECT DISTINCT variant, purchase_rate, ecpm, ad_impressions
    FROM dbo.parameters
    WHERE retention_day = 1
) AS parameter_values 
    ON parameter_values.variant = adjusted_old_dau.variant;
