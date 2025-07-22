-- Creating the database
CREATE DATABASE db_lab4;

-- Selecting the database for use
USE db_lab4;

-- Creating table for storing patient information
CREATE TABLE Patient (
    Patient_ID INT PRIMARY KEY,
    PatientName VARCHAR(100) NOT NULL,
    Age INT CHECK (Age >= 0 AND Age <= 120),
    Gender VARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Other')),
    Address TEXT,
    Contact_Number VARCHAR(20) UNIQUE,
    DOB DATE,
    Blood_Type VARCHAR(10) CHECK (Blood_Type IN ('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'))
);

-- Creating table for hospital departments
CREATE TABLE Department (
    Department_ID VARCHAR(10) PRIMARY KEY,
    Department_Name VARCHAR(100) NOT NULL UNIQUE
);

-- Creating table for all hospital employees
CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Role VARCHAR(50),
    Department_ID VARCHAR(10),
    Joining_Date DATE,
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID) ON DELETE CASCADE
);

-- Creating table for receptionists
CREATE TABLE Receptionist (
    Receptionist_ID INT PRIMARY KEY,
    R_Name VARCHAR(100),
    Number VARCHAR(20),
    Email VARCHAR(100) UNIQUE,
    Employee_ID INT,
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID) ON DELETE CASCADE
);

-- Creating table for doctors
CREATE TABLE Doctor (
    Doctor_ID INT PRIMARY KEY,
    Doctor_Name VARCHAR(100),
    Specialization VARCHAR(100),
    Contact VARCHAR(20),
    Email VARCHAR(100) UNIQUE,
    License_Number VARCHAR(50) UNIQUE NOT NULL,
    Employee_ID INT,
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID) ON DELETE CASCADE
);

-- Creating table for appointments
CREATE TABLE Appointment (
    Appointment_ID INT PRIMARY KEY,
    Patient_ID INT,
    Doctor_ID INT,
    Receptionist_ID INT,
    Date DATE,
    Time TIME,
    Status VARCHAR(50) CHECK (Status IN ('Scheduled', 'Completed', 'Cancelled')),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID) ON DELETE CASCADE, 
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID) ON DELETE CASCADE,
    FOREIGN KEY (Receptionist_ID) REFERENCES Receptionist(Receptionist_ID) ON DELETE CASCADE
);

-- Creating table for diagnoses
CREATE TABLE Diagnosis (
    Diagnosis_ID INT PRIMARY KEY,
    Appointment_ID INT,
    Patient_ID INT,
    Doctor_ID INT,
    Description TEXT,
    Date DATE,
    FOREIGN KEY (Appointment_ID) REFERENCES Appointment(Appointment_ID) ON DELETE CASCADE,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID) ON DELETE CASCADE,
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID) ON DELETE CASCADE
);

-- Creating table for treatments
CREATE TABLE Treatment (
    Treatment_ID VARCHAR(10) PRIMARY KEY,
    Diagnosis_ID INT,
    Treatment_Type VARCHAR(100),
    Description TEXT,
    Treatment_Cost DECIMAL(10, 2) CHECK (Treatment_Cost >= 0),
    FOREIGN KEY (Diagnosis_ID) REFERENCES Diagnosis(Diagnosis_ID) ON DELETE CASCADE
);

-- Creating table for hospital rooms
CREATE TABLE Room (
    Room_ID INT PRIMARY KEY,
    Room_Number VARCHAR(10) UNIQUE,
    Type VARCHAR(50) CHECK (Type IN ('ICU', 'General', 'Private')),
    Status VARCHAR(20) CHECK (Status IN ('Available', 'Occupied'))
);

-- Creating table for patient admissions
CREATE TABLE Admission (
    Admission_ID INT PRIMARY KEY,
    Patient_ID INT,
    Diagnosis_ID INT,
    Room_ID INT,
    Admission_Date DATE,
    Discharge_Date DATE,
    Room_Cost DECIMAL(10, 2) CHECK (Room_Cost >= 0),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID) ON DELETE CASCADE,
    FOREIGN KEY (Diagnosis_ID) REFERENCES Diagnosis(Diagnosis_ID) ON DELETE CASCADE,
    FOREIGN KEY (Room_ID) REFERENCES Room(Room_ID) ON DELETE CASCADE
);

-- Creating table for nurses
CREATE TABLE Nurse (
    Nurse_ID INT PRIMARY KEY,
    Nurse_Name VARCHAR(100),
    Contact_Number VARCHAR(20) UNIQUE,
    Shift_Timings VARCHAR(100),
    Room_ID INT,
    Employee_ID INT,
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID) ON DELETE CASCADE,
    FOREIGN KEY (Room_ID) REFERENCES Room(Room_ID) ON DELETE CASCADE
);

-- Creating table for prescriptions
CREATE TABLE Prescription (
    PrescriptionID VARCHAR(10) PRIMARY KEY,
    DiagnosisID INT,
    FOREIGN KEY (DiagnosisID) REFERENCES Diagnosis(Diagnosis_ID) ON DELETE CASCADE
);

-- Creating table for prescription medicines
CREATE TABLE PrescriptionMedicine (
    PrescriptionMedicineID VARCHAR(10) PRIMARY KEY,
    PrescriptionID VARCHAR(10),
    MedicineName VARCHAR(100),
    Dosage VARCHAR(50),
    Instructions TEXT,
    Duration VARCHAR(50),
    FOREIGN KEY (PrescriptionID) REFERENCES Prescription(PrescriptionID) ON DELETE CASCADE
);

-- Creating table for labs
CREATE TABLE Lab (
    Lab_ID VARCHAR(10) PRIMARY KEY,
    DiagnosisID INT,
    FOREIGN KEY (DiagnosisID) REFERENCES Diagnosis(Diagnosis_ID) ON DELETE CASCADE
);

-- Creating table for lab tests
CREATE TABLE Test (
    Test_ID VARCHAR(10) PRIMARY KEY,
    Lab_ID VARCHAR(10),
    Test_Name VARCHAR(100),
    Description TEXT,
    Test_Cost DECIMAL(10, 2) CHECK (Test_Cost >= 0),
    FOREIGN KEY (Lab_ID) REFERENCES Lab(Lab_ID) ON DELETE CASCADE
);

-- Creating table for medical history of patients
CREATE TABLE Medical_History (
    History_ID INT PRIMARY KEY,
    Patient_ID INT,
    Doctor_ID INT,
    Description TEXT,
    Date_Recorded DATE,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID) ON DELETE CASCADE,
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID) ON DELETE CASCADE
);

-- Creating table for billing information
CREATE TABLE Bill (
    Bill_ID INT PRIMARY KEY,
    Patient_ID INT,
    Appointment_ID INT,
    Receptionist_ID INT,
    Amount DECIMAL(10, 2) CHECK (Amount >= 0),
    Bill_Date DATE,
    Bill_Status VARCHAR(50),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID) ON DELETE CASCADE,
    FOREIGN KEY (Appointment_ID) REFERENCES Appointment(Appointment_ID) ON DELETE CASCADE,
    FOREIGN KEY (Receptionist_ID) REFERENCES Receptionist(Receptionist_ID) ON DELETE CASCADE
);

-- Inserting sample records into Patient table
INSERT INTO Patient (Patient_ID, PatientName, Age, Gender, Address, Contact_Number, DOB, Blood_Type) VALUES
(1, 'Ali Raza', 34, 'Male', 'Ho-- Selecting the database for use
use #12, Model Town, Lahore', 03001234567, '1990-03-25', 'A+'),
(2, 'Emily Davis', 12, 'Female', '1234 Elm St, New York, USA', '001-212-4567890', '2013-06-20', 'O+'),
(3, 'Ahmed Khan', 41, 'Male', 'Street 45, G-11, Islamabad', 03111222333, '1983-07-12', 'B+'),
(4, 'Carlos Martinez', 50, 'Male', 'Av. Reforma, Mexico City', '0052-55-78945612', '1974-10-04', 'AB-'),
(5, 'Fatima Zahra', 14, 'Female', 'DHA Phase 6, Karachi', 03451234567, '2010-06-20', 'O-'),
(6, 'Sophia Turner', 11, 'Female', '44 Oxford Rd, London, UK', '0044-20-79460000', '2014-06-20', 'A-'),
(7, 'Usman Tariq', 29, 'Male', 'Shalimar Town, Faisalabad', 03034561234, '1995-09-11', 'B-'),
(8, 'John Smith', 45, 'Male', '742 Evergreen Terrace, Springfield', '001-310-1122334', '1979-01-05', 'O+'),
(9, 'Zainab Bukhari', 31, 'Female', 'PECHS Block 2, Karachi', 03161119999, '1993-05-21', 'A+'),
(10, 'Emma Wilson', 16, 'Female', '5th Avenue, NYC, USA', '001-646-7889900', '2009-06-20', 'AB+'),
(11, 'Bilal Ahmad', 38, 'Male', 'GT Road, Gujranwala', 03217775555, '1986-11-08', 'A-'),
(12, 'Noah Taylor', 30, 'Male', 'Queen St, Toronto, Canada', '001-416-9988776', '1994-12-30', 'O+'),
(13, 'Hira Yousaf', 17, 'Female', 'Bahria Town, Rawalpindi', 03334445566, '2008-06-20', 'AB+'),
(14, 'Isabella Moore', 32, 'Female', 'Harbor Ave, Sydney, Australia', '0061-2-98765432', '1992-09-27', 'B+'),
(15, 'Mariam Javed', 35, 'Female', 'Wapda Town, Multan', 03001112233, '1989-04-09', 'A+'),
(16, 'Liam Brown', 39, 'Male', 'George St, London, UK', '0044-20-12345678', '1985-06-06', 'B+'),
(17, 'Ayesha Malik', 13, 'Female', 'Iqbal Town, Lahore', 03451112233, '2012-06-20', 'O-'),
(18, 'Oliver Anderson', 44, 'Male', 'Berlin Strasse, Germany', '0049-30-11223344', '1980-02-02', 'AB-'),
(19, 'Hassan Niazi', 37, 'Male', 'Saddar, Peshawar', 03118889900, '1987-05-03', 'B-'),
(20, 'Chloe Thomas', 15, 'Female', 'Paris Central, France', '0033-1-44556677', '2010-06-20', 'A-'),
(21, 'Tariq Mehmood', 60, 'Male', 'Satellite Town, Quetta', 03007778899, '1964-04-04', 'O+'),
(22, 'Jessica Clark', 43, 'Female', 'Main St, Wellington, NZ', '0064-4-998877', '1981-11-11', 'B+'),
(23, 'Nida Haroon', 12, 'Female', 'Shahrah-e-Faisal, Karachi', 03229998888, '2013-06-20', 'A-'),
(24, 'Ethan Harris', 31, 'Male', 'Central Blvd, Chicago', '001-312-5566778', '1993-08-08', 'AB+'),
(25, 'Rashid Latif', 48, 'Male', 'Civic Center, Hyderabad', 03006665544, '1976-03-03', 'O-'),
(26, 'Grace Hall', 14, 'Female', 'Melbourne Road, Australia', '0061-3-33445566', '2011-06-20', 'A+'),
(27, 'Sana Sheikh', 16, 'Female', 'F-10 Markaz, Islamabad', 03124448888, '2009-06-20', 'B-'),
(28, 'Mason King', 40, 'Male', 'Palm St, Los Angeles', '001-213-1122445', '1984-09-09', 'B+'),
(29, 'Rehana Qureshi', 52, 'Female', 'Liaquat Road, Sukkur', 03003332211, '1972-02-28', 'AB+'),
(30, 'Daniel Evans', 34, 'Male', 'Broadway Ave, NYC, USA', '001-718-9988770', '1990-07-07', 'A-'),
(31, 'Zoya Malik', 20, 'Female', 'Johar Town, Lahore', '03081234567', '2005-09-10', 'O+'),
(32, 'Hamza Bashir', 21, 'Male', 'Blue Area, Islamabad', '03124569876', '2004-11-22', 'B+'),
(33, 'Tania Iqbal', 23, 'Female', 'Gulshan-e-Iqbal, Karachi', '03415554433', '2002-03-18', 'A-'),
(34, 'Usman Farooq', 19, 'Male', 'Model Town, Multan', '03002221111', '2006-05-05', 'AB+'),
(35, 'Mehreen Javed', 25, 'Female', 'Clifton, Karachi', '03234445555', '2000-07-12', 'A+'),
(36, 'Sameer Ali', 31, 'Male', 'Saddar, Hyderabad', '03337778888', '1993-04-04', 'B-'),
(37, 'Areeba Shah', 18, 'Female', 'Gulberg, Lahore', '03009998877', '2007-06-15', 'O-'),
(38, 'Rayan Khan', 26, 'Male', 'Bahria Town, Rawalpindi', '03451112233', '1999-12-19', 'A+'),
(39, 'Laiba Siddiqui', 22, 'Female', 'F-7, Islamabad', '03129990000', '2003-08-08', 'AB-'),
(40, 'Talha Qureshi', 9, 'Male', 'Korangi, Karachi', '03006664444', '2016-06-20', 'B+');

-- Inserting records into Department table
INSERT INTO Department (Department_ID, Department_Name) VALUES
('Depart1', 'Cardiology'),
('Depart2', 'Neurology'),
('Depart3', 'Emergency'),
('Depart4', 'Outpatient Services'),
('Depart5', 'Human Resources'),
('Depart6', 'Radiology'),
('Depart7', 'Pediatrics'),
('Depart8', 'Internal Medicine'),
('Depart9', 'Oncology'),
('Depart10', 'Surgery');

-- Inserting records into Employee table
INSERT INTO Employee (Employee_ID, Role, Department_ID, Joining_Date) VALUES
(13, 'Receptionist', 'Depart5', '2022-05-11'),
(28, 'Nurse', 'Depart7', '2021-02-14'),
(16, 'Doctor', 'Depart9', '2021-09-10'),
(34, 'Nurse', 'Depart7', '2021-06-03'),
(6, 'Doctor', 'Depart3', '2021-03-25'),
(41, 'Nurse', 'Depart7', '2021-11-25'),
(18, 'Receptionist', 'Depart5', '2022-07-16'),
(7, 'Receptionist', 'Depart5', '2022-03-20'),
(31, 'Nurse', 'Depart7', '2021-03-12'),
(1, 'Receptionist', 'Depart5', '2022-01-10'),
(39, 'Nurse', 'Depart7', '2021-10-10'),
(20, 'Doctor', 'Depart2', '2021-12-01'),
(45, 'Nurse', 'Depart7', '2022-02-15'),
(2, 'Doctor', 'Depart1', '2021-01-15'),
(11, 'Doctor', 'Depart6', '2021-06-22'),
(49, 'Nurse', 'Depart7', '2022-05-08'),
(25, 'Doctor', 'Depart8', '2022-03-08'),
(36, 'Nurse', 'Depart7', '2021-07-21'),
(8, 'Doctor', 'Depart4', '2021-04-10'),
(3, 'Receptionist', 'Depart5', '2022-02-14'),
(27, 'Nurse', 'Depart7', '2021-01-20'),
(21, 'Receptionist', 'Depart5', '2022-08-25'),
(32, 'Nurse', 'Depart7', '2021-04-06'),
(15, 'Receptionist', 'Depart5', '2022-06-09'),
(17, 'Doctor', 'Depart10', '2021-10-05'),
(29, 'Nurse', 'Depart7', '2021-03-01'),
(14, 'Doctor', 'Depart8', '2021-08-15'),
(9, 'Doctor', 'Depart5', '2021-05-18'),
(10, 'Receptionist', 'Depart5', '2022-04-01'),
(22, 'Doctor', 'Depart3', '2022-01-09'),
(30, 'Receptionist', 'Depart5', '2022-10-05'),
(4, 'Doctor', 'Depart2', '2021-02-20'),
(24, 'Receptionist', 'Depart5', '2022-09-13'),
(40, 'Nurse', 'Depart7', '2021-11-04'),
(48, 'Nurse', 'Depart7', '2022-04-13'),
(26, 'Doctor', 'Depart6', '2022-04-21'),
(19, 'Doctor', 'Depart1', '2021-11-12'),
(43, 'Nurse', 'Depart7', '2022-01-07'),
(33, 'Nurse', 'Depart7', '2021-05-09'),
(37, 'Nurse', 'Depart7', '2021-08-16'),
(44, 'Nurse', 'Depart7', '2022-01-28'),
(5, 'Nurse', 'Depart7', '2021-01-11'),
(12, 'Doctor', 'Depart7', '2021-07-30'),
(50, 'Nurse', 'Depart7', '2022-05-30'),
(46, 'Nurse', 'Depart7', '2022-03-05'),
(38, 'Nurse', 'Depart7', '2021-09-02'),
(42, 'Nurse', 'Depart7', '2021-12-18'),
(23, 'Doctor', 'Depart7', '2022-02-17'),
(35, 'Nurse', 'Depart7', '2021-06-30'),
(51, 'Nurse', 'Depart7', '2022-06-20'),
(52, 'Nurse', 'Depart7', '2022-07-11'),
(47, 'Nurse', 'Depart7', '2022-03-22'),
(53, 'Nurse', 'Depart7', '2022-08-03'),
(54, 'Nurse', 'Depart7', '2022-08-25'),
(55, 'Nurse', 'Depart7', '2022-09-15'),
(56, 'Nurse', 'Depart7', '2022-10-01'),
(57, 'Doctor', 'Depart3', '2025-06-17');

-- Inserting records into Receptionist table
INSERT INTO Receptionist (Receptionist_ID, R_Name, Number, Email, Employee_ID) VALUES
(1, 'Ayesha Khan', '0301-4567890', 'ayesha.khan@hospital.pk', 1),
(2, 'Emily Smith', '0323-1122334', 'emily.smith@hospital.com', 3),
(3, 'Fatima Noor', '0302-9988776', 'fatima.noor@hospital.pk', 7),
(4, 'John Carter', '0345-6677889', 'john.carter@hospital.com', 10),
(5, 'Hina Shah', '0333-2211445', 'hina.shah@hospital.pk', 13),
(6, 'Sophie Turner', '0312-7766554', 'sophie.turner@hospital.com', 15),
(7, 'Mehwish Ali', '0309-1234567', 'mehwish.ali@hospital.pk', 18),
(8, 'Jake Wilson', '0311-9988223', 'jake.wilson@hospital.com', 21),
(9, 'Zara Ahmed', '0340-4561221', 'zara.ahmed@hospital.pk', 24),
(10, 'Daniel Brown', '0307-8899001', 'daniel.brown@hospital.com', 30);

-- Inserting records into Doctor table
INSERT INTO Doctor (Doctor_ID, Doctor_Name, Specialization, Contact, Email, License_Number, Employee_ID) VALUES
(1, 'Dr. Asim Qureshi', 'Cardiology', '0301-5566778', 'asim.qureshi@hospital.pk', 'PKC-1001', 2),
(2, 'Dr. Emily Grace', 'Neurology', '0312-8899002', 'emily.grace@hospital.com', 'USN-2002', 4),
(3, 'Dr. Sarah Malik', 'Emergency', '0323-4567891', 'sarah.malik@hospital.pk', 'PKE-1003', 6),
(4, 'Dr. John Matthews', 'Outpatient Services', '0341-6655884', 'john.matthews@hospital.com', 'USO-2004', 8),
(5, 'Dr. Naveed Khan', 'Human Resources', '0306-7896542', 'naveed.khan@hospital.pk', 'PKH-1005', 9),
(6, 'Dr. Lisa Ray', 'Radiology', '0314-1223344', 'lisa.ray@hospital.com', 'USR-2006', 11),
(7, 'Dr. Hamza Shah', 'Pediatrics', '0333-9988776', 'hamza.shah@hospital.pk', 'PKP-1007', 12),
(8, 'Dr. Andrew James', 'Internal Medicine', '0322-5544333', 'andrew.james@hospital.com', 'USI-2008', 14),
(9, 'Dr. Mahnoor Iqbal', 'Oncology', '0345-2233445', 'mahnoor.iqbal@hospital.pk', 'PKO-1009', 16),
(10, 'Dr. Ethan Brown', 'Surgery', '0307-3344556', 'ethan.brown@hospital.com', 'USS-2010', 17),
(11, 'Dr. Huma Tariq', 'Cardiology', '0310-4567123', 'huma.tariq@hospital.pk', 'PKC-1011', 19),
(12, 'Dr. Oliver Stone', 'Neurology', '0331-6677885', 'oliver.stone@hospital.com', 'USN-2012', 20),
(13, 'Dr. Zainab Rafiq', 'Emergency', '0343-9988771', 'zainab.rafiq@hospital.pk', 'PKE-1013', 22),
(14, 'Dr. George White', 'Pediatrics', '0308-7788990', 'george.white@hospital.com', 'PKP-1014', 23),
(15, 'Dr. Bilal Javed', 'Internal Medicine', '0325-6655443', 'bilal.javed@hospital.pk', 'PKI-1015', 25),
(16, 'Dr. Emma Clark', 'Radiology', '0311-3322110', 'emma.clark@hospital.com', 'USR-2016', 26),
(17, 'Dr. Arsalan Shah', 'Emergency', '0315-8899776', 'arsalan.shah@hospital.pk', 'PKE-1017', 57);

-- Inserting records into Appointment table
INSERT INTO Appointment (Appointment_ID, Patient_ID, Doctor_ID, Receptionist_ID, Date, Time, Status) VALUES
(1, 5, 2, 1, '2025-06-01', '09:00:00', 'Completed'),
(2, 12, 5, 3, '2025-06-02', '10:30:00', 'Completed'),
(3, 8, 7, 2, '2025-06-03', '14:00:00', 'Cancelled'),
(4, 17, 1, 1, '2025-06-04', '11:45:00', 'Completed'),
(5, 3, 10, 4, '2025-06-05', '13:00:00', 'Completed'),
(6, 20, 3, 2, '2025-06-06', '15:30:00', 'Scheduled'),
(7, 10, 4, 3, '2025-06-07', '09:15:00', 'Scheduled'),
(8, 15, 12, 5, '2025-06-08', '10:00:00', 'Cancelled'),
(9, 7, 6, 2, '2025-06-09', '16:00:00', 'Completed'),
(10, 28, 11, 1, '2025-06-10', '11:30:00', 'Scheduled'),
(11, 1, 9, 4, '2025-06-11', '12:45:00', 'Completed'),
(12, 19, 8, 3, '2025-06-12', '14:15:00', 'Scheduled'),
(13, 2, 13, 2, '2025-06-13', '15:00:00', 'Scheduled'),
(14, 23, 14, 5, '2025-06-14', '10:45:00', 'Cancelled'),
(15, 6, 15, 1, '2025-06-15', '09:00:00', 'Completed'),
(16, 11, 16, 4, '2025-06-16', '13:30:00', 'Scheduled'),
(17, 13, 1, 2, '2025-06-17', '12:00:00', 'Scheduled'),
(18, 21, 2, 3, '2025-06-18', '10:15:00', 'Completed'),
(19, 14, 3, 1, '2025-06-19', '11:00:00', 'Scheduled'),
(20, 9, 4, 2, '2025-06-20', '16:45:00', 'Scheduled'),
(21, 25, 5, 3, '2025-06-21', '14:30:00', 'Scheduled'),
(22, 26, 6, 5, '2025-06-22', '15:15:00', 'Completed'),
(23, 4, 7, 4, '2025-06-23', '10:00:00', 'Scheduled'),
(24, 16, 8, 1, '2025-06-24', '11:30:00', 'Cancelled'),
(25, 30, 9, 2, '2025-06-25', '12:45:00', 'Completed'),
(26, 18, 10, 3, '2025-06-26', '09:00:00', 'Scheduled'),
(27, 22, 11, 4, '2025-06-27', '14:15:00', 'Scheduled'),
(28, 24, 12, 5, '2025-06-28', '15:30:00', 'Scheduled'),
(29, 27, 13, 1, '2025-06-29', '16:00:00', 'Completed'),
(30, 29, 14, 2, '2025-06-30', '10:45:00', 'Scheduled');

-- Inserting records into Diagnosis table
INSERT INTO Diagnosis (Diagnosis_ID, Appointment_ID, Patient_ID, Doctor_ID, Description, Date) VALUES
(1, 1, 5, 2, 'Mild upper respiratory infection', '2025-06-01'),
(2, 2, 12, 5, 'Seasonal allergies with sneezing', '2025-06-02'),
(3, 3, 8, 7, 'Sprained ankle', '2025-06-03'),
(4, 4, 17, 1, 'Gastric ulcer symptoms', '2025-06-04'),
(5, 5, 3, 10, 'Type 2 diabetes newly diagnosed', '2025-06-05'),
(6, 6, 20, 3, 'Migraine with aura', '2025-06-06'),
(7, 7, 10, 4, 'Common cold and mild fever', '2025-06-07'),
(8, 8, 15, 12, 'Chronic tonsillitis', '2025-06-08'),
(9, 9, 7, 6, 'Iron-deficiency anemia', '2025-06-09'),
(10, 10, 28, 11, 'Urinary tract infection', '2025-06-10'),
(11, 11, 1, 9, 'Mild depression, referred to therapist', '2025-06-11'),
(12, 12, 19, 8, 'Acute bronchitis', '2025-06-12'),
(13, 13, 2, 13, 'Lower back pain', '2025-06-13'),
(14, 14, 23, 14, 'Allergic skin rash', '2025-06-14'),
(15, 15, 6, 15, 'Hypertension stage 1', '2025-06-15'),
(16, 16, 11, 16, 'Asthma exacerbation', '2025-06-16'),
(17, 17, 13, 1, 'Thyroid imbalance', '2025-06-17'),
(18, 18, 21, 2, 'Viral fever with fatigue', '2025-06-18'),
(19, 19, 14, 3, 'Knee joint inflammation', '2025-06-19'),
(20, 20, 9, 4, 'High cholesterol', '2025-06-20'),
(21, 21, 25, 5, 'Eczema flare-up', '2025-06-21'),
(22, 22, 26, 6, 'Peptic ulcer symptoms', '2025-06-22'),
(23, 23, 4, 7, 'Mild dehydration', '2025-06-23'),
(24, 24, 16, 8, 'Sore throat and viral infection', '2025-06-24'),
(25, 25, 30, 9, 'Kidney stone symptoms', '2025-06-25'),
(26, 26, 18, 10, 'Sinus infection', '2025-06-26'),
(27, 27, 22, 11, 'Hyperthyroidism', '2025-06-27'),
(28, 28, 24, 12, 'Tension-type headache', '2025-06-28'),
(29, 29, 27, 13, 'Scalp psoriasis', '2025-06-29'),
(30, 30, 29, 14, 'Chronic constipation', '2025-06-30');

-- Inserting records into Treatment table
INSERT INTO Treatment (Treatment_ID, Diagnosis_ID, Treatment_Type, Description, Treatment_Cost) VALUES
(1, 1, 'Medical', 'Prescribed antibiotics and rest', 1500),
(2, 2, 'Medical', 'Antihistamines and nasal spray', 1800),
(3, 3, 'Therapy', 'Physical therapy for ankle recovery', 3000),
(4, 4, 'Medical', 'Antacids and proton pump inhibitors', 2500),
(5, 5, 'Medical', 'Metformin prescribed, dietary counseling', 4000),
(6, 6, 'Medical', 'Migraine medication and follow-up', 2200),
(7, 7, 'Medical', 'Paracetamol and fluids recommended', 800),
(8, 8, 'Surgical', 'Tonsillectomy planned', 15000),
(9, 9, 'Medical', 'Iron supplements and nutrition plan', 1700),
(10, 10, 'Medical', 'Antibiotics and hydration advice', 2100),
(11, 11, 'Therapy', 'Psychological counseling sessions', 3500),
(12, 12, 'Medical', 'Cough suppressants and antibiotics', 1900),
(13, 13, 'Therapy', 'Back exercises and analgesics', 2800),
(14, 14, 'Medical', 'Antihistamines and topical cream', 2000),
(15, 15, 'Medical', 'Blood pressure medication initiated', 3300),
(16, 16, 'Medical', 'Inhaler and bronchodilator prescribed', 2700),
(17, 17, 'Medical', 'Thyroid medication and monitoring', 3100),
(18, 18, 'Medical', 'Fever reducers and vitamin C', 1600),
(19, 19, 'Therapy', 'Physiotherapy sessions for joint pain', 4000),
(20, 20, 'Medical', 'Statins and dietary control', 3600),
(21, 21, 'Medical', 'Moisturizers and antihistamines', 2400),
(22, 22, 'Medical', 'PPI treatment and follow-up', 2300),
(23, 23, 'Medical', 'IV fluids and electrolytes', 2800),
(24, 24, 'Medical', 'Throat lozenges and antibiotics', 1800),
(25, 25, 'Surgical', 'Lithotripsy procedure for stone removal', 18000),
(26, 26, 'Medical', 'Antibiotics and steam inhalation', 1900),
(27, 27, 'Medical', 'Anti-thyroid drugs initiated', 3100),
(28, 28, 'Medical', 'Pain relievers and stress management', 2200),
(29, 29, 'Medical', 'Medicated shampoo and creams', 2600),
(30, 30, 'Medical', 'Laxatives and fiber supplements', 2000);

-- Inserting records into Room table
INSERT INTO Room (Room_ID, Room_Number, Type, Status) VALUES
(1, 'ICU-101', 'ICU', 'Occupied'),
(2, 'GEN-102', 'General', 'Available'),
(3, 'PRI-103', 'Private', 'Occupied'),
(4, 'ICU-104', 'ICU', 'Available'),
(5, 'GEN-105', 'General', 'Occupied'),
(6, 'PRI-106', 'Private', 'Available'),
(7, 'GEN-107', 'General', 'Occupied'),
(8, 'ICU-108', 'ICU', 'Available'),
(9, 'PRI-109', 'Private', 'Occupied'),
(10, 'GEN-110', 'General', 'Available'),
(11, 'ICU-111', 'ICU', 'Occupied'),
(12, 'PRI-112', 'Private', 'Available'),
(13, 'GEN-113', 'General', 'Occupied'),
(14, 'ICU-114', 'ICU', 'Available'),
(15, 'PRI-115', 'Private', 'Occupied'),
(16, 'GEN-116', 'General', 'Available'),
(17, 'ICU-117', 'ICU', 'Occupied'),
(18, 'PRI-118', 'Private', 'Available'),
(19, 'GEN-119', 'General', 'Occupied'),
(20, 'ICU-120', 'ICU', 'Available'),
(21, 'PRI-121', 'Private', 'Occupied'),
(22, 'GEN-122', 'General', 'Available'),
(23, 'ICU-123', 'ICU', 'Occupied'),
(24, 'PRI-124', 'Private', 'Available'),
(25, 'GEN-125', 'General', 'Occupied'),
(26, 'ICU-126', 'ICU', 'Available'),
(27, 'PRI-127', 'Private', 'Occupied'),
(28, 'GEN-128', 'General', 'Available'),
(29, 'ICU-129', 'ICU', 'Occupied'),
(30, 'PRI-130', 'Private', 'Available');

-- Inserting records into Admission table
INSERT INTO Admission (Admission_ID, Patient_ID, Diagnosis_ID, Room_ID, Admission_Date, Discharge_Date, Room_Cost) VALUES
(1, 1, 1, 1, '2024-12-01', '2024-12-05', 10000),
(2, 2, 2, 3, '2024-11-15', '2024-11-18', 15000),
(3, 3, 3, 5, '2025-01-10', '2025-01-12', 8000),
(4, 4, 4, 2, '2024-10-05', '2024-10-08', 9000),
(5, 5, 5, 4, '2025-02-11', '2025-02-15', 12000),
(6, 6, 6, 6, '2025-03-01', '2025-03-04', 13000),
(7, 7, 7, 7, '2025-04-01', '2025-04-06', 16000),
(8, 8, 8, 8, '2024-09-10', '2024-09-14', 9500),
(9, 9, 9, 9, '2025-05-01', '2025-05-03', 7000),
(10, 10, 10, 10, '2024-12-20', '2024-12-24', 14000),
(11, 11, 11, 11, '2025-01-15', '2025-01-18', 11000),
(12, 12, 12, 12, '2025-03-22', '2025-03-26', 12500),
(13, 13, 13, 13, '2025-02-28', '2025-03-01', 9000),
(14, 14, 14, 14, '2025-04-15', '2025-04-17', 11500),
(15, 15, 15, 15, '2024-11-05', '2024-11-09', 10000),
(16, 16, 16, 16, '2024-12-12', '2024-12-15', 8500),
(17, 17, 17, 17, '2025-01-20', '2025-01-23', 15000),
(18, 18, 18, 18, '2025-02-05', '2025-02-07', 9500),
(19, 19, 19, 19, '2025-04-10', '2025-04-14', 13000),
(20, 20, 20, 20, '2025-03-10', '2025-03-12', 11000),
(21, 21, 21, 1, '2025-02-25', '2025-02-28', 10000),
(22, 22, 22, 2, '2024-10-18', '2024-10-20', 9000),
(23, 23, 23, 3, '2025-01-05', '2025-01-08', 15000),
(24, 24, 24, 4, '2025-03-15', '2025-03-19', 12000),
(25, 25, 25, 5, '2025-04-22', '2025-04-26', 8500),
(26, 26, 26, 6, '2024-12-01', '2024-12-05', 13500),
(27, 27, 27, 7, '2025-02-01', '2025-02-04', 14000),
(28, 28, 28, 8, '2025-01-18', '2025-01-21', 9500),
(29, 29, 29, 9, '2025-03-30', '2025-04-03', 12500),
(30, 30, 30, 10, '2025-05-05', '2025-05-08', 15000);

-- Inserting records into Nurse table
INSERT INTO Nurse (Nurse_ID, Nurse_Name, Contact_Number, Shift_Timings, Room_ID, Employee_ID) VALUES
(1, 'Ayesha Khan', 03001234567, 'Morning', 1, 5),
(2, 'Sarah Williams', '+447911123456', 'Evening', 2, 27),
(3, 'Nadia Akhtar', 03123456789, 'Night', 3, 28),
(4, 'Emily Chen', '+8613800138000', 'Morning', 4, 29),
(5, 'Mehwish Tariq', 03337654321, 'Evening', 5, 31),
(6, 'John Mathews', '+16135550100', 'Night', 6, 32),
(7, 'Fatima Noor', 03451239876, 'Morning', 7, 33),
(8, 'Sana Farooq', 03031234567, 'Evening', 8, 34),
(9, 'Rachel Green', '+19295551234', 'Night', 9, 35),
(10, 'Zainab Rehman', 03216549876, 'Morning', 10, 36),
(11, 'Tina Patel', '+918123456789', 'Evening', 11, 37),
(12, 'Bushra Qureshi', 03139874563, 'Night', 12, 38),
(13, 'Maria Gomez', '+5215550001234', 'Morning', 13, 39),
(14, 'Anum Javed', 03009876543, 'Evening', 14, 40),
(15, 'Lucy Brown', '+61412345678', 'Night', 15, 41),
(16, 'Iqra Yousuf', 03421234567, 'Morning', 16, 42),
(17, 'Amna Shakeel', 03016783452, 'Evening', 17, 43),
(18, 'Linda Park', '+821012345678', 'Night', 18, 44),
(19, 'Kiran Shah', 03111222333, 'Morning', 19, 45),
(20, 'Maryam Abbas', 03234567891, 'Evening', 20, 46),
(21, 'Anna Ivanova', '+74951234567', 'Night', 21, 47),
(22, 'Noor Fatima', 03329876543, 'Morning', 22, 48),
(23, 'Sara Daniel', '+4915112345678', 'Evening', 23, 49),
(24, 'Mina Ali', 03041239876, 'Night', 24, 50),
(25, 'Zoya Siddiqui', 03451234555, 'Morning', 25, 51),
(26, 'Habiba Zahid', 03112345678, 'Evening', 26, 52),
(27, 'Jessica Lee', '+81312345678', 'Night', 27, 53),
(28, 'Maha Saeed', 03013456789, 'Morning', 28, 54),
(29, 'Aleena Babar', 03221234567, 'Evening', 29, 55),
(30, 'Asma Haroon', 03314567890, 'Night', 30, 56);

-- Inserting records into Medical_History table
INSERT INTO Medical_History (History_ID, Patient_ID, Doctor_ID, Description, Date_Recorded) VALUES
(1, 12, 4, 'History of seasonal asthma during childhood.', '2020-03-10'),
(2, 3, 1, 'Diagnosed with hypertension in 2021.', '2021-06-15'),
(3, 17, 6, 'Suffered minor concussion after a road accident.', '2019-12-22'),
(4, 5, 3, 'Underwent appendectomy in 2018.', '2018-11-05'),
(5, 1, 8, 'Type 2 diabetes managed with oral medication.', '2020-01-10'),
(6, 11, 5, 'History of migraine and tension headaches.', '2022-05-17'),
(7, 8, 2, 'Fractured right arm in a sports injury.', '2019-04-09'),
(8, 20, 10, 'Diagnosed with PCOS, ongoing treatment.', '2023-02-14'),
(9, 15, 7, 'Treated for peptic ulcer successfully.', '2020-08-21'),
(10, 4, 11, 'Chronic allergic rhinitis since teenage.', '2021-09-30'),
(11, 19, 9, 'Underwent gallbladder removal surgery.', '2019-03-12'),
(12, 7, 13, 'Diagnosed with mild scoliosis.', '2022-01-19'),
(13, 23, 12, 'Past history of tuberculosis treatment.', '2018-06-08'),
(14, 2, 6, 'Recovering from COVID-19 complications.', '2021-12-05'),
(15, 6, 15, 'History of depression, therapy ongoing.', '2022-04-22'),
(16, 14, 16, 'Treated for kidney stones.', '2020-07-07'),
(17, 26, 1, 'Suffered from severe food poisoning.', '2019-11-29'),
(18, 13, 2, 'Underwent LASIK eye surgery.', '2023-03-03'),
(19, 10, 5, 'Chronic back pain due to poor posture.', '2021-10-13'),
(20, 21, 7, 'Vaccinated against Hepatitis B.', '2020-05-04'),
(21, 9, 3, 'Recovered from dengue fever.', '2018-08-15'),
(22, 18, 14, 'Diagnosed with hypothyroidism.', '2022-06-28'),
(23, 24, 13, 'History of anxiety and panic attacks.', '2021-07-16'),
(24, 27, 12, 'Previously treated for pneumonia.', '2019-10-20'),
(25, 25, 11, 'Tonsillectomy at age 10.', '2010-02-18'),
(26, 30, 9, 'Multiple dental fillings due to cavities.', '2020-11-30'),
(27, 28, 6, 'Knee ligament surgery after sports injury.', '2018-01-26'),
(28, 29, 10, 'Diagnosed with eczema and skin allergies.', '2021-03-08'),
(29, 22, 8, 'Family history of cardiovascular disease.', '2022-09-19'),
(30, 16, 4, 'Recovered from H1N1 flu.', '2020-12-12');

-- Inserting records into Lab table
INSERT INTO Lab (Lab_ID, DiagnosisID) VALUES
('L1', 5), ('L2', 9), ('L3', 14), ('L4', 1), ('L5', 3), ('L6', 7), ('L7', 6), ('L8', 2), ('L9', 8), ('L10', 10),
('L11', 4), ('L12', 11), ('L13', 12), ('L14', 13), ('L15', 15), ('L16', 16), ('L17', 17), ('L18', 18), ('L19', 19), ('L20', 20),
('L21', 21), ('L22', 22), ('L23', 23), ('L24', 24), ('L25', 25), ('L26', 26), ('L27', 27), ('L28', 28), ('L29', 29), ('L30', 30);

-- Inserting records into Test table
INSERT INTO Test (Test_ID, Lab_ID, Test_Name, Description, Test_Cost) VALUES
('TEST1', 'L1', 'CBC', 'Complete Blood Count', 1500),
('TEST2', 'L2', 'Lipid Profile', 'Cholesterol and Triglycerides', 2800),
('TEST3', 'L3', 'Liver Function Test', 'Check liver health', 3200),
('TEST4', 'L4', 'Urinalysis', 'Urine examination', 1200),
('TEST5', 'L5', 'Thyroid Panel', 'TSH, T3, T4', 2500),
('TEST6', 'L6', 'COVID-19 PCR', 'COVID Testing', 4500),
('TEST7', 'L7', 'Blood Glucose', 'Fasting & Random sugar', 900),
('TEST8', 'L8', 'MRI Brain', 'Brain MRI Scan', 7500),
('TEST9', 'L9', 'CT Abdomen', 'Abdominal CT scan', 6200),
('TEST10', 'L10', 'Vitamin D', 'Vitamin D Level Test', 2100),
('TEST11', 'L11', 'Malaria Test', 'Parasite Check', 1100),
('TEST12', 'L12', 'Dengue NS1', 'Dengue Detection', 1800),
('TEST13', 'L13', 'Hepatitis B', 'Hep B Surface Antigen', 2000),
('TEST14', 'L14', 'Hepatitis C', 'HCV Antibodies', 2000),
('TEST15', 'L15', 'Stool Culture', 'Infection Check', 1300),
('TEST16', 'L16', 'Blood Group', 'ABO & Rh Typing', 700),
('TEST17', 'L17', 'Electrolyte Panel', 'Na+, K+, Cl-', 1700),
('TEST18', 'L18', 'HbA1c', 'Long-term Sugar Level', 1600),
('TEST19', 'L19', 'Liver Function Test', 'Check liver health', 3000),
('TEST20', 'L20', 'X-Ray Chest', 'Lung X-Ray', 1500),
('TEST21', 'L21', 'CT Abdomen', 'Abdominal CT scan', 6200),
('TEST22', 'L22', 'Thyroid Panel', 'TSH, T3, T4', 2700),
('TEST23', 'L23', 'CBC', 'Complete Blood Count', 1600),
('TEST24', 'L24', 'MRI Brain', 'Brain MRI Scan', 8000),
('TEST25', 'L25', 'Urinalysis', 'Urine examination', 1000),
('TEST26', 'L26', 'COVID-19 PCR', 'COVID Testing', 5000),
('TEST27', 'L27', 'Malaria Test', 'Parasite Check', 1000),
('TEST28', 'L28', 'Hepatitis B', 'Hep B Surface Antigen', 2000),
('TEST29', 'L29', 'Blood Glucose', 'Fasting & Random sugar', 950),
('TEST30', 'L30', 'Stool Culture', 'Infection Check', 1400);

-- Inserting records into Prescription table
INSERT INTO Prescription (PrescriptionID, DiagnosisID) VALUES
('PRX1', 1),
('PRX2', 2),
('PRX3', 3),
('PRX4', 4),
('PRX5', 5),
('PRX6', 6),
('PRX7', 7),
('PRX8', 8),
('PRX9', 9),
('PRX10', 10),
('PRX11', 11),
('PRX12', 12),
('PRX13', 13),
('PRX14', 14),
('PRX15', 15),
('PRX16', 16),
('PRX17', 17),
('PRX18', 18),
('PRX19', 19),
('PRX20', 20),
('PRX21', 21),
('PRX22', 22),
('PRX23', 23),
('PRX24', 24),
('PRX25', 25),
('PRX26', 26),
('PRX27', 27),
('PRX28', 28),
('PRX29', 29),
('PRX30', 30);

-- Inserting records into PrescriptionMedicine table
INSERT INTO PrescriptionMedicine (PrescriptionMedicineID, PrescriptionID, MedicineName, Dosage, Instructions, Duration) VALUES
('MED1', 'PRX1', 'Paracetamol', '2 tablets', 'After meal', '5 days'),
('MED2', 'PRX2', 'Amoxicillin', '1 tablet', 'Before meal', '7 days'),
('MED3', 'PRX3', 'Ibuprofen', '1 tablet', 'With water', '3 days'),
('MED4', 'PRX4', 'Omeprazole', '1 tablet', 'Empty stomach', '10 days'),
('MED5', 'PRX5', 'Ciprofloxacin', '2 tablets', 'After breakfast', '5 days'),
('MED6', 'PRX6', 'Metformin', '1 tablet', 'Twice daily', '30 days'),
('MED7', 'PRX7', 'Losartan', '1 tablet', 'Once at night', '60 days'),
('MED8', 'PRX8', 'Cetirizine', '1 tablet', 'After meal', '7 days'),
('MED9', 'PRX9', 'Azithromycin', '1 tablet', 'Before meal', '3 days'),
('MED10', 'PRX10', 'Dexamethasone', '1 tablet', 'With water', '4 days'),
('MED11', 'PRX11', 'Atorvastatin', '1 tablet', 'After meal', '90 days'),
('MED12', 'PRX12', 'Levothyroxine', '1 tablet', 'Empty stomach', '30 days'),
('MED13', 'PRX13', 'Insulin', '1 shot', 'Twice daily', '30 days'),
('MED14', 'PRX14', 'Clopidogrel', '1 tablet', 'With water', '60 days'),
('MED15', 'PRX15', 'Paracetamol', '2 tablets', 'After meal', '3 days'),
('MED16', 'PRX16', 'Omeprazole', '1 tablet', 'Before meal', '10 days'),
('MED17', 'PRX17', 'Ciprofloxacin', '1 tablet', 'Twice daily', '7 days'),
('MED18', 'PRX18', 'Amoxicillin', '1 tablet', 'After meal', '5 days'),
('MED19', 'PRX19', 'Azithromycin', '1 tablet', 'Empty stomach', '3 days'),
('MED20', 'PRX20', 'Levothyroxine', '1 tablet', 'Before meal', '30 days'),
('MED21', 'PRX21', 'Insulin', '1 shot', 'Twice daily', '60 days'),
('MED22', 'PRX22', 'Cetirizine', '1 tablet', 'At night', '5 days'),
('MED23', 'PRX23', 'Metformin', '1 tablet', 'After breakfast', '60 days'),
('MED24', 'PRX24', 'Paracetamol', '2 tablets', 'After meal', '3 days'),
('MED25', 'PRX25', 'Ibuprofen', '1 tablet', 'Before meal', '5 days'),
('MED26', 'PRX26', 'Ciprofloxacin', '1 tablet', 'After meal', '7 days'),
('MED27', 'PRX27', 'Omeprazole', '1 tablet', 'Before meal', '15 days'),
('MED28', 'PRX28', 'Clopidogrel', '1 tablet', 'With water', '60 days'),
('MED29', 'PRX29', 'Dexamethasone', '1 tablet', 'After breakfast', '7 days'),
('MED30', 'PRX30', 'Atorvastatin', '1 tablet', 'With water', '90 days');

-- Inserting records into Bill table
INSERT INTO Bill (Bill_ID, Patient_ID, Appointment_ID, Receptionist_ID, Amount, Bill_Date, Bill_Status) VALUES
(1,  5,  1,  1,  5000, '2025-06-01', 'Paid'),
(2,  12, 2,  2,  3500, '2025-06-02', 'Paid'),
(3,  8,  3,  3,  2500, '2025-06-03', 'Refunded'),
(4,  17, 4,  4,  6000, '2025-06-04', 'Paid'),
(5,  3,  5,  5,  4500, '2025-06-05', 'Paid'),
(6,  20, 6,  6,  5200, '2025-06-06', 'Unpaid'),
(7,  10, 7,  7,  3100, '2025-06-07', 'Unpaid'),
(8,  15, 8,  8,  4700, '2025-06-08', 'Refunded'),
(9,  7,  9,  9,  3800, '2025-06-09', 'Paid'),
(10, 28, 10, 10, 6100, '2025-06-10', 'Unpaid'),
(11, 1,  11, 1,  2900, '2025-06-11', 'Paid'),
(12, 19, 12, 2,  5300, '2025-06-12', 'Paid'),
(13, 2,  13, 3,  4000, '2025-06-13', 'Unpaid'),
(14, 23, 14, 4,  3600, '2025-06-14', 'Refunded'),
(15, 6,  15, 5,  4800, '2025-06-15', 'Paid'),
(16, 11, 16, 6,  5500, '2025-06-16', 'Unpaid'),
(17, 13, 17, 7,  4200, '2025-06-17', 'Paid'),
(18, 21, 18, 8,  3900, '2025-06-18', 'Paid'),
(19, 14, 19, 9,  6100, '2025-06-19', 'Unpaid'),
(20, 9,  20, 10, 4300, '2025-06-20', 'Paid'),
(21, 25, 21, 1,  4700, '2025-06-21', 'Unpaid'),
(22, 26, 22, 2,  3800, '2025-06-22', 'Paid'),
(23, 4,  23, 3,  3100, '2025-06-23', 'Unpaid'),
(24, 16, 24, 4,  5200, '2025-06-24', 'Refunded'),
(25, 30, 25, 5,  6000, '2025-06-25', 'Paid'),
(26, 18, 26, 6,  4500, '2025-06-26', 'Unpaid'),
(27, 22, 27, 7,  4900, '2025-06-27', 'Paid'),
(28, 24, 28, 8,  5300, '2025-06-28', 'Unpaid'),
(29, 27, 29, 9,  4100, '2025-06-29', 'Paid'),
(30, 29, 30, 10, 5800, '2025-06-30', 'Unpaid');

-- Selecting all records from Patient table
SELECT * FROM Patient;

-- Selecting patient names with Blood Type 'O+'
SELECT PatientName, Blood_Type
FROM Patient
WHERE Blood_Type = 'O+'
ORDER BY PatientName;

-- Selecting limited records from Doctor table
SELECT * FROM Doctor
LIMIT 5;

-- Joining Appointment, Patient, and Doctor tables
SELECT a.Appointment_ID, p.PatientName AS Patient, d.Doctor_Name AS Doctor, a.Date
FROM Appointment a
INNER JOIN Patient p 
ON a.Patient_ID = p.Patient_ID
INNER JOIN Doctor d 
ON a.Doctor_ID = d.Doctor_ID;

-- Finding patients who have not been admitted
SELECT p.PatientName
FROM Patient p
LEFT JOIN Admission adm 
ON p.Patient_ID = adm.Patient_ID
WHERE adm.Admission_ID IS NULL;

-- List room numbers and patient occupants
SELECT r.Room_Number, p.PatientName AS Occupant
FROM Room r
LEFT JOIN Admission adm 
ON r.Room_ID = adm.Room_ID
LEFT JOIN Patient p 
ON adm.Patient_ID = p.Patient_ID;

-- Count employees per department
SELECT Department_ID, COUNT(*) AS NumEmployees
FROM Employee
GROUP BY Department_ID
ORDER BY Department_ID ASC;

-- Calculating average room cost
SELECT AVG(Room_Cost) AS AvgRoomCost
FROM Admission;

-- Finding highest treatment cost
SELECT MAX(Treatment_Cost) AS HighestTreatmentCost
FROM Treatment;

-- Patients with scheduled appointments
SELECT PatientName
FROM Patient
WHERE Patient_ID IN (
	SELECT Patient_ID
	FROM Appointment
	WHERE Status = 'Scheduled'
);

-- Patients who have paid all their bills
SELECT p.PatientName
FROM Patient p
WHERE NOT EXISTS (
	SELECT 1
	FROM Bill b
	WHERE b.Patient_ID = p.Patient_ID
	AND b.Bill_Status = 'Unpaid'
);

-- Average bill amount above overall average
SELECT AVG(Amount) AS AvgAboveOverall
FROM Bill
WHERE Amount > (
	SELECT AVG(Amount)
	FROM Bill
);

-- Selecting all records from Patient table
SELECT * FROM Patient;

-- Updating patient address
UPDATE Patient
SET Address = 'Ho-- Selecting the database for use
use #99, New Address, Lahore'
WHERE Patient_ID = 1;

SELECT * FROM Patient;

SELECT * FROM Bill;

-- Updating bill status
UPDATE Bill
SET Bill_Status = 'Paid'
WHERE Bill_ID = 6;

SELECT * FROM Bill;

SELECT * FROM Doctor;

-- Updating doctor specialization
UPDATE Doctor
SET Specialization = 'General Medicine'
WHERE Doctor_ID = 8;

SELECT * FROM Doctor;

SELECT * FROM Appointment;

-- Deleting cancelled appointments
DELETE FROM Appointment
WHERE Status = 'Cancelled';

SELECT * FROM Appointment;

SELECT * FROM PrescriptionMedicine;

-- Deleting prescription medicines with '3 days' duration
DELETE FROM PrescriptionMedicine
WHERE Duration = '3 days';

SELECT * FROM PrescriptionMedicine;

-- Deleting patient with ID 30
DELETE FROM Patient
WHERE Patient_ID = 30;

-- Displaying patient contact info
SELECT Patient_ID AS ID, PatientName AS Name, Contact_Number AS Contact
FROM Patient
ORDER BY PatientName ASC;

-- Joining Doctor and Employee
SELECT d.Doctor_Name AS DocName, e.Department_ID AS DeptID
FROM Doctor d
JOIN Employee e 
ON d.Employee_ID = e.Employee_ID;

-- Joining Appointment and Receptionist
SELECT a.Appointment_ID AS ApptID, a.Date AS ApptDate, r.R_Name AS ReceptionistName
FROM Appointment a
JOIN Receptionist r 
ON a.Receptionist_ID = r.Receptionist_ID;

-- Displaying patient info using CONCAT
SELECT CONCAT(PatientName, ' (ID:', Patient_ID, ')') AS PatientInfo
FROM Patient;

-- Generates a readable doctor profile summary combining name, specialization, department, and contact.
SELECT CONCAT
(
	d.Doctor_Name, 
	' specializes in ', d.Specialization, 
	' (Dept: ', e.Department_ID, 
	') and can be reached at ', d.Contact
) AS DoctorProfile
FROM Doctor d
JOIN Employee e 
ON d.Employee_ID = e.Employee_ID;

-- Produces a descriptive sentence for each patient detailing their diagnosis and treatment plan.
SELECT 
CONCAT(
	'Patient ', p.PatientName, 
	' was diagnosed with "', d.Description, 
	'" and received treatment: "', t.Description, '".'
) AS MedicalSummary
FROM Patient p
JOIN Diagnosis d 
ON p.Patient_ID = d.Patient_ID
JOIN Treatment t 
ON d.Diagnosis_ID = t.Diagnosis_ID
ORDER BY p.PatientName;

-- Displaying employee roles in uppercase
SELECT UPPER(Role) AS UpperRole
FROM Employee
GROUP BY Role;

-- Displaying doctor specializations in lowercase
SELECT LOWER(Specialization) AS LowerSpec
FROM Doctor
GROUP BY Specialization;

-- Showing current timestamp
SELECT NOW() AS CurrentTimestamp;

-- Calculating patient age in days and considering it as DaysLived
SELECT Patient_ID, DATEDIFF(NOW(), DOB) AS DaysLived
FROM Patient;

-- Extracting year from appointment date
SELECT Appointment_ID, YEAR(Date) AS YearOfAppointment
FROM Appointment;

-- Categorizing patients as adult or minor
SELECT Patient_ID,
CASE 
	WHEN DATEDIFF(NOW(), DOB)/365 >= 18 THEN 'Adult'
    ELSE 'Minor'
	END AS AgeGroup
FROM Patient;

-- Finding doctors with no diagnoses
SELECT d.Doctor_ID, d.Doctor_Name AS Name
FROM Doctor d
LEFT JOIN Diagnosis diag ON d.Doctor_ID = diag.Doctor_ID
WHERE diag.Diagnosis_ID IS NULL;

-- Right join to show room and admitted patient info
SELECT 
	r.Room_Number,
    a.Admission_ID,
    p.PatientName,
    a.Admission_Date
FROM Room r
RIGHT JOIN Admission a 
ON r.Room_ID = a.Room_ID
LEFT JOIN Patient p 
ON a.Patient_ID = p.Patient_ID
ORDER BY a.Admission_Date DESC;

-- Full outer join for doctors and appointments
SELECT 
    d.Doctor_ID,
    d.Doctor_Name,
    a.Appointment_ID,
    a.Date
FROM Doctor d
LEFT JOIN Appointment a 
ON d.Doctor_ID = a.Doctor_ID
UNION
SELECT 
    d.Doctor_ID,
    d.Doctor_Name,
    a.Appointment_ID,
    a.Date
FROM Doctor d
RIGHT JOIN Appointment a 
ON d.Doctor_ID = a.Doctor_ID
ORDER BY Doctor_ID;

-- Full outer join to check if employees are doctors
SELECT 
    e.Employee_ID,
    e.Role,
    d.Doctor_ID,
    d.Doctor_Name
FROM Employee e
LEFT JOIN Doctor d ON e.Employee_ID = d.Employee_ID
UNION
SELECT 
    e.Employee_ID,
    e.Role,
    d.Doctor_ID,
    d.Doctor_Name
FROM Employee e
RIGHT JOIN Doctor d ON e.Employee_ID = d.Employee_ID
ORDER BY Employee_ID;

-- Lists doctors and number of diagnoses they've made
SELECT d.Doctor_Name, COUNT(diag.Diagnosis_ID) AS DiagnosesHandled
FROM Doctor d
LEFT JOIN Diagnosis diag 
ON d.Doctor_ID = diag.Doctor_ID
GROUP BY d.Doctor_ID, d.Doctor_Name
ORDER BY DiagnosesHandled DESC;

-- Finds the top 5 patients with the longest hospital stay
SELECT p.PatientName, DATEDIFF(a.Discharge_Date, a.Admission_Date) AS StayLength, r.Type AS RoomType
FROM Admission a
JOIN Patient p 
ON a.Patient_ID = p.Patient_ID
JOIN Room r 
ON a.Room_ID = r.Room_ID
ORDER BY StayLength DESC
LIMIT 5;

-- Creating index on Patient_ID
CREATE INDEX Patient_ID_index
ON Patient(Patient_ID);

-- Showing indexes from Patient table
SHOW INDEX FROM Patient;

-- Creating index on Appointment_ID
CREATE INDEX Appointment_ID_index
ON Appointment(Appointment_ID);

-- Creating index on Diagnosis_ID
CREATE INDEX Diagnosis_ID_index
ON Diagnosis(Diagnosis_ID);

-- Creating index on Doctor_ID
CREATE INDEX Doctor_ID_index
ON Doctor(Doctor_ID);

-- Showing indexes from Doctor table
SHOW INDEX FROM Doctor;

-- Creating a view to show patient diagnosis info
CREATE VIEW PatientDiagnosisView AS
SELECT 
    p.Patient_ID,
    p.PatientName,
    p.Blood_Type,
    d.Diagnosis_ID,
    d.Description AS Diagnosis_Description,
    d.Doctor_ID
FROM Patient p
JOIN Diagnosis d ON p.Patient_ID = d.Patient_ID;

SELECT * FROM PatientDiagnosisView;

-- Creating a view for full patient medical details
CREATE VIEW PatientFullMedicalView AS
SELECT 
    p.Patient_ID,
    p.PatientName,
    d.Description AS Diagnosis_Description,
    pm.MedicineName,
    t.Description AS Treatment_Description,
    tst.Test_Name AS LabTest,
    h.Description AS History_Description
FROM Patient p
LEFT JOIN Diagnosis d ON p.Patient_ID = d.Patient_ID
LEFT JOIN Prescription pr ON d.Diagnosis_ID = pr.DiagnosisID
LEFT JOIN PrescriptionMedicine pm ON pr.PrescriptionID = pm.PrescriptionID
LEFT JOIN Treatment t ON d.Diagnosis_ID = t.Diagnosis_ID
LEFT JOIN Lab l ON d.Diagnosis_ID = l.DiagnosisID
LEFT JOIN Test tst ON l.Lab_ID = tst.Lab_ID
LEFT JOIN Medical_History h ON p.Patient_ID = h.Patient_ID;

SELECT * FROM PatientFullMedicalView;

-- Creates a cleaner view showing only actual hospital charges per patient, without billed summary fields
CREATE VIEW PatientBillBreakdownView AS
SELECT 
    p.Patient_ID,
    p.PatientName,
    IFNULL(t.Treatment_Cost, 0) AS Treatment_Cost,
    IFNULL(a.Room_Cost, 0) AS Room_Cost,
    IFNULL(tst.Test_Cost, 0) AS Test_Cost,
    (IFNULL(t.Treatment_Cost, 0) + IFNULL(a.Room_Cost, 0) + IFNULL(tst.Test_Cost, 0)) AS Computed_Total_Charges,
    CONCAT('Breakdown - Treatment: Rs.', IFNULL(t.Treatment_Cost, 0), ', Room: Rs.', IFNULL(a.Room_Cost, 0), ', Tests: Rs.', IFNULL(tst.Test_Cost, 0)) AS ChargeDetails,
    b.Bill_Status
FROM Patient p
LEFT JOIN Diagnosis d 
ON p.Patient_ID = d.Patient_ID
LEFT JOIN Treatment t 
ON d.Diagnosis_ID = t.Diagnosis_ID
LEFT JOIN Admission a 
ON p.Patient_ID = a.Patient_ID
LEFT JOIN Lab l 
ON d.Diagnosis_ID = l.DiagnosisID
LEFT JOIN Test tst 
ON l.Lab_ID = tst.Lab_ID
LEFT JOIN Bill b 
ON p.Patient_ID = b.Patient_ID;

SELECT * FROM PatientBillBreakdownView;


