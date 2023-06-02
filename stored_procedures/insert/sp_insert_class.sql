USE [db_index]
GO

create or alter procedure sp_insert_class
    (
    @code char(4),
    @title varchar(100),
    @description varchar(MAX),
    @code_course char,
    @acronym varchar
)
as
begin

    begin transaction;

    insert into dbo.Class
    values
        (@code, @title, @description, @code_course, @acronym)

    commit;

end
GO