CREATE TABLE [dbo].FileStreamTable
(
    [FSID] UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL UNIQUE,
    [FSDescription] VARCHAR(50),
    [FSBLOB] VARBINARY(MAX) FILESTREAM NULL
)