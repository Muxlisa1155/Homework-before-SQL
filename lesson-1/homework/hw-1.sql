Lesson-1 Homework.
Easy.
--Task-1. 
--Define the following terms: data, database, relational database, and table.
--Answer: Data - is information in the form of facts, numbers, symbols, or text that can be collected, stored, and analyzed. In data analytics, the term "data" refers to raw facts, figures, or information that are collected for analysis. A database - is  a digital filing cabinet where large amounts of data are kept in an organized way so that they can be easily searched, updated, and analyzed.A relational database stores data in rows and columns (tables), and uses relationships to connect different pieces of data.In data analytics, a table is a way of organizing data into rows and columns — like a spreadsheet — so that it is easy to read, manage, and analyze.
--Task2. 
--List five key features of SQL Server.Answer:  Here are five key features of SQL Server, a popular relational database management system developed by Microsoft:
--1. Relational Database Management
--SQL Server stores data in structured tables with rows and columns.
--It supports relationships between tables using primary and foreign keys, ensuring data integrity and organization.
--2. T-SQL (Transact-SQL) Support
--SQL Server uses T-SQL, an extended version of SQL, for querying and manipulating data.
--It allows advanced features like stored procedures, triggers, views, and functions, making database operations powerful and efficient.
--3. Security and Access Control
--SQL Server includes robust security features:
--Authentication (Windows and SQL Server logins)
--Role-based permissions
--Encryption
--Auditing
--These protect sensitive data and control who can access or change it.
--4. Data Tools and Integration Services
--Offers tools like:
--SQL Server Management Studio (SSMS) – for managing and querying databases.
--SQL Server Integration Services (SSIS) – for data import/export and ETL (Extract, Transform, Load) processes.
--SQL Server Reporting Services (SSRS) – for creating reports and dashboards.
--5. High Availability and Disaster Recovery
--Features like:
--Failover clustering
--Always On Availability Groups
--Database mirroring and backups
--Ensure your data is available and recoverable in case of system failures.
--Task-3
--What are the different authentication modes available when connecting to SQL Server? (Give at least 2)1. Windows Authentication
--Uses your Windows account credentials to log in.
--Integrated with Active Directory.
--More secure because it uses the Windows login system.
--Recommended in enterprise environments.
--✅ Example: You log into SQL Server using your Windows username like DOMAIN/username.2. SQL Server Authentication
--Uses a separate username and password created within SQL Server.
--Not tied to Windows accounts.
--Useful when users are outside the Windows domain.
--✅ Example: Login with username: sa, password: yourpassword.
--Task-4

create database SchoolDB
use SchoolDB

--Task-5
create table Students(StudentID int PRIMARY KEY, Name varchar(50), age int) 

--Task-6
--Describe the differences between SQL Server,SSMS and SQL
----Here’s a simple explanation of the differences between SQL Server, SSMS, and SQL:SQL Server
----What it is: A database management system made by Microsoft.
----Purpose: Stores, organizes, and manages data.
----Use: Runs in the background to handle databases.
----🔹 SSMS (SQL Server Management Studio)
----What it is: A software tool (GUI) used to work with SQL Server.
----Purpose: Helps users manage databases, write queries, and see results.
----Use: A user-friendly interface to connect to SQL Server.
----🔹 SQL (Structured Query Language)
----What it is: A programming language used to talk to databases.
----Purpose: Used to query, update, or manage data inside SQL Server (or any other database).
----Use: Written inside SSMS or other tools to control the database.

--Task-7
--Research and explain the different SQL commands: DQL, DML, DDL, DCL, TCL with examples.
--Here is a detailed explanation of the five main categories of SQL commands — DQL, DML, DDL, DCL, and TCL — along with their purpose and examples.
--1. DQL (Data Query Language)
--Purpose: Used to query and retrieve data from a database.
--Main Command:
--SELECT – Fetches data from a table.
--Example:
--SELECT first_name, last_name FROM employees WHERE department = 'Sales';
--2. DML (Data Manipulation Language)
--Purpose: Used to modify the data stored in database tables.
--Main Commands:
--INSERT – Adds new records.
--UPDATE – Modifies existing records.
--DELETE – Removes existing records.
--Examples:
INSERT INTO employees (first_name, last_name, department) VALUES ('John', 'Doe', 'HR');
UPDATE employees SET department = 'Marketing' WHERE employee_id = 101;
DELETE FROM employees WHERE employee_id = 101;
--3. DDL (Data Definition Language)
--Purpose: Used to define or modify database structure (schema).
--Main Commands:
--CREATE – Creates databases, tables, views, indexes, etc.
--ALTER – Modifies structure of existing database objects.
--DROP – Deletes database objects.
--TRUNCATE – Removes all data from a table without logging individual row deletions.
--Examples:
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50)
);
ALTER TABLE employees ADD hire_date DATE;
DROP TABLE employees;
TRUNCATE TABLE employees;
--4. DCL (Data Control Language)
--Purpose: Controls access to data in the database.
--Main Commands:
--GRANT – Gives user access privileges.
--REVOKE – Removes user access privileges.
--Examples:
GRANT SELECT ON employees TO user1;
REVOKE SELECT ON employees FROM user1;
--5. TCL (Transaction Control Language)
--Purpose: Manages transactions in a database to maintain data integrity.
--Main Commands:
--BEGIN TRANSACTION / START TRANSACTION – Begins a transaction.
--COMMIT – Saves all changes made in the current transaction.
--ROLLBACK – Undoes changes since the last commit.
--SAVEPOINT – Sets a point within a transaction to roll back to.
--Examples:
BEGIN TRANSACTION;
UPDATE accounts SET balance = balance - 500 WHERE account_id = 1;
UPDATE accounts SET balance = balance + 500 WHERE account_id = 2;
COMMIT;
ROLLBACK;
--Task 8
--Write a query to insert three records into the Students table.
create table Students(StudentID int PRIMARY KEY, Name varchar(50), age int) 
Insert into Students values
(1, 'Nodir', 24),
(2, 'Alex' , 22),
(3, 'Sara' , 27)
select * from Students
