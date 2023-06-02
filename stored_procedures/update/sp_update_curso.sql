use [db_index]
GO

-- sp to insert course
create or alter procedure sp_update_curso
    (
    @code char(4),
    @title varchar(100),
    @description varchar(MAX)
)
as
begin

    begin transaction;

    update dbo.Course
        set [title] = @title,
        [description] = @description
    where code = @code

    commit;

end
go

