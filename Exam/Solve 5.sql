SELECT 
    Title AS BookTitle,
    ISBN,
    YearPublished AS YearReleased
FROM 
    Books
ORDER BY 
    YearPublished DESC,
    Title ASC;
