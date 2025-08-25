Homework8
--Task1
select
   Category,
   Sum(StockQuantity) as TotalProductsNumber
from Products
group by Category;

--Task2
select
	AVG(Price) as AvgPrice
from Products
where Category = 'Electronics';

--Task3
select * from Customers
where city like 'L%';

--Task4
select * from Products
where productname like'%er';

--Task5
select * from Customers
where Country like '%A';
--Task6
select max(price) as MaxPrice
from Products;
--Task7
select 
    ProductID,
	ProductName,
	StockQuantity,
	Case 
	   when StockQuantity < 30 then 'Low Stock'
	   else 'Sufficient'
    End As StockStatus
from Products;
--Task8
select * from Customers
select 
    Country,
    sum(CustomerID) as TotalCustomers
from Customers
Group by Country;
--Task9
select 
   Min(Quantity) as MinQuantity,
   Max(Quantity) as MaxQuantity
from Orders;

--Task10
SELECT DISTINCT o.CustomerID
FROM Orders o
WHERE o.OrderDate >= '2023-01-01' AND o.OrderDate < '2023-02-01'
  AND o.CustomerID NOT IN (
      SELECT DISTINCT i.CustomerID
      FROM Invoices i
      WHERE i.InvoiceDate >= '2023-01-01' AND i.InvoiceDate < '2023-02-01'
  );

--Task11
select ProductName From Products
Union All
Select ProductName From Products_Discounted;

--Task12
select ProductName from Products
Union
Select ProductName from Products_Discounted;

--Task13
select 
    Year(OrderDate) as OrderYear,
	Avg(TotalAmount) as AvgAmount
from Orders
Group by Year(OrderDate)

--Task14
select 
   ProductName,
   Case  
      when Price < 100 then 'Low'
	  when Price > 100 then 'High'
	  when Price Between 100 and 500 then 'MID'
   End AS PriceGroup
From
   Products;
--Task15
SELECT 
    district_id,
    district_name,
    [2012],
    [2013]
INTO Population_Each_Year
FROM 
(
    SELECT 
        district_id,
        district_name,
        population,
        year
    FROM city_population
) AS SourceTable
PIVOT
(
    SUM(population)
    FOR year IN ([2012], [2013])
) AS PivotTable;

--Task16
select 
   ProductID,
   SUM(SaleAmount) as TotalSales
from Sales
   Group BY ProductID;

--Task17
select ProductName
from Products
where ProductName Like '%oo%';

--Task18
CREATE TABLE Population_Each_City (
    Year VARCHAR(20),
    Bektemir DECIMAL(10,2),
    Chilonzor DECIMAL(10,2),
    Yakkasaroy DECIMAL(10,2)
);

INSERT INTO Population_Each_City (Year, Bektemir, Chilonzor, Yakkasaroy)
SELECT 
    year,
    [Bektemir],
    [Chilonzor],
    [Yakkasaroy]
FROM (
    SELECT 
        year,
        district_name,
        population
    FROM 
        city_population
    WHERE 
        district_name IN ('Bektemir', 'Chilonzor', 'Yakkasaroy')
) AS SourceTable
PIVOT (
    SUM(population)
    FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS PivotTable;

--Task19
select
   Top 3 CustomerID,
   Sum(TotalAmount) as TotalSpent
From Invoices
Group By CustomerID
Order BY TotalSpent DESC;

--Task20
SELECT 
    district_id,
    district_name,
    [2012],
    [2013]
FROM (
    SELECT district_id, district_name, year, population
    FROM city_population
) src
PIVOT (
    SUM(population)
    FOR year IN ([2012], [2013])
) AS pvt;


--Task21
select
   p.productname,
   COUNT(s.saleid) as TimeSold
from 
   Products p
Left Join
   Sales s on p.productid = s.productid
Group By
   p.ProductName
Order BY
   Timesold Desc;

--Task22
SELECT 
    district_id,
    district_name,
    [2012],
    [2013]
FROM (
    SELECT district_id, district_name, year, population
    FROM city_population
) src
PIVOT (
    SUM(population)
    FOR year IN ([2012], [2013])
) AS p;
