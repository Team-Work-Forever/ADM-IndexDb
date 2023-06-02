-- sp_view_log

USE [db_index]
go

-- Action
-- 0 - SELECT | 1 - INSERT | 2 - UPDATE | 3 DELETE | 4 - EXECUTE
-- N'{"table" : "Espadas", "action" : "EXECUTE", "columns" : []}'
CREATE OR ALTER PROCEDURE sp_view_log
	(
	@info varchar(50)
)
AS
BEGIN

	declare @jsonResult nvarchar(max)

	DECLARE @table varchar(50);
	DECLARE @action varchar(50);
	DECLARE @columns varchar(max);
	DECLARE @created_at date;
	DECLARE @deleted_at date;

	select
		@jsonResult = json_info,
		@created_at = createdAt,
		@deleted_at = deletedAt
	from dbo.log_action

	SELECT @table = JSON_VALUE(@jsonResult, '$.table'),
		@action = JSON_VALUE(@jsonResult, '$.action'),
		@columns = JSON_QUERY(@jsonResult, '$.columns');

	PRINT 'LOGS';
	PRINT 'Table: ' + @table;
	PRINT 'Action: ' + @action;
	PRINT 'Columns: ' + ISNULL(@columns, '');
	PRINT 'CREATED_AT: ' + CAST(@created_at as varchar);
	PRINT 'DELETED_AT: ' + CAST(@deleted_at as varchar);

END
GO

exec dbo.sp_view_log 'table';
go

select *
from dbo.log_action;