use [db_index]
GO

CREATE OR ALTER TRIGGER tr_insert_class
	ON dbo.Class
	AFTER INSERT
AS
BEGIN

	DECLARE @system_user varchar(100) = SYSTEM_USER;

	DECLARE @code char(7);
	DECLARE @title varchar(200);
	DECLARE @description varchar(max);
	DECLARE @code_course char(4);
	DECLARE @acronym varchar(10);

	SELECT
		@code = code,
		@title = title,
		@description = description,
		@code_course = code_course,
		@acronym = acronym
	FROM inserted;

	-- Create Log of INSERT
	exec dbo.sp_add_log 1, @system_user, 'Class', 'code,title,description,code_course,acronym';

	RETURN;

END
GO