use [db_index]
GO

CREATE OR ALTER TRIGGER tr_update_class
	ON dbo.Class
	AFTER UPDATE
AS
BEGIN

	DECLARE @updated_fields varchar(100) = '';
	DECLARE @system_user varchar(100) = SYSTEM_USER;

	DECLARE @inserted_code char(7);
	DECLARE @inserted_title varchar(200);
	DECLARE @inserted_description varchar(max);
	DECLARE @inserted_code_course char(4);
	DECLARE @inserted_acronym varchar(10);

	DECLARE @deleted_code char(7);
	DECLARE @deleted_title varchar(200);
	DECLARE @deleted_description varchar(max);
	DECLARE @deleted_code_course char(4);
	DECLARE @deleted_acronym varchar(10);

	SELECT
		@inserted_code = code,
		@inserted_title = title,
		@inserted_description = [description],
		@inserted_code_course = code_course,
		@inserted_acronym = acronym
	FROM inserted;

	SELECT
		@deleted_code = code,
		@deleted_title = title,
		@deleted_description = [description],
		@deleted_code_course = code_course,
		@deleted_acronym = acronym
	FROM deleted;

	-- Verify what updates what
	IF (@deleted_code <> @inserted_code)
	BEGIN
		SELECT @updated_fields = @updated_fields + ',' + 'code'
	END

	IF (@deleted_acronym <> @inserted_acronym)
	BEGIN
		SET @updated_fields = @updated_fields + ',' + 'acronym'
	END

	IF (@deleted_title <> @inserted_title)
	BEGIN
		SET @updated_fields = @updated_fields + ',' + 'title'
	END

	IF (@deleted_description <> @inserted_description)
	BEGIN
		SET @updated_fields = @updated_fields + ',' + 'description'
	END

	IF (@deleted_code_course <> @inserted_code_course)
	BEGIN
		SET @updated_fields = @updated_fields + ',' + 'code_course'
	END

	IF (LEN(@updated_fields) > 0)  -- Check if @updated_fields is not empty
	BEGIN
		SET @updated_fields = SUBSTRING(@updated_fields, 2, LEN(@updated_fields) - 1);
	END

	-- Create Log of INSERT
	exec dbo.sp_add_log 2, @system_user, 'Class', @updated_fields;

	RETURN;

END
GO
