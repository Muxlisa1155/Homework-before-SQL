-- 1
select o.OrderID, c.FirstName, c.LastName, o.OrderDate
from Orders o join Customers c
on o.CustomerID = c.CustomerID
where year(o.OrderDate) > 2022 

-- 2
select e.Name as EmployeeName, d.DepartmentName
from Employees e join Departments d
on e.DepartmentID = d.DepartmentID
where d.DepartmentName in ('Sales', 'Marketing')

-- 3 
select d.DepartmentName, max(e.Salary)  as maxSalary
from Employees e join Departments d
on e.DepartmentID = d.DepartmentID
group by d.DepartmentName

-- 4
select c.FirstName, c.LastName, o.OrderID, o.OrderDate
from Customers c join Orders o
on c.CustomerID = o.CustomerID
where c.Country = 'USA' and year(o.OrderDate) = 2023

-- 5
select c.FirstName, C.LastName, count(o.OrderID) as TotalOrders
from Orders o left join Customers c
on o.CustomerID = c.CustomerID
group by c.FirstName, c.LastName

-- 6
select p.ProductName, s.SupplierName
from Products p join Suppliers s
on p.SupplierID = s.SupplierID
where s.SupplierName in ('Gadget Supplies', 'Clothing Mart')

-- 7
SELECT 
    c.FirstName, c.LastName,
    MAX(o.OrderDate) AS MostRecentOrderDate
FROM Customers c LEFT JOIN Orders o 
ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName;

-- 8
select c.FirstName, c.LastName, sum(o.TotalAmount * o.Quantity)
from Orders o join Customers c
on o.CustomerID = c.CustomerID
group by c.FirstName, c.LastName
having sum(o.TotalAmount * o.Quantity) > 500

-- 9
select p.ProductName, s.SaleDate, s.SaleAmount
from Products p join Sales s
on p.ProductID = s.ProductID
where year(s.SaleDate) = 2022 or s.SaleAmount > 400

-- 10
select p.ProductName, sum(s.SaleAmount) as TotalSalesAmount
from Sales s join Products p
on s.ProductID = p.ProductID
group by p.ProductName

-- 11
select e.Name as EmployeeName, d.DepartmentName, e.Salary
from Employees e join Departments d
on e.DepartmentID = d.DepartmentID
where d.DepartmentName = 'Human Resources' and
e.Salary > 60000

-- 12
select p.ProductName, s.SaleDate, p.StockQuantity
from Products p join Sales s
on p.ProductID = s.ProductID
where year(s.SaleDate) = 2023 and p.StockQuantity > 100

-- 13
select e.Name as EmployeeName, d.DepartmentName, e.HireDate
from Employees e join Departments d
on e.DepartmentID = d.DepartmentID
where d.DepartmentName = 'Sales' or year(e.HireDate) = 2020

-- 14
select 
	c.FirstName + ' ' + c.LastName AS CustomerName,
	o.OrderID,
	c.Address,
	o.OrderDate
from Customers c join Orders o
on c.CustomerID = o.CustomerID
where c.Country = 'USA' and c.Address like '[0-9][0-9][0-9][0-9]%'

-- 15
select p.ProductName,
    p.Category,
    s.SaleAmount
from Products p join Sales s
on p.ProductID = s.ProductID
where p.Category = (SELECT CategoryID FROM Categories WHERE CategoryName = 'Electronics')
or s.SaleAmount > 350

-- 16
select c.CategoryName, count(p.ProductID) as ProductCount
from Products p join Categories c
on p.Category = c.CategoryID
group by c.CategoryName

-- 17
select 
	c.FirstName + ' ' + c.LastName as CustomerName,
	c.City, o.OrderID, o.TotalAmount as Amount
from Customers c join Orders o
on c.CustomerID = o.CustomerID
where c.City = 'Los Angeles' and o.TotalAmount > 300

-- 18
select e.Name as EmployeeName, d.DepartmentName
from Employees e join Departments d
on e.DepartmentID = d.DepartmentID
where d.DepartmentName in ('Human Resources', 'Finance')
 OR (
        LEN(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(e.Name,'a',''),'e',''),'i',''),'o',''),'u','')) 
        <= LEN(e.Name) - 4
      );


-- 19
select e.Name as EmployeeName, d.DepartmentName, e.Salary
from Employees e join Departments d
on e.DepartmentID = d.DepartmentID
where  d.DepartmentName in ('Sales ', 'Marketing')
and e.Salary > 60000
