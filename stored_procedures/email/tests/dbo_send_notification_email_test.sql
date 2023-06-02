USE [db_index]
GO

EXEC dbo.SendNotificationEmail 'diogoassuncao@ipvc.pt', 'Assunto da notificação', 'Corpo da notificação';
GO