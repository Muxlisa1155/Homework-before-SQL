Homework10
-- 1

select e.Name EmployeeName, e.Salary, d.DepartmentName
from Employees e join Departments d
on e.DepartmentID = d.DepartmentID 
and e.Salary > 50000


-- 2

select c.FirstName, c.LastName, o.OrderDate
from Customers c join Orders o
on c.CustomerID = o.CustomerID
where year(o.OrderDate) = 2023

-- 3

select e.Name EmployeeName, d.DepartmentName
from Employees e left join Departments d
on e.DepartmentID = d.DepartmentID
where d.DepartmentID is null

-- 4

select s.SupplierName, p.ProductName
from Products p right join Suppliers s
on p.SupplierID = s.SupplierID
 
-- 5
select o.OrderID, o.OrderDate, p.PaymentDate
from Orders o full join Payments p
on o.OrderID = p.OrderID

-- 6
select e.Name EmployeeName, m.Name ManagerName
from Employees e left join Employees m
on m.EmployeeID = e.ManagerID

-- 7
select s.Name StudentName, c.CourseName
from Students s 
join Enrollments e on e.StudentID = s.StudentID
join Courses c on c.CourseID = e.CourseID
where c.CourseName = 'Math 101'


-- 8

select c.FirstName, c.LastName, o.Quantity
from Customers c join Orders o 
on c.CustomerID = o.CustomerID
where o.Quantity > 3

-- 9

select e.Name EmployeeName, d.DepartmentName
from Employees e join Departments d
on e.DepartmentID = d.DepartmentID
where d.DepartmentName = 'Human Resources'

-- 10
select d.DepartmentName, count(e.Name) as EmployeeCount
from Employees e join Departments d
on e.DepartmentID = d.DepartmentID
group by d.DepartmentName
having count(e.Name) > 5

-- 11
select p.ProductID, p.ProductName
from Products p left join Sales s
on p.ProductID = s.ProductID
where s.SaleID is null

-- 12
select c.FirstName, c.LastName, count(o.OrderID) as totalOrders
from Customers c join Orders o
on c.CustomerID = o.CustomerID
group by c.FirstName, c.LastName
having count(o.OrderID) > 0

-- 13
select e.Name EmployeeName, d.DepartmentName
from Employees e join Departments d
on e.DepartmentID = d.DepartmentID

-- 14
SELECT 
    e1.Name AS Employee1,
    e2.Name AS Employee2,
    e1.ManagerID
FROM Employees e1
JOIN Employees e2 
    ON e1.ManagerID = e2.ManagerID
   AND e1.EmployeeID < e2.EmployeeID
WHERE e1.ManagerID IS NOT NULL
ORDER BY e1.ManagerID;

-- 15
select o.OrderID, o.OrderDate, c.FirstName, c.LastName
from Orders o join Customers c
on o.CustomerID = c.CustomerID
and year(o.OrderDate) = 2022

-- 16

select e.Name EmployeeName, e.Salary, d.DepartmentName
from Employees e join Departments d
on e.DepartmentID = d.DepartmentID
where d.DepartmentName = 'Sales' and e.Salary > 60000

-- 17
select o.OrderID, o.OrderDate, p.PaymentDate, p.Amount
from Orders o join Payments p
on o.OrderID = p.OrderID

-- 18
select p.ProductID, p.ProductName
from Products p left join Orders o
on p.ProductID = o.ProductID

-- 19

select e.Name as EmployeeName, e.Salary
from Employees e
where e.Salary > (
	select avg(e2.Salary)
	from Employees e2
	where e2.DepartmentID = e.DepartmentID
)

-- 20
select o.OrderID, o.OrderDate
from Orders o left join Payments p
on o.OrderID = p.OrderID
where year(o.OrderDate) < 2020 and p.PaymentID is null

-- 21
select p.ProductID, p.ProductName
from Products p join Categories c
on p.Category != c.CategoryID

-- 22
SELECT 
    e1.Name AS Employee1,
    e2.Name AS Employee2,
    e1.ManagerID,
    e1.Salary AS Salary1,
    e2.Salary AS Salary2
FROM Employees e1
JOIN Employees e2 
    ON e1.ManagerID = e2.ManagerID
   AND e1.EmployeeID < e2.EmployeeID
WHERE e1.ManagerID IS NOT NULL
  AND e1.Salary > 60000
  AND e2.Salary > 60000
ORDER BY e1.ManagerID;
select *
from Employees

-- 23
select e.Name, d.DepartmentName
from Employees e join Departments d
on e.DepartmentID = d.DepartmentID
where d.DepartmentName like 'M%'

-- 24
select s.SaleID, p.ProductName, s.SaleAmount
from Products p join Sales s
on p.ProductID = s.ProductID
where s.SaleAmount > 500

-- 25
select s.StudentID, s.Name
from Students s 
left join Enrollments e on s.StudentID = e.StudentID
left join Courses c on c.CourseID = e.CourseID and c.CourseName = 'Math 101'
where c.CourseID is null

-- 26
select o.OrderDate, o.OrderDate, p.PaymentID
from Orders o left join Payments p
on o.OrderID = p.OrderID
where p.PaymentID is null

-- 27
select p.ProductID, p.ProductName, c.CategoryName
from Products p join Categories c
on p.ProductID = c.CategoryID
where c.CategoryName = 'Electronics'
or c.CategoryName = 'Furniture'

