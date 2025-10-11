--Window functions
--Task1
select * from ProductSales;
--Write a query to assign a row number to each sale based on the SaleDate.
select
     SaleID,
	 ProductName,
	 SaleDate,
	 SaleAmount,
	 Quantity,
	 CustomerID,
	 Row_Number() Over (Order by SaleDate) as Row_Number
from ProductSales;

--Task2
select * from ProductSales;
select 
     productname,
	 Sum(Quantity) as TotalQuantitySold,
	 Dense_Rank() Over (Order by Sum(Quantity) Desc) as ProductRank
from ProductSales
Group by productname;

--Task3
select * from ProductSales;
SELECT 
    SaleID,
    CustomerID,
    ProductName,
    SaleDate,
    SaleAmount,
    Quantity
FROM (
    SELECT 
        SaleID,
        CustomerID,
        ProductName,
        SaleDate,
        SaleAmount,
        Quantity,
        ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS rn
    FROM ProductSales
) AS RankedSales
WHERE rn = 1;
--Task4
select * from ProductSales;

--Here we use Lead() window function because it looks forward to the next row in order

Select 
     SaleID,
	 ProductName,
	 SaleDate,
	 SaleAmount,
	 Lead(SaleAmount) Over (Order By SaleDate) as NextSaleAmount
From ProductSales;

--Task5
--Here we use Lag(SaleAmount) - gets the previous row's value

select 
      SaleID,
	  ProductName,
	  Saledate,
	  SaleAmount,
	  Lag(SaleAmount) over (Order by Saledate) as PrevSaleAmount
From ProductSales;

--Task6
WITH SalesWithPrev AS (
    SELECT
        SaleID,
        ProductName,
        SaleDate,
        SaleAmount,
        LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PrevSaleAmount
    FROM ProductSales
)
SELECT *
FROM SalesWithPrev
WHERE SaleAmount > PrevSaleAmount;

--Task7
Select 
     SaleID,
	 ProductName,
	 SaleDate,
	 SaleAmount,
	 Lag(SaleAmount) Over (Partition by ProductName Order by Saledate) as PrevSaleAmount,
	 SaleAmount - Lag(SaleAmount) over (Partition by ProductName order by Saledate) as Difference
from ProductSales;


--Task8
SELECT
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    LEAD(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS NextSaleAmount,
    ROUND(
        ((LEAD(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) - SaleAmount)
        / SaleAmount) * 100, 2
    ) AS PercentageChange
FROM ProductSales;

--Task9
SELECT
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSaleAmount,
    ((LEAD(SaleAmount) OVER (ORDER BY SaleDate) - SaleAmount) * 100.0 / SaleAmount) AS PercentageChange
FROM ProductSales
ORDER BY SaleDate;

--task10
Select
    SaleID,
	ProductName,
	SaleDate,
	SaleAmount,
	First_Value(SaleAmount) over (Partition by ProductName Order by Saledate) as FirstSaleAmount,
	SaleAmount - First_Value(SaleAmount) over (Partition by ProductName Order by Saledate) as DifferenceFromFirst
from ProductSales
Order by ProductName, Saledate;

--Task11
WITH SalesWithPrev AS (
    SELECT
        ProductName,
        SaleID,
        SaleDate,
        SaleAmount,
        LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PrevSaleAmount
    FROM ProductSales
)
SELECT
    ProductName,
    SaleID,
    SaleDate,
    SaleAmount,
    PrevSaleAmount
FROM SalesWithPrev
WHERE SaleAmount > PrevSaleAmount
ORDER BY ProductName, SaleDate;

--Task12
Select 
   Productname,
   Saledate,
   SaleAmount,
   Sum(SaleAmount0 over (
       Partition By Productname
	   Order By SaleDate
	   Rows Between unbounded Preceding And Current Row
   ) As ClosingBalance
From ProductSales
Order by ProductName, Saledate;

--Task13
Select
    ProductName,
	SaleDate,
	SaleAmount,
	AVG(SaleAmount) Over (
	   Partition by ProductName
	   Order by Saledate
	   Rows between 2 preceding and current row
	) as MovingAvg_Last3Sales
from ProductSales
Order by ProductName, SaleDate;

--Task14
select * from productSales;

Select 
     ProductName,
	 SaleDate,
	 SaleAmount,
	 Avg(SaleAmount) Over (Partition By ProductName) As AvgSaleAmount,
	 SaleAmount - Avg(SaleAmount) Over (Partition By Productname) As DifferenceFromAvg
From ProductSales
Order by ProductName, Saledate;

--Task15
WITH RankedEmployees AS (
    SELECT 
        EmployeeID,
        Name,
        Department,
        Salary,
        DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees1
)
SELECT 
    SalaryRank,
    Name,
    Department,
    Salary
FROM RankedEmployees
WHERE SalaryRank IN (
    SELECT SalaryRank
    FROM RankedEmployees
    GROUP BY SalaryRank
    HAVING COUNT(*) > 1
)
ORDER BY SalaryRank, Salary DESC;

--Task16
WITH DepartmentSalaryRank AS (
    SELECT 
        EmployeeID,
        Name,
        Department,
        Salary,
        DENSE_RANK() OVER (
            PARTITION BY Department 
            ORDER BY Salary DESC
        ) AS SalaryRank
    FROM Employees1
)
SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    SalaryRank
FROM DepartmentSalaryRank
WHERE SalaryRank <= 2
ORDER BY Department, Salary DESC;

--Task17
SELECT e.Department, e.Name, e.Salary
FROM Employees1 e
WHERE e.Salary = (
    SELECT MIN(Salary)
    FROM Employees1
    WHERE Department = e.Department
)
ORDER BY e.Department;

--Task18
Select 
    EmployeeID,
	Name,
	Department,
	Salary,
	HireDate,
	Sum(Salary) Over (
	    Partition by Department
		Order by Hiredate
		Rows Unbounded preceding
	) as RunningTotal
From Employees1
Order by Department, Hiredate;

--Task19
Select
     Department,
	 Name,
	 Salary,
	 Sum(Salary) over (Partition By Department) As TotalDeapartmentSalary
from Employees1
Order by department;

--Task20
select 
    EmployeeID,
	Name,
	Department,
	Salary,
	AVG(Salary) over (Partition By Department) as AvgDepartmentSalary
from Employees1
Order by Department;

--Task21
select * from Employees1;

select 
     EmployeeID,
	 Name,
	 Department,
	 Salary,
	 Avg(salary) Over (Partition By Department) as AvgDepartmentSalary,
	 Salary - Avg(Salary) Over (Partition By Department) as SalaryDifference
from Employees1
Order by department, Salary desc;

--Task22
Select 
    EmployeeID,
	Name,
	Department,
	Salary,
	Avg(Salary) over (
	    order by HireDate
        rows between 1 preceding and 1 following
	) as MovingAvgSalary
from Employees1
order by Hiredate;

--Task23
Select 
     EmployeeID,
	 Name,
	 Department,
	 HireDate,
	 Salary,
	 Sum(Salary) Over (
	     Order by HireDate
		 rows between 2 preceding and current row
	 ) as SumLast3hires
from Employees1
Order by HireDate;
     



