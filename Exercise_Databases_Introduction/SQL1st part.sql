-- Create the Minions database
CREATE DATABASE Minions;

-- Use the Minions database
USE Minions;

-- Create the Towns table first
CREATE TABLE Towns (
    Id INT PRIMARY KEY,
    Name NVARCHAR(50)
);

-- Create the Minions table
CREATE TABLE Minions (
    Id INT PRIMARY KEY,
    Name NVARCHAR(50),
    Age INT
);

-- Alter the Minions table to add the TownId column
ALTER TABLE Minions
ADD TownId INT;

-- Add the foreign key constraint to the Minions table
ALTER TABLE Minions
ADD CONSTRAINT FK_Minions_Towns
FOREIGN KEY (TownId)
REFERENCES Towns(Id);

-- Insert records into Towns table
INSERT INTO Towns (Id, Name) VALUES (1, 'Sofia');
INSERT INTO Towns (Id, Name) VALUES (2, 'Plovdiv');
INSERT INTO Towns (Id, Name) VALUES (3, 'Varna');

-- Insert records into Minions table
INSERT INTO Minions (Id, Name, Age, TownId) VALUES (1, 'Kevin', 22, 1);
INSERT INTO Minions (Id, Name, Age, TownId) VALUES (2, 'Bob', 15, 3);
INSERT INTO Minions (Id, Name, Age, TownId) VALUES (3, 'Steward', NULL, 2);

-- Task 5: Truncate Table Minions
TRUNCATE TABLE Minions;

-- Task 6: Drop All Tables
-- Drop the foreign key constraint first
ALTER TABLE Minions
DROP CONSTRAINT FK_Minions_Towns;

-- Drop the tables
DROP TABLE Minions;
DROP TABLE Towns;

-- Create the People table
CREATE TABLE People (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Picture VARBINARY(MAX),
    Height DECIMAL(5,2),
    Weight DECIMAL(5,2),
    Gender CHAR(1) CHECK (Gender IN ('m', 'f')) NOT NULL,
    Birthdate DATE NOT NULL,
    Biography NVARCHAR(MAX)
);

-- Insert records into People table
INSERT INTO People (Name, Picture, Height, Weight, Gender, Birthdate, Biography) VALUES
('John Doe', NULL, 1.80, 75.50, 'm', '1985-04-12', 'John is a software developer.'),
('Jane Smith', NULL, 1.65, 60.00, 'f', '1990-08-23', 'Jane is a graphic designer.'),
('Alice Johnson', NULL, 1.70, 65.00, 'f', '1995-03-17', 'Alice is a project manager.'),
('Bob Brown', NULL, 1.75, 70.00, 'm', '1988-12-05', 'Bob is a data analyst.'),
('Charlie Black', NULL, 1.85, 80.00, 'm', '1982-07-30', 'Charlie is a network engineer.');

USE Minions;

-- Create the Users table
CREATE TABLE Users (
    Id BIGINT IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(30) UNIQUE NOT NULL,
    Password VARCHAR(26) NOT NULL,
    ProfilePicture VARBINARY(MAX),
    LastLoginTime DATETIME,
    IsDeleted BIT
);

-- Insert records into Users table
INSERT INTO Users (Username, Password, ProfilePicture, LastLoginTime, IsDeleted) VALUES
('user1', 'pass1', NULL, '2024-05-01 12:34:56', 0),
('user2', 'pass2', NULL, '2024-05-02 13:34:56', 0),
('user3', 'pass3', NULL, '2024-05-03 14:34:56', 1),
('user4', 'pass4', NULL, '2024-05-04 15:34:56', 0),
('user5', 'pass5', NULL, '2024-05-05 16:34:56', 1);

USE Minions;

-- Drop the current primary key
ALTER TABLE Users
DROP CONSTRAINT PK__Users__3214EC073AB218D1; 

-- Add a new primary key that combines Id and Username
ALTER TABLE Users
ADD CONSTRAINT PK_Users_Id_Username PRIMARY KEY (Id, Username);

ALTER TABLE Users
ADD CONSTRAINT CHK_Users_Password_Length CHECK (LEN(Password) >= 5);

-- Task 11: Set Default Value of a Field
ALTER TABLE Users
ADD CONSTRAINT DF_Users_LastLoginTime DEFAULT GETDATE() FOR LastLoginTime;

-- Remove the composite primary key
ALTER TABLE Users
DROP CONSTRAINT PK_Users_Id_Username;

-- Add a new primary key on the Id column only
ALTER TABLE Users
ADD CONSTRAINT PK_Users_Id PRIMARY KEY (Id);

-- Add a unique constraint to the Username field
ALTER TABLE Users
ADD CONSTRAINT UQ_Users_Username UNIQUE (Username);

