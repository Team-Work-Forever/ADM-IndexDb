-- sp to insert class
create or alter procedure sp_update_class
    (
    @code char(4),
    @title varchar(100),
    @description varchar(MAX),
    @course_id int
)
as
begin

    begin transaction;

    update dbo.Class
        set [name] = @title,
        [description] = @description
    where code_course = @course_id

    commit;

end
go