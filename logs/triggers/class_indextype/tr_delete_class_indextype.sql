-- INSERT TRIGGER COURSES
--[code] [char](4) NOT NULL,
--[title] [varchar](200) NOT NULL,
--[description] [varchar](max) NULL,
--[acronym] [varchar](10) NULL

use [index]
GO

CREATE OR ALTER TRIGGER tr_delete_class_indextype
	ON dbo.Class_IndexType
	AFTER DELETE
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
	FROM deleted;


	-- Create Log of DELETED
	exec dbo.sp_add_log 3, 'user', 'Class_IndexType', 'year,id_index_type,code_class,value';

	RETURN;

END
GO

-- TEST

DELETE FROM DBO.COURSE;

DELETE FROM DBO.Class WHERE CODE = '1005401'
