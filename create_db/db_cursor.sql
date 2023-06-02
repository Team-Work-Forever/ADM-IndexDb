-- Cursor read-only que percorre todos os curso printa o código, nome e número de disciplinas
DECLARE infoCurso CURSOR READ_ONLY
FOR
SELECT
    c.code,
    c.title,
    COUNT(cl.code) AS Num_Disciplinas
FROM dbo.Course c
    LEFT JOIN dbo.Class cl ON c.code = cl.code_course
GROUP BY c.code, c.title

DECLARE
    @code CHAR(4),
    @title VARCHAR(200),
    @num_disciplinas INT;

OPEN infoCurso

FETCH NEXT FROM infoCurso INTO 
    @code, 
    @title,
    @num_disciplinas

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Código: ' + @code
    PRINT 'Nome: ' + @title
    PRINT 'Número de Disciplinas: ' + CAST(@num_disciplinas AS VARCHAR(10))

    FETCH NEXT FROM infoCurso INTO 
        @code, 
        @title, 
        @num_disciplinas
END

CLOSE infoCurso
DEALLOCATE infoCurso
GO

-- Cursor que altera a descrição de todas as disciplinas para nomeDoCurso - Acrónimo
DECLARE cursorDisciplina CURSOR FOR
SELECT
    cl.code,
    cl.description,
    cr.title AS course_title,
    cr.acronym AS course_acronym
FROM dbo.Class cl
    INNER JOIN dbo.Course cr ON cl.code_course = cr.code

DECLARE
    @code CHAR(7),
    @description VARCHAR(MAX),
    @course_title VARCHAR(200),
    @course_acronym VARCHAR(200)

OPEN cursorDisciplina

FETCH NEXT FROM cursorDisciplina INTO 
    @code,
    @description,
    @course_title,
    @course_acronym

WHILE @@FETCH_STATUS = 0
BEGIN

    DECLARE @newDescription VARCHAR(MAX)
    SET @newDescription = @course_title + ' - ' + @course_acronym


    UPDATE dbo.Class
    SET description = @newDescription
    WHERE code = @code

    FETCH NEXT FROM cursorDisciplina INTO 
        @code, 
        @description,
        @course_title,
        @course_acronym
END

CLOSE cursorDisciplina
DEALLOCATE cursorDisciplina
