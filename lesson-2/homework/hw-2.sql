--Task1
create database homework2
use homework2
--Task2
create table Employees (EmpID int, name varchar(50), salary decimal(10,2))
insert into Employees values (1, 'Michael Jackson', 70000), (2, 'Diana Johnson', 56000), (3, 'David Smith', 40000);
select * from Employees
--Task3
update Employees
set salary = 7000
where EmpID = 1;
--Task4
delete from Employees
where EmpID = 2;
--Task 5 Give a brief definition for difference between Delete, Truncate, and Drop
--Answer: DELETE: Removes specific rows from a table based on a condition.It can be rolled back if used within a transaction.
--TRUNCATE: Removes all rows from a table quickly and resets identity columns.It can not be rolled back in most databases and 
--does not log individual row deletions.
--DROP: Completely removes the entire table (or other database object) from the database including its structure. It can not be rolled back.
--Task6
Alter Table Employees
alter column Name Varchar(100);
--Task7
Alter table Employees
Add Department Varchar(50);
--Task8
Alter table Employees
Alter Column Salary FLOAT;
Select * from Employees
--Task9
Create table Departments ( DepartmentID int Primary key, DepartmentName Varchar(50));
--Task10
Truncate table Employees;
--Task11
Insert into Departments
Select 1, 'Human Resources' Union All
Select 2, 'Finance' Union All
Select 3, 'Engineering' Union All
Select 4, 'Marketing' Union All
Select 5, 'IT Support';
Select * from Departments
--
create table Employees (EmpID int, name varchar(50), salary decimal(10,2), Department varchar(50))
insert into Employees values (1, 'Michael Jackson', 70000, 'IT'), (2, 'Diana Johnson', 56000, 'Sales'), (3, 'David Smith', 40000, 'Management');
select * from employees
--Task12
Update Employees
Set Department = 'Management'
Where Salary > 5000;

--Task13
Truncate table Employees;
--Task14
Alter table Employees
Drop Column Department;
--Task15
EXEC sp_rename 'Employees', 'StaffMembers';
--Task16
Drop table Departments;
--Task17
Create table Products (
   ProductID int Primary key,
   ProductName Varchar(100),
   Category Varchar(50),
   Price Decimal(10, 2),
   StockQuantity int
   );
Drop table Products
Create table Products (
   ProductID int Primary key,
   ProductName Varchar(100),
   Category Varchar(50),
   Price Decimal(10, 2),
   StockQuantity int
   --Constraint chk_price_positive Check (Price > 0)
   );
--Task18
alter table products
add check(price > 0)
--Task19
Update Products
Set StockQuantity = 50
Where StockQuantity is NULL;
--Task20
EXEC sp_rename 'Products.Category', 'ProductCategory', 'Column';
--Task21
Insert into Products (ProductID, ProductName, ProductCategory, Price, StockQuantity)
Values (1, 'Wireless Mouse', 'Electronics', 25.99, 100),
        (2, 'Bluetooth Headphones', 'Electronics', 59.95, 75),
		(3, 'Coffe Mug', 'Kitchenware', 12.50, 200),
		(4, 'Notebook', 'Stationery', 4.25, 300),
		(5, 'Water Bottle', 'Fitness', 18.99, 150);

--Task22
Select *
Into Products_Backup
From Products;
--Task23
Exec sp_rename 'Products', 'Inventory';
--Task24
Alter Table Inventory
Alter Column Price FLOAT;



Alter Table Inventory
drop constraint CK__Products__Price__3F466844;
select * from Inventory
--Task25
create table Inventory_new (
      ProductCode INT Identity(1000, 5) Primary KEY,
	  ProductID INT,
	  ProductName Varchar(100),
	  ProductCategory Varchar(50),
	  Price FLOAT,
	  StockQuantity INT
);
