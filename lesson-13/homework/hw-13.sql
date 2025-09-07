Homework13
--create table Students(
--  StudentID int,
--  FullName varchar(100),
--  Grade decimal(5,2)
--)

--insert into Students values 
--(1,'James Alexander Hamilton',98.5),
--(2,'Arthur George Mason',78.2),
--(3,'Lily B Peters',81),
--(4,'Kayne Thomas Derek',87.3),
--(5,'April Dukane Paris',79.1),
--(6,'Payton Carl Johnson',97.1)
--CREATE TABLE Employee
--(
--EmployeeID  INTEGER PRIMARY KEY,
--ManagerID   INTEGER NULL,
--JobTitle    VARCHAR(100) NOT NULL
--);
--GO

--INSERT INTO Employee (EmployeeID, ManagerID, JobTitle) VALUES
--(1001,NULL,'President'),(2002,1001,'Director'),
--(3003,1001,'Office Manager'),(4004,2002,'Engineer'),
--(5005,2002,'Engineer'),(6006,2002,'Engineer');
--GO

--CREATE TABLE Orders
--(
--CustomerID     INTEGER,
--OrderID        INTEGER,
--DeliveryState  VARCHAR(100) NOT NULL,
--Amount         MONEY NOT NULL,
--PRIMARY KEY (CustomerID, OrderID)
--);
--GO

--INSERT INTO Orders (CustomerID, OrderID, DeliveryState, Amount) VALUES
--(1001,1,'CA',340),(1001,2,'TX',950),(1001,3,'TX',670),
--(1001,4,'TX',860),(2002,5,'WA',320),(3003,6,'CA',650),
--(3003,7,'CA',830),(4004,8,'TX',120);
--GO

--CREATE TABLE DMLTable
--(
--SequenceNumber  INTEGER PRIMARY KEY,
--String          VARCHAR(100) NOT NULL
--);
--GO
--INSERT INTO DMLTable (SequenceNumber, String) VALUES
--(1,'SELECT'),
--(2,'Product,'),
--(3,'UnitPrice,'),
--(4,'EffectiveDate'),
--(5,'FROM'),
--(6,'Products'),
--(7,'WHERE'),
--(8,'UnitPrice'),
--(9,'> 100');
--GO

--CREATE TABLE Equations
--(
--Equation  VARCHAR(200) PRIMARY KEY,
--TotalSum  INTEGER NULL
--);
--GO
--INSERT INTO Equations (Equation) VALUES
--('123'),('1+2+3'),('1+2-3'),('1+23'),('1-2+3'),('1-2-3'),('1-23'),('12+3'),('12-3');
--GO

--CREATE TABLE Student
--(
--StudentName  VARCHAR(50) PRIMARY KEY,
--Birthday     DATE
--);
--GO
--INSERT INTO Student (StudentName, Birthday) VALUES
--('Susan', '2015-04-15'),
--('Tim', '2015-04-15'),
--('Jacob', '2015-04-15'),
--('Earl', '2015-02-05'),
--('Mike', '2015-05-23'),
--('Angie', '2015-05-23'),
--('Jenny', '2015-11-19'),
--('Michelle', '2015-12-12'),
--('Aaron', '2015-12-18');
--GO
--CREATE TABLE TestMax
--(
--    Year1 INT
--    ,Max1 INT
--    ,Max2 INT
--    ,Max3 INT
--)
--INSERT INTO TestMax 
--VALUES
--    (2001,10,101,87)
--    ,(2002,103,19,88)
--    ,(2003,21,23,89)
--    ,(2004,27,28,91)
--CREATE TABLE cinema (
--    id INT PRIMARY KEY,
--    movie VARCHAR(50),
--    description VARCHAR(255),
--    rating DECIMAL(3, 1)
--);
--INSERT INTO cinema (id, movie, description, rating) VALUES
--(1, 'War', 'great 3D', 8.9),
--(2, 'Science', 'fiction', 8.5),
--(3, 'Irish', 'boring', 6.2),
--(4, 'Ice song', 'Fantacy', 8.6),
--(5, 'House card', 'Interesting', 9.1);

--CREATE TABLE SingleOrder
--(
--	 Id INT
--	,Vals VARCHAR(10)
--)
--GO
--INSERT INTO SingleOrder VALUES
--(0,'All'),
--(1,'Pawan'),
--(2,'Avtaar'),
--(3,'Kishan'),
--(4,'Vaibhav'),
--(5,'Ashutosh')
--GO

--SELECT * FROM SingleOrder
--GO
--CREATE TABLE person (
--    id INT,
--    ssn VARCHAR(13),
--    passportid VARCHAR(10),
--    itin VARCHAR(10)
--);

--INSERT INTO person VALUES 
--(1, '111-11-1111', 'aa155', '123itin'),
--(2, NULL, 'aa156', '124itin'),
--(3, NULL, NULL, '125itin'),
--(4, NULL, NULL, NULL),
--(5, '222-22-2222', NULL, '126itin'),
--(6, '333-33-3333', 'aa157', NULL);


