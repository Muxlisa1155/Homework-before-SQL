--Homework16
--Easy tasks
--Task1
with Numbers AS (
    select 1 AS n
	Union ALL
	select n + 1
	from numbers
	where n < 1000
)
select n
from numbers
Option (MaxRecursion 1000);

--Task2
--Write a query to find the total sales per employee using a derived table.
select * from employees;
select * from sales;

SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    d.TotalSales
FROM Employees e
JOIN (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
) d
ON e.EmployeeID = d.EmployeeID
ORDER BY d.TotalSales DESC;

--Task3
select * from employees;

with AvgSalary AS (
     Select Avg(Salary) as AverageSalary
	 from employees
)
Select AverageSalary
from Avgsalary;

--Task4
select * from products;
select * from sales;

select 
     p.productID,
	 p.productName,
	 d.MaxSaleAmount
from Products p
Join (
     select ProductID, Max(SalesAmount) AS MaxSaleAmount
	 from Sales
	 Group By ProductID
) d
on p.productID = d.productID
Order By d.MaxSaleAmount DESC;

--Task5
With Doubling As (
     Select 1 as n
	 Union All
	 Select n * 2
	 From Doubling
	 Where n * 2 < 100000
)
select n
From Doubling;

--Task6
select * from employees
select * from sales;

WITH SalesCount AS (
    SELECT 
        EmployeeID,
        COUNT(*) AS SaleCount
    FROM Sales
    GROUP BY EmployeeID
)
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    sc.SaleCount
FROM Employees e
JOIN SalesCount sc 
    ON e.EmployeeID = sc.EmployeeID
WHERE sc.SaleCount > 5
ORDER BY sc.SaleCount DESC;

--Task7
select * from sales;
select * from products;

with ProductSales AS (
    Select 
	     ProductID,
		 Sum(SalesAmount) As TotalSales
	from Sales
	group by ProductID
)
select 
      p.productid,
	  p.productname,
	  ps.TotalSales
from products p
Join ProductSales ps
     on p.ProductID = ps.ProductID
where ps.TotalSales > 500
Order by ps.TotalSales DESC;

--Task8
with AvgSalary AS (
     Select Avg(Salary) As AverageSalary
	 From Employees
)
Select 
     e.EmployeeID,
	 e.Firstname,
	 e.LastName,
	 e.Salary
from Employees e
Cross Join AvgSalary a
where e.salary > a.AverageSalary
Order by e.Salary DESC;

--Medium Tasks
--Task1
SELECT TOP 5
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    dt.OrderCount
FROM Employees e
JOIN (
    SELECT 
        EmployeeID, 
        COUNT(*) AS OrderCount
    FROM Sales
    GROUP BY EmployeeID
) AS dt
ON e.EmployeeID = dt.EmployeeID
ORDER BY dt.OrderCount DESC;
--Task2
select * from sales;
select * from products;

select 
     dt.CategoryID,
	 Sum(dt.SalesAmount) As TotalSales
from (
    Select
	    s.ProductID,
		s.SalesAmount,
		p.CategoryID
	From Sales s
	Join Products p
	    on s.ProductID = p.ProductID
) As dt
Group by dt.Categoryid
Order by TotalSales DESC;

--Task3
select * from numbers1;
WITH FactorialCTE AS (
    SELECT Number, 1 AS Factorial, Number AS n
    FROM Numbers1
    UNION ALL
    SELECT Number, Factorial * n, n - 1
    FROM FactorialCTE
    WHERE n > 1
)
SELECT Number, MAX(Factorial) AS Factorial
FROM FactorialCTE
GROUP BY Number
ORDER BY Number;

--Task4
select * from example;
-- Sample table

-- Recursive CTE to split into characters
WITH RecursiveCTE AS
(
    -- Anchor: first character
    SELECT 
        Id,
        1 AS Position,
        SUBSTRING(String, 1, 1) AS Character,
        String
    FROM Example

    UNION ALL

    -- Recursive: next character
    SELECT 
        Id,
        Position + 1,
        SUBSTRING(String, Position + 1, 1),
        String
    FROM RecursiveCTE
    WHERE Position < LEN(String)
)
SELECT Id, Position, Character
FROM RecursiveCTE
ORDER BY Id, Position
OPTION (MAXRECURSION 0);



--Task5
WITH MonthlySales AS (
    SELECT
        YEAR(SaleDate) AS SaleYear,
        MONTH(SaleDate) AS SaleMonth,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY YEAR(SaleDate), MONTH(SaleDate)
)
SELECT
    SaleYear,
    SaleMonth,
    TotalSales,
    TotalSales - LAG(TotalSales) OVER (ORDER BY SaleYear, SaleMonth) AS SalesDifference
FROM MonthlySales
ORDER BY SaleYear, SaleMonth;

--Task6
select * from sales;
select * from employees;

SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    dt.Quarter,
    dt.TotalSales
FROM Employees e
JOIN (
    SELECT 
        EmployeeID,
        DATEPART(QUARTER, SaleDate) AS Quarter,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID, DATEPART(QUARTER, SaleDate)
) AS dt
ON e.EmployeeID = dt.EmployeeID
WHERE dt.TotalSales > 45000
ORDER BY dt.Quarter, dt.TotalSales DESC;

--Difficult Tasks
--Task1
with Fibonacci AS (
    Select 0 AS Position, 0 As Fibnumber, 1 As NextNumber
	Union All
	Select Position + 1, NextNumber, FibNumber + NextNumber
	From Fibonacci
	where Position < 14
)
Select Position, Fibnumber
From Fibonacci
Order By Position;

--Task2
SELECT *
FROM FindSameCharacters
WHERE LEN(Vals) > 1
  AND LEN(REPLACE(Vals, LEFT(Vals, 1), '')) = 0;

--Task3
DECLARE @n INT = 5;  -- You can change this value

WITH NumbersCTE AS (
    -- Anchor: start with 1
    SELECT 1 AS Num, CAST(1 AS VARCHAR(MAX)) AS Sequence
    UNION ALL
    -- Recursive: append next number
    SELECT Num + 1, Sequence + CAST(Num + 1 AS VARCHAR)
    FROM NumbersCTE
    WHERE Num + 1 <= @n
)
SELECT Sequence
FROM NumbersCTE

--Task4
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    dt.TotalSales
FROM Employees e
JOIN (
    SELECT 
        EmployeeID,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -6, '2025-08-31')
    GROUP BY EmployeeID
) AS dt
ON e.EmployeeID = dt.EmployeeID
WHERE dt.TotalSales = (
    SELECT MAX(TotalSales)
    FROM (
        SELECT 
            EmployeeID,
            SUM(SalesAmount) AS TotalSales
        FROM Sales
        WHERE SaleDate >= DATEADD(MONTH, -6, '2025-08-31')
        GROUP BY EmployeeID
    ) AS sub
);

Task5
SELECT 
    PawanName,
    -- First remove duplicate digits like 111 → 1, 4444 → 4
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
        Pawan_slug_name,
        '11','1'),'22','2'),'33','3'),'44','4'),'55','5'),
        '66','6'),'77','7'),'88','8'),'99','9'),'00','0'
    ) AS CleanedDuplicates,

    -- Then remove a single -digit at the end (like -3)
    CASE 
        WHEN Pawan_slug_name LIKE '%-[0-9]' 
        THEN LEFT(Pawan_slug_name, LEN(Pawan_slug_name)-2)
        ELSE Pawan_slug_name
    END AS CleanedTrailing
FROM RemoveDuplicateIntsFromNames;
