USE [db_index]
GO

INSERT into dbo.Course
    (code, title, acronym)
VALUES
    ('5002', 'Cuidados Veterin�rios', 'CUVE')
GO

INSERT into dbo.Class
    (code, title, acronym, code_course)
VALUES
    ('1005401', 'Anatomia e fisiologia animal', 'AFA', 5002)
GO