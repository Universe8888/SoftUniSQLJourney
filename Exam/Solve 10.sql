SELECT 
    a.Name AS Author,
    b.Title,
    l.Name AS Library,
    c.PostAddress AS LibraryAddress
FROM 
    Books b
JOIN 
    Authors a ON b.AuthorId = a.Id
JOIN 
    Genres g ON b.GenreId = g.Id
JOIN 
    LibrariesBooks lb ON b.Id = lb.BookId
JOIN 
    Libraries l ON lb.LibraryId = l.Id
JOIN 
    Contacts c ON l.ContactId = c.Id
WHERE 
    g.Name = 'Fiction'
    AND c.PostAddress LIKE '%Denver%'
ORDER BY 
    b.Title ASC;
