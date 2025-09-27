--Homework19
--Task1
select * from Employees;
select * from departmentbonus;

create Procedure pr_Employeebonus
As
Begin
     create table #EmployeeBonus
	 (    
	   EmployeeID INT,
	   Fullname NVarchar(100),
	   Department NVarchar(100),
	   Salary decimal(10,2),
	   BonusAmount decimal(10,2)
	 );
	  
	 insert into #EmployeeBonus (EmployeeID, Fullname, Department, Salary, BonusAmount)
	 select
	   e.employeeid,
	   e.firstname + '' + e.lastname as Fullname,
	   e.department,
	   e.salary,
	   e.salary * db.BonusPercentage / 100 As BonusAmount
	 from Employees e
	 Inner  Join DepartmentBonus db
	 on e.department = db.department;

	 select * from #EmployeeBonus;
End;
GO

exec pr_Employeebonus;

--Task2
select * from employees;
select * from departmentbonus;

create procedure UpdateDepartmentSalary
   @Deptname Nvarchar(50),
   @Percent Decimal(5,2)
AS
Begin
       
	 Update Employees
	 Set Salary = Salary + (Salary *@Percent/ 100)
	 where Department = @DeptName;

     Select EmployeeID,
	        FirstName + '' + LastName As FullName,
			Department,
			Salary
	 From Employees
	 where Department = @DeptName;
End;
go

Exec UpdateDepartmentSalary @DeptName = 'Sales', @Percent = 10;

--Task3
select * from Products_Current;
select * from Products_New;

Merge Products_Current As T
Using Products_New As S
On T.ProductID = S.ProductID

When Matched Then
     Update Set 
	    t.ProductName = s.ProductName,
		t.Price = s.Price

When not matched by target then
     insert (ProductID, ProductName, Price)
	 values (s.productid, s.productname, s.price)

When not matched by source then
     delete;

select * from Products_Current;
     
--Task4

select * from Tree;

select 
     id,
	 case 
	     when p_id is Null then 'Root'
		 when id in (select p_id from tree where p_id is not Null) then 'Inner'
		 Else 'Leaf'
	 End as NodeType
From Tree;

--Task5
select * from signups;
select * from confirmations;

SELECT 
    s.user_id,
    CAST(
        ISNULL(SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END), 0) * 1.0 
        / NULLIF(COUNT(c.user_id), 0)
    AS DECIMAL(5,2)) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c 
    ON s.user_id = c.user_id
GROUP BY s.user_id;


--Task6
select * from employees;

select id,
       name,
	   salary 
from employees
where salary = (
    select Min(salary)
	from employees
);

--Task7

create procedure GetProductSalesSummary
 @ProductID INT
As
Begin
   
   select 
        p.productname,
		SUM(s.Quantity) AS TotalQuantitySold,
		SUM(s.Quantity * p.Price) as TotalSalesAmount,
		MIN(s.SaleDate) AS FirstSaleDate,
		MAX(s.SaleDate) as LastSaleDate
   from Products p
   left join Sales s
        on p.productID = s.ProductID
   where p.productid = @ProductID
   Group By p.productname;
End;
Go

EXEC GetProductSalesSummary @ProductID = 1;
