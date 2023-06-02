use [db_index]
GO

CREATE OR ALTER TRIGGER tr_delete_index_type
	ON dbo.IndexType
	AFTER DELETE
AS
BEGIN

	DECLARE @system_user varchar(100) = SYSTEM_USER;

	DECLARE @id int;
	DECLARE @title varchar(100);

	SELECT
		@id = id,
		@title = title
	FROM deleted;

	-- Create Log of DELETED
	exec dbo.sp_add_log 3, @system_user, 'IndexType', 'id,title';

	EXEC dbo.SendNotificationEmail 'diogoassuncao@ipvc.pt', 'Eliminação de uma Linha na Tabela Class_IndexType', N'';

	RETURN;

END
GO
