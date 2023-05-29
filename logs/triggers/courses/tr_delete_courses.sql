-- INSERT TRIGGER COURSES
--[code] [char](4) NOT NULL,
--[title] [varchar](200) NOT NULL,
--[description] [varchar](max) NULL,
--[acronym] [varchar](10) NULL

use [index]
GO

CREATE OR ALTER TRIGGER tr_delete_courses
	ON dbo.Course
	AFTER DELETE
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
	FROM deleted;

	-- Create Log of DELETED
	exec dbo.sp_add_log 3, 'user', 'Course', 'code,title,description,acronym';

	RETURN;

END
GO

DELETE FROM DBO.COURSE;