-- Add a check constraint to ensure Username is at least 3 characters long
ALTER TABLE Users
ADD CONSTRAINT CHK_Users_Username_Length CHECK (LEN(Username) >= 3);

USE Movies;

-- Create the Directors table
CREATE TABLE Directors (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    DirectorName NVARCHAR(100) NOT NULL,
    Notes NVARCHAR(MAX)
);

-- Create the Genres table
CREATE TABLE Genres (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    GenreName NVARCHAR(50) NOT NULL,
    Notes NVARCHAR(MAX)
);

-- Create the Categories table
CREATE TABLE Categories (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(50) NOT NULL,
    Notes NVARCHAR(MAX)
);

-- Create the Movies table
CREATE TABLE Movies (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    DirectorId INT NOT NULL,
    CopyrightYear INT CHECK (CopyrightYear > 1800 AND CopyrightYear <= YEAR(GETDATE())),
    Length INT CHECK (Length > 0), -- Length in minutes
    GenreId INT NOT NULL,
    CategoryId INT NOT NULL,
    Rating DECIMAL(3,2) CHECK (Rating >= 0 AND Rating <= 10),
    Notes NVARCHAR(MAX),
    FOREIGN KEY (DirectorId) REFERENCES Directors(Id),
    FOREIGN KEY (GenreId) REFERENCES Genres(Id),
    FOREIGN KEY (CategoryId) REFERENCES Categories(Id)
);

-- Insert records into Directors table
INSERT INTO Directors (DirectorName, Notes) VALUES
('Steven Spielberg', 'Famous for movies like Jurassic Park and E.T.'),
('Christopher Nolan', 'Known for Inception and The Dark Knight trilogy'),
('Martin Scorsese', 'Director of Goodfellas and The Irishman'),
('Quentin Tarantino', 'Famous for Pulp Fiction and Kill Bill'),
('James Cameron', 'Known for Titanic and Avatar');

-- Insert records into Genres table
INSERT INTO Genres (GenreName, Notes) VALUES
('Action', 'Movies with intense sequences'),
('Drama', 'Movies with strong emotional themes'),
('Comedy', 'Movies meant to make the audience laugh'),
('Horror', 'Movies designed to scare the audience'),
('Science Fiction', 'Movies with futuristic and scientific themes');

-- Insert records into Categories table
INSERT INTO Categories (CategoryName, Notes) VALUES
('Blockbuster', 'High-budget, high-grossing movies'),
('Indie', 'Independent films'),
('Documentary', 'Non-fictional films'),
('Animated', 'Movies using animation techniques'),
('Classic', 'Old, significant movies in film history');

-- Insert records into Movies table
INSERT INTO Movies (Title, DirectorId, CopyrightYear, Length, GenreId, CategoryId, Rating, Notes) VALUES
('Jurassic Park', 1, 1993, 127, 1, 1, 8.1, 'A groundbreaking dinosaur movie'),
('Inception', 2, 2010, 148, 5, 1, 8.8, 'A mind-bending thriller'),
('Goodfellas', 3, 1990, 146, 2, 5, 8.7, 'A classic crime drama'),
('Pulp Fiction', 4, 1994, 154, 1, 5, 8.9, 'A cult classic'),
('Avatar', 5, 2009, 162, 5, 1, 7.8, 'A visually stunning sci-fi movie');

-- Create the CarRental database
CREATE DATABASE CarRental;
USE CarRental;

-- Create the Categories table
CREATE TABLE Categories (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(50) NOT NULL,
    DailyRate DECIMAL(10,2) NOT NULL,
    WeeklyRate DECIMAL(10,2) NOT NULL,
    MonthlyRate DECIMAL(10,2) NOT NULL,
    WeekendRate DECIMAL(10,2) NOT NULL
);

-- Create the Cars table
CREATE TABLE Cars (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    PlateNumber NVARCHAR(20) NOT NULL,
    Manufacturer NVARCHAR(50) NOT NULL,
    Model NVARCHAR(50) NOT NULL,
    CarYear INT NOT NULL,
    CategoryId INT NOT NULL,
    Doors INT NOT NULL,
    Picture VARBINARY(MAX),
    Condition NVARCHAR(100),
    Available BIT NOT NULL,
    FOREIGN KEY (CategoryId) REFERENCES Categories(Id)
);

-- Create the Employees table
CREATE TABLE Employees (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Title NVARCHAR(50) NOT NULL,
    Notes NVARCHAR(MAX)
);

-- Create the Customers table
CREATE TABLE Customers (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    DriverLicenceNumber NVARCHAR(20) NOT NULL,
    FullName NVARCHAR(100) NOT NULL,
    Address NVARCHAR(200),
    City NVARCHAR(50),
    ZIPCode NVARCHAR(10),
    Notes NVARCHAR(MAX)
);

