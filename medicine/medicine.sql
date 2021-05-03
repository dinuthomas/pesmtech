/**
* The table designed for medicine project. 
* 
* @Auther: MTechProject Team
* @UpdateHistory: <Updater>-<date>-<Update Details>
* Dinu Thomas-16/4/2021-Created the first copy 
* TODO , pls insert the data according to the design and add the change details as per the format
*/

create database medicine;

use medicine;
set sql_safe_updates=0;
-- drop table Physician;
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
-- drop table Affiliated_With;
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

CREATE TABLE Medicine (
  MedCode INTEGER PRIMARY KEY NOT NULL,
  MedName TEXT NOT NULL,
  MedPrice INTEGER,
  MedBrand TEXT NOT NULL,
  MedGroup INTEGER, -- group id of similar medicines
  Description TEXT NOT NULL
);

CREATE TABLE prescription (
  doctorId INTEGER NOT NULL,
    foreign key (doctorId) REFERENCES doctor(EmployeeID),
  Patient INTEGER NOT NULL,
    foreign key (Patient) REFERENCES Patient(adhar_id),
  Medication INTEGER NOT NULL,
    foreign key (Medication) REFERENCES Medicine(MedCode),
  Date DATETIME NOT NULL,
  Appointment INTEGER,
    foreign key (Appointment) REFERENCES Appointment(AppointmentID),
  Dose TEXT NOT NULL,
  PRIMARY KEY(doctorId, Patient, Medication, Date)
);

/*
INSERT INTO doctor VALUES(1,'John Dorian','Staff Internist',111111111);


select * from Department;
INSERT INTO Department VALUES(1,'General Medicine',4);


INSERT INTO medical_departmets VALUES(1,1,1);


INSERT INTO Patient VALUES(100000001,'John Smith','42 Foobar Lane','555-0256',68476213,1);


INSERT INTO Appointment VALUES(13216584,100000001,101,1,'2008-04-24 10:00','2008-04-24 11:00','A');


INSERT INTO Medication VALUES(1,'Procrastin-X','X','N/A');

INSERT INTO prescription VALUES(1,100000001,1,'2008-04-24 10:47',13216584,'5');
*/