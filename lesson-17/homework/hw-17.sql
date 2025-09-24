Homework17
Task1
select * from #RegionSales

select r.Region, d.Distributor
from (select distinct Region from #RegionSales) r
Cross Join (select distinct Distributor from #RegionSales) d
Order by d.Distributor, r.Region;

select * from #RegionSales;

Select 
    r.region,
	d.distributor,
	rs.Sales
From
    (select distinct Region From #RegionSales) r
Cross Join 
    (select distinct Distributor from #Regionsales) d
Left Join
    #RegionSales rs
	on rs.Region = r.Region And rs.Distributor = d.Distributor
Order by d.Distributor, r.Region;

--Task2
select * from employee;


select managerid, count(*) as DirectReports
from employee
where managerid is not NULL
group by managerid;

--Then

select m.id, m.name, count(e.id) as DirectReports
from Employee e
join Employee m
   on e.managerID = m.id
Group by m.id, m.name
Having Count(e.id) >= 5;

--Task3
select * from products
select * from orders;


SELECT 
    p.product_id,
    p.product_name,
    SUM(o.unit) AS total_units
FROM Products p
JOIN Orders o 
    ON p.product_id = o.product_id
WHERE o.order_date >= '2020-02-01'
  AND o.order_date < '2020-03-01'
GROUP BY p.product_id, p.product_name
HAVING SUM(o.unit) >= 100;


--Task4

select * from orders;

select CustomerID, Vendor, Count(*) as OrderCount
from Orders
Group by CustomerID, Vendor;

WITH VendorCounts AS (
    SELECT 
        CustomerID,
        Vendor,
        COUNT(*) AS OrderCount,
        RANK() OVER (
            PARTITION BY CustomerID 
            ORDER BY COUNT(*) DESC
        ) AS rnk
    FROM Orders
    GROUP BY CustomerID, Vendor
)
SELECT CustomerID, Vendor, OrderCount
FROM VendorCounts
WHERE rnk = 1;

--Task5
DECLARE @Check_Prime INT = 91;  
DECLARE @i INT = 2;  
DECLARE @isPrime BIT = 1;  

WHILE @i < @Check_Prime
BEGIN
    IF @Check_Prime % @i = 0
    BEGIN
        SET @isPrime = 0;
        BREAK;
    END
    SET @i = @i + 1;
END

IF @isPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime

--Task6
select * from Device
WITH LocationCounts AS (
    SELECT 
        Device_id,
        Locations,
        COUNT(*) AS SignalCount
    FROM Device
    GROUP BY Device_id, Locations
),
Ranked AS (
    SELECT 
        Device_id,
        Locations,
        SignalCount,
        RANK() OVER (PARTITION BY Device_id ORDER BY SignalCount DESC) AS rnk
    FROM LocationCounts
)
SELECT 
    d.Device_id,
    COUNT(DISTINCT d.Locations) AS NumLocations,
    r.Locations AS MostSignalsLocation,
    r.SignalCount AS MaxSignals,
    SUM(l.SignalCount) AS TotalSignals
FROM Device d
JOIN LocationCounts l ON d.Device_id = l.Device_id
JOIN Ranked r ON l.Device_id = r.Device_id AND r.rnk = 1
GROUP BY d.Device_id, r.Locations, r.SignalCount;

--Task7
select Empid, Empname, Salary
from employee e
where salary > (
      select AVG(salary)
	  from Employee
	  where DeptID = e.DeptID
);

--OR

select e.empid, e.empname, e.salary
from Employee e
Join ( 
     Select DeptID, Avg(salary) as AvgSalary
	 from Employee
	 Group by DeptID
) d
on e.DeptID = d.DeptID
where e.salary > d.AvgSalary;

--Task8

select * from numbers;
select * from tickets;

WITH TicketMatches AS (
    SELECT 
        t.TicketID,
        COUNT(*) AS MatchedCount
    FROM Tickets t
    INNER JOIN Numbers n
        ON t.Number = n.Number
    GROUP BY t.TicketID
),
Winning AS (
    SELECT COUNT(*) AS TotalWinningNums
    FROM Numbers
)
SELECT 
    tm.TicketID,
    CASE 
        WHEN tm.MatchedCount = w.TotalWinningNums THEN 100
        WHEN tm.MatchedCount > 0 THEN 10
        ELSE 0
    END AS Winnings
FROM TicketMatches tm
CROSS JOIN Winning w;

--Task9
select * from spending;

WITH UserSpend AS (
    SELECT 
        User_id,
        Spend_date,
        SUM(CASE WHEN Platform = 'Mobile' THEN Amount ELSE 0 END) AS MobileSpend,
        SUM(CASE WHEN Platform = 'Desktop' THEN Amount ELSE 0 END) AS DesktopSpend
    FROM Spending
    GROUP BY User_id, Spend_date
)
SELECT
    Spend_date,
    CASE 
        WHEN MobileSpend > 0 AND DesktopSpend = 0 THEN 'Mobile only'
        WHEN DesktopSpend > 0 AND MobileSpend = 0 THEN 'Desktop only'
        WHEN MobileSpend > 0 AND DesktopSpend > 0 THEN 'Both'
    END AS UserType,
    COUNT(*) AS TotalUsers,
    SUM(MobileSpend + DesktopSpend) AS TotalAmount
FROM UserSpend
GROUP BY Spend_date,
    CASE 
        WHEN MobileSpend > 0 AND DesktopSpend = 0 THEN 'Mobile only'
        WHEN DesktopSpend > 0 AND MobileSpend = 0 THEN 'Desktop only'
        WHEN MobileSpend > 0 AND DesktopSpend > 0 THEN 'Both'
    END
ORDER BY Spend_date, UserType;

Task10

select * from Grouped;

;WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL SELECT 2
    UNION ALL SELECT 3
    UNION ALL SELECT 4
    UNION ALL SELECT 5
    -- you can add more if needed
)
SELECT g.Product
FROM Grouped g
JOIN Numbers n 
  ON n.n <= g.Quantity
ORDER BY g.Product;
