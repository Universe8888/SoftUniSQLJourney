-- Create the SoftUni database
CREATE DATABASE SoftUni;
GO

-- Switch to the SoftUni database
USE SoftUni;
GO

-- Create Towns table
CREATE TABLE Towns (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

-- Create Addresses table
CREATE TABLE Addresses (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    AddressText VARCHAR(255) NOT NULL,
    TownId INT,
    FOREIGN KEY (TownId) REFERENCES Towns(Id)
);

-- Create Departments table
CREATE TABLE Departments (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

-- Create Employees table
CREATE TABLE Employees (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    MiddleName VARCHAR(50),
    LastName VARCHAR(50) NOT NULL,
    JobTitle VARCHAR(50) NOT NULL,
    DepartmentId INT,
    HireDate DATE NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
    AddressId INT,
    FOREIGN KEY (DepartmentId) REFERENCES Departments(Id),
    FOREIGN KEY (AddressId) REFERENCES Addresses(Id)
);

-- Insert sample data into Towns table
INSERT INTO Towns (Name) VALUES
('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas');

-- Insert sample data into Departments table
INSERT INTO Departments (Name) VALUES
('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance');

-- Insert sample data into Employees table
INSERT INTO Employees (FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary, AddressId) VALUES
('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 
    (SELECT Id FROM Departments WHERE Name = 'Software Development'), 
    '2013-02-01', 3500.00, NULL),
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 
    (SELECT Id FROM Departments WHERE Name = 'Engineering'), 
    '2004-03-02', 4000.00, NULL),
('Maria', 'Petrova', 'Ivanova', 'Intern', 
    (SELECT Id FROM Departments WHERE Name = 'Quality Assurance'), 
    '2016-08-28', 525.25, NULL),
('Georgi', 'Teziev', 'Ivanov', 'CEO', 
    (SELECT Id FROM Departments WHERE Name = 'Sales'), 
    '2007-12-09', 3000.00, NULL),
('Peter', 'Pan', 'Pan', 'Intern', 
    (SELECT Id FROM Departments WHERE Name = 'Marketing'), 
    '2016-08-28', 599.88, NULL);
