-- Store Procedure que verifica se tipo de informação existe recebe uma string (tipo de estatística) e @resultMessage = @message OUTPUT
CREATE OR ALTER PROCEDURE VerifyResultType
    @type VARCHAR(100),
    @resultMessage VARCHAR(200) OUTPUT
AS
BEGIN

    DECLARE @typeExists BIT;

    SELECT @typeExists = CASE WHEN EXISTS (
        SELECT 1
        FROM dbo.IndexType
        WHERE title = @type
    ) THEN 1 ELSE 0 END;

    IF @typeExists = 1
    BEGIN
        SET @resultMessage = 'Tipo de estatística encontrado.';
    END
    ELSE
    BEGIN
        SET @resultMessage = 'Tipo de estatística inexistente.';
    END;
END;
GO


-- DECLARE @message VARCHAR(200);
-- EXEC VerifyResultType 'Disciplina com mais alunos', @resultMessage = @message OUTPUT;
-- SELECT @message;