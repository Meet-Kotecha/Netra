-- ============================================================================
-- NETRA Platform Database Schema Script
-- Target Database: SQL Server 2016+ / MSSQLLocalDB
-- Author: Meet
-- ============================================================================

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'NetraDB')
BEGIN
    CREATE DATABASE NetraDB;
END
GO

USE NetraDB;
GO

-- ============================================================================
-- 1. USER MANAGEMENT & AUTHENTICATION
-- ============================================================================

IF OBJECT_ID('dbo.UserSessions', 'U') IS NOT NULL DROP TABLE dbo.UserSessions;
IF OBJECT_ID('dbo.CaseNotes', 'U') IS NOT NULL DROP TABLE dbo.CaseNotes;
IF OBJECT_ID('dbo.CasePersons', 'U') IS NOT NULL DROP TABLE dbo.CasePersons;
IF OBJECT_ID('dbo.PersonRelationships', 'U') IS NOT NULL DROP TABLE dbo.PersonRelationships;
IF OBJECT_ID('dbo.NotificationPreferences', 'U') IS NOT NULL DROP TABLE dbo.NotificationPreferences;
IF OBJECT_ID('dbo.UserPreferences', 'U') IS NOT NULL DROP TABLE dbo.UserPreferences;
IF OBJECT_ID('dbo.BulkDataImports', 'U') IS NOT NULL DROP TABLE dbo.BulkDataImports;
IF OBJECT_ID('dbo.AuditLogs', 'U') IS NOT NULL DROP TABLE dbo.AuditLogs;
IF OBJECT_ID('dbo.CrimeCases', 'U') IS NOT NULL DROP TABLE dbo.CrimeCases;
IF OBJECT_ID('dbo.Persons', 'U') IS NOT NULL DROP TABLE dbo.Persons;
IF OBJECT_ID('dbo.Alerts', 'U') IS NOT NULL DROP TABLE dbo.Alerts;
IF OBJECT_ID('dbo.CaseStatuses', 'U') IS NOT NULL DROP TABLE dbo.CaseStatuses;
IF OBJECT_ID('dbo.Users', 'U') IS NOT NULL DROP TABLE dbo.Users;
IF OBJECT_ID('dbo.Roles', 'U') IS NOT NULL DROP TABLE dbo.Roles;

CREATE TABLE [Roles] (
    RoleID INT IDENTITY(1,1) PRIMARY KEY,
    RoleName NVARCHAR(50) NOT NULL UNIQUE,
    Description NVARCHAR(255) NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE [Users] (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(120) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(256) NOT NULL,
    RoleID INT NOT NULL FOREIGN KEY REFERENCES [Roles](RoleID),
    Department NVARCHAR(100) DEFAULT 'Crime Intelligence Unit',
    ProfilePicturePath NVARCHAR(255) DEFAULT 'Images/Digvijay.jpeg',
    IsActive BIT DEFAULT 1,
    TwoFactorEnabled BIT DEFAULT 1,
    TwoFactorMethod NVARCHAR(50) DEFAULT 'Authenticator App',
    LastPasswordChangeDate DATETIME DEFAULT GETDATE(),
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE [UserSessions] (
    SessionID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL FOREIGN KEY REFERENCES [Users](UserID),
    DeviceName NVARCHAR(100) NOT NULL,
    Location NVARCHAR(100) DEFAULT 'Bengaluru',
    IPAddress NVARCHAR(45) NOT NULL,
    LastActive DATETIME DEFAULT GETDATE(),
    IsCurrentSession BIT DEFAULT 0,
    IsActive BIT DEFAULT 1
);

-- ============================================================================
-- 2. CRIME CASES & INCIDENTS
-- ============================================================================

CREATE TABLE [CaseStatuses] (
    StatusID INT IDENTITY(1,1) PRIMARY KEY,
    StatusName NVARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE [CrimeCases] (
    CaseID INT IDENTITY(1,1) PRIMARY KEY,
    CaseNumber NVARCHAR(50) NOT NULL UNIQUE,
    Title NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX) NULL,
    CrimeType NVARCHAR(100) NOT NULL,
    Severity NVARCHAR(20) DEFAULT 'Medium',
    StatusID INT NOT NULL FOREIGN KEY REFERENCES [CaseStatuses](StatusID),
    District NVARCHAR(100) DEFAULT 'Bengaluru Urban',
    LocationSector NVARCHAR(150) NULL,
    IncidentDate DATETIME NOT NULL,
    AssignedOfficerID INT NULL FOREIGN KEY REFERENCES [Users](UserID),
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE [CaseNotes] (
    NoteID INT IDENTITY(1,1) PRIMARY KEY,
    CaseID INT NOT NULL FOREIGN KEY REFERENCES [CrimeCases](CaseID),
    UserID INT NOT NULL FOREIGN KEY REFERENCES [Users](UserID),
    NoteText NVARCHAR(MAX) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- ============================================================================
-- 3. PERSONS DIRECTORY & NETWORK RELATIONSHIPS
-- ============================================================================

CREATE TABLE [Persons] (
    PersonID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(150) NOT NULL,
    Alias NVARCHAR(100) NULL,
    NationalID NVARCHAR(50) NULL,
    Gender NVARCHAR(20) NULL,
    DateOfBirth DATE NULL,
    RiskLevel NVARCHAR(20) DEFAULT 'Medium',
    PhotoPath NVARCHAR(255) NULL,
    LastKnownLocation NVARCHAR(150) NULL,
    Notes NVARCHAR(MAX) NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE [CasePersons] (
    CasePersonID INT IDENTITY(1,1) PRIMARY KEY,
    CaseID INT NOT NULL FOREIGN KEY REFERENCES [CrimeCases](CaseID),
    PersonID INT NOT NULL FOREIGN KEY REFERENCES [Persons](PersonID),
    RoleInCase NVARCHAR(50) DEFAULT 'Suspect',
    AddedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE [PersonRelationships] (
    RelationshipID INT IDENTITY(1,1) PRIMARY KEY,
    Person1ID INT NOT NULL FOREIGN KEY REFERENCES [Persons](PersonID),
    Person2ID INT NOT NULL FOREIGN KEY REFERENCES [Persons](PersonID),
    RelationshipType NVARCHAR(50) NOT NULL,
    StrengthScore DECIMAL(3,2) DEFAULT 0.50,
    Notes NVARCHAR(255) NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- ============================================================================
-- 4. ALERTS & NOTIFICATIONS
-- ============================================================================

CREATE TABLE [Alerts] (
    AlertID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    Message NVARCHAR(MAX) NOT NULL,
    Sector NVARCHAR(100) DEFAULT 'Sector 4, Downtown',
    Severity NVARCHAR(20) DEFAULT 'High',
    IsRead BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE [NotificationPreferences] (
    PreferenceID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL FOREIGN KEY REFERENCES [Users](UserID),
    HighRiskAreaAlerts BIT DEFAULT 1,
    UnusualActivityAlerts BIT DEFAULT 1,
    PatternDetectedAlerts BIT DEFAULT 1,
    CaseAssignedAlerts BIT DEFAULT 1,
    InAppChannel BIT DEFAULT 1,
    EmailChannel BIT DEFAULT 1,
    DesktopChannel BIT DEFAULT 0,
    EmailFrequency NVARCHAR(20) DEFAULT 'Immediately'
);

-- ============================================================================
-- 5. SYSTEM PREFERENCES & USER CONFIG
-- ============================================================================

CREATE TABLE [UserPreferences] (
    UserPrefID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL FOREIGN KEY REFERENCES [Users](UserID) UNIQUE,
    AppTheme NVARCHAR(20) DEFAULT 'dark',
    AccentColor NVARCHAR(10) DEFAULT '#00d2ff',
    DisplayDensity NVARCHAR(20) DEFAULT 'compact',
    KeepSidebarExpanded BIT DEFAULT 1,
    ShowStatusBadges BIT DEFAULT 1,
    ShowTimestamps BIT DEFAULT 1,
    DefaultDistrict NVARCHAR(100) DEFAULT 'Bengaluru Urban',
    DefaultDateRange NVARCHAR(50) DEFAULT 'Last 30 Days',
    DefaultCrimeType NVARCHAR(100) DEFAULT 'All Crime Types',
    DefaultSeverity NVARCHAR(50) DEFAULT 'All Severities',
    Language NVARCHAR(50) DEFAULT 'English',
    TimeZone NVARCHAR(50) DEFAULT 'IST (UTC+05:30)',
    DateFormat NVARCHAR(20) DEFAULT 'DD/MM/YYYY',
    TimeFormat NVARCHAR(20) DEFAULT '24-hour'
);

-- ============================================================================
-- 6. BULK DATA IMPORT & AUDIT LOGS
-- ============================================================================

CREATE TABLE [BulkDataImports] (
    ImportID INT IDENTITY(1,1) PRIMARY KEY,
    FileName NVARCHAR(255) NOT NULL,
    FileType NVARCHAR(20) NOT NULL,
    TotalRecords INT DEFAULT 0,
    SuccessfulRecords INT DEFAULT 0,
    FailedRecords INT DEFAULT 0,
    Status NVARCHAR(50) DEFAULT 'Completed',
    UploadedBy INT NOT NULL FOREIGN KEY REFERENCES [Users](UserID),
    UploadedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE [AuditLogs] (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NULL FOREIGN KEY REFERENCES [Users](UserID),
    Action NVARCHAR(100) NOT NULL,
    Module NVARCHAR(100) NOT NULL,
    IPAddress NVARCHAR(45) NULL,
    Details NVARCHAR(MAX) NULL,
    Timestamp DATETIME DEFAULT GETDATE()
);
GO

-- ============================================================================
-- SEED INITIAL DATA
-- ============================================================================

INSERT INTO [Roles] (RoleName, Description) VALUES
('Administrator', 'Full system configuration and user management privileges'),
('Intelligence Analyst', 'Standard operative access for crime analysis and case work'),
('Investigating Officer', 'Field level investigation and case updating rights');

INSERT INTO [Users] (FullName, Email, PasswordHash, RoleID, Department, ProfilePicturePath) VALUES
('Alex Silva', 'analyst@netra.gov', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 2, 'Crime Intelligence Unit', 'Images/Digvijay.jpeg');

INSERT INTO [CaseStatuses] (StatusName) VALUES 
('Active Investigation'), ('Under Review'), ('Closed'), ('Pending Ingestion');

INSERT INTO [UserPreferences] (UserID) VALUES (1);
INSERT INTO [NotificationPreferences] (UserID) VALUES (1);

INSERT INTO [UserSessions] (UserID, DeviceName, Location, IPAddress, LastActive, IsCurrentSession, IsActive) VALUES
(1, 'Windows Desktop', 'Bengaluru', '192.168.1.45', GETDATE(), 1, 1),
(1, 'Chrome Browser', 'Bengaluru', '192.168.1.102', DATEADD(HOUR, -2, GETDATE()), 0, 1);

INSERT INTO [CrimeCases] (CaseNumber, Title, Description, CrimeType, Severity, StatusID, IncidentDate, AssignedOfficerID) VALUES
('NX-2049', 'Anomalous Network Traffic Detected', 'Suspicious outbound data transfers flagged from Sector 4 server cluster.', 'Cybercrime', 'Critical', 1, GETDATE(), 1),
('CASE-892-A', 'Vehicle Theft Surge', 'Pattern of organized vehicle break-ins along Downtown area.', 'Vehicle Theft', 'High', 1, DATEADD(DAY, -2, GETDATE()), 1);

INSERT INTO [Alerts] (Title, Message, Sector, Severity) VALUES
('Unusual increase in vehicle theft detected', 'Spike reported in Sector 4, Downtown area.', 'Sector 4, Downtown', 'High'),
('Case #892-A Updated', 'Status changed to Active Investigation.', 'Sector 1, Central', 'Medium');
GO