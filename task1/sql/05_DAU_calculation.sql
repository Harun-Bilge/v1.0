-- Computes DAU from installs × retention.

IF OBJECT_ID('dbo.dau') IS NOT NULL DROP TABLE dbo.dau;

SELECT 
    r.variant,
    r.day,
    i.installs * r.retention AS dau
INTO dbo.dau
FROM dbo.retention_model r
JOIN dbo.installs i ON i.day = r.day;
