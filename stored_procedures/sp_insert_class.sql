-- sp to insert class
create or alter procedure sp_insert_class
    (
    @code char(4),
    @title varchar(100),
    @description varchar(MAX),
    @course_id int
)
as
begin

    begin transaction;

    insert into dbo.Class
    values
        (@code, @title, @description, @course_id)

    commit;

end
go