-- View de rank e dense rank das melhores médias em disciplinas no diferentes anos letivos (que aparecem do mais recente para o mais antigo) utiliza partition
CREATE OR ALTER view rankMediasClass
AS
    SELECT
        ci.[year],
        c.title,
        c.acronym,
        RANK() OVER (PARTITION BY ci.[year] ORDER BY ci.value DESC) AS 'Rank',
        ci.[value],
        DENSE_RANK() OVER (PARTITION BY ci.[year] ORDER BY ci.value DESC) AS 'Dense Rank'
    FROM dbo.Class_IndexType ci
        INNER JOIN dbo.Class c ON c.code = ci.code_class
    WHERE ci.[value] IS NOT NULL AND ci.id_index_type = 1
GO

-- SELECT *
-- FROM rankMediasClass
-- ORDER BY [year] DESC;
-- GO

-- View para ver média dos cursos no ano letivo 2022/23, onde a média é superior a 9,5
CREATE OR ALTER view showPositiveAverageCourses
AS
    SELECT
        co.title,
        co.acronym,
        co.code,
        SUM(ci.value) AS totalAverageClasses,
        AVG(ci.[value]) AS AverageCourse
    FROM dbo.Class_IndexType ci
        INNER JOIN dbo.Class c
        ON c.code = ci.code_class
        INNER JOIN dbo.Course co
        ON co.code = c.code_course
    WHERE ci.id_index_type = 1 AND ci.year = 202223
    GROUP BY co.code, co.title, co.acronym
    HAVING AVG(ci.[value]) > 9.5
GO

-- SELECT *
-- FROM showPositiveAverageCourses
-- ORDER BY AverageCourse DESC
-- GO
