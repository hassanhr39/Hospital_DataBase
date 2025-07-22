# 🏥 Hospital Management System Database

This project is a university-level implementation of a relational database for a Hospital Management System (HMS). It models real-life operations of a hospital using SQL, with an emphasis on data integrity, normalization, and clear entity relationships.

---

## 📌 Table of Contents
- [Introduction](#introduction)
- [Problem Statement](#problem-statement)
- [Scope](#scope)
- [Entities and Attributes](#entities-and-attributes)
- [Normalization](#normalization)
- [Entity-Relationship Diagrams](#entity-relationship-diagrams)
- [Technologies Used](#technologies-used)
- [Getting Started](#getting-started)
- [Author](#author)

---

## 📖 Introduction

In modern healthcare, managing massive volumes of patient, staff, and operational data is a challenge. This Hospital Management System (HMS) project is built using SQL to simulate core hospital functionalities like appointments, admissions, billing, diagnoses, lab tests, prescriptions, and staff management. It follows a relational database approach and focuses on real-world hospital workflows.

---

## 🛠️ Problem Statement

Manual (file-based) hospital systems are inefficient, error-prone, and lack centralized data access. Our project aims to resolve this by:

- Accurately capturing and organizing essential data
- Defining clear relationships between entities like patients, doctors, treatments, and diagnoses
- Ensuring data integrity via normalization
- Simulating realistic hospital operations

---

## 🎯 Scope

The database handles:

- Patient management (details, admissions, history)
- Staff records (doctors, nurses, receptionists)
- Appointments and diagnoses
- Treatments, prescriptions, and lab tests
- Room allocations and billing
- Department assignments

---

## 🧱 Entities and Attributes

The system includes 17 relational tables. Example entities:

- **Patient**: Patient_ID, Name, Age, Gender, etc.
- **Doctor**: Doctor_ID, Name, Specialization, etc.
- **Appointment**: Appointment_ID, Date, Time, Status, etc.
- **Diagnosis**: Diagnosis_ID, Description, Date
- **Lab / Test**, **Prescription / PrescriptionMedicine**
- **Admission**, **Room**, **Bill**, **Medical_History**
- **Employee**, **Department**, etc.

All entities and justifications are provided in the report.
---

## 📐 Normalization

To avoid redundancy and ensure consistency, normalization was applied:

- ✅ **1NF**: Removed multivalued attributes (e.g., MedicineName → separate table `PrescriptionMedicine`)
- ✅ **2NF**: No partial dependencies
- ✅ **3NF**: No transitive dependencies

Total number of tables after normalization: **17**

---

## 🔗 Entity-Relationship Diagrams

### 👣 Crow Foot ERD

![Crow Foot Diagram](./assets/crowfoot-erd.png)

### 🧬 Chen Model

![Chen Model Diagram](./assets/chen-model.png)

> ⚠️ If images don't load, make sure they're correctly uploaded in the `assets/` folder and named appropriately.

---

## 🧰 Technologies Used

- **SQL** (Structured Query Language)
- **ERD Design Tools** (Draw.io / Lucidchart / any)
- **MS SQL Server** or **MySQL** (recommended DBMS)

---

## 🚀 Getting Started

1. Clone the repository
2. Open SQL scripts in your preferred DBMS
3. Run table creation and insertion scripts
4. Use SELECT queries to retrieve patient, billing, appointment, or treatment data

---

## 👨‍🎓 Author

**Mohammad Hassan**  
4th Semester Student  
Project for Database Systems Course

---

## 📄 Report

For a detailed explanation of entities, normalization, and relationships, refer to the full report.

---

