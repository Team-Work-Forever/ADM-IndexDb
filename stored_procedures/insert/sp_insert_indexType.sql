USE [db_index]
GO

-- insert into indexType
create or alter procedure sp_insert_indexType
    (
    @id int,
    @title varchar(100)
)
as
begin

    begin transaction;

    insert into dbo.Class_IndexType
    values
        (@id, @title)

    commit;

end
go
