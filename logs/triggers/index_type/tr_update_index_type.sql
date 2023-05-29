-- INSERT TRIGGER COURSES
--[code] [char](4) NOT NULL,
--[title] [varchar](200) NOT NULL,
--[description] [varchar](max) NULL,
--[acronym] [varchar](10) NULL

use [index]
GO

CREATE OR ALTER TRIGGER tr_update_index_type
	ON dbo.IndexType
	AFTER UPDATE
AS
BEGIN
	
	DECLARE @id int;
	DECLARE @title varchar(100);
		
	SELECT
		@id = id,
		@title = title
	FROM deleted;

	-- Verify what updates what

	-- Create Log of INSERT
	exec dbo.sp_add_log 2, 'user', 'IndexType', 'id,title';
	RETURN;

END
GO

INSERT INTO DBO.COURSE VALUES ('XXXX', 'XXXXXX', 'XXXXXXXXXXX', 'XXXXX');