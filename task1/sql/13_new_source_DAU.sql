-- Computes DAU from new installs and new retention curve.

IF OBJECT_ID('dbo.new_source_dau') IS NOT NULL DROP TABLE dbo.new_source_dau;

SELECT
    new_source_retention.variant,
    new_source_retention.day,
    new_installs.installs * new_source_retention.retention AS dau
INTO dbo.new_source_dau
FROM dbo.new_source_retention AS new_source_retention
JOIN dbo.new_installs AS new_installs
    ON new_installs.day = new_source_retention.day;
