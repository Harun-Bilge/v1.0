-- Drop tables if needed
IF OBJECT_ID('dbo.days') IS NOT NULL DROP TABLE dbo.days;
IF OBJECT_ID('dbo.parameters') IS NOT NULL DROP TABLE dbo.parameters;
IF OBJECT_ID('dbo.installs') IS NOT NULL DROP TABLE dbo.installs;
IF OBJECT_ID('dbo.retention_model') IS NOT NULL DROP TABLE dbo.retention_model;
IF OBJECT_ID('dbo.dau') IS NOT NULL DROP TABLE dbo.dau;
IF OBJECT_ID('dbo.revenue_prep') IS NOT NULL DROP TABLE dbo.revenue_prep;
IF OBJECT_ID('dbo.revenue') IS NOT NULL DROP TABLE dbo.revenue;