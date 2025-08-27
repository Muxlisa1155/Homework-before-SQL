Homework9
--Task1

select * from suppliers
select * from products

select 
    s.suppliername,
	p.productname
from Products P
Cross join 
    Suppliers S
--Task2
select
    e.name,
	d.departmentname
from departments d
Cross Join
    employees e;

--Task3
select
    s.suppliername,
	p.productname
from 
    Products P
Inner Join 
    Suppliers S on p.productID = s.supplierID;

--Task4
select 
    customers.Firstname,
	customers.Lastname,
	Orders.orderID
from
    Orders
Join
    Customers on Orders.CustomerID = Customers.CustomerID;
--Task5
select 
    s.name,
	c.coursename
from
    students s
Cross join
    courses c;
--Task6
select 
    p.productname,
	o.orderid,
	o.productid
from 
    orders o
join
    Products p on o.productid = p.productid;

Task7
select 
    e.name,
	d.departmentname
from
    departments d
Join 
    employees e on e.departmentid = d.departmentid;

--Task8
select
    s.name,
	s.major,
	e.courseid,
	e.studentid
from
    enrollments e
join 
    students s on s.studentid = e.studentid;

--Task9
 select o.*
 from orders o
 inner join payments p on o.orderid = p.orderid;

 --Task10
 SELECT o.*
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
WHERE p.Price > 100;

--Task11
select 
   e.name as employeename,
   d.departmentname
from 
   employees e
join
   departments d
on
   e.departmentid <> d.departmentid;

--Task12
select 
    p.productid,
	p.productname,
	p.stockquantity,
	o.orderid,
	o.quantity
from 
    orders o
join 
    products p
on
    p.productid = o.orderid
where
    o.quantity > p.stockquantity;

--Task13
select 
    s.customerid,
	c.firstname,
	s.productid,
	s.saleamount
from customers c
join sales s
on c.customerid = s.customerid
where saleamount >= '500';

--Task14
select 
      s.Name as StudentName,
	  c.coursename
from
      enrollments e
Join 
      students s on e.studentid = s.studentid
Join
      courses c on e.courseid = c.courseid
order by
      s.name;
--Task15
select 
    p.productname,
	s.suppliername,
	s.contactname,
	s.supplierid
from products p
join suppliers s
on s.supplierid = p.supplierid
where s.suppliername like 'tech%';

--Task16
select 
      o.orderid,
	  p.amount,
	  o.totalamount
from orders o
join payments p
on o.orderid = p.orderid
where p.amount < o.totalamount;

--Task17
select 
      e.departmentid,
	  e.name,
	  d.departmentname
from employees e
join departments d
on e.departmentid = d.departmentid;

--Task18
SELECT 
    p.ProductID,
    p.ProductName,
    p.Price,
    p.Category,
    p.StockQuantity,
    c.CatName
FROM 
    Products p
JOIN 
    Categories c ON p.Category = c.CatName
WHERE 
    c.CatName IN ('Electronics', 'Furniture');

--Task19
select 
c.customerid,
c.firstname,
c.country,
s.saleid,
s.saleamount
from sales s
join customers c
on s.customerid = c.customerid
where country = 'USA';

--Task20
select 
o.customerid,
c.firstname,
o.totalamount as OrderTotal,
o.orderid,
c.country
from orders o
join customers c
on o.customerid = c.customerid
where c.country = 'Germany'
and o.totalamount > 100;

--Task21
SELECT 
    e1.EmployeeID AS Employee1_ID,
    e1.Name AS Employee1_Name,
    e1.DepartmentID AS Department1,
    e2.EmployeeID AS Employee2_ID,
    e2.Name AS Employee2_Name,
    e2.DepartmentID AS Department2
FROM 
    Employees e1
JOIN 
    Employees e2 ON e1.EmployeeID < e2.EmployeeID
WHERE 
    e1.DepartmentID <> e2.DepartmentID;

--Task22
SELECT 
    p.PaymentID,
    p.OrderID,
    p.Amount AS AmountPaid,
    o.Quantity,
    pr.Price,
    (o.Quantity * pr.Price) AS ExpectedAmount
FROM 
    Payments p
JOIN 
    Orders o ON p.OrderID = o.OrderID
JOIN 
    Products pr ON o.ProductID = pr.ProductID
WHERE 
    p.Amount <> (o.Quantity * pr.Price);

--Task23
SELECT s.StudentID, s.Name, s.Major
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.StudentID IS NULL;

--Task24
SELECT 
    m.EmployeeID AS ManagerID,
    m.Name AS ManagerName,
    m.Salary AS ManagerSalary,
    e.EmployeeID AS EmployeeID,
    e.Name AS EmployeeName,
    e.Salary AS EmployeeSalary
FROM 
    Employees m
JOIN 
    Employees e ON m.EmployeeID = e.ManagerID
WHERE 
    m.Salary <= e.Salary;
--Task25
SELECT DISTINCT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    o.OrderID,
    o.OrderDate,
    o.TotalAmount
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
LEFT JOIN 
    Payments p ON o.OrderID = p.OrderID
WHERE 
    p.OrderID IS NULL;
