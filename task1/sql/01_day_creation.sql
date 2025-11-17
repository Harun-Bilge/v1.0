-- Day creation
WITH x AS (
    SELECT 1 AS day
    UNION ALL
    SELECT day + 1 FROM x WHERE day < 30
)
SELECT day 
INTO dbo.days
FROM x
OPTION (MAXRECURSION 0);

