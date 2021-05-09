/**
* The table designed for medicine project. 
* 
* @Auther: MTechProject Team
* @UpdateHistory: <Updater>-<date>-<Update Details>
* Dinu Thomas-02/05/2021-Added create scripts for the tables
* Dinu Thomas-03/05/2021-updated insert statements for doctor database
* Dinu Thomas-08/05/2021- added DOB and Sex into Patient table
* Dinu Thomas-08/05/2021- added Prescription column, medicine set into Prescription table
* Charithra Chandrashekar-09/05/2021- added INSERT values for tables doctor, Department, medical_departmets, Patient, Appointment
* TODO , pls insert the data according to the design and 
* add the change details as per the format<Updater>-<date>-<Update Details>
* pls use the same comment in the commit message
*/

create database medicine;

use medicine;
set sql_safe_updates=0;

CREATE TABLE doctor (
  EmployeeID int PRIMARY KEY NOT NULL,
  Name TEXT NOT NULL,
  Position TEXT NOT NULL,
  adhar_id INTEGER NOT NULL
); 

CREATE TABLE Department (
  DepartmentID INTEGER PRIMARY KEY NOT NULL,
  Name TEXT NOT NULL,
  Head INTEGER,
  foreign key (Head) references doctor(EmployeeID)
);

CREATE TABLE medical_departmets (
  doctorId INTEGER NOT NULL,
    foreign key (doctorId) REFERENCES doctor(EmployeeID),
  Department INTEGER NOT NULL,
    foreign key (Department) REFERENCES Department(DepartmentID),
  PrimaryDepartment BOOLEAN NOT NULL,
  PRIMARY KEY(doctorId, Department)
);

CREATE TABLE Patient (
  adhar_id INTEGER PRIMARY KEY NOT NULL,
  Name TEXT NOT NULL,
  DOB Date NOT NULL,
  sex Text not null,
  Address TEXT NOT NULL,
  Phone TEXT NOT NULL,
  InsuranceID INTEGER NOT NULL,
  ConsultingDoctor INTEGER NOT NULL,
    foreign key (ConsultingDoctor) REFERENCES doctor(EmployeeID)
);

CREATE TABLE Appointment (
  AppointmentID INTEGER PRIMARY KEY NOT NULL,
  Patient INTEGER NOT NULL,
    foreign key (Patient) REFERENCES Patient(adhar_id),
  doctorId INTEGER NOT NULL,
    foreign key (doctorId) REFERENCES doctor(EmployeeID),
  Start DATETIME NOT NULL,
  End DATETIME NOT NULL
);

CREATE TABLE prescription (
  doctorId INTEGER NOT NULL,
    foreign key (doctorId) REFERENCES doctor(EmployeeID),
  Patient INTEGER NOT NULL,
    foreign key (Patient) REFERENCES Patient(adhar_id),
  Medicine_set varchar(1024),# comma separated medicine codes , MedCode
  Appointment INTEGER,
    foreign key (Appointment) REFERENCES Appointment(AppointmentID),
  Prescription TEXT NOT NULL,
  PRIMARY KEY(Appointment)
);

CREATE TABLE Medicine (
  MedCode INTEGER PRIMARY KEY NOT NULL,
  MedName TEXT NOT NULL,
  MedPrice INTEGER,
  MedBrand TEXT NOT NULL,
  MedGroup INTEGER, -- group id of similar medicines
  Description TEXT NOT NULL
);

INSERT INTO doctor VALUES(101,'Sudhakar Reddy','Medical Officer',111111111);
INSERT INTO doctor VALUES(102,'Rajaram Mohan','Physician',111111112);
INSERT INTO doctor VALUES(103,'Sunny Kuttan','Psychiatrist',111111113);
INSERT INTO doctor VALUES(104,'Annie Kurian','Pediatrician',111111114);
INSERT INTO doctor VALUES(105,'Mohan Kumar','Oncologist',111111115);
INSERT INTO doctor VALUES(106,'Mahendra Saraf','Gynacologist',111111116);
INSERT INTO doctor VALUES(107,'Arvind Sawakar','Cardiologist',111111117);
INSERT INTO doctor VALUES(108,'Bob Kelso','Head Chief of Medicine',111111118);
INSERT INTO doctor VALUES(109,'Suresh Kumar','Emergency',111111119);
INSERT INTO doctor VALUES(110,'Venugopal','Emergency',111111120);

INSERT INTO Department VALUES(1,'General Medicine',108);
INSERT INTO Department VALUES(2,'Surgery',105);
INSERT INTO Department VALUES(3,'Psychiatry',103);

INSERT INTO medical_departmets VALUES(101,1,1);
INSERT INTO medical_departmets VALUES(102,1,1);
INSERT INTO medical_departmets VALUES(103,3,1);
INSERT INTO medical_departmets VALUES(104,1,1);
INSERT INTO medical_departmets VALUES(105,1,0);
INSERT INTO medical_departmets VALUES(105,2,1);
INSERT INTO medical_departmets VALUES(106,1,1);
INSERT INTO medical_departmets VALUES(106,2,0);
INSERT INTO medical_departmets VALUES(107,2,1);
INSERT INTO medical_departmets VALUES(108,1,1);
INSERT INTO medical_departmets VALUES(108,2,0);
INSERT INTO medical_departmets VALUES(109,1,0);
INSERT INTO medical_departmets VALUES(110,2,0);

INSERT INTO Patient VALUES(100000001,'John Smith','1988-04-24','M','821 Okuneva Alley','555-0256',796214,102);
INSERT INTO Patient VALUES(100000002,'Jane Doe','1987-01-04','F','2492  Moonlight Drive','971-4923',619267,109);
INSERT INTO Patient VALUES(100000003,'Jon Dorian','1972-06-12','M','1809  Don Jackson Lane','274-5285',953026,107);
INSERT INTO Patient VALUES(100000004,'Elliot Reid','1990-04-28','F','2609  Bel Meadow Drive','206-1327',510149,102);
INSERT INTO Patient VALUES(100000005,'Christopher Turk','1988-03-25','M','11 Bank Drive','764-1354',199291,102);
INSERT INTO Patient VALUES(100000006,'Jane Smith','2003-07-10','F','9046 Rockcrest St','846-5136',498823,106);
INSERT INTO Patient VALUES(100000007,'Percival Cox','2009-02-02','M','18 Miles Court','436-4240',955257,102);
INSERT INTO Patient VALUES(100000008,'Stanley Hodgson','1960-07-17','M','8666 Myrtle Street','488-7399',985303,108);
INSERT INTO Patient VALUES(100000009,'Holly Townsend','1989-10-25','F','6776 Batz Club','723-6981',969719,110);
INSERT INTO Patient VALUES(100000010,'John Wen','1994-10-19','M','921 Smitham Estate','698-5890',688406,102);
INSERT INTO Patient VALUES(100000011,'Violet Cantrell','1985-04-14','F','941 Beatty Fords','828-1934',775141,103);
INSERT INTO Patient VALUES(100000012,'Molly Clock','1979-10-13','F','24804 Bauch Divide','256-4599',101504,102);
INSERT INTO Patient VALUES(100000013,'Philip Maldonado','1973-09-17','M','3598 Emard Ford','454-3148',329387,105);
INSERT INTO Patient VALUES(100000014,'Tamara Clark','2001-01-03','F','9986 Conner Crossroad','928-1412',835308,106);
INSERT INTO Patient VALUES(100000015,'Grant Martin','2011-10-07','M','453 Tyshawn Stream','473-5710',245360,102);
INSERT INTO Patient VALUES(100000016,'Keith Dudemeister','1984-06-19','M','8824 Hudson Crescent','927-1057',283681,102);
INSERT INTO Patient VALUES(100000017,'Marc Warren','1997-11-20','M','728 Esmeralda Extension','675-1061',180710,102);
INSERT INTO Patient VALUES(100000018,'Todd Quinlan','2020-04-18','M','211 Brooke Brooks','335-0288',835042,104);
INSERT INTO Patient VALUES(100000019,'Dexter Garner','1998-05-17','M','57 Collier Fork','876-5495',688139,102);
INSERT INTO Patient VALUES(100000020,'Clara Becker','1985-09-20','F','68 Beer Street','651-8910',508206,106);

INSERT INTO Appointment VALUES(01,100000011,18,'2021-01-21 10:00','2021-01-28 11:00');
INSERT INTO Appointment VALUES(02,100000020,19,'2021-04-24 10:00','2021-04-24 11:00');
INSERT INTO Appointment VALUES(03,100000013,23,'2021-03-01 10:00','2021-03-09 11:00');
INSERT INTO Appointment VALUES(04,100000004,27,'2021-03-28 10:00','2021-03-31 11:00');
INSERT INTO Appointment VALUES(05,100000015,28,'2021-03-31 10:00','2021-04-10 11:00');
INSERT INTO Appointment VALUES(06,100000011,18,'2021-01-21 11:00','2021-01-28 12:00');
INSERT INTO Appointment VALUES(07,100000012,19,'2021-04-24 11:00','2021-04-24 12:00');
INSERT INTO Appointment VALUES(08,100000003,23,'2018-03-01 11:00','2018-03-09 12:00');
INSERT INTO Appointment VALUES(09,100000014,27,'2021-03-28 11:00','2021-03-31 12:00');
INSERT INTO Appointment VALUES(10,100000015,28,'2021-03-31 11:00','2021-04-10 12:00');
INSERT INTO Appointment VALUES(11,100000001,18,'2021-01-21 14:00','2021-01-28 15:00');
INSERT INTO Appointment VALUES(12,100000012,19,'2021-04-24 14:00','2021-04-24 15:00');
INSERT INTO Appointment VALUES(13,100000009,23,'2021-03-01 14:00','2021-03-09 15:00');
INSERT INTO Appointment VALUES(14,100000014,27,'2021-03-28 14:00','2021-03-31 15:00');
INSERT INTO Appointment VALUES(15,100000019,28,'2021-03-31 14:00','2021-04-10 15:00');
INSERT INTO Appointment VALUES(16,100000011,18,'2021-01-21 15:00','2021-01-28 16:00');
INSERT INTO Appointment VALUES(17,100000012,19,'2021-04-24 15:00','2021-04-24 16:00');
INSERT INTO Appointment VALUES(18,100000008,23,'2018-03-01 15:00','2018-03-09 16:00');
INSERT INTO Appointment VALUES(19,100000014,27,'2021-03-28 15:00','2021-03-31 16:00');
INSERT INTO Appointment VALUES(20,100000015,28,'2021-03-31 15:00','2021-04-10 16:00');