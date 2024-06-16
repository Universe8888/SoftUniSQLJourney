CREATE FUNCTION dbo.udf_AuthorsWithBooks (@name NVARCHAR(100))
RETURNS INT
AS
BEGIN
    DECLARE @BookCount INT;

    SELECT @BookCount = COUNT(*)
    FROM Books b
    JOIN Authors a ON b.AuthorId = a.Id
    WHERE a.Name = @name;

    RETURN @BookCount;
END;


SELECT dbo.udf_AuthorsWithBooks('J.K. Rowling');
