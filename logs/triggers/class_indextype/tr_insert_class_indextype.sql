-- INSERT TRIGGER COURSES
--[year] [char](6) NOT NULL,
--[id_index_type] [int] NOT NULL,
--[code_class] [char](7) NOT NULL,
--[value] [decimal](18, 2) NULL,

use [index]
GO

CREATE OR ALTER TRIGGER tr_insert_class_indextype
	ON dbo.Class_IndexType
	AFTER INSERT
AS
BEGIN
	
	DECLARE @year char(6);
	DECLARE @id_index_type int;
	DECLARE @code_class  char(7);
	DECLARE @value  decimal(18, 2);
	
	SELECT
		@year = [year],
		@id_index_type = id_index_type,
		@code_class = code_class,
		@value = [value]
	FROM inserted;

	-- Create Log of INSERT
	exec dbo.sp_add_log 1, 'user', 'Class_IndexType', 'year,id_index_type,code_class,value';

	RETURN;

END
GO

-- TEST

