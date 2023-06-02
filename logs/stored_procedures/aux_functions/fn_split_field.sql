use [db_index]
GO

CREATE OR ALTER FUNCTION dbo.split_fields
(
    @fields VARCHAR(MAX),
    @delimiter CHAR(1)
)
RETURNS TABLE
AS
RETURN
(
    WITH
    FieldTable
    AS
    (
                    SELECT
                CASE
                WHEN CHARINDEX(@delimiter, @fields) = 0 THEN @fields
                ELSE SUBSTRING(@fields, 1, CHARINDEX(@delimiter, @fields) - 1)
            END AS fieldName,
                CASE
                WHEN CHARINDEX(@delimiter, @fields) = 0 THEN ''
                ELSE SUBSTRING(@fields, CHARINDEX(@delimiter, @fields) + 1, LEN(@fields))
            END AS remainingFields
        UNION ALL
            SELECT
                CASE
                WHEN CHARINDEX(@delimiter, remainingFields) = 0 THEN remainingFields
                ELSE SUBSTRING(remainingFields, 1, CHARINDEX(@delimiter, remainingFields) - 1)
            END,
                CASE
                WHEN CHARINDEX(@delimiter, remainingFields) = 0 THEN ''
                ELSE SUBSTRING(remainingFields, CHARINDEX(@delimiter, remainingFields) + 1, LEN(remainingFields))
            END
            FROM FieldTable
            WHERE LEN(remainingFields) > 0
    )
    SELECT fieldName
FROM FieldTable
);
go

select fieldName
from dbo.split_fields('name,age,address', ',')