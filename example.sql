select * from tb_exmp;


-- membuat view
GO
    CREATE VIEW madhai AS
    SELECT id, nama
    FROM tb_exmp
    WHERE id = 1;
GO

select * from madhai;


-- Membuat Function
GO
    create FUNCTION get_where(@id int)
    returns int
    as 
        BEGIN
            RETURN (select id from tb_exmp where id=@id)
        END  
GO

GO
    CREATE FUNCTION dbo.get_id(@id int)
    returns table
    as 
        RETURN (select * from dbo.tb_exmp where id=@id)
GO

GO
    DECLARE @id int = 1
    select dbo.get_where(@id)
GO

select * from get_id(2);

-- Membuat Prosedur
GO
    ALTER PROCEDURE selectLike @nama varchar(50)
    AS
    SELECT * FROM dbo.tb_exmp WHERE nama=@nama
GO

EXEC dbo.selectLike @nama = 'Mochammad Hairullah'

-- Select Table
GO
    CREATE FUNCTION get_table(@table int)
    returns table
    as 
        RETURN (select * from @table)
GO

-- Membuat Prosedur
GO
    ALTER PROCEDURE get_table @tbl varchar(50)
    AS
    SELECT * FROM @tbl
GO