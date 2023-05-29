-- INSERT TRIGGER COURSES
--[code] [char](4) NOT NULL,
--[title] [varchar](200) NOT NULL,
--[description] [varchar](max) NULL,
--[acronym] [varchar](10) NULL

use [index]
GO

CREATE OR ALTER TRIGGER tr_update_courses
	ON dbo.Course
	AFTER UPDATE
AS
BEGIN
	
	DECLARE @code char(4);
	DECLARE @title varchar(200);
	DECLARE @description varchar(max);
	DECLARE @acronym varchar(10);
		
	SELECT
		@code = code,
		@title = title,
		@description = description,
		@acronym = acronym
	FROM inserted;

	-- Verify what updates what

	-- Create Log of INSERT
	exec dbo.sp_add_log 1, 'user', 'Course', 'code,title,description,acronym';

	RETURN;

END
GO

INSERT INTO DBO.COURSE VALUES ('XXXX', 'XXXXXX', 'XXXXXXXXXXX', 'XXXXX');