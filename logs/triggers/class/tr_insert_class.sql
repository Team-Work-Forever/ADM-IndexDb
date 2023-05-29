-- INSERT TRIGGER COURSES
--[code] [char](7) NOT NULL,
--[title] [varchar](200) NOT NULL,
--[description] [varchar](max) NULL,
--[code_course] [char](4) NOT NULL,
--[acronym] [varchar](10) NULL,

use [index]
GO

CREATE OR ALTER TRIGGER tr_insert_class
	ON dbo.Class
	AFTER INSERT
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

	-- Create Log of INSERT
	exec dbo.sp_add_log 1, 'user', 'Class', 'code,title,description,code_course,acronym';

	RETURN;

END
GO

-- TEST

INSERT into dbo.Course
    (code, title, acronym)
VALUES
    ('5002', 'Cuidados Veterinários', 'CUVE');

INSERT into dbo.Class
    (code, title, acronym, code_course)
VALUES
    ('1005401', 'Anatomia e fisiologia animal', 'AFA', 5002);