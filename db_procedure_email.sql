CREATE OR ALTER PROCEDURE dbo.SendNotificationEmail
    @RecipientEmail NVARCHAR(100),
    @Subject NVARCHAR(100),
    @Body NVARCHAR(MAX)
AS
BEGIN
    DECLARE @MailSubject NVARCHAR(200) = @Subject;
    DECLARE @MailBody NVARCHAR(MAX) = @Body;

    EXEC msdb.dbo.sp_send_dbmail
        @profile_name = 'SQL Server Agent Profile',
        @recipients = @RecipientEmail,
        @subject = @MailSubject,
        @body = @MailBody;
END;



EXEC dbo.SendNotificationEmail 'davidbraga@ipvc.pt', 'Assunto da notificação', 'Corpo da notificação';
