-- Parameters
CREATE TABLE dbo.parameters (
    variant VARCHAR(1),
    retention_day INT,
    retention_value FLOAT,
    purchase_rate FLOAT,
    ecpm FLOAT,
    ad_impressions FLOAT
);

INSERT INTO dbo.parameters VALUES
-- Variant A
('A', 1, 0.53, 0.0305, 9.80, 2.3),
('A', 3, 0.27, 0.0305, 9.80, 2.3),
('A', 7, 0.17, 0.0305, 9.80, 2.3),
('A', 14, 0.06, 0.0305, 9.80, 2.3),
-- Variant B
('B', 1, 0.48, 0.0315, 10.80, 1.6),
('B', 3, 0.25, 0.0315, 10.80, 1.6),
('B', 7, 0.19, 0.0315, 10.80, 1.6),
('B', 14, 0.09, 0.0315, 10.80, 1.6);

