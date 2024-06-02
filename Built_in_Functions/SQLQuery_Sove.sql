--01
SELECT FirstName, LastName
FROM Employees
WHERE FirstName LIKE 'Sa%';

--02
SELECT FirstName, LastName
FROM Employees
WHERE LastName LIKE '%ei%';

--03
SELECT FirstName
FROM Employees
WHERE (DepartmentID = 3 OR DepartmentID = 10)
  AND YEAR(HireDate) BETWEEN 1995 AND 2005;

--04
SELECT FirstName, LastName
FROM Employees
WHERE JobTitle NOT LIKE '%engineer%';

--05
SELECT Name
FROM Towns
WHERE LEN(Name) IN (5, 6)
ORDER BY Name;

--06
SELECT TownID, Name
FROM Towns
WHERE Name LIKE 'M%' 
   OR Name LIKE 'K%' 
   OR Name LIKE 'B%' 
   OR Name LIKE 'E%'
ORDER BY Name;

--07
SELECT TownID, Name
FROM Towns
WHERE Name NOT LIKE 'R%' 
  AND Name NOT LIKE 'B%' 
  AND Name NOT LIKE 'D%'
ORDER BY Name;

--08
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName, LastName
FROM Employees
WHERE YEAR(HireDate) > 2000;
SELECT * FROM V_EmployeesHiredAfter2000;

--09
SELECT FirstName, LastName
FROM Employees
WHERE LEN(LastName) = 5;

--10
SELECT 
    EmployeeID, 
    FirstName, 
    LastName, 
    Salary,
    DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS Rank
FROM Employees
WHERE Salary BETWEEN 10000 AND 50000
ORDER BY Salary DESC;

--11
WITH RankedEmployees AS (
    SELECT 
        EmployeeID, 
        FirstName, 
        LastName, 
        Salary,
        DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS Rank
    FROM Employees
    WHERE Salary BETWEEN 10000 AND 50000
)
SELECT 
    EmployeeID, 
    FirstName, 
    LastName, 
    Salary,
    Rank
FROM RankedEmployees
WHERE Rank = 2
ORDER BY Salary DESC;

--12
USE Geography
GO

SELECT CountryName, IsoCode
FROM Countries
WHERE LEN(CountryName) - LEN(REPLACE(UPPER(CountryName), 'A', '')) >= 3
ORDER BY IsoCode;

--13
SELECT 
    Peaks.PeakName,
    Rivers.RiverName,
    LOWER(Peaks.PeakName + Rivers.RiverName) AS Mix
FROM 
    Peaks
JOIN 
    Rivers 
ON 
    RIGHT(Peaks.PeakName, 1) = LEFT(Rivers.RiverName, 1)
ORDER BY 
    Mix;

--14
USE [Diablo]
GO

SELECT TOP 50 
    [Name], 
    CONVERT(VARCHAR, [Start], 23) AS [Start]
FROM 
    [dbo].[Games]
WHERE 
    YEAR([Start]) IN (2011, 2012)
ORDER BY 
    [Start] ASC, 
    [Name] ASC;

--15
SELECT 
    [Username], 
    SUBSTRING([Email], CHARINDEX('@', [Email]) + 1, LEN([Email])) AS [Email Provider]
FROM 
    [dbo].[Users]
ORDER BY 
    [Email Provider] ASC, 
    [Username] ASC;

--16
SELECT 
    [Username], 
    [IPAddress]
FROM 
    [dbo].[Users]
WHERE 
    [IPAddress] LIKE '[0-9][0-9][0-9].1%.%.%'
ORDER BY 
    [Username] ASC;

--17
SELECT 
    [Name] AS [Game],
    CASE 
        WHEN DATEPART(HOUR, [Start]) >= 0 AND DATEPART(HOUR, [Start]) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, [Start]) >= 12 AND DATEPART(HOUR, [Start]) < 18 THEN 'Afternoon'
        WHEN DATEPART(HOUR, [Start]) >= 18 AND DATEPART(HOUR, [Start]) < 24 THEN 'Evening'
    END AS [Part of the Day],
    CASE 
        WHEN [Duration] IS NULL THEN 'Extra Long'
        WHEN [Duration] <= 3 THEN 'Extra Short'
        WHEN [Duration] > 3 AND [Duration] <= 6 THEN 'Short'
        WHEN [Duration] > 6 THEN 'Long'
    END AS [Duration]
FROM 
    [dbo].[Games]
ORDER BY 
    [Name] ASC,
    [Duration] ASC,
    [Part of the Day] ASC;