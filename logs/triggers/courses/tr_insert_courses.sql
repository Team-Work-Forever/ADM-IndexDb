use [db_index]
GO

CREATE OR ALTER TRIGGER tr_insert_courses
	ON dbo.Course
	AFTER INSERT
AS
BEGIN

	DECLARE @system_user varchar(100) = SYSTEM_USER;

	DECLARE @code char(4);
	DECLARE @title varchar(200);
	DECLARE @description varchar(max);
	DECLARE @acronym varchar(10);

	SELECT
		@code = code,
		@title = title,
		@description = description,
		@acronym = acronym
	FROM inserted;

	-- Create Log of INSERT
	exec dbo.sp_add_log 1, @system_user, 'Course', 'code,title,description,acronym';

	RETURN;

END
GO