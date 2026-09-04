
-- RaceDay Database - Section C SQL Script

CREATE DATABASE RaceDayDB;
GO
USE RaceDayDB;
GO

-- CREATING TABLES
-- 1. ORGANISER TABLE
CREATE TABLE Organiser (
OrganiserId VARCHAR(20) NOT NULL PRIMARY KEY,
FullName VARCHAR(100) NOT NULL,
Email VARCHAR(100) NOT NULL UNIQUE,
PasswordHash VARCHAR(255) NOT NULL
);

-- 2. PARTICIPANT TABLE
CREATE TABLE Participant (
ParticipantId VARCHAR(20) NOT NULL PRIMARY KEY,
FullName VARCHAR(100) NOT NULL,
Email VARCHAR(100) NOT NULL UNIQUE,
PasswordHash VARCHAR(255) NOT NULL,
DateOfBirth DATE NOT NULL,
Gender VARCHAR(20) NULL
);

-- 3. EVENT TABLE
CREATE TABLE Event (
EventId INT IDENTITY(1,1) PRIMARY KEY,
OrganiserId VARCHAR(20) NOT NULL,
EventName VARCHAR(150) NOT NULL,
Description VARCHAR(500) NULL,
EventDate DATE NOT NULL,
Location VARCHAR(150) NOT NULL,
EventType VARCHAR(20) NOT NULL DEFAULT 'Run'
CHECK (EventType IN ('Run', 'Walk', 'Cycle')),
CONSTRAINT FK_Event_Organiser FOREIGN KEY (OrganiserId) REFERENCES Organiser(OrganiserId)
);

-- 4. CATEGORY TABLE
CREATE TABLE Category (
CategoryId INT IDENTITY(1,1) PRIMARY KEY,
EventId INT NOT NULL,
CategoryName VARCHAR(100) NOT NULL,
Distance DECIMAL(6,2) NOT NULL,
CONSTRAINT FK_Category_Event FOREIGN KEY (EventId) REFERENCES Event(EventId)
);

-- 5. ROUTE TABLE
CREATE TABLE Route (
RouteId INT IDENTITY(1,1) PRIMARY KEY,
CategoryId INT NOT NULL,
MapFileUrl VARCHAR(255) NOT NULL,
CONSTRAINT FK_Route_Category FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId)
);

-- 6. ENROLMENT TABLE
CREATE TABLE Enrolment (
EnrolmentId INT IDENTITY(1,1) PRIMARY KEY,
ParticipantId VARCHAR(20) NOT NULL,
CategoryId INT NOT NULL,
Status VARCHAR(20) NOT NULL DEFAULT 'Pending'
CHECK (Status IN ('Pending', 'Confirmed', 'Cancelled')),
EnrolledTime DATETIME NOT NULL DEFAULT GETDATE(),
CONSTRAINT FK_Enrolment_Participant FOREIGN KEY (ParticipantId) REFERENCES Participant(ParticipantId),
CONSTRAINT FK_Enrolment_Category FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId)
);

-- 7. RESULT TABLE
CREATE TABLE Result (
ResultId INT IDENTITY(1,1) PRIMARY KEY,
EnrolmentId INT NOT NULL UNIQUE,
CapturedBy VARCHAR(20) NOT NULL,
FinishTime TIME NULL,
Position INT NULL,
CONSTRAINT FK_Result_Enrolment FOREIGN KEY (EnrolmentId) REFERENCES Enrolment(EnrolmentId),
CONSTRAINT FK_Result_Organiser FOREIGN KEY (CapturedBy) REFERENCES Organiser(OrganiserId)
);


-- SAMPLE DATA

INSERT INTO Organiser (OrganiserId, FullName, Email, PasswordHash) 
VALUES ('ORG001', 'Thabo Nkosi', 'thabo.nkosi@raceday.co.za', 'HASHED_PASSWORD_1'),
('ORG002', 'Lindiwe Dlamini', 'lindiwe.dlamini@raceday.co.za', 'HASHED_PASSWORD_2');

INSERT INTO Participant (ParticipantId, FullName, Email, PasswordHash, DateOfBirth, Gender) 
VALUES ('PART001', 'Sarah van der Merwe', 'sarah.vdm@example.com', 'HASHED_PASSWORD_3', '1995-03-12', 'Female'),
('PART002', 'Sipho Mokoena', 'sipho.mokoena@example.com', 'HASHED_PASSWORD_4', '1990-07-25', 'Male');

INSERT INTO Event (OrganiserId, EventName, Description, EventDate, Location, EventType) 
VALUES ('ORG001', 'Johannesburg City Run', 'A scenic 10km and 21km run through the streets of Johannesburg.', '2026-11-15', 'Johannesburg, Gauteng', 'Run'),
('ORG002', 'Cape Town Cycle Challenge','A road cycling event along the Cape Town coastline.', '2026-10-03', 'Cape Town, Western Cape', 'Cycle'),
('ORG001', 'Durban Beachfront Walk', 'A family-friendly walk along the Durban beachfront.', '2026-09-20', 'Durban, KwaZulu-Natal', 'Walk');

INSERT INTO Category (EventId, CategoryName, Distance)
VALUES (1, '10km', 10.00), (1, '21km', 21.10), (2, '50km', 50.00), 
(2, '100km', 100.00), (3, '5km', 5.00);  


INSERT INTO Route (CategoryId, MapFileUrl)
VALUES (1, 'https://raceday.blob.core.windows.net/routes/joburg-10km-map.pdf'),
(3, 'https://raceday.blob.core.windows.net/routes/capetown-50km-map.pdf');

INSERT INTO Enrolment (ParticipantId, CategoryId, Status, EnrolledTime)
VALUES ('PART001', 1, 'Confirmed', '2026-09-01 08:30:00'),
('PART002', 4, 'Confirmed', '2026-09-02 10:15:00'),
('PART001', 5, 'Pending',   '2026-09-03 14:00:00');

INSERT INTO Result (EnrolmentId, CapturedBy, FinishTime, Position)
VALUES (1, 'ORG001', '00:52:30', 15), (2, 'ORG002', '03:10:05', 8);

SELECT * FROM Organiser;
SELECT * FROM Participant;
SELECT * FROM Event;
SELECT * FROM Category;
SELECT * FROM Route;
SELECT * FROM Enrolment;
SELECT * FROM Result;
