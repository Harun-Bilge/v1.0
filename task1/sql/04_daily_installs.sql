-- Creates the daily install table (base 20,000 installs per day).
-- In Task 1-e this will be modified for mixed sources.

IF OBJECT_ID('dbo.installs') IS NOT NULL DROP TABLE dbo.installs;

SELECT 
    day,
    CASE WHEN day < 20 THEN 20000 ELSE 20000 END AS installs
INTO dbo.installs
FROM dbo.days;
