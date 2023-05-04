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
        set [name] = @title,
        [description] = @description
    where code = @code

    commit;

end
go

