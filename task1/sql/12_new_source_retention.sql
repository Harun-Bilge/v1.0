-- Builds exponential retention curve for new user source.

IF OBJECT_ID('dbo.new_source_retention') IS NOT NULL DROP TABLE dbo.new_source_retention;

SELECT 
    v.variant,
    d.day,
    
    -- Variant A formula
    CASE 
        WHEN v.variant = 'A'
        THEN 0.58 * EXP(-0.12 * (d.day - 1))
        
        -- Variant B formula
        WHEN v.variant = 'B'
        THEN 0.52 * EXP(-0.10 * (d.day - 1))
    END AS retention

INTO dbo.new_source_retention
FROM dbo.days d
CROSS JOIN (SELECT DISTINCT variant FROM dbo.parameters) v;