-- Create the RentalOrders table
CREATE TABLE RentalOrders (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeId INT NOT NULL,
    CustomerId INT NOT NULL,
    CarId INT NOT NULL,
    TankLevel DECIMAL(3,1) NOT NULL,
    KilometrageStart INT NOT NULL,
    KilometrageEnd INT,
    TotalKilometrage INT,
    StartDate DATE NOT NULL,
    EndDate DATE,
    TotalDays INT,
    RateApplied DECIMAL(10,2) NOT NULL,
    TaxRate DECIMAL(5,2) NOT NULL,
    OrderStatus NVARCHAR(20) NOT NULL,
    Notes NVARCHAR(MAX),
    FOREIGN KEY (EmployeeId) REFERENCES Employees(Id),
    FOREIGN KEY (CustomerId) REFERENCES Customers(Id),
    FOREIGN KEY (CarId) REFERENCES Cars(Id)
);

-- Insert records into Categories table
INSERT INTO Categories (CategoryName, DailyRate, WeeklyRate, MonthlyRate, WeekendRate) VALUES
('Economy', 25.00, 150.00, 600.00, 50.00),
('Compact', 30.00, 180.00, 720.00, 60.00),
('SUV', 50.00, 300.00, 1200.00, 100.00);

-- Insert records into Cars table
INSERT INTO Cars (PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Picture, Condition, Available) VALUES
('ABC123', 'Toyota', 'Corolla', 2018, 1, 4, NULL, 'Good', 1),
('XYZ789', 'Honda', 'Civic', 2019, 2, 4, NULL, 'Excellent', 1),
('DEF456', 'Ford', 'Explorer', 2020, 3, 5, NULL, 'Excellent', 1);

-- Insert records into Employees table
INSERT INTO Employees (FirstName, LastName, Title, Notes) VALUES
('John', 'Doe', 'Manager', 'Experienced manager with 10 years in car rental business.'),
('Jane', 'Smith', 'Sales Associate', 'Friendly and knowledgeable about cars.'),
('Bob', 'Brown', 'Mechanic', 'Skilled mechanic with expertise in various car models.');

-- Insert records into Customers table
INSERT INTO Customers (DriverLicenceNumber, FullName, Address, City, ZIPCode, Notes) VALUES
('D1234567', 'Alice Johnson', '123 Elm Street', 'Springfield', '12345', 'Regular customer.'),
('D2345678', 'Michael Smith', '456 Oak Avenue', 'Greenville', '67890', 'First-time renter.'),
('D3456789', 'Eve Davis', '789 Pine Road', 'Lakeside', '11223', 'Prefers SUVs.');

-- Insert records into RentalOrders table
INSERT INTO RentalOrders (EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, TotalKilometrage, StartDate, EndDate, TotalDays, RateApplied, TaxRate, OrderStatus, Notes) VALUES
(1, 1, 1, 1.0, 15000, 15100, 100, '2024-05-01', '2024-05-03', 2, 50.00, 7.5, 'Completed', 'Customer was very satisfied.'),
(2, 2, 2, 0.8, 20000, 20100, 100, '2024-05-05', '2024-05-07', 2, 60.00, 7.5, 'Completed', 'First rental, customer may return.'),
(3, 3, 3, 0.9, 25000, NULL, NULL, '2024-05-10', NULL, NULL, 100.00, 7.5, 'In Progress', 'Rental ongoing.');


-- Create Employees table
CREATE TABLE Employees (
    Id INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Title VARCHAR(50),
    Notes TEXT
);

-- Create Customers table
CREATE TABLE Customers (
    AccountNumber INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL,
    EmergencyName VARCHAR(50),
    EmergencyNumber VARCHAR(20),
    Notes TEXT
);

-- Create RoomStatus table
CREATE TABLE RoomStatus (
    RoomStatus VARCHAR(20) PRIMARY KEY,
    Notes TEXT
);

-- Create RoomTypes table
CREATE TABLE RoomTypes (
    RoomType VARCHAR(20) PRIMARY KEY,
    Notes TEXT
);

-- Create BedTypes table
CREATE TABLE BedTypes (
    BedType VARCHAR(20) PRIMARY KEY,
    Notes TEXT
);

-- Create Rooms table
CREATE TABLE Rooms (
    RoomNumber INT PRIMARY KEY,
    RoomType VARCHAR(20),
    BedType VARCHAR(20),
    Rate DECIMAL(10, 2),
    RoomStatus VARCHAR(20),
    Notes TEXT,
    FOREIGN KEY (RoomType) REFERENCES RoomTypes(RoomType),
    FOREIGN KEY (BedType) REFERENCES BedTypes(BedType),
    FOREIGN KEY (RoomStatus) REFERENCES RoomStatus(RoomStatus)
);

