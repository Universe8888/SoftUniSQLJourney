DECLARE @AuthorId INT;
SELECT @AuthorId = Id FROM Authors WHERE Name = 'Alex Michaelides';

DECLARE @Books TABLE (BookId INT);
INSERT INTO @Books (BookId)
SELECT Id FROM Books WHERE AuthorId = @AuthorId;

DELETE FROM LibrariesBooks
WHERE BookId IN (SELECT BookId FROM @Books);

DELETE FROM Books
WHERE AuthorId = @AuthorId;

DELETE FROM Authors
WHERE Id = @AuthorId;
