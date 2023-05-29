-- INSERT TRIGGER COURSES
--[code] [char](4) NOT NULL,
--[title] [varchar](200) NOT NULL,
--[description] [varchar](max) NULL,
--[acronym] [varchar](10) NULL

use [index]
GO

CREATE OR ALTER TRIGGER tr_update_class
	ON dbo.Class
	AFTER UPDATE
AS
BEGIN
	
	DECLARE @code char(7);
	DECLARE @title varchar(200);
	DECLARE @description varchar(max);
	DECLARE @code_course char(4);
	DECLARE @acronym varchar(10);
		
	SELECT
		@code = code,
		@title = title,
		@description = description,
		@code_course = code_course,
		@acronym = acronym
	FROM inserted;

	-- Verify what updates what

	-- Create Log of INSERT
	exec dbo.sp_add_log 2, 'user', 'Class', 'code,title,description,code_course,acronym';
	RETURN;

END
GO

INSERT INTO DBO.COURSE VALUES ('XXXX', 'XXXXXX', 'XXXXXXXXXXX', 'XXXXX');