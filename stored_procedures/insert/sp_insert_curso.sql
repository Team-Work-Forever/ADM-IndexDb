USE [db_index]
GO

-- sp to insert course
create or alter procedure sp_insert_course
    (
    @code char(4),
    @title varchar(100),
    @description varchar(MAX),
    @acronym varchar(15)
)
as
begin

    begin transaction;

    insert into dbo.Course
    values
        (@code, @title, @description, @acronym)

    commit;

end
go

