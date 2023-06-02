USE [db_index]
GO

CREATE OR ALTER PROCEDURE InsertFileStreamData
    @FSDescription varchar(50),
    @FSBLOB varchar(max)
AS
BEGIN

    BEGIN TRANSACTION;

    INSERT INTO [dbo].[FileStreamTable]
        ([FSID], [FSDescription], [FSBLOB])
    VALUES
        (NEWID(), @FSDescription, CONVERT(varbinary(max), @FSBLOB));

    EXEC dbo.SendNotificationEmail 'diogoassuncao@ipvc.pt', 'Criação de um novo ficheiro', @FSDescription;

    COMMIT;

END
GO
