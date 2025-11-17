-- New daily install distribution starting Day 20: old(12k) + new(8k)

IF OBJECT_ID('dbo.new_installs') IS NOT NULL DROP TABLE dbo.new_installs;

SELECT 
    day,
    CASE 
        WHEN day < 20 THEN 20000
        ELSE 12000 + 8000 
    END AS installs
INTO dbo.new_installs
FROM dbo.days;
