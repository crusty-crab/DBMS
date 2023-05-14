DROP DATABASE IF EXISTS AirportManagementSystem;
CREATE DATABASE AirportManagementSystem;
USE AirportManagementSystem;

CREATE TABLE Airport (
  AirportCode VARCHAR(10) NOT NULL PRIMARY KEY,
  AirportName VARCHAR(255) NOT NULL,
  City VARCHAR(255) NOT NULL,
  State VARCHAR(255) NOT NULL
);

CREATE TABLE Airline (
  AirlineName VARCHAR(20) NOT NULL PRIMARY KEY,
  Sales INT NOT NULL
);

CREATE TABLE Employee(
  EmployeeId CHAR(10) NOT NULL PRIMARY KEY,
  EmployeeRank VARCHAR(20) NOT NULL,
  TerminalNumber CHAR(5) NOT NULL,
  TimeShiftPosition VARCHAR(20) NOT NULL,
  FOREIGN KEY (TerminalNumber) REFERENCES AirportTerminal(TerminalNumber)
);

CREATE TABLE Flight(
 FlightNumber CHAR(5) NOT NULL PRIMARY KEY,
 FlightWeekdays VARCHAR(255) NOT NULL 
);
CREATE TABLE AirplaneType (
  TypeId INT NOT NULL PRIMARY KEY,
  TypeName VARCHAR(50) NOT NULL,
  ManufacturingCompany VARCHAR(255) NOT NULL,
  MaxSeats INT NOT NULL
);

CREATE TABLE AllowedAirplaneTypes (
  AirportCode VARCHAR(10) NOT NULL,
  FlightNumber VARCHAR(20) NOT NULL,
  FOREIGN KEY (AirportCode) REFERENCES Airport(AirportCode)
);

CREATE TABLE Customer(
	PassportNumber CHAR(10) NOT NULL PRIMARY KEY,
    CustomerName VARCHAR(50) NOT NULL,
    CustomerResidency VARCHAR(30) NOT NULL,
    CustomerPayment VARCHAR(10) NOT NULL
);

CREATE TABLE Airplane (
  AirplaneId INT NOT NULL PRIMARY KEY,
  BoughtDate DATE NOT NULL,
  TypeId INT NOT NULL,
  FOREIGN KEY (TypeId) REFERENCES AirplaneType(TypeId)
);

CREATE TABLE FlightTrip (
  LegNumber INT NOT NULL PRIMARY KEY,
  TripDate DATE NOT NULL,
  FlightNumber CHAR(5) NOT NULL,
  FOREIGN KEY (FlightNumber) REFERENCES Flight(FlightNumber)
);

CREATE TABLE Ticket (
  TicketNumber CHAR(10) NOT NULL PRIMARY KEY,
  Class VARCHAR(10) NOT NULL,
  LegNumber INT NOT NULL,
  SeatNumber INT NOT NULL,
  FOREIGN KEY (LegNumber) REFERENCES FlightTrip(LegNumber)
);

CREATE TABLE AirplaneMaintainance(
  MaintainenceTeam VARCHAR(50) PRIMARY KEY
);

CREATE TABLE DeptMaintenance (
	MaintainenceTeam VARCHAR(50) NOT NULL,
    AirplaneId INT NOT NULL,
    MaintainenceDateTime DATE NOT NULL,
    FOREIGN KEY (MaintainenceTeam) REFERENCES AirplaneMaintainance(MaintainenceTeam),
    FOREIGN KEY (AirplaneId) REFERENCES Airplane(AirplaneId)
);

CREATE TABLE AirportTerminal(
	TerminalNumber CHAR(5) NOT NULL PRIMARY KEY,
	Status VARCHAR(10) NOT NULL,
    AirportCode VARCHAR(10) NOT NULL,
    FOREIGN KEY (AirportCode) REFERENCES Airport(AirportCode)
);

CREATE TABLE TerminalAirplane (
	TerminalNumber CHAR(5) NOT NULL,
  AirplaneId INT NOT NULL,
  AssociatedTime DATETIME NOT NULL,
  FOREIGN KEY (TerminalNumber) REFERENCES AirportTerminal(TerminalNumber)
);


CREATE TABLE CabinCrew(
	AirplaneId INT NOT NULL,
	EmployeeId CHAR(10) NOT NULL,
  FOREIGN KEY (AirplaneId) REFERENCES Airplane(AirplaneId),
  FOREIGN KEY (EmployeeId) REFERENCES Employee(EmployeeId)
);

CREATE TABLE NonCabinCrew(
	TerminalNumber CHAR(5) NOT NULL,
    EmployeeId CHAR(10) NOT NULL,
    FOREIGN KEY (EmployeeId) REFERENCES Employee(EmployeeId),
    FOREIGN KEY (TerminalNumber) REFERENCES AirportTerminal(TerminalNumber)
);

CREATE TABLE Carriage(
	CarriageNumber CHAR(5) PRIMARY KEY NOT NULL,
    CarriageWeight INT NOT NULL,
    TicketNumber CHAR(10) NOT NULL,
    PassportNumber CHAR(10) NOT NULL,
    FOREIGN KEY (TicketNumber) REFERENCES Ticket(TicketNumber),
    FOREIGN KEY (PassportNumber) REFERENCES Customer(TicketNumber)
);

CREATE TABLE ArrivalAndDeparture(
  TerminalNumber CHAR(5) NOT NULL,
  LegNumber INT NOT NULL,
  ArrivalAirportCode VARCHAR(10) NOT NULL,
  ArrivalTime DATETIME NOT NULL,
  DepartureAirportCode VARCHAR(10) NOT NULL,
  DepartureTime DATETIME NOT NULL,
  Status VARCHAR(15) NOT NULL,
  FOREIGN KEY (ArrivalAirportCode, DepartureAirportCode) REFERENCES Airport(AirportCode),
  FOREIGN KEY (TerminalNumber) REFERENCES AirportTerminal(TerminalNumber),
  FOREIGN KEY (LegNumber) REFERENCES FlightTrip(LegNumber)
)


INSERT INTO Airport (AirportCode, AirportName, City, State)
VALUES
('KTM', 'Tribhuvan International Airport', 'Kathmandu', 'Bagmati'),
('PKR', 'Pokhara International Airport', 'Pokhara', 'Gandaki'),
('BWA', 'Bhairahawa International Airport', 'Bhairahawa', 'Lumbini'),
('SIF', 'Simara Airport', 'Bara', 'Province No. 2'),
('BHR', 'Bharatpur Airport', 'Bharatpur', 'Province No. 3');

Select * from Airport;

INSERT INTO AirlineFlight (FlightNumber, Airline, Weekdays)
VALUES
('AI-101', 'Air India', 'Monday, Wednesday, Friday'),
('QR-202', 'Qatar Airways', 'Daily'),
('TG-308', 'Thai Airways', 'Tuesday, Thursday, Saturday'),
('EK-409', 'Emirates', 'Daily'),
('BA-511', 'British Airways', 'Monday, Wednesday, Friday');

Select * from AirlineFlight;

INSERT INTO AirplaneType (TypeId, TypeName, ManufacturingCompany, MaxSeats)
VALUES
(1, 'Boeing 747', 'Boeing', 660),
(2, 'Airbus A380', 'Airbus', 853),
(3, 'Boeing 777', 'Boeing', 550),
(4, 'Airbus A350', 'Airbus', 440),
(5, 'Boeing 737', 'Boeing', 215);

Select * from AirplaneType;

INSERT INTO Customer (PassportNumber, CustomerName, CustomerResidency, CustomerPayment)
VALUES
('A1234567', 'John Doe', 'USA', '1000'),
('B9876543', 'Jane Smith', 'Canada', '750'),
('C2468101', 'Ahmed Khan', 'Pakistan', '500'),
('D3691215', 'Maria Rodriguez', 'Mexico', '1250'),
('E5554443', 'Yoshi Tanaka', 'Japan', '900');

Select * from Customer;

INSERT INTO Airplane (AirplaneId, TotalSeats, TypeId)
VALUES
(1, 250, 5),
(2, 440, 4),
(3, 550, 3),
(4, 660, 1),
(5, 853, 2);

Select * from Airplane;

INSERT INTO FlightTrip (TripNumber, FlightNumber, LegNumber, DepartureAirportCode, ScheduledDepartureTime, ArrivalAirportCode, ScheduledArrivalTime, AvailableSeats, AirplaneId, Date)
VALUES
('ADC01', 'AI-101', 1, 'KTM', '2023-06-01 09:00:00', 'SIF', '2023-06-01 11:00:00', 100, 1, '2023-06-01'),
('ABC01', 'QR-202', 2, 'SIF', '2023-06-01 12:00:00', 'PKR', '2023-06-01 14:00:00', 100, 1, '2023-06-01'),
('DEG02', 'AI-101', 1, 'BHR', '2023-06-02 14:00:00', 'PKR', '2023-06-02 18:00:00', 250, 3, '2023-06-02'),
('DEF02', 'BA-511', 2, 'KTM', '2023-06-02 19:00:00', 'KTM', '2023-06-02 22:00:00', 250, 3, '2023-06-02'),
('GHI03', 'EK-409', 1, 'BHR', '2023-06-03 10:00:00', 'BWA', '2023-06-03 18:00:00', 440, 2, '2023-06-03');

Select * from FlightTrip;

INSERT INTO Ticket (Date, CustomerName, CustomerPhone, SeatNumber, ResidencyType, PaymentSystem, TripNumber)
VALUES 
('2023-06-15', 'John Smith', '+1-202-555-0123', 23, 'International', 'Visa', 'ADC01'),
('2023-06-16', 'Sarah Johnson', '+1-212-555-0123', 15, 'Domestic', 'Mastercard', 'DEG02'),
('2023-06-17', 'David Kim', '+1-415-555-0123', 42, 'Domestic', 'Paypal', 'ADC01'),
('2023-06-18', 'Emily Chen', '+1-310-555-0123', 7, 'International', 'Venmo', 'GHI03'),
('2023-06-19', 'Michael Jackson', '+1-702-555-0123', 31, 'Domestic', 'Cash', 'GHI03');

Select * from Ticket;

INSERT INTO AirplaneMaintainance (AirplaneId, maintainanceDate)
VALUES 
  (1, '2022-01-15'),
  (2, '2022-03-05'),
  (3, '2022-06-12'),
  (4, '2022-02-28'),
  (5, '2022-05-20');
  
Select * from AirplaneMaintainance;

INSERT INTO AirportTerminal (TerminalNumber, FlightNumber, AirportCode)
VALUES 
  ('T1', 'AI-101', 'KTM'),
  ('T2', 'QR-202', 'PKR'),
  ('T3', 'AI-101', 'BWA'),
  ('T4', 'BA-511', 'SIF'),
  ('T5', 'QR-202', 'SIF');

Select * from AirportTerminal;

INSERT INTO Employee (EmployeeId, EmployeeRank, AirportCode)
VALUES 
  ('E1001', 'Manager', 'BWA'),
  ('E1002', 'Supervisor', 'PKR'),
  ('E1003', 'Agent', 'PKR'),
  ('E1004', 'Attendant', 'KTM'),
  ('E1005', 'Security', 'KTM');
  
Select * from Employee;


INSERT INTO CabinCrew (AirplaneId, EmployeeId)
VALUES 
  (1, 'E1002'),
  (1, 'E1004'),
  (3, 'E1001'),
  (4, 'E1005'),
  (2, 'E1003');

Select * from CabinCrew;

INSERT INTO NonCabinCrew (TerminalNumber, EmployeeId)
VALUES 
  ('T1', 'E1002'),
  ('T2', 'E1001'),
  ('T3', 'E1003'),
  ('T4', 'E1004'),
  ('T5', 'E1005');
  
Select * from NonCabinCrew;

INSERT INTO Carriage(CustomerPassportNumber, CarriageWeight, CarriageNumber)
VALUES 
('A1234567', 20, 'C001'),
('B9876543', 35, 'C002'),
('C2468101', 10, 'C003'),
('D3691215', 25, 'C004'),
('E5554443', 30, 'C005');

Select * from Carriage;
