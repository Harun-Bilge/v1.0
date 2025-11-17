-- Drop tables if needed
IF OBJECT_ID('dbo.new_installs') IS NOT NULL DROP TABLE dbo.new_installs;
IF OBJECT_ID('dbo.new_source_retention') IS NOT NULL DROP TABLE dbo.new_source_retention;
IF OBJECT_ID('dbo.new_source_dau') IS NOT NULL DROP TABLE dbo.new_source_dau;
IF OBJECT_ID('dbo.new_revenue_prep') IS NOT NULL DROP TABLE dbo.new_revenue_prep;
IF OBJECT_ID('dbo.new_revenue') IS NOT NULL DROP TABLE dbo.new_revenue;
IF OBJECT_ID('dbo.revenue_sale_prep') IS NOT NULL DROP TABLE dbo.revenue_sale_prep;
IF OBJECT_ID('dbo.revenue_sale') IS NOT NULL DROP TABLE dbo.revenue_sale;
