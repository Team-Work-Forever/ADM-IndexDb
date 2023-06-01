use [db_index]

GO

CREATE OR ALTER TRIGGER tr_update_class_indextype
	ON dbo.Class_IndexType
	AFTER UPDATE
AS
BEGIN

	DECLARE @updated_fields varchar(max);
	DECLARE @system_user varchar(100) = SYSTEM_USER;

	DECLARE @inserted_year char(6);
	DECLARE @inserted_id_index_type int;
	DECLARE @inserted_code_class  char(7);
	DECLARE @inserted_value  decimal(18, 2);

	DECLARE @deleted_year char(6);
	DECLARE @deleted_id_index_type int;
	DECLARE @deleted_code_class  char(7);
	DECLARE @deleted_value  decimal(18, 2);

	SELECT
		@inserted_year = [year],
		@inserted_id_index_type = id_index_type,
		@inserted_code_class = code_class,
		@inserted_value = [value]
	FROM inserted;

	SELECT
		@deleted_year = [year],
		@deleted_id_index_type = id_index_type,
		@deleted_code_class = code_class,
		@deleted_value = [value]
	FROM deleted;

	-- Verify what updates what
	IF (@deleted_id_index_type <> @inserted_id_index_type)
	BEGIN
		SELECT @updated_fields = @updated_fields + ',' + 'id_index_type'
	END

	IF (@deleted_value <> @inserted_value)
	BEGIN
		SET @updated_fields = @updated_fields + ',' + 'value'
	END

	IF (@deleted_year <> @inserted_year)
	BEGIN
		SET @updated_fields = @updated_fields + ',' + 'year'
	END

	IF (@deleted_code_class <> @inserted_code_class)
	BEGIN
		SET @updated_fields = @updated_fields + ',' + 'code_class'
	END

	SET @updated_fields = SUBSTRING(@updated_fields, 2, LEN(@updated_fields) - 1);

	-- Create Log of INSERT
	exec dbo.sp_add_log 2, @system_user, 'Class_IndexType', @updated_fields;

	RETURN;

END
GO
