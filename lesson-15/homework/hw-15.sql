--Homework15
--Task1 
--Find employees with minimum salary
select id, name, salary
from employees
where salary = (select Min(salary) from employees);

--OR

--Window function

select id, name, salary
from (
    select *,
	       Dense_rank() over (order by salary asc) as drnk
	from employees
) x
where drnk = 1;

--Task2
--Find Products above average price

select * from products;

-- Query with Subquery
select id, product_name, price
from products
where price > (select avg(price) from products);

--Query with AVG() Over()
select id, product_name,price
from (
     select *,
	        Avg(price) over() as avg_price
	 from products
) x
where price > avg_price;

--Task3
-- Find Employees in Sales Department Task: Retrieve employees who work in the "Sales" department. Tables: employees (columns: id, name, department_id), departments (columns: id, department_name)
select * from employees;
select * from departments;

select e.id, e.name, d.department_name
from employees e
Join departments d
 on e.department_id = d.id
where d.department_name ='Sales';

--Task4
select * from customers;
select * from orders;

select c.customer_id,
       c.name,
	   o.order_id
from Customers c
Left Join Orders o
on c.customer_id = o.customer_id
where o.order_id is NULL;

-- We can solve this puzzle with NOT EXIST

Select c.customer_id, c.name
from customers c
where not exists (
      select 1
	  from orders o
	  where o.customer_id = c.customer_id
);

--Task5
select * from products;

select category_id,
       Max(Price) As MaxPrice
from Products
Group by category_id;

--Window Function
select id, product_name, price, category_id
from (
     select *,
	        Rank() over (Partition by category_id order by price desc) as rnk 
	 from products
) x
where rnk = 1

--Task6
select * from employees;
select * from departments;

select
      e.id,
      e.name,
	  e.salary,
	  d.department_name
from employees e
Join departments d
on e.department_id = d.id
where e.department_id = (
    select Top 1 department_id
	from employees
	group by department_id
	order by AVG(salary) DESC
);

--Task7
select * from employees;

--Subquery version
select e.id, e.name, e.salary, e.department_id
from employees e
where e.salary > (
      select AVG(salary)
	  from employees
	  where department_id = e.department_id
);

--Window Function
select id, name, salary, department_id
from (
     select e.*,
	        AVG(salary) OVER (Partition By department_id) as dept_avg
	 from employees e
) x 
where salary > dept_avg;

--Task8
select * from students;
select * from grades;

--subquery version
select s.student_id, s.name, g.course_id, g.grade
from grades g
Join students s on s.student_id = g.student_id
where g.grade = (
      select MAX(g2.grade)
	  from grades g2
	  where g2.course_id = g.course_id
);

--Window version
SELECT s.student_id, s.name, g.course_id, g.grade
FROM (
    SELECT g.*,
           RANK() OVER (PARTITION BY course_id ORDER BY grade DESC) AS rnk
    FROM grades g
) g
JOIN students s ON s.student_id = g.student_id
WHERE g.rnk = 1;

--Task9
select * from products;
 
--Window Function Version.
SELECT id, product_name, price, category_id
FROM (
    SELECT p.*,
           DENSE_RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS rnk
    FROM products p
) x
WHERE rnk = 3;

--Subquery Version.
SELECT p.id, p.product_name, p.price, p.category_id
FROM products p
WHERE 2 = (
    SELECT COUNT(DISTINCT p2.price)
    FROM products p2
    WHERE p2.category_id = p.category_id
      AND p2.price > p.price
);

--Task10
select * from employees;

--Window Function Version
SELECT id, name, salary, department_id
FROM (
    SELECT e.*,
           AVG(salary) OVER () AS company_avg,
           MAX(salary) OVER (PARTITION BY department_id) AS dept_max
    FROM employees e
) x
WHERE salary > company_avg
  AND salary < dept_max;


--Subquery Version.
  SELECT e.id, e.name, e.salary, e.department_id
FROM employees e
WHERE e.salary > (
    SELECT AVG(salary) FROM employees
)
AND e.salary < (
    SELECT MAX(salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
);
