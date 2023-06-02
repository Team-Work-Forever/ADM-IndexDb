USE [db_index]
GO

-- sp to insert into class_indexType
create or alter procedure sp_insert_class_index
    (
    @year char(5),
    @code_class char(7),
    @id_index_type int,
    @value decimal(18,2)
)
as
begin

    begin transaction;

    insert into dbo.Class_IndexType
    values
        (@year, @id_index_type, @code_class, @value)

    commit;

end
GO