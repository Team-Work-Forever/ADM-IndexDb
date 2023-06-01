use [db_index]
GO

CREATE OR ALTER TRIGGER tr_insert_index_type
	ON dbo.IndexType
	AFTER INSERT
AS
BEGIN

	DECLARE @system_user varchar(100) = SYSTEM_USER;

	DECLARE @id int;
	DECLARE @title varchar(100);

	SELECT
		@id = id,
		@title = title
	FROM inserted;

	-- Create Log of INSERT
	exec dbo.sp_add_log 1, @system_user, 'IndexType', 'id,title';

	RETURN;

END
GO
