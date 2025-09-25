--Homework18
--Task1
select * from sales;
select * from products;

--step1
CREATE TABLE #MonthlySales (
    ProductID INT,
    TotalQuantity INT,
    TotalRevenue DECIMAL(10,2)
);
--step2
INSERT INTO #MonthlySales (ProductID, TotalQuantity, TotalRevenue)
SELECT 
    s.ProductID,
    SUM(s.Quantity) AS TotalQuantity,
    SUM(s.Quantity * p.Price) AS TotalRevenue
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE YEAR(s.SaleDate) = YEAR(GETDATE())   -- current year
  AND MONTH(s.SaleDate) = MONTH(GETDATE()) -- current month
GROUP BY s.ProductID;
--step3

--Task2
create view vw_ProductsSalesSumary
As
select 
      p.productID,
      ISNULL(SUM(s.Quantity), 0) As TotalQuantity,
	  ISNULL(SUM(s.Quantity * p.Price), 0) As TotalRevenue
from Products p
Left Join Sales s
      on p.ProductID = s.ProductID
Group By
      p.ProductID;

Select * from vw_ProductsSalesSumary;

--Task3

CREATE FUNCTION fn_GetTotalRevenueForProduct (@ProductID INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
    -- Calculate total revenue for the product
    RETURN (
        SELECT ISNULL(SUM(s.Quantity * p.Price), 0)
        FROM Sales s
        JOIN Products p ON s.ProductID = p.ProductID
        WHERE s.ProductID = @ProductID
    );
END;

SELECT dbo.fn_GetTotalRevenueForProduct(1) AS RevenueForProduct1;

--Task4
CREATE FUNCTION fn_GetSalesByCategory (@Category VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        p.ProductName,
        ISNULL(SUM(s.Quantity), 0) AS TotalQuantity,
        ISNULL(SUM(s.Quantity * p.Price), 0) AS TotalRevenue
    FROM Products p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.Category = @Category
    GROUP BY p.ProductName
);

SELECT * FROM fn_GetSalesByCategory('Electronics');

--Task5

CREATE FUNCTION dbo.fn_IsPrime (@Number INT)
RETURNS VARCHAR(3)
AS
BEGIN
    DECLARE @i INT = 2;
    DECLARE @IsPrime VARCHAR(3) = 'Yes';

    -- Handle numbers less than 2
    IF @Number < 2
        RETURN 'No';

    -- Check divisibility from 2 to sqrt(@Number)
    WHILE @i * @i <= @Number
    BEGIN
        IF @Number % @i = 0
        BEGIN
            SET @IsPrime = 'No';
            BREAK;
        END
        SET @i = @i + 1;
    END

    RETURN @IsPrime;
END;

SELECT dbo.fn_IsPrime(7) AS Result;   -- Yes
SELECT dbo.fn_IsPrime(10) AS Result;  -- No
SELECT dbo.fn_IsPrime(1) AS Result;   -- No

--Task6

CREATE FUNCTION fn_GetNumbersBetween (@Start INT, @End INT)
RETURNS TABLE
AS
RETURN
(
    WITH NumbersCTE AS
    (
        SELECT @Start AS Number
        UNION ALL
        SELECT Number + 1
        FROM NumbersCTE
        WHERE Number + 1 <= @End
    )
    SELECT Number
    FROM NumbersCTE
);

SELECT * FROM fn_GetNumbersBetween(5, 10);

--Task7
DECLARE @N INT = 2;  -- Nth highest salary

SELECT MAX(salary) AS NthHighestSalary
FROM (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM Employee
) AS RankedSalaries
WHERE rnk = @N;


--Task8
-- Step 1: Create the table
CREATE TABLE RequestAccepted (
    requester_id INT,
    accepter_id INT,
    accept_date DATE
);

-- Step 2: Insert the sample data
INSERT INTO RequestAccepted VALUES
(1, 2, '2016-06-03'),
(1, 3, '2016-06-08'),
(2, 3, '2016-06-08'),
(3, 4, '2016-06-09');

-- Step 3: Query the user with the most friends
SELECT TOP 1
    user_id,
    COUNT(*) AS total_friends
FROM
(
    -- Count each friendship for both users
    SELECT requester_id AS user_id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS user_id FROM RequestAccepted
) AS AllFriends
GROUP BY user_id
ORDER BY total_friends DESC;

SELECT TOP 1
    user_id,
    COUNT(*) AS total_friends
FROM
(
    -- Count each friendship for both users
    SELECT requester_id AS user_id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS user_id FROM RequestAccepted
) AS AllFriends
GROUP BY user_id
ORDER BY total_friends DESC;

--Task9
-- Customers
select * from orders
select * from customers;

CREATE VIEW vw_CustomerOrderSummary
AS
SELECT
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders,
    ISNULL(SUM(o.amount), 0) AS total_amount,
    MAX(o.order_date) AS last_order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

SELECT * FROM vw_CustomerOrderSummary;

--Task10

SELECT 
    RowNumber,
    MAX(TestCase) OVER (ORDER BY RowNumber ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS TestCase
FROM Gaps
ORDER BY RowNumber;
