-- Returns key A/B test outputs for Task 1 (a–d).

-- a) Day 15 DAU (base, no sale)
SELECT 
    variant, 
    dau
FROM dbo.dau
WHERE day = 15;

-- b) Revenue up to Day 15 (base, no sale)
SELECT 
    variant, 
    SUM(total_revenue) AS total_rev_1_15_base
FROM dbo.revenue
WHERE day <= 15
GROUP BY variant;

-- c) Revenue up to Day 30 (base, no sale)
SELECT 
    variant, 
    SUM(total_revenue) AS total_rev_1_30_base
FROM dbo.revenue
WHERE day <= 30
GROUP BY variant;

-- d) Revenue up to Day 30 with 10-day sale
SELECT 
    variant, 
    SUM(total_revenue) AS total_rev_1_30_sale
FROM dbo.revenue_sale
WHERE day <= 30
GROUP BY variant;
