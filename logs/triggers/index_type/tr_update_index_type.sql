use [db_index]
GO

CREATE OR ALTER TRIGGER tr_update_index_type
	ON dbo.IndexType
	AFTER UPDATE
AS
BEGIN

	DECLARE @updated_fields varchar(max);
	DECLARE @system_user varchar(100) = SYSTEM_USER;

	DECLARE @inserted_id int;
	DECLARE @inserted_title varchar(100);

	DECLARE @deleted_id int;
	DECLARE @deleted_title varchar(100);

	SELECT
		@inserted_id = id,
		@inserted_title = title
	FROM inserted;

	SELECT
		@deleted_id = id,
		@deleted_title = title
	FROM deleted;

	-- Verify what updates what

	IF (@deleted_id <> @inserted_id)
	BEGIN
		SELECT @updated_fields = @updated_fields + ',' + 'id'
	END

	IF (@deleted_title <> @inserted_title)
	BEGIN
		SELECT @updated_fields = @updated_fields + ',' + 'title'
	END

	SET @updated_fields = SUBSTRING(@updated_fields, 2, LEN(@updated_fields) - 1);

	-- Create Log of INSERT
	exec dbo.sp_add_log 2, @system_user, 'IndexType', @updated_fields;
	RETURN;

END
GO
