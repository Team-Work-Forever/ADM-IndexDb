-- Trigger que verifica se o código do curso existe na tabela Course e se não cancela insert da Class
CREATE OR ALTER TRIGGER ValidateClassInsert
ON dbo.Class
AFTER INSERT
AS
BEGIN
    IF NOT EXISTS (
        SELECT 1
    FROM dbo.Course c
        INNER JOIN inserted i ON c.code = i.code_course
    )
    BEGIN
        RAISERROR ('Código do curso inválido.',16, 1);
        ROLLBACK;
        RETURN;
    END;
END;



-- Experimentar
-- INSERT into dbo.Class
--     (code, title, acronym, code_course)
-- VALUES
--     ('23435', 'Matemática Aplicada', 'MATAP', 110)

-- delete from dbo.Class where code = '23435'

-- select *
-- from dbo.Class
-- where code = '23435'