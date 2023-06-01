use [db_index]
go

DELETE FROM DBO.COURSE
go

DELETE FROM DBO.Class WHERE CODE = '1005401'
go

INSERT into dbo.Class
    (code, title, acronym, code_course)
VALUES
    ('1005401', 'Anatomia e fisiologia animal', 'AFA', 5002)
GO