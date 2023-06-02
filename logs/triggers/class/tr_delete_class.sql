use [db_index]
GO

CREATE OR ALTER TRIGGER tr_delete_class
	ON dbo.Class
	AFTER DELETE
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
		@description = [description],
		@code_course = code_course,
		@acronym = acronym
	FROM deleted;

	-- Create Log of DELETED
	exec dbo.sp_add_log 3, @system_user, 'Class', 'code,title,description,code_course,acronym';

	EXEC dbo.SendNotificationEmail 'diogoassuncao@ipvc.pt', 'Eliminação de uma Linha na Tabela Class_IndexType', N'';

	RETURN;

END
GO
