USE [index]
go

-- Action
-- 0 - SELECT | 1 - INSERT | 2 - UPDATE | 3 DELETE | 4 - EXECUTE
CREATE OR ALTER PROCEDURE sp_add_log
	(
	@action int,
	@user varchar(50),
	-- USER
	@table varchar(50),
	@fields varchar(max)
)
AS
BEGIN

	DECLARE @jsonResult nvarchar(max);

	SET @jsonResult = dbo.fn_convert_to_json_log(@action, @user, @table, @fields);
	print @jsonResult
	-- Use @jsonResult as needed

	INSERT INTO dbo.log_action
		(json_info)
	values
		(@jsonResult);

END
GO

exec dbo.sp_add_log 0, 'user', 'Cursos', 'index,nota,algo,ola';
go
