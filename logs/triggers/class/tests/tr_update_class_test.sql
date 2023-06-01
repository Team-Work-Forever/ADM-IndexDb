USE [db_index]
GO

UPDATE dbo.Class
	SET title = 'D.A.M.A',
	[description] = 'A dar te beijo a descar'
WHERE code = '1005402'
GO

select *
FROM dbo.Class
GO

select *
from dbo.log_action
GO

INSERT into dbo.Class
    (code, title, acronym, code_course)
VALUES
    ('1005402', 'Biologia', 'BIO', 5002)
GO

INSERT INTO DBO.Class
VALUES
    ('XXXX', 'XXXXXX', 'XXXXXXXXXXX', 'XXXXX')
GO

