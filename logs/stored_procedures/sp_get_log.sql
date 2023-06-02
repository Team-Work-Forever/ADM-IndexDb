USE [db_index]
GO

CREATE OR ALTER PROCEDURE sp_get_log
    (
    @id int
)
AS
BEGIN

    declare @jsonResult nvarchar(max)

    DECLARE @table varchar(50);
    DECLARE @action varchar(50);
    DECLARE @columns varchar(max);
    DECLARE @created_at date;
    DECLARE @deleted_at date;

    SELECT @table = JSON_VALUE(@jsonResult, '$.table'),
        @action = JSON_VALUE(@jsonResult, '$.action'),
        @columns = JSON_QUERY(@jsonResult, '$.columns');

    WITH
        NEW_TABLE
        AS
        (
            SELECT id
            FROM dbo.log_action
        )
    SELECT *
    FROM NEW_TABLE

    RETURN

END
GO