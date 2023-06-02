EXEC sp_configure filestream_access_level, 2
RECONFIGURE

DBCC TRACEON(12324, -1)

alter database db_index
add filegroup FileStreamDBFS contains filestream;
go

alter database db_index
add file
  ( NAME = N'FileStreamDBFS', FILENAME = N'C:\tp_adm\DBFilestream\FileStreamDBFS' , MAXSIZE = UNLIMITED )
to filegroup FileStreamDBFS;
go

USE [db_index]
GO

CREATE TABLE [dbo].FileStreamTable
(
    [FSID] UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL UNIQUE,
    [FSDescription] VARCHAR(50),
    [FSBLOB] VARBINARY(MAX) FILESTREAM NULL
)