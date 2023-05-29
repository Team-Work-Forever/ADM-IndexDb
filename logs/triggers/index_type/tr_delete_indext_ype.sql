-- INSERT TRIGGER COURSES
--[code] [char](4) NOT NULL,
--[title] [varchar](200) NOT NULL,
--[description] [varchar](max) NULL,
--[acronym] [varchar](10) NULL

use [index]
GO

CREATE OR ALTER TRIGGER tr_delete_index_type
	ON dbo.IndexType
	AFTER DELETE
AS
BEGIN
	
	
	DECLARE @id int;
	DECLARE @title varchar(100);
		
	SELECT
		@id = id,
		@title = title
	FROM deleted;

	-- Create Log of DELETED
	exec dbo.sp_add_log 3, 'user', 'IndexType', 'id,title';

	RETURN;

END
GO

-- TEST
