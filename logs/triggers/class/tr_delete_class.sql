-- INSERT TRIGGER COURSES
--[code] [char](4) NOT NULL,
--[title] [varchar](200) NOT NULL,
--[description] [varchar](max) NULL,
--[acronym] [varchar](10) NULL

use [index]
GO

CREATE OR ALTER TRIGGER tr_delete_class
	ON dbo.Class
	AFTER DELETE
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
	FROM deleted;

	-- Create Log of DELETED
	exec dbo.sp_add_log 3, 'user', 'Class', 'code,title,description,code_course,acronym';

	RETURN;

END
GO

DELETE FROM DBO.COURSE;

DELETE FROM DBO.Class WHERE CODE = '1005401'

INSERT into dbo.Class
    (code, title, acronym, code_course)
VALUES
    ('1005401', 'Anatomia e fisiologia animal', 'AFA', 5002);