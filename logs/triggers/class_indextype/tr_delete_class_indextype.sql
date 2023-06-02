use [db_index]
GO

CREATE OR ALTER TRIGGER tr_delete_class_indextype
	ON dbo.Class_IndexType
	AFTER DELETE
AS
BEGIN

	DECLARE @system_user varchar(100) = SYSTEM_USER;

	DECLARE @year char(6);
	DECLARE @id_index_type int;
	DECLARE @code_class  char(7);
	DECLARE @value  decimal(18, 2);

	SELECT
		@year = [year],
		@id_index_type = id_index_type,
		@code_class = code_class,
		@value = [value]
	FROM deleted;

	-- Create Log of DELETED
	exec dbo.sp_add_log 3, @system_user, 'Class_IndexType', 'year,id_index_type,code_class,value';

	EXEC dbo.SendNotificationEmail 'diogoassuncao@ipvc.pt', 'Eliminação de uma Linha na Tabela Class_IndexType', N'';

	RETURN;

END
GO
