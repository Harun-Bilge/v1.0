-- New user source (12k old + 8k new from Day 20)

-- Day 30 revenue comparison
SELECT 
    variant,
    SUM(total_revenue) AS total_rev_30_new_source
FROM dbo.new_revenue
WHERE day <= 30
GROUP BY variant;

-- Day 20-30 incremental revenue (optional)
SELECT 
    variant,
    SUM(total_revenue) AS rev_day20_30
FROM dbo.new_revenue
WHERE day >= 20 AND day <= 30
GROUP BY variant;