--CREATE TABLE PlayerScores
--(
--PlayerA  INTEGER,
--PlayerB  INTEGER,
--Score    INTEGER NOT NULL,
--PRIMARY KEY (PlayerA, PlayerB)
--);
--GO

--INSERT INTO PlayerScores (PlayerA, PlayerB, Score) VALUES
--(1001,2002,150),(3003,4004,15),(4004,3003,125);
--GO

--CREATE TABLE Personal
--(
--SpacemanID      INTEGER PRIMARY KEY,
--JobDescription  VARCHAR(100) NOT NULL,
--MissionCount    INTEGER NOT NULL
--);
--GO
--INSERT INTO Personal (SpacemanID, JobDescription, MissionCount) VALUES
--(1001,'Astrogator',6),(2002,'Astrogator',12),(3003,'Astrogator',17),
--(4004,'Geologist',21),(5005,'Geologist',9),(6006,'Geologist',8),
--(7007,'Technician',13),(8008,'Technician',2),(9009,'Technician',7);
--GO

--Easy Tasks
--1
select * from employees where manager_id = 101;

SELECT DEPARTMENT_ID, AVG(SALARY) AS AVG_SALARY
FROM Employees
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) > 10000;

SELECT FIRST_NAME, LAST_NAME, SALARY
FROM Employees
ORDER BY SALARY DESC
LIMIT 5;

SELECT FIRST_NAME, LAST_NAME, COMMISSION_PCT
FROM Employees
WHERE COMMISSION_PCT > 0;

SELECT e1.FIRST_NAME AS EMPLOYEE, e2.FIRST_NAME AS MANAGER
FROM Employees e1
LEFT JOIN Employees e2 ON e1.MANAGER_ID = e2.EMPLOYEE_ID;

--2
SELECT 
  EMPLOYEE_ID,
  FIRST_NAME,
  LAST_NAME,
  PHONE_NUMBER,
  REPLACE(PHONE_NUMBER, '124', '999') AS UPDATED_PHONE
FROM 
  EMPLOYEES;
  select * from employees;
--3
select 
      first_name as "First Name",
	  Len(First_Name) as "Name Length"
from 
      Employees
where 
      Substring(First_Name,1,1) in ('A', 'J', 'M')
Order by
      First_Name;
--4
select 
   Manager_ID,
   SUM(salary) as Total_Salary
from
   employees
Group by
   Manager_ID
Order BY
   Manager_ID;
--5
WITH RankedMissions AS (
    SELECT 
        SpacemanID,
        JobDescription,
        MissionCount,
        ROW_NUMBER() OVER (PARTITION BY JobDescription ORDER BY MissionCount DESC) AS MostExpRank,
        ROW_NUMBER() OVER (PARTITION BY JobDescription ORDER BY MissionCount ASC) AS LeastExpRank
    FROM Personal
)
SELECT 
    JobDescription,
    MAX(CASE WHEN MostExpRank = 1 THEN SpacemanID END) AS MostExperiencedSpacemanID,
    MAX(CASE WHEN LeastExpRank = 1 THEN SpacemanID END) AS LeastExperiencedSpacemanID
FROM RankedMissions
GROUP BY JobDescription;

--6
select *
from cinema
where id % 2 = 1
And description <> 'boring';

--7
SELECT *
FROM SingleOrder
ORDER BY IIF(Id = 0, 9, Id);

--8
select * from person;

select 
 id,
 coalesce(ssn, passportid, itin) as First_non_null_id
from
 person;

--Medium Tasks
--1
SELECT
    StudentID,
    FullName,
    LEFT(FullName, CHARINDEX(' ', FullName) - 1) AS FirstName,

    SUBSTRING(
        FullName,
        CHARINDEX(' ', FullName) + 1,
        CHARINDEX(' ', FullName, CHARINDEX(' ', FullName) + 1) - CHARINDEX(' ', FullName) - 1
    ) AS MiddleName,

    RIGHT(FullName, LEN(FullName) - CHARINDEX(' ', FullName, CHARINDEX(' ', FullName) + 1)) AS LastName,

    Grade
FROM Students;

--2

SELECT
    StudentID,
    FullName,
    SUM(Grade) OVER (ORDER BY StudentID) AS CumulativeGrade
FROM Students;

--3
SELECT STRING_AGG(String, ' ') WITHIN GROUP (ORDER BY SequenceNumber) AS FullQuery
FROM DMLTable;

--4
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
FROM Employees
WHERE LEN(LOWER(FIRST_NAME + LAST_NAME)) 
     - LEN(REPLACE(LOWER(FIRST_NAME + LAST_NAME), 'a', '')) >= 3;
       
