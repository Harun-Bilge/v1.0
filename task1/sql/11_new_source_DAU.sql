-- Computes DAU from new installs and new retention curve.

IF OBJECT_ID('dbo.new_source_dau') IS NOT NULL DROP TABLE dbo.new_source_dau;

SELECT
    r.variant,
    r.day,
    i.installs * r.retention AS dau
INTO dbo.new_source_dau
FROM dbo.new_source_retention r
JOIN dbo.new_installs i ON i.day = r.day;
