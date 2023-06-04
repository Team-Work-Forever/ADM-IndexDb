USE [db_index]
go

CREATE OR ALTER PROCEDURE sp_view_log
AS
BEGIN

	DECLARE view_log CURSOR FOR
	SELECT
		json_info,
		createdAt,
		deletedAt
	from dbo.log_action

	DECLARE
	@jsonResult nvarchar(max),
	@created_at date,
	@deleted_at date

	OPEN view_log

	FETCH NEXT FROM view_log INTO 
    @jsonResult,
    @created_at,
    @deleted_at

	WHILE @@FETCH_STATUS = 0
	BEGIN

		DECLARE @table varchar(50) = JSON_VALUE(@jsonResult, '$.table');
		DECLARE @action varchar(50) = JSON_VALUE(@jsonResult, '$.action');
		DECLARE @columns varchar(max) = JSON_QUERY(@jsonResult, '$.columns');
		DECLARE @value nvarchar(max);

		PRINT ''
		PRINT '-------------------'
		PRINT 'Table: ' + @table
		PRINT 'Action: ' + @action
		PRINT '-------------------'
		PRINT ''
		-- PRINT 'Created At: ' + @created_at
		-- PRINT 'Delted At' + @deleted_at

		FETCH NEXT FROM view_log INTO 
       	@jsonResult,
		@created_at,
		@deleted_at

	END

	CLOSE view_log
	DEALLOCATE view_log


	RETURN;
END
GO