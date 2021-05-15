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
