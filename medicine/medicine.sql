/**
* The table design is from https://en.wikibooks.org/wiki/SQL_Exercises/The_Hospital, 
* The table constructs are modified for mySQL. 
* 
* @Auther: wikibooks: https://en.wikibooks.org/wiki/SQL_Exercises/The_Hospital
* @UpdateHistory: <Updater>-<date>-<Update Details>
* Dinu Thomas-16/4/2021-Created the first copy for MySQL from the original (wikibooks), ported MySQL Constructs
* TODO , pls change the schema according to the design
*/

create database new_hospital;

use new_hospital;
set sql_safe_updates=0;
-- drop table Physician;
CREATE TABLE Physician (
  EmployeeID int PRIMARY KEY NOT NULL,
  Name TEXT NOT NULL,
  Position TEXT NOT NULL,
  SSN INTEGER NOT NULL
); 

CREATE TABLE Department (
  DepartmentID INTEGER PRIMARY KEY NOT NULL,
  Name TEXT NOT NULL,
  Head INTEGER,
  foreign key (Head) references Physician(EmployeeID)
);
-- drop table Affiliated_With;
CREATE TABLE Affiliated_With (
  Physician INTEGER NOT NULL,
    foreign key (Physician) REFERENCES Physician(EmployeeID),
  Department INTEGER NOT NULL,
    foreign key (Department) REFERENCES Department(DepartmentID),
  PrimaryAffiliation BOOLEAN NOT NULL,
  PRIMARY KEY(Physician, Department)
);

CREATE TABLE Procedures (
  ProcCode INTEGER PRIMARY KEY NOT NULL,
  ProcName TEXT NOT NULL,
  Cost float NOT NULL
);

CREATE TABLE Trained_In (
  Physician INTEGER NOT NULL,
    foreign key (Physician) REFERENCES Physician(EmployeeID),
  Treatment INTEGER NOT NULL,
    foreign key (Treatment) REFERENCES Procedures(ProcCode),
  CertificationDate DATETIME NOT NULL,
  CertificationExpires DATETIME NOT NULL,
  PRIMARY KEY(Physician, Treatment)
);

CREATE TABLE Patient (
  SSN INTEGER PRIMARY KEY NOT NULL,
  Name TEXT NOT NULL,
  Address TEXT NOT NULL,
  Phone TEXT NOT NULL,
  InsuranceID INTEGER NOT NULL,
  PCP INTEGER NOT NULL,
    foreign key (PCP) REFERENCES Physician(EmployeeID)
);

CREATE TABLE Nurse (
  EmployeeID INTEGER PRIMARY KEY NOT NULL,
  Name TEXT NOT NULL,
  Position TEXT NOT NULL,
  Registered BOOLEAN NOT NULL,
  SSN INTEGER NOT NULL
);

CREATE TABLE Appointment (
  AppointmentID INTEGER PRIMARY KEY NOT NULL,
  Patient INTEGER NOT NULL,
    foreign key (Patient) REFERENCES Patient(SSN),
  PrepNurse INTEGER,
    foreign key (PrepNurse) REFERENCES Nurse(EmployeeID),
  Physician INTEGER NOT NULL,
    foreign key (Physician) REFERENCES Physician(EmployeeID),
  Start DATETIME NOT NULL,
  End DATETIME NOT NULL,
  ExaminationRoom TEXT NOT NULL
);

CREATE TABLE Medication (
  Code INTEGER PRIMARY KEY NOT NULL,
  Name TEXT NOT NULL,
  Brand TEXT NOT NULL,
  Description TEXT NOT NULL
);

CREATE TABLE Prescribes (
  Physician INTEGER NOT NULL,
    foreign key (Physician) REFERENCES Physician(EmployeeID),
  Patient INTEGER NOT NULL,
    foreign key (Patient) REFERENCES Patient(SSN),
  Medication INTEGER NOT NULL,
    foreign key (Medication) REFERENCES Medication(Code),
  Date DATETIME NOT NULL,
  Appointment INTEGER,
    foreign key (Appointment) REFERENCES Appointment(AppointmentID),
  Dose TEXT NOT NULL,
  PRIMARY KEY(Physician, Patient, Medication, Date)
);

-- drop table Block;
CREATE TABLE Block (
  Floor INTEGER NOT NULL,
  BCode INTEGER NOT NULL,
  PRIMARY KEY(Floor, BCode)
); 
-- drop table Room;
CREATE TABLE Room (
  Number INTEGER PRIMARY KEY NOT NULL,
  Type TEXT NOT NULL,
  BlockFloor INTEGER NOT NULL, FOREIGN KEY(BlockFloor) REFERENCES Block(Floor),
  BlockCode INTEGER NOT NULL, -- FOREIGN KEY(BlockCode) REFERENCES Block(BCode),
  Unavailable BOOLEAN NOT NULL
);
-- drop table On_Call;
CREATE TABLE On_Call (
  Nurse INTEGER NOT NULL,
    foreign key (Nurse) REFERENCES Nurse(EmployeeID),
  BlockFloor INTEGER NOT NULL, FOREIGN KEY(BlockFloor) REFERENCES Block(Floor),
  BlockCode INTEGER NOT NULL,
  Start DATETIME NOT NULL,
  End DATETIME NOT NULL,
  PRIMARY KEY(Nurse, BlockFloor, BlockCode, Start, End)

);
-- drop table Stay;
CREATE TABLE Stay (
  StayID INTEGER PRIMARY KEY NOT NULL,
  Patient INTEGER NOT NULL,
    foreign key (Patient) REFERENCES Patient(SSN),
  Room INTEGER NOT NULL,
    foreign key (Room) REFERENCES Room(Number),
  Start DATETIME NOT NULL,
  End DATETIME NOT NULL
);
-- drop table Undergoes;
CREATE TABLE Undergoes (
  Patient INTEGER NOT NULL,
    foreign key (Patient) REFERENCES Patient(SSN),
  Procedures INTEGER NOT NULL,
    foreign key (Procedures) REFERENCES Procedures(ProcCode),
  Stay INTEGER NOT NULL,
    foreign key (Stay) REFERENCES Stay(StayID),
  Date DATETIME NOT NULL,
  Physician INTEGER NOT NULL,
    foreign key (Physician) REFERENCES Physician(EmployeeID),
  AssistingNurse INTEGER,
    foreign key (AssistingNurse) REFERENCES Nurse(EmployeeID),
  PRIMARY KEY(Patient, Procedures, Stay, Date)
);

INSERT INTO Physician VALUES(1,'John Dorian','Staff Internist',111111111);
INSERT INTO Physician VALUES(2,'Elliot Reid','Attending Physician',222222222);
INSERT INTO Physician VALUES(3,'Christopher Turk','Surgical Attending Physician',333333333);
INSERT INTO Physician VALUES(4,'Percival Cox','Senior Attending Physician',444444444);
INSERT INTO Physician VALUES(5,'Bob Kelso','Head Chief of Medicine',555555555);
INSERT INTO Physician VALUES(6,'Todd Quinlan','Surgical Attending Physician',666666666);
INSERT INTO Physician VALUES(7,'John Wen','Surgical Attending Physician',777777777);
INSERT INTO Physician VALUES(8,'Keith Dudemeister','MD Resident',888888888);
INSERT INTO Physician VALUES(9,'Molly Clock','Attending Psychiatrist',999999999);

select * from Department;
INSERT INTO Department VALUES(1,'General Medicine',4);
INSERT INTO Department VALUES(2,'Surgery',7);
INSERT INTO Department VALUES(3,'Psychiatry',9);

INSERT INTO Affiliated_With VALUES(1,1,1);
INSERT INTO Affiliated_With VALUES(2,1,1);
INSERT INTO Affiliated_With VALUES(3,1,0);
INSERT INTO Affiliated_With VALUES(3,2,1);
INSERT INTO Affiliated_With VALUES(4,1,1);
INSERT INTO Affiliated_With VALUES(5,1,1);
INSERT INTO Affiliated_With VALUES(6,2,1);
INSERT INTO Affiliated_With VALUES(7,1,0);
INSERT INTO Affiliated_With VALUES(7,2,1);
INSERT INTO Affiliated_With VALUES(8,1,1);
INSERT INTO Affiliated_With VALUES(9,3,1);

INSERT INTO Procedures VALUES(1,'Reverse Rhinopodoplasty',1500.0);
INSERT INTO Procedures VALUES(2,'Obtuse Pyloric Recombobulation',3750.0);
INSERT INTO Procedures VALUES(3,'Folded Demiophtalmectomy',4500.0);
INSERT INTO Procedures VALUES(4,'Complete Walletectomy',10000.0);
INSERT INTO Procedures VALUES(5,'Obfuscated Dermogastrotomy',4899.0);
INSERT INTO Procedures VALUES(6,'Reversible Pancreomyoplasty',5600.0);
INSERT INTO Procedures VALUES(7,'Follicular Demiectomy',25.0);

INSERT INTO Patient VALUES(100000001,'John Smith','42 Foobar Lane','555-0256',68476213,1);
INSERT INTO Patient VALUES(100000002,'Grace Ritchie','37 Snafu Drive','555-0512',36546321,2);
INSERT INTO Patient VALUES(100000003,'Random J. Patient','101 Omgbbq Street','555-1204',65465421,2);
INSERT INTO Patient VALUES(100000004,'Dennis Doe','1100 Foobaz Avenue','555-2048',68421879,3);

INSERT INTO Nurse VALUES(101,'Carla Espinosa','Head Nurse',1,111111110);
INSERT INTO Nurse VALUES(102,'Laverne Roberts','Nurse',1,222222220);
INSERT INTO Nurse VALUES(103,'Paul Flowers','Nurse',0,333333330);

INSERT INTO Appointment VALUES(13216584,100000001,101,1,'2008-04-24 10:00','2008-04-24 11:00','A');
INSERT INTO Appointment VALUES(26548913,100000002,101,2,'2008-04-24 10:00','2008-04-24 11:00','B');
INSERT INTO Appointment VALUES(36549879,100000001,102,1,'2008-04-25 10:00','2008-04-25 11:00','A');
INSERT INTO Appointment VALUES(46846589,100000004,103,4,'2008-04-25 10:00','2008-04-25 11:00','B');
INSERT INTO Appointment VALUES(59871321,100000004,NULL,4,'2008-04-26 10:00','2008-04-26 11:00','C');
INSERT INTO Appointment VALUES(69879231,100000003,103,2,'2008-04-26 11:00','2008-04-26 12:00','C');
INSERT INTO Appointment VALUES(76983231,100000001,NULL,3,'2008-04-26 12:00','2008-04-26 13:00','C');
INSERT INTO Appointment VALUES(86213939,100000004,102,9,'2008-04-27 10:00','2008-04-21 11:00','A');
INSERT INTO Appointment VALUES(93216548,100000002,101,2,'2008-04-27 10:00','2008-04-27 11:00','B');

INSERT INTO Medication VALUES(1,'Procrastin-X','X','N/A');
INSERT INTO Medication VALUES(2,'Thesisin','Foo Labs','N/A');
INSERT INTO Medication VALUES(3,'Awakin','Bar Laboratories','N/A');
INSERT INTO Medication VALUES(4,'Crescavitin','Baz Industries','N/A');
INSERT INTO Medication VALUES(5,'Melioraurin','Snafu Pharmaceuticals','N/A');

INSERT INTO Prescribes VALUES(1,100000001,1,'2008-04-24 10:47',13216584,'5');
INSERT INTO Prescribes VALUES(9,100000004,2,'2008-04-27 10:53',86213939,'10');
INSERT INTO Prescribes VALUES(9,100000004,2,'2008-04-30 16:53',NULL,'5');
select * from Block;
-- truncate table Block;
INSERT INTO Block VALUES(11,1);
INSERT INTO Block VALUES(21,2);
INSERT INTO Block VALUES(31,3);
INSERT INTO Block VALUES(12,1);
INSERT INTO Block VALUES(22,2);
INSERT INTO Block VALUES(32,3);
INSERT INTO Block VALUES(13,1);
INSERT INTO Block VALUES(23,2);
INSERT INTO Block VALUES(33,3);
INSERT INTO Block VALUES(14,1);
INSERT INTO Block VALUES(24,2);
INSERT INTO Block VALUES(34,3);

-- truncate table Room;
INSERT INTO Room VALUES(101,'Single',11,1,0);
INSERT INTO Room VALUES(102,'Single',11,1,0);
INSERT INTO Room VALUES(103,'Single',11,1,0);
INSERT INTO Room VALUES(111,'Single',21,2,0);
INSERT INTO Room VALUES(112,'Single',21,2,1);
INSERT INTO Room VALUES(113,'Single',21,2,0);
INSERT INTO Room VALUES(121,'Single',31,3,0);
INSERT INTO Room VALUES(122,'Single',31,3,0);
INSERT INTO Room VALUES(123,'Single',31,3,0);
INSERT INTO Room VALUES(201,'Single',12,1,1);
INSERT INTO Room VALUES(202,'Single',12,1,0);
INSERT INTO Room VALUES(203,'Single',12,1,0);
INSERT INTO Room VALUES(211,'Single',22,2,0);
INSERT INTO Room VALUES(212,'Single',22,2,0);
INSERT INTO Room VALUES(213,'Single',22,2,1);
INSERT INTO Room VALUES(221,'Single',32,3,0);
INSERT INTO Room VALUES(222,'Single',32,3,0);
INSERT INTO Room VALUES(223,'Single',32,3,0);
INSERT INTO Room VALUES(301,'Single',13,1,0);
INSERT INTO Room VALUES(302,'Single',13,1,1);
INSERT INTO Room VALUES(303,'Single',13,1,0);
INSERT INTO Room VALUES(311,'Single',23,2,0);
INSERT INTO Room VALUES(312,'Single',23,2,0);
INSERT INTO Room VALUES(313,'Single',23,2,0);
INSERT INTO Room VALUES(321,'Single',33,3,1);
INSERT INTO Room VALUES(322,'Single',33,3,0);
INSERT INTO Room VALUES(323,'Single',33,3,0);
INSERT INTO Room VALUES(401,'Single',14,1,0);
INSERT INTO Room VALUES(402,'Single',14,1,1);
INSERT INTO Room VALUES(403,'Single',14,1,0);
INSERT INTO Room VALUES(411,'Single',24,2,0);
INSERT INTO Room VALUES(412,'Single',24,2,0);
INSERT INTO Room VALUES(413,'Single',24,2,0);
INSERT INTO Room VALUES(421,'Single',34,3,1);
INSERT INTO Room VALUES(422,'Single',34,3,0);
INSERT INTO Room VALUES(423,'Single',34,3,0);

INSERT INTO On_Call VALUES(101,11,1,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(101,21,2,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(102,31,3,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(103,11,1,'2008-11-04 19:00','2008-11-05 03:00');
INSERT INTO On_Call VALUES(103,21,2,'2008-11-04 19:00','2008-11-05 03:00');
INSERT INTO On_Call VALUES(103,31,3,'2008-11-04 19:00','2008-11-05 03:00');
-- truncate table Stay;
INSERT INTO Stay VALUES(3215,100000001,111,'2008-05-01','2008-05-04');
INSERT INTO Stay VALUES(3216,100000003,123,'2008-05-03','2008-05-14');
INSERT INTO Stay VALUES(3217,100000004,112,'2008-05-02','2008-05-03');
-- truncate table Undergoes;
INSERT INTO Undergoes VALUES(100000001,6,3215,'2008-05-02',3,101);
INSERT INTO Undergoes VALUES(100000001,2,3215,'2008-05-03',7,101);
INSERT INTO Undergoes VALUES(100000004,1,3217,'2008-05-07',3,102);
INSERT INTO Undergoes VALUES(100000004,5,3217,'2008-05-09',6,NULL);
INSERT INTO Undergoes VALUES(100000001,7,3217,'2008-05-10',7,101);
INSERT INTO Undergoes VALUES(100000004,4,3217,'2008-05-13',3,103);

INSERT INTO Trained_In VALUES(3,1,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,5,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,7,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(6,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(6,5,'2007-01-01','2007-12-31');
INSERT INTO Trained_In VALUES(6,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,1,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,3,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,4,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,5,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,7,'2008-01-01','2008-12-31');