-- Create Payments table
CREATE TABLE Payments (
    Id INT PRIMARY KEY,
    EmployeeId INT,
    PaymentDate DATE,
    AccountNumber INT,
    FirstDateOccupied DATE,
    LastDateOccupied DATE,
    TotalDays INT,
    AmountCharged DECIMAL(10, 2),
    TaxRate DECIMAL(5, 2),
    TaxAmount DECIMAL(10, 2),
    PaymentTotal DECIMAL(10, 2),
    Notes TEXT,
    FOREIGN KEY (EmployeeId) REFERENCES Employees(Id),
    FOREIGN KEY (AccountNumber) REFERENCES Customers(AccountNumber)
);

-- Create Occupancies table
CREATE TABLE Occupancies (
    Id INT PRIMARY KEY,
    EmployeeId INT,
    DateOccupied DATE,
    AccountNumber INT,
    RoomNumber INT,
    RateApplied DECIMAL(10, 2),
    PhoneCharge DECIMAL(10, 2),
    Notes TEXT,
    FOREIGN KEY (EmployeeId) REFERENCES Employees(Id),
    FOREIGN KEY (AccountNumber) REFERENCES Customers(AccountNumber),
    FOREIGN KEY (RoomNumber) REFERENCES Rooms(RoomNumber)
);

-- Insert sample data into Employees table
INSERT INTO Employees (Id, FirstName, LastName, Title, Notes) VALUES
(1, 'John', 'Doe', 'Manager', 'Notes for John Doe'),
(2, 'Jane', 'Smith', 'Receptionist', 'Notes for Jane Smith'),
(3, 'Mike', 'Brown', 'Cleaner', 'Notes for Mike Brown');

-- Insert sample data into Customers table
INSERT INTO Customers (AccountNumber, FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber, Notes) VALUES
(1, 'Alice', 'Johnson', '123-456-7890', 'Bob Johnson', '098-765-4321', 'Notes for Alice Johnson'),
(2, 'Charlie', 'Lee', '234-567-8901', 'Dana Lee', '987-654-3210', 'Notes for Charlie Lee'),
(3, 'Eva', 'Davis', '345-678-9012', 'Frank Davis', '876-543-2109', 'Notes for Eva Davis');

-- Insert sample data into RoomStatus table
INSERT INTO RoomStatus (RoomStatus, Notes) VALUES
('Available', 'Room is available'),
('Occupied', 'Room is currently occupied'),
('Under Maintenance', 'Room is under maintenance');

-- Insert sample data into RoomTypes table
INSERT INTO RoomTypes (RoomType, Notes) VALUES
('Single', 'Single room'),
('Double', 'Double room'),
('Suite', 'Suite room');

-- Insert sample data into BedTypes table
INSERT INTO BedTypes (BedType, Notes) VALUES
('Single', 'Single bed'),
('Double', 'Double bed'),
('Queen', 'Queen size bed');

-- Insert sample data into Rooms table
INSERT INTO Rooms (RoomNumber, RoomType, BedType, Rate, RoomStatus, Notes) VALUES
(101, 'Single', 'Single', 100.00, 'Available', 'Room 101 notes'),
(102, 'Double', 'Double', 150.00, 'Occupied', 'Room 102 notes'),
(103, 'Suite', 'Queen', 300.00, 'Under Maintenance', 'Room 103 notes');

-- Insert sample data into Payments table
INSERT INTO Payments (Id, EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, TotalDays, AmountCharged, TaxRate, TaxAmount, PaymentTotal, Notes) VALUES
(1, 1, '2024-05-01', 1, '2024-04-25', '2024-04-30', 5, 500.00, 10.00, 50.00, 550.00, 'Payment 1 notes'),
(2, 2, '2024-05-02', 2, '2024-04-26', '2024-05-01', 5, 750.00, 10.00, 75.00, 825.00, 'Payment 2 notes'),
(3, 3, '2024-05-03', 3, '2024-04-27', '2024-05-02', 6, 1800.00, 10.00, 180.00, 1980.00, 'Payment 3 notes');

-- Insert sample data into Occupancies table
INSERT INTO Occupancies (Id, EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge, Notes) VALUES
(1, 1, '2024-04-25', 1, 101, 100.00, 10.00, 'Occupancy 1 notes'),
(2, 2, '2024-04-26', 2, 102, 150.00, 15.00, 'Occupancy 2 notes'),
(3, 3, '2024-04-27', 3, 103, 300.00, 20.00, 'Occupancy 3 notes');


