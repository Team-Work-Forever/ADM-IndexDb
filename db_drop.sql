EXEC sp_MSforeachtable 'DROP TABLE ?'

USE [db_index];

DECLARE @sql NVARCHAR(MAX);

-- Drop views
SET @sql = N'';
SELECT @sql = @sql + N'DROP VIEW ' + QUOTENAME(SCHEMA_NAME(schema_id)) + N'.' + QUOTENAME(name) + N';' + CHAR(13) + CHAR(10)
FROM sys.views;
EXEC sp_executesql @sql;

-- Drop stored procedures
SET @sql = N'';
SELECT @sql = @sql + N'DROP PROCEDURE ' + QUOTENAME(SCHEMA_NAME(schema_id)) + N'.' + QUOTENAME(name) + N';' + CHAR(13) + CHAR(10)
FROM sys.procedures;
EXEC sp_executesql @sql;

---- Drop functions
SET @sql = N'';
SELECT @sql = @sql + N'DROP FUNCTION ' + QUOTENAME(SCHEMA_NAME(schema_id)) + N'.' + QUOTENAME(name) + N';' + CHAR(13) + CHAR(10)
FROM sys.func;
EXEC sp_executesql @sql;

-- Drop tables
SET @sql = N'';
SELECT @sql = @sql + N'DROP TABLE ' + QUOTENAME(SCHEMA_NAME(schema_id)) + N'.' + QUOTENAME(name) + N';' + CHAR(13) + CHAR(10)
FROM sys.tables;
EXEC sp_executesql @sql;

-- Drop índices
SET @sql = N'';
SELECT @sql = @sql + N'DROP INDEX ' + QUOTENAME(i.name) + N' ON ' + QUOTENAME(SCHEMA_NAME(t.schema_id)) + N'.' + QUOTENAME(t.name) + N';' + CHAR(13) + CHAR(10)
FROM sys.indexes i
    JOIN sys.tables t ON i.object_id = t.object_id;
EXEC sp_executesql @sql;