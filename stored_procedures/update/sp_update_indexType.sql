-- update indexType
create or alter procedure sp_update_indexType
    (
    @id int,
    @title varchar(100)
)
as
begin

    begin transaction;

    update dbo.IndexType
        set [name] = @title
    where id = @id

    commit;

end
go
