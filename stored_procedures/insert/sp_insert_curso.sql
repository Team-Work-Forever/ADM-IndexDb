-- sp to insert course
create or alter procedure sp_insert_curso
    (
    @code char(4),
    @title varchar(100),
    @description varchar(MAX)
)
as
begin

    begin transaction;

    insert into dbo.Course
    values
        (@code, @title, @description)

    commit;

end
go

