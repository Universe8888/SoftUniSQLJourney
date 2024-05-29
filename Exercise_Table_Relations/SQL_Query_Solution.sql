--01
CREATE TABLE Passports (
    PassportID INT PRIMARY KEY,
    PassportNumber VARCHAR(20) NOT NULL
);

CREATE TABLE Persons (
    PersonID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
    PassportID INT,
    CONSTRAINT fk_PassportID FOREIGN KEY (PassportID) REFERENCES Passports(PassportID)
);

INSERT INTO Passports (PassportID, PassportNumber)
VALUES
(101, 'N34FG21B'),
(102, 'K65L04R7'),
(103, 'ZE657QP2');

INSERT INTO Persons (PersonID, FirstName, Salary, PassportID)
VALUES
(1, 'Roberto', 43300.00, 102),
(2, 'Tom', 56100.00, 103),
(3, 'Yana', 60200.00, 101);

--02

CREATE TABLE Manufacturers (
    ManufacturerID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    EstablishedOn DATE NOT NULL
);

CREATE TABLE Models (
    ModelID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    ManufacturerID INT,
    CONSTRAINT fk_ManufacturerID FOREIGN KEY (ManufacturerID) REFERENCES Manufacturers(ManufacturerID)
);

INSERT INTO Manufacturers (ManufacturerID, Name, EstablishedOn)
VALUES
(1, 'BMW', '1916-07-03'),
(2, 'Tesla', '2003-01-01'),
(3, 'Lada', '1966-05-01');

INSERT INTO Models (ModelID, Name, ManufacturerID)
VALUES
(101, 'X1', 1),
(102, 'i6', 1),
(103, 'Model S', 2),
(104, 'Model X', 2),
(105, 'Model 3', 2),
(106, 'Nova', 3);

--3
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL
);

CREATE TABLE Exams (
    ExamID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL
);

CREATE TABLE StudentsExams (
    StudentID INT,
    ExamID INT,
    PRIMARY KEY (StudentID, ExamID),
    CONSTRAINT fk_StudentID FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    CONSTRAINT fk_ExamID FOREIGN KEY (ExamID) REFERENCES Exams(ExamID)
);

INSERT INTO Students (StudentID, Name)
VALUES
(1, 'Mila'),
(2, 'Toni'),
(3, 'Ron');

INSERT INTO Exams (ExamID, Name)
VALUES
(101, 'SpringMVC'),
(102, 'Neo4j'),
(103, 'Oracle 11g');

INSERT INTO StudentsExams (StudentID, ExamID)
VALUES
(1, 101),
(1, 102),
(2, 101),
(3, 103),
(2, 102),
(2, 103);


--4
CREATE TABLE Teachers (
    TeacherID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    ManagerID INT,
    CONSTRAINT fk_ManagerID FOREIGN KEY (ManagerID) REFERENCES Teachers(TeacherID)
);

INSERT INTO Teachers (TeacherID, Name, ManagerID)
VALUES
(101, 'John', NULL),
(102, 'Maya', 106),
(103, 'Silvia', 106),
(104, 'Ted', 105),
(105, 'Mark', 101),
(106, 'Greta', 101);

--5

CREATE TABLE Cities (
    CityID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

CREATE TABLE ItemTypes (
    ItemTypeID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Birthday DATE NOT NULL,
    CityID INT,
    CONSTRAINT fk_CityID FOREIGN KEY (CityID) REFERENCES Cities(CityID)
);

CREATE TABLE Items (
    ItemID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    ItemTypeID INT,
    CONSTRAINT fk_ItemTypeID FOREIGN KEY (ItemTypeID) REFERENCES ItemTypes(ItemTypeID)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    CONSTRAINT fk_CustomerID FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderItems (
    OrderID INT,
    ItemID INT,
    PRIMARY KEY (OrderID, ItemID),
    CONSTRAINT fk_OrderID FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT fk_ItemID FOREIGN KEY (ItemID) REFERENCES Items(ItemID)
);

--6

CREATE TABLE Majors (
    MajorID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentNumber VARCHAR(20) NOT NULL,
    StudentName VARCHAR(100) NOT NULL,
    MajorID INT,
    CONSTRAINT fk_MajorID FOREIGN KEY (MajorID) REFERENCES Majors(MajorID)
);

CREATE TABLE Subjects (
    SubjectID INT PRIMARY KEY,
    SubjectName VARCHAR(100) NOT NULL
);

CREATE TABLE Agenda (
    StudentID INT,
    SubjectID INT,
    PRIMARY KEY (StudentID, SubjectID),
    CONSTRAINT fk_StudentID_Agenda FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    CONSTRAINT fk_SubjectID_Agenda FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    PaymentDate DATE NOT NULL,
    PaymentAmount DECIMAL(10, 2) NOT NULL,
    StudentID INT,
    CONSTRAINT fk_StudentID_Payments FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);
