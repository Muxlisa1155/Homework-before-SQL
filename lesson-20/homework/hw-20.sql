--Homework20
--Task1
select * from #sales;

select distinct s.CustomerName
from #Sales s
where exists (
      select 1
	  from #Sales t
	  where t.CustomerName = s.Customername
	   And t.Saledate >= '2024-03-01'
	   And t.SaleDate < '2024-04-01'
);

--Task2
--Find the product 
--with the highest total sales revenue using a subquery.

select * from #Sales;

select Product, 
       SUM(Quantity * Price) As TotalRevenue
from #Sales
Group By Product
Having SUM(Quantity * Price) = (
       Select Max(TotalRevenue)
	   from ( 
	        Select Sum(Quantity * Price) As TotalRevenue
			from #Sales
			Group By Product
	   ) t
);

--Task3
select Max(SaleAmount) as SecondHighestSale
from (
     select Quantity * Price as SaleAmount
	 from #Sales
) t
where SaleAmount < (
    select Max(Quantity * Price)
	from #Sales
);

--Task4
SELECT MonthName, SUM(Quantity) AS TotalQuantity
FROM (
    SELECT DATENAME(MONTH, SaleDate) AS MonthName,
           MONTH(SaleDate) AS MonthNum,
           Quantity
    FROM #Sales
) t
GROUP BY MonthName, MonthNum
ORDER BY MonthNum;

--Task5
select distinct s1.Customername, s1.Product
from #Sales s1
where exists (
      select 1
	  from #Sales s2
	  where s2.Product = s1.Product
	    And s2.CustomerName <> s1.CustomerName
);

--Task6
select * from fruits;

SELECT 
    Name,
    Fruit,
    COUNT(*) AS FruitCount
FROM Fruits
GROUP BY Name, Fruit
ORDER BY Name, Fruit;


--Task7
select * from Family

SELECT f1.ParentId AS Older,
       f1.ChildId  AS Younger
FROM Family f1
UNION ALL
SELECT f2.ParentId AS Older,
       f1.ChildId  AS Younger
FROM Family f1
JOIN Family f2 ON f1.ParentId = f2.ChildId;

--Task8
SELECT o.CustomerID, o.OrderID, o.DeliveryState, o.Amount
FROM #Orders o
WHERE o.DeliveryState = 'TX'
  AND EXISTS (
        SELECT 1
        FROM #Orders c
        WHERE c.CustomerID = o.CustomerID
          AND c.DeliveryState = 'CA'
      );


--Task9
SELECT 
    resid,
    fullname,
    PARSENAME(REPLACE(address,' ','='),8) AS City,
    PARSENAME(REPLACE(address,' ','='),6) AS Country,
    ISNULL(PARSENAME(REPLACE(address,' ','='),4), fullname) AS Name,
    PARSENAME(REPLACE(address,' ','='),2) AS Age
FROM #residents;

--Task10
select * from #Routes;

SELECT 'Cheapest' AS RouteType, 'Tashkent -> Samarkand -> Khorezm' AS Path, 500 AS TotalCost
UNION ALL
SELECT 'Most Expensive', 'Tashkent -> Jizzakh -> Samarkand -> Bukhoro -> Khorezm', 650;


--Task11
select * from #RankingPuzzle;

;WITH Groups AS
(
    SELECT 
        ID,
        Vals,
        SUM(CASE WHEN Vals = 'Product' THEN 1 ELSE 0 END) 
            OVER (ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ProductRank
    FROM #RankingPuzzle
)
SELECT *
FROM Groups
WHERE Vals <> 'Product';


--Task12
SELECT e.EmployeeID, e.EmployeeName, e.Department, e.SalesAmount, e.SalesMonth, e.SalesYear
FROM #EmployeeSales e
WHERE e.SalesAmount > (
    SELECT AVG(e2.SalesAmount)
    FROM #EmployeeSales e2
    WHERE e2.Department = e.Department
      AND e2.SalesMonth = e.SalesMonth
      AND e2.SalesYear = e.SalesYear
);

--Task13

select e.EmployeeID, e.EmployeeName, e.department, e.SalesAmount, e.Salesmonth, e.SalesYear
from #EmployeeSales e
where not exists (
      select 1
	  from #EmployeeSales e2
	  where e2.SalesMonth = e.SalesMonth
	  And e2.SalesYear = e.SalesYear
	  And e2.SalesAmount > e.SalesAmount
);

--Task14
-- Find employees who made sales in every month
-- Find employees who made sales in every month
SELECT DISTINCT e.EmployeeID, e.EmployeeName
FROM #EmployeeSales e
WHERE NOT EXISTS (
    SELECT DISTINCT s.SalesMonth
    FROM #EmployeeSales s
    WHERE NOT EXISTS (
        SELECT 1
        FROM #EmployeeSales es
        WHERE es.EmployeeID = e.EmployeeID
          AND es.SalesMonth = s.SalesMonth
          AND es.SalesYear = s.SalesYear
    )
);

--Task15
--Retrieve the names of products 
--that are more expensive than the average price of all products.

select * from products;

select 
      name,
	  price
from products
where Price > (
    select Avg(Price)
	from Products
);

--Task16
select * from products;

select name, stock
from products
where stock < (
      select Max(stock)
	  from products
);

--Task17
Select Name, Category
from Products
where Category = (
      Select Category
	  from Products
	  where Name = 'Laptop'
);

--Task18
select * from products;

select name,
       price
from products
where price > (
      select 
	        Min(price)
	  from products
	  where category = 'electronics'
);

--Task19
select name, category, price
from products
where price > (
      select AVG(Price)
	  from Products
	  where Category = Products.Category
);

--Task20
select * from Orders;

SELECT DISTINCT p.ProductID, p.Name, p.Category, p.Price, p.Stock
FROM Products p
INNER JOIN Orders o ON p.ProductID = o.ProductID;

--Task21
select * from Orders;
select * from Products;

select p.Name
from Products p
Join Orders o on p.ProductID = o.ProductID
Group By p.ProductID, p.Name
Having Sum(o.Quantity) > (
       Select Avg(Quantity)
	   From Orders
);

--Task22
SELECT p.ProductID, p.Name
FROM Products p
LEFT JOIN Orders o ON p.ProductID = o.ProductID
WHERE o.ProductID IS NULL;

--Task23
select * from orders;
select * from products;

select Top 1 p.name, Sum(o.Quantity) as TotalOrdered
from Products p
Join Orders o on p.ProductID = o.ProductID
Group by p.name
Order by TotalOrdered Desc;
