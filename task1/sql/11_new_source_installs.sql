-- New daily installs for the new user source only.

IF OBJECT_ID('dbo.new_installs') IS NOT NULL DROP TABLE dbo.new_installs;

SELECT 
    days.day,
    CASE 
        WHEN days.day < 20 THEN 0
        ELSE 8000
    END AS installs
INTO dbo.new_installs
FROM dbo.days AS days;
