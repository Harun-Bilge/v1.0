-- Drop code to cleaning
IF OBJECT_ID('dbo.retention_model') IS NOT NULL DROP TABLE dbo.retention_model;

IF OBJECT_ID('dbo.retention_model') IS NOT NULL DROP TABLE dbo.retention_model;

-- Step 1: Previous anchor point (<= day)
WITH prev_points AS (
    SELECT 
        d.day,
        p.variant,
        p.retention_day AS d1,
        p.retention_value AS v1,
        ROW_NUMBER() OVER (
            PARTITION BY d.day, p.variant 
            ORDER BY p.retention_day DESC
        ) AS rn
    FROM dbo.days d
    JOIN dbo.parameters p 
        ON p.retention_day <= d.day
),

-- Step 2: Next anchor point (>= day) 
-- WITH FALLBACK for days > last anchor (day 15–30)
next_points AS (
    SELECT
        d.day,
        v.variant,

        -- Next anchor day (or fallback = 14)
        CASE 
            WHEN EXISTS (
                SELECT 1 FROM dbo.parameters p2
                WHERE p2.variant = v.variant AND p2.retention_day >= d.day
            )
            THEN (
                SELECT TOP 1 p2.retention_day
                FROM dbo.parameters p2
                WHERE p2.variant = v.variant AND p2.retention_day >= d.day
                ORDER BY p2.retention_day ASC
            )
            ELSE 14
        END AS d2,

        -- Next anchor retention value (or fallback = retention at 14)
        CASE 
            WHEN EXISTS (
                SELECT 1 FROM dbo.parameters p2
                WHERE p2.variant = v.variant AND p2.retention_day >= d.day
            )
            THEN (
                SELECT TOP 1 p2.retention_value
                FROM dbo.parameters p2
                WHERE p2.variant = v.variant AND p2.retention_day >= d.day
                ORDER BY p2.retention_day ASC
            )
            ELSE (
                SELECT retention_value 
                FROM dbo.parameters 
                WHERE variant = v.variant AND retention_day = 14
            )
        END AS v2,

        ROW_NUMBER() OVER (
            PARTITION BY d.day, v.variant 
            ORDER BY (SELECT NULL)
        ) AS rn
    FROM dbo.days d
    CROSS JOIN (SELECT DISTINCT variant FROM dbo.parameters) v
),

-- Step 3: Pair d1 and d2
paired AS (
    SELECT
        p.day,
        p.variant,
        p.d1,
        p.v1,
        n.d2,
        n.v2
    FROM prev_points p
    JOIN next_points n
         ON n.day = p.day
        AND n.variant = p.variant
        AND p.rn = 1
        AND n.rn = 1
),

-- Step 4: Linear interpolation (with fallback flat tail)
calc AS (
    SELECT
        variant,
        day,
        CASE
            WHEN d1 = d2 THEN v1
            ELSE v1 + ((day - d1) * 1.0 / (d2 - d1)) * (v2 - v1)
        END AS retention
    FROM paired
)

SELECT * 
INTO dbo.retention_model
FROM calc;