--5
SELECT 
    DEPARTMENT_ID,
    COUNT(*) AS TotalEmployees,
    COUNT(CASE 
              WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 
              THEN 1 
         END) AS EmployeesOver3Years,
    CAST(
        100.0 * COUNT(CASE 
                          WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 
                          THEN 1 
                     END) / COUNT(*) 
        AS DECIMAL(5,2)
    ) AS PercentageOver3Years
FROM 
    Employees
GROUP BY 
    DEPARTMENT_ID
ORDER BY 
    DEPARTMENT_ID;

--6
WITH RankedSpacemen AS (
    SELECT
        SpacemanID,
        JobDescription,
        MissionCount,
        RANK() OVER (PARTITION BY JobDescription ORDER BY MissionCount ASC) AS LeastRank,
        RANK() OVER (PARTITION BY JobDescription ORDER BY MissionCount DESC) AS MostRank
    FROM 
        Personal
)
SELECT 
    JobDescription,
    SpacemanID,
    MissionCount,
    CASE 
        WHEN LeastRank = 1 AND MostRank = 1 THEN 'Most & Least Experienced'
        WHEN LeastRank = 1 THEN 'Least Experienced'
        WHEN MostRank = 1 THEN 'Most Experienced'
    END AS ExperienceType
FROM 
    RankedSpacemen
WHERE 
    LeastRank = 1 OR MostRank = 1
ORDER BY 
    JobDescription, ExperienceType;

--Difficult tasks
--1
WITH Tally AS (
    SELECT TOP (LEN('tf56sd#%OqH')) 
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS N
    FROM sys.all_objects -- Any sufficiently large system table will work
),
SplitChars AS (
    SELECT 
        SUBSTRING('tf56sd#%OqH', N, 1) AS Char
    FROM Tally
),
ClassifiedChars AS (
    SELECT 
        Char,
        CASE 
            WHEN Char LIKE '[A-Z]' THEN 'Uppercase'
            WHEN Char LIKE '[a-z]' THEN 'Lowercase'
            WHEN Char LIKE '[0-9]' THEN 'Number'
            ELSE 'Other'
        END AS CharType
    FROM SplitChars
)
SELECT
    STRING_AGG(CASE WHEN CharType = 'Uppercase' THEN Char END, '') AS UppercaseLetters,
    STRING_AGG(CASE WHEN CharType = 'Lowercase' THEN Char END, '') AS LowercaseLetters,
    STRING_AGG(CASE WHEN CharType = 'Number' THEN Char END, '') AS Numbers,
    STRING_AGG(CASE WHEN CharType = 'Other' THEN Char END, '') AS OtherCharacters
FROM ClassifiedChars;

--2
SELECT 
    StudentID,
    FullName,
    SUM(Grade) OVER (ORDER BY StudentID) AS CumulativeGrade
FROM Students;

--3
WITH Parsed AS (
    SELECT 
        Equation,
        CAST('<x>' + 
            REPLACE(REPLACE(REPLACE(Equation, '+', '</x><x>+'), '-', '</x><x>-'), ' ', '') + 
        '</x>' AS XML) AS ExprXML
    FROM Equations
),
Split AS (
    SELECT 
        p.Equation,
        ROW_NUMBER() OVER (PARTITION BY p.Equation ORDER BY (SELECT NULL)) AS PartOrder,
        x.value('.', 'varchar(10)') AS Token
    FROM Parsed p
    CROSS APPLY p.ExprXML.nodes('/x') AS T(x)
),
Evaluated AS (
    SELECT 
        Equation,
        SUM(CAST(
            CASE 
                WHEN Token LIKE '+%' THEN SUBSTRING(Token, 2, LEN(Token))
                WHEN Token LIKE '-%' THEN Token
                ELSE Token
            END 
        AS INT)) AS TotalSum
    FROM (
        SELECT 
            Equation,
            -- Attach + sign to all numbers that don't start with + or -
            CASE 
                WHEN Token LIKE '[0-9]%' THEN '+' + Token
                ELSE Token
            END AS Token
        FROM Split
    ) AS Adjusted
    GROUP BY Equation
)
-- Final output
SELECT 
    e.Equation,
    ev.TotalSum
FROM Equations e
JOIN Evaluated ev ON e.Equation = ev.Equation
ORDER BY e.Equation;

--4
SELECT 
    s.StudentName,
    s.Birthday
FROM 
    Student s
JOIN (
    SELECT 
        Birthday
    FROM 
        Student
    GROUP BY 
        Birthday
    HAVING 
        COUNT(*) > 1
) dup ON s.Birthday = dup.Birthday
ORDER BY 
    s.Birthday, s.StudentName;

--5
SELECT 
    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END AS Player1,
    CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END AS Player2,
    SUM(Score) AS TotalScore
FROM 
    PlayerScores
GROUP BY 
    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END,
    CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END
ORDER BY 
    Player1, Player2;
