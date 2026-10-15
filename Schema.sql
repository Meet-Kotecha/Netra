-- NETRA Relational Database Schema Design (Normalized to 3NF)

CREATE TABLE Departments (
    DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(150) UNIQUE NOT NULL,
    Role VARCHAR(50) NOT NULL,
    DepartmentID INT FOREIGN KEY REFERENCES Departments(DepartmentID)
);

CREATE TABLE Districts (
    DistrictID INT IDENTITY(1,1) PRIMARY KEY,
    DistrictName VARCHAR(100) NOT NULL,
    RiskScore DECIMAL(5,2) DEFAULT 0.00
);

CREATE TABLE CrimeCases (
    CaseID INT IDENTITY(1,1) PRIMARY KEY,
    CaseNumber VARCHAR(50) UNIQUE NOT NULL,
    CrimeType VARCHAR(50) NOT NULL,
    IncidentDate DATE NOT NULL,
    Severity VARCHAR(20) CHECK (Severity IN ('Critical', 'High', 'Medium', 'Low')),
    DistrictID INT FOREIGN KEY REFERENCES Districts(DistrictID),
    Latitude DECIMAL(9,6) NULL,
    Longitude DECIMAL(9,6) NULL,
    AssignedInvestigatorID INT FOREIGN KEY REFERENCES Users(UserID)
);

CREATE TABLE Persons (
    PersonID INT IDENTITY(1,1) PRIMARY KEY,
    PersonCode VARCHAR(50) UNIQUE NOT NULL,
    FullName VARCHAR(150) NOT NULL,
    PersonType VARCHAR(30) CHECK (PersonType IN ('Suspect', 'POI', 'Witness', 'Victim')),
    KnownLocations NVARCHAR(MAX)
);

CREATE TABLE CasePersons (
    CasePersonID INT IDENTITY(1,1) PRIMARY KEY,
    CaseID INT FOREIGN KEY REFERENCES CrimeCases(CaseID),
    PersonID INT FOREIGN KEY REFERENCES Persons(PersonID),
    RoleInCase VARCHAR(50) NOT NULL
);