--Homework5
--Task1
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2),
    Category VARCHAR(50),
    StockQuantity INT
);

INSERT INTO Products VALUES
(1, 'Laptop', 1200.00, 'Electronics', 30),
(2, 'Smartphone', 800.00, 'Electronics', 50),
(3, 'Tablet', 400.00, 'Electronics', 40),
(4, 'Monitor', 250.00, 'Electronics', 60),
(5, 'Keyboard', 50.00, 'Accessories', 100),
(6, 'Mouse', 30.00, 'Accessories', 120),
(7, 'Chair', 150.00, 'Furniture', 80),
(8, 'Desk', 200.00, 'Furniture', 75),
(9, 'Pen', 5.00, 'Stationery', 300),
(10, 'Notebook', 10.00, 'Stationery', 500),
(11, 'Printer', 180.00, 'Electronics', 25),
(12, 'Camera', 500.00, 'Electronics', 40),
(13, 'Flashlight', 25.00, 'Tools', 200),
(14, 'Shirt', 30.00, 'Clothing', 150),
(15, 'Jeans', 45.00, 'Clothing', 120),
(16, 'Jacket', 80.00, 'Clothing', 70),
(17, 'Shoes', 60.00, 'Clothing', 100),
(18, 'Hat', 20.00, 'Accessories', 50),
(19, 'Socks', 10.00, 'Clothing', 200),
(20, 'T-Shirt', 25.00, 'Clothing', 150),
(21, 'Lamp', 60.00, 'Furniture', 40),
(22, 'Coffee Table', 100.00, 'Furniture', 35),
(23, 'Book', 15.00, 'Stationery', 250),
(24, 'Rug', 90.00, 'Furniture', 60),
(25, 'Cup', 5.00, 'Accessories', 500),
(26, 'Bag', 25.00, 'Accessories', 300),
(27, 'Couch', 450.00, 'Furniture', 15),
(28, 'Fridge', 600.00, 'Electronics', 20),
(29, 'Stove', 500.00, 'Electronics', 15),
(30, 'Microwave', 120.00, 'Electronics', 25),
(31, 'Air Conditioner', 350.00, 'Electronics', 10),
(32, 'Washing Machine', 450.00, 'Electronics', 15),
(33, 'Dryer', 400.00, 'Electronics', 10),
(34, 'Hair Dryer', 30.00, 'Accessories', 100),
(35, 'Iron', 40.00, 'Electronics', 50),
(36, 'Coffee Maker', 50.00, 'Electronics', 60),
(37, 'Blender', 35.00, 'Electronics', 40),
(38, 'Juicer', 55.00, 'Electronics', 30),
(39, 'Toaster', 40.00, 'Electronics', 70),
(40, 'Dishwasher', 500.00, 'Electronics', 20);

select ProductName as Name
from Products;

--Task2
select *
from Customers as Clients;
--Task3
CREATE TABLE Products_Discounted (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2),
    Category VARCHAR(50),
    StockQuantity INT
);

INSERT INTO Products_Discounted VALUES
(1, 'Gaming Laptop', 950.00, 'Electronics', 25),
(2, 'Smartphone', 750.00, 'Electronics', 45),
(3, 'Convertible Tablet', 350.00, 'Electronics', 35),
(4, 'Ultra-Wide Monitor', 220.00, 'Electronics', 55),
(5, 'Mechanical Keyboard', 45.00, 'Accessories', 90),
(6, 'Wireless Mouse', 25.00, 'Accessories', 110),
(7, 'Chair', 130.00, 'Furniture', 75),
(8, 'Standing Desk', 190.00, 'Furniture', 70),
(9, 'Luxury Pen', 4.50, 'Stationery', 280),
(10, 'Leather Notebook', 9.00, 'Stationery', 480),
(11, 'Laser Printer', 160.00, 'Electronics', 20),
(12, 'DSLR Camera', 480.00, 'Electronics', 35),
(13, 'LED Flashlight', 20.00, 'Tools', 190),
(14, 'Designer Shirt', 28.00, 'Clothing', 140),
(15, 'Jeans', 40.00, 'Clothing', 110),
(16, 'Winter Jacket', 70.00, 'Clothing', 60),
(17, 'Running Shoes', 55.00, 'Clothing', 90),
(18, 'Wool Hat', 18.00, 'Accessories', 45),
(19, 'Thermal Socks', 9.00, 'Clothing', 180),
(20, 'T-Shirt', 22.00, 'Clothing', 140),
(21, 'Desk Lamp', 55.00, 'Furniture', 35),
(22, 'Marble Coffee Table', 95.00, 'Furniture', 30),
(23, 'Hardcover Book', 13.00, 'Stationery', 230),
(24, 'Persian Rug', 85.00, 'Furniture', 50),
(25, 'Glass Cup', 4.50, 'Accessories', 470),
(26, 'Leather Bag', 22.00, 'Accessories', 270),
(27, 'Recliner Couch', 420.00, 'Furniture', 10),
(28, 'Smart Fridge', 570.00, 'Electronics', 15),
(29, 'Gas Stove', 460.00, 'Electronics', 12),
(30, 'Compact Microwave', 100.00, 'Electronics', 20),
(31, 'Split Air Conditioner', 320.00, 'Electronics', 8),
(32, 'Front-Load Washing Machine', 410.00, 'Electronics', 12),
(33, 'High-Efficiency Dryer', 370.00, 'Electronics', 8),
(34, 'Ionic Hair Dryer', 27.00, 'Accessories', 90),
(35, 'Steam Iron', 38.00, 'Electronics', 45),
(36, 'Espresso Maker', 45.00, 'Electronics', 55),
(37, 'Portable Blender', 32.00, 'Electronics', 35),
(38, 'Cold Press Juicer', 50.00, 'Electronics', 28),
(39, 'Smart Toaster', 36.00, 'Electronics', 65),
(40, 'Compact Dishwasher', 470.00, 'Electronics', 18);


SELECT ProductName
FROM Products

UNION

SELECT ProductName
FROM Products_Discounted;

--Task4
select ProductName
from Products

Intersect

select ProductName
From Products_Discounted;

--Task5
select * from Customers
SELECT DISTINCT 
    FirstName + ' ' + LastName AS CustomerName,
    Country
FROM Customers;
--Task6
SELECT 
    ProductName,
    Price,
    CASE 
        WHEN Price > 1000 THEN 'High'
        ELSE 'Low'
    END AS PriceCategory
FROM Products;
--Task7
SELECT 
    ProductName,
    StockQuantity,
    IIF(StockQuantity > 100, 'Yes', 'No') AS IsStockHigh
FROM Products_Discounted;
--Task8
select ProductName
from Products

Union

Select ProductName
from Products_Discounted;
--Task9
select ProductName
from Products

except

Select ProductName
from Products_Discounted;
--Task10
SELECT 
    ProductName,
    Price,
    IIF(Price > 1000, 'Expensive', 'Affordable') AS PriceCategory
FROM Products;
--Task11
SELECT *
FROM Employees
WHERE Age < 25 OR Salary > 60000;
--Task12
UPDATE Employees
SET Salary = Salary * 1.10
WHERE DepartmentName = 'HR' OR EmployeeID = 5;
--Task13
SELECT 
    SaleID,
    SaleAmount,
    CASE 
        WHEN SaleAmount > 500 THEN 'Top Tier'
        WHEN SaleAmount BETWEEN 200 AND 500 THEN 'Mid Tier'
        ELSE 'Low Tier'
    END AS SaleTier
FROM Sales;
--Task14
select CustomerID
from Orders

Except

Select CustomerID
From Sales;
--Task15
SELECT 
    CustomerID,
    Quantity,
    CASE 
        WHEN Quantity = 1 THEN '3%'
        WHEN Quantity BETWEEN 2 AND 3 THEN '5%'
        ELSE '7%'
    END AS DiscountPercentage
FROM Orders;
