--Homework14
--Easy Tasks
--Task1
SELECT 
    Id,
    LTRIM(PARSENAME(REPLACE(Name, ',', '.'), 2)) AS FirstName,
    LTRIM(PARSENAME(REPLACE(Name, ',', '.'), 1)) AS Surname
FROM TestMultipleColumns;

--Task2
select strs
from TestPercent
where strs like '%[%]%';

--Task3
--in this puzzle the easiest trick is to use Parsename, because it is designed to split strings by dots
select 
     id,
	 Parsename(Vals,1) as Part1,
	 Parsename(Vals,2) as Part2
From Splitter;

--Task4
--The trick with Translate
Declare @str Varchar(100) = '1234ABC123456XYZ1234567890ADS';
Select Translate(@str, '0123456789', 'XXXXXXXXXX') AS MaskedString;

--Task5
select *
from testdots
where Len(Vals) -Len(Replace(Vals, '.', '')) > 2;

--Task6
select * from CountSpaces;

SELECT 
    texts,
    LEN(texts) - LEN(REPLACE(texts, ' ', '')) AS SpaceCount
FROM CountSpaces;

--Task7
--Self Join
select * from employee;

select 
    e.name AS Employee,
	e.salary AS EmployeeSalary,
	m.name AS Manager,
	m.salary AS ManagerSalary
From Employee e
Join Employee m
    on e.ManagerID = m.ID
where e.salary > m.salary;

--Task8
--DatedIFF(Year, Hire_Date, GetDate()) - calculates how many full years each employee has been in this company

select 
     employee_id,
	 first_name,
	 last_name,
	 hire_date,
	 DatedIFF(Year, Hire_Date, GetDate()) AS Years_of_Service
From Employees
where DatedIFF(Year, Hire_Date, GetDate()) > 10
  And DatedIFF(Year, Hire_Date, GetDate()) < 15;

 --Medium Tasks
 --Task1
 DECLARE @str VARCHAR(100) = 'rtcfvty34redt';

SELECT 
    REPLACE(TRANSLATE(@str, '0123456789', '##########'), '#', '') AS OnlyCharacters,
    REPLACE(TRANSLATE(@str, 'abcdefghijklmnopqrstuvwxyz', REPLICATE('#',26)), '#', '') AS OnlyNumbers;

--Task2
--Self Join
select
     w1.id,
	 w1.RecordDate,
	 w1.Temperature
from weather w1
Join weather w2
   on w1.RecordDate = DateAdd(Day, 1, w2.RecordDate)
where w1.Temperature > w2.Temperature;

--Task3
select * from Activity;

select 
     player_id,
	 Min(event_date) as FirstLogin
from Activity
Group by player_id;

--Task4

SELECT PARSENAME(REPLACE(fruit_list, ',', '.'), 2) AS third_item
FROM fruits;

--Task5
SELECT SUBSTRING('sdgfhsdgfhs@121313131', number, 1) AS character
FROM master.dbo.spt_values
WHERE type = 'P'
  AND number BETWEEN 1 AND LEN('sdgfhsdgfhs@121313131');

--Task6
select * from p1;
select * from p2;

select 
    p1.id,
	case 
	   when p1.code = 0 then p2.code
	   else p1.code
	End As final_code
from p1
join p2
on p1.id = p2.id;

--Task7

select 
    employee_id,
	first_name,
	last_name,
	Hire_date,
	Datediff(Year, Hire_Date, GetDate()) As Years_ofService,
	Case
	    When DatedIff(Year, Hire_Date, GetDate()) < 1 Then 'New Hire'
		When DatedIff(Year, Hire_Date, GetDate()) between 1 and 5 Then 'Junior'
		When DatedIff(Year, Hire_Date, GetDate()) between 6 and 10 Then 'Mid-Level'
		When DatedIff(Year, Hire_Date, GetDate()) between 11 and 20 Then 'Senior'
        Else 'Veteran'
    End As Employment_Stage
From Employees;

--Task8
SELECT 
    Id,
    VALS,
    CAST(LEFT(VALS, PATINDEX('%[^0-9]%', VALS + 'a') - 1) AS INT) AS Extracted_Integer
FROM GetIntegers;


--Difficult Tasks
--Task1
 SELECT 
    Id,
    Vals,
    STUFF(
        Vals,
        1,
        CHARINDEX(',', Vals),
        SUBSTRING(Vals, CHARINDEX(',', Vals) + 1, CHARINDEX(',', Vals) - 1) + ','
    ) AS SwappedVals
FROM MultipleVals;

--Task2
SELECT a.player_id, a.device_id
FROM Activity a
JOIN (
    SELECT player_id, MIN(event_date) AS first_login
    FROM Activity
    GROUP BY player_id
) b
ON a.player_id = b.player_id
AND a.event_date = b.first_login;

--Task3 
 WITH SalesCTE AS (
    SELECT 
        Area,
        [Date],
        ISNULL(SalesLocal, 0) + ISNULL(SalesRemote, 0) AS TotalSales,
        FinancialWeek,
        FinancialYear,
        [DayName],
        [DayOfWeek],
        [MonthName]
    FROM WeekPercentagePuzzle
)
, WeeklyTotals AS (
    SELECT 
        FinancialYear,
        FinancialWeek,
        SUM(TotalSales) AS WeekTotal
    FROM SalesCTE
    GROUP BY FinancialYear, FinancialWeek
)
SELECT 
    s.Area,
    s.[Date],
    s.TotalSales,
    w.WeekTotal,
    s.FinancialWeek,
    s.FinancialYear,
    s.[DayName],
    s.[DayOfWeek],
    s.[MonthName],
    CAST(100.0 * s.TotalSales / w.WeekTotal AS DECIMAL(10,2)) AS PercentageOfWeek
FROM SalesCTE s
JOIN WeeklyTotals w
    ON s.FinancialYear = w.FinancialYear
   AND s.FinancialWeek = w.FinancialWeek
ORDER BY s.FinancialYear, s.FinancialWeek, s.[Date], s.Area;
