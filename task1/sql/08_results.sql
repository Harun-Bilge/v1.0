-- Returns key A/B test outputs.

-- Day 15 DAU comparison
SELECT variant, dau
FROM dbo.revenue
WHERE day = 15;

-- Revenue up to Day 15
SELECT variant, SUM(total_revenue) AS total_rev_15
FROM dbo.revenue
WHERE day <= 15
GROUP BY variant;

-- Revenue up to Day 30
SELECT variant, SUM(total_revenue) AS total_rev_30
FROM dbo.revenue
WHERE day <= 30
GROUP BY variant;
