-- sp to update into class_indexType
create or alter procedure sp_update_class_index
    (
    @year char(5),
    @code_class char(7),
    @id_index_type int,
    @value decimal(18,2)
)
as
begin

    begin transaction;

    update dbo.Class_IndexType
        set [year] = @year,
        code_class = @code_class,
        [value] = @value
    where id_index_type = @id_index_type

    commit;

end
go