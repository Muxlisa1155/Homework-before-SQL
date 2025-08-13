--Homework 3
--Task1
--Define and explain the purpose of BULK INSERT in SQL Server.
--BULK INSERT in SQL Server is a Transact-SQL (T-SQL) command used to quickly import large amounts of data from an external data file into a SQL Server table or view.
--The main purposes of BULK INSERT are:
--Fast Data Loading
--It’s much faster than inserting rows individually with INSERT statements because it bypasses some of the logging and parsing overhead.
--Importing External Data
--It allows you to bring in data from flat files (like .csv or .txt) into your SQL Server database.
--ETL (Extract, Transform, Load) Processes
--Often used as part of the “Load” phase in ETL, where large datasets from outside sources are imported for further processing.
--Reducing Manual Work
--Instead of writing many INSERT statements, you can load thousands or millions of rows in one command.
--Task2
--Here are four common file formats that can be imported into SQL Server:
--CSV (Comma-Separated Values) – e.g., data.csv
--TXT (Plain Text Files) – often with tab or custom delimiters, e.g., data.txt
--XML (Extensible Markup Language) – e.g., data.xml
--JSON (JavaScript Object Notation) – e.g., data.json
--SQL Server also supports others like Excel (.xls, .xlsx) and binary formats, but these four are among the most widely used for imports.
--Task3
Create table Products (
ProductID INT PRIMARY KEY,
ProductName Varchar(50),
Price Decimal(10,2)
);

--Task4
Insert into Products Values 
     (1, 'Laptop', 899.90),
	 (2, 'Smartphone', 599.25),
	 (3, 'Headphones', 325.19);
--Task5
--Explain the difference between NULL and NOT NULL in SQL lies in whether a column can contain missing or unknown values
--Answer: Null indicates no valu, unknown, or missing data. A columnn defined to allow NULL can have empty cells.
--Example: ProductionDescription to be left empty in some rows.
--This is allows ProductionsDescription to be left empty in some rows
--Not NULL:
--Means the column must always contain a value.
--The database will throw an error if you try to insert or update a row with a NULL value in that column.
--Example: ProductionName Varchar(50) NOT NULL. This ensures that every product must have a name.

Create table Solditems (
   ProductID INT PRIMARY KEY,
   ProductName Varchar(50) NOT NULL,
   ProductDescription Varchar(255) NULL,
   Price DECIMAL(10,2) NOT NULL
   );
--ProductionName and Price must have values.
ProductionDescription is optional.
--Task6
alter table Products
add constraint unique_product_name Unique (ProductName);

--it ensures that no two products in the table can have the same name.
--If you try to insert or update a row with a duplicate ProductName, the database will return an error.
--Task7
--In SQL, you can write a comment using either -- for a single-line comment or /*...*/ for multi-line comments
--Task8
Alter table Products
Add CategoryID INT;
--Task9
create table Categories (
  CategoryID INT Primary key,
  CategoryName Varchar(50) unique
  );
  --Task10
--Explain the purpose of the IDENTITY column in SQL Server
--Answer: In SQL Server, an IDENTITY column is used to automatically generate unique numeric values for each new row inserted into a table—usually for primary keys.
--Auto-incrementing keys
--Automatically assigns sequential numbers (e.g., 1, 2, 3…) without needing manual input.
--Ensuring uniqueness
--Helps maintain a unique identifier for each record in a table.
--Simplifying inserts
--You don’t have to specify the value when inserting a row—SQL Server handles it.
--Useful for surrogate keys
--Ideal when you need a unique key but don’t want to use business data (like email or SSN).
--Task11
BULK INSERT Products
FROM 'C:\Data\products.txt'
WITH (
    FIELDTERMINATOR = ',',   -- Delimiter between fields (e.g., comma)
    ROWTERMINATOR = '\n',    -- Line break for rows (or '\r\n' on Windows)
    FIRSTROW = 2             -- Optional: skip header row if present
);
--Task12
ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID)
REFERENCES Categories(CategoryID);
--Task13
--The PRIMARY KEY and UNIQUE KEY constraints in SQL are both used to enforce uniqueness of values in one or more columns—but they have key differences in purpose, behavior, and limitations.
--PRIMARY KEY
--Uniquely identifies each row in the table (main identifier).
--UNIQUE KEY
--Ensures all values in the column(s) are unique, but not necessarily the main identifier.
--PRIMARY KEY
--Only one per table
--UNIQUE KEY
--You can have multiple UNIQUE keys
--Task14
ALTER TABLE Products
ADD CONSTRAINT CHK_Products_Price_Positive
CHECK (Price > 0);
Select * from Products
--Task15
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;
Select * from Products
--Task16
SELECT 
    ProductID,
    ProductName,
    ISNULL(Price, 0) AS Price,
    Stock
FROM Products;
--Task17
--Purpose of FOREIGN KEY Constraints
--Enforce Relationships Between Tables
--A foreign key establishes a link between the data in two tables. It ensures that a value in one table (the child or referencing table) corresponds to an existing value in another table (the parent or referenced table).
--Maintain Referential Integrity
--This means you cannot insert a value into the foreign key column of the child table unless it exists in the parent table. Similarly, you can’t delete a row from the parent table if there are related rows in the child table—unless you define cascading actions.
--Prevent Orphaned Records
--Ensures that child records don’t point to non-existent parent records, avoiding data inconsistencies.
--Task18
create table Customers (
   CustomersID int primary key,
   CustomerName varchar(100),
   Age int,
   Constraint chk_customers_age check
--Task19
CREATE TABLE SampleTable (
    ID INT IDENTITY(100, 10) PRIMARY KEY,
    Name VARCHAR(100),
    CreatedDate DATETIME
);
--Task20
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    PRIMARY KEY (OrderID, ProductID)
);
--Task21
--Both Coalesce and Isnull are used in SQL to handle NULL values, but they have some differences in syntax, behavior and portability.
--Here is breakdown of each:
--ISNULL
--Purpose:Replaces NULL with a specified replacement value.
--Syntax:
--ISNULL(expression, replacement_value)
--Select ISNULL(firstnameName, 'N/A') AS Name FROM Employees;
--COALESCE
--Purpose: Returns the first non-NULL value from a list of expressions.
--Syntax:
COALESCE(expression1, expression2, ..., expressionN)
SELECT COALESCE(FirstName, Lastname, 'N/A') AS PreferredName FROM Employees;
--COALESCE is for portability and multiple fallback options while ISNULL on SQL Server is needed NULL handling with just two values.
--Task22
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    HireDate DATE
);
select * from Employees
--Task23
drop table orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    EmpID INT,
    OrderDate DATE,
    Amount DECIMAL(10, 2),
    CONSTRAINT FK_EmpID FOREIGN KEY (EmpID)
        REFERENCES Employees(EmpID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
