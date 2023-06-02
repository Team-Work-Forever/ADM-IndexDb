use [db_index]
GO

CREATE OR ALTER TRIGGER tr_update_courses
	ON dbo.Course
	AFTER UPDATE
AS
BEGIN

	DECLARE @updated_fields varchar(max);
	DECLARE @system_user varchar(100) = SYSTEM_USER;

	DECLARE @inserted_code char(4);
	DECLARE @inserted_title varchar(200);
	DECLARE @inserted_description varchar(max);
	DECLARE @inserted_acronym varchar(10);

	DECLARE @deleted_code char(4);
	DECLARE @deleted_title varchar(200);
	DECLARE @deleted_description varchar(max);
	DECLARE @deleted_acronym varchar(10);

	SELECT
		@inserted_code = code,
		@inserted_title = title,
		@inserted_description = [description],
		@inserted_acronym = acronym
	FROM inserted;

	SELECT
		@deleted_code = code,
		@deleted_title = title,
		@deleted_description = [description],
		@deleted_acronym = acronym
	FROM deleted;

	-- Verify what updates what

	IF (@deleted_title <> @inserted_title)
	BEGIN
		SELECT @updated_fields = @updated_fields + ',' + 'title'
	END

	IF (@deleted_description <> @inserted_description)
	BEGIN
		SELECT @updated_fields = @updated_fields + ',' + 'description'
	END

	IF (@deleted_code <> @inserted_code)
	BEGIN
		SELECT @updated_fields = @updated_fields + ',' + 'code'
	END

	IF (@deleted_acronym <> @inserted_acronym)
	BEGIN
		SELECT @updated_fields = @updated_fields + ',' + 'acronym'
	END

	SET @updated_fields = SUBSTRING(@updated_fields, 2, LEN(@updated_fields) - 1);

	-- Create Log of INSERT
	exec dbo.sp_add_log 1, @system_user, 'Course', @updated_fields;

	RETURN;

END
GO
