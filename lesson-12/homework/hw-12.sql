Homework12

--Task1
select * from person;
select * from address;

select 
     p.personid,
     p.firstname,
	 p.lastname,
	 a.addressid,
	 a.city,
	 a.state
from person p
left join address a
on p.personid = a.personid;

--Task2
select * from employees;
--self join

select 
     e.name as Employee
from 
     employee e
join
     employee m
on e.managerid = m.id
where e.salary > m.salary;

--Task3
CREATE TABLE Person (
    id INT,
    email VARCHAR(255)
);
TRUNCATE TABLE Person;

INSERT INTO Person (id, email) VALUES (1, 'a@b.com');
INSERT INTO Person (id, email) VALUES (2, 'c@d.com');
INSERT INTO Person (id, email) VALUES (3, 'a@b.com');

SELECT email
FROM Person
GROUP BY email
HAVING COUNT(*) > 1;

--Task4
DELETE FROM Person
WHERE id NOT IN (
    SELECT MIN(id)
    FROM Person
    GROUP BY email
);
--Task5
SELECT DISTINCT g.ParentName
FROM girls g
WHERE g.ParentName NOT IN (
    SELECT DISTINCT b.ParentName
    FROM boys b
);

--Task7
SELECT
    c1.Item AS [Item Cart 1],
    c2.Item AS [Item Cart 2]
FROM Cart1 c1
FULL OUTER JOIN Cart2 c2
    ON c1.Item = c2.Item;

--Task8

SELECT c.name
FROM Customers c
LEFT JOIN Orders o ON c.id = o.customerId
WHERE o.customerId IS NULL;

--Task9

--Create table Students (student_id int, student_name varchar(20))
--Create table Subjects (subject_name varchar(20))
--Create table Examinations (student_id int, subject_name varchar(20))
--Truncate table Students
--insert into Students (student_id, student_name) values ('1', 'Alice')
--insert into Students (student_id, student_name) values ('2', 'Bob')
--insert into Students (student_id, student_name) values ('13', 'John')
--insert into Students (student_id, student_name) values ('6', 'Alex')
--Truncate table Subjects
--insert into Subjects (subject_name) values ('Math')
--insert into Subjects (subject_name) values ('Physics')
--insert into Subjects (subject_name) values ('Programming')
--Truncate table Examinations
--insert into Examinations (student_id, subject_name) values ('1', 'Math')
--insert into Examinations (student_id, subject_name) values ('1', 'Physics')
--insert into Examinations (student_id, subject_name) values ('1', 'Programming')
--insert into Examinations (student_id, subject_name) values ('2', 'Programming')
--insert into Examinations (student_id, subject_name) values ('1', 'Physics')
--insert into Examinations (student_id, subject_name) values ('1', 'Math')
--insert into Examinations (student_id, subject_name) values ('13', 'Math')
--insert into Examinations (student_id, subject_name) values ('13', 'Programming')
--insert into Examinations (student_id, subject_name) values ('13', 'Physics')
--insert into Examinations (student_id, subject_name) values ('2', 'Math')
--insert into Examinations (student_id, subject_name) values ('1', 'Math')

SELECT 
    e.student_id,
    s.student_name,
    e.subject_name,
    COUNT(*) AS attended_exams
FROM Examinations e
JOIN Students s ON e.student_id = s.student_id
GROUP BY e.student_id, s.student_name, e.subject_name
ORDER BY e.student_id, e.subject_name;
