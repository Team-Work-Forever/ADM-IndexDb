USE [db_index]
GO

CREATE OR ALTER FUNCTION fn_convert_to_json_log
(
    @action int, 
    @user varchar(50), -- USER
    @table varchar(50),
    @fields varchar(max)
)
RETURNS nvarchar(max)
AS
BEGIN
    DECLARE @json nvarchar(max) = N'{"table" : "Espadas", "action" : "EXECUTE", "columns" : []}';
    DECLARE @counter int = 0;
    DECLARE @delimiter char(1) = ',';

    DECLARE @fieldTable TABLE (fieldName varchar(50));

    SELECT @json = JSON_MODIFY(@json, '$.table', @table);
    SELECT @json = JSON_MODIFY(@json, '$.action', 
        CASE @action 
            WHEN 0 THEN 'SELECT'
            WHEN 1 THEN 'INSERT'
            WHEN 2 THEN 'UPDATE'
            WHEN 3 THEN 'DELETE'
            WHEN 4 THEN 'EXECUTE'
        END
    );

    -- Get multiple fields
    INSERT INTO @fieldTable
        (fieldName)
    SELECT fieldName
    FROM dbo.split_fields(@fields, @delimiter);

    DECLARE @fieldName varchar(50);
    DECLARE @columnsArray nvarchar(max) = N'';

    DECLARE @result nvarchar(max);

    DECLARE fieldCursor CURSOR FOR SELECT fieldName
    FROM @fieldTable;

    OPEN fieldCursor;

    FETCH NEXT FROM fieldCursor INTO @fieldName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @columnsArray = @columnsArray + IIF(LEN(@columnsArray) > 0, ', ', '') + '"' + @fieldName + '"';

        SET @counter = @counter + 1;
        FETCH NEXT FROM fieldCursor INTO @fieldName;
    END

    CLOSE fieldCursor;
    DEALLOCATE fieldCursor;

    SET @json = REPLACE(@json, '[]', '[' + @columnsArray + ']');

    SET @result = @json;

    RETURN @result;
END
GO
