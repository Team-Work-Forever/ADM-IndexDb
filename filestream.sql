USE [db_index]
GO

CREATE OR ALTER PROCEDURE InsertFileStreamData
    @FSDescription varchar(50),
    @FSBLOB varchar(max)
AS
BEGIN
    INSERT INTO [dbo].[FileStreamTable]
        ([FSID], [FSDescription], [FSBLOB])
    VALUES
        (NEWID(), @FSDescription, CONVERT(varbinary(max), @FSBLOB));
END
GO


EXEC InsertFileStreamData 'Descrição do arquivo', 'Arquivo BLOB';
