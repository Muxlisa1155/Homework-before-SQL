--Homework22
--Aggregated Window functions
--Task1
select * from Sales_data;

select 
     sale_id,
	 customer_id,
	 customer_name,
	 order_date,
	 total_amount,
	 Sum(total_amount) over (
	     partition by customer_id
		 order by order_date
		 rows unbounded preceding
	 ) as running_total_sales
from Sales_data
order by customer_id, order_date;

--Task2
select * from sales_data;

select 
    product_category,
	Count(*) as total_orders
from sales_data
group by product_category;

--Or we can use window function to solve this puzzle

select 
    distinct product_category,
	count(*) over (partition by product_category) as total_orders
from sales_data;

--Task3
select * from sales_data;

select 
    product_category,
	Max(total_amount) as MaxAmount
from sales_data
Group By product_category

--Or

select 
     Distinct product_category,
	 Max(total_amount) over (partition by product_category) as MaxAmount
from sales_data;

--Task4
--Find the Minimum Price of Products per Product Category
select * from sales_data;

select 
     product_category,
	 Min(unit_price) as MinPrice
from sales_data
group by product_category;

--Or
 
select distinct
      product_category,
	  Min(unit_price) over (Partition by product_category) as MinPrice
from sales_data;

--Task5
select
    order_date,
	avg(total_amount) over (
	    order by order_date
		rows between 1 preceding and 1 following
	) as MovingAvgSales
from sales_data
order by order_date;

--Task6
--Find the Total Sales per Region
select * from sales_data;

select
     region,
	 Sum(total_amount) as TotalSales
from sales_data
group by region;


--Or we can use Window function here

select * from sales_data;
select distinct
     region,
	 Sum(total_amount) over (
	 order by region
	 ) as TotalSales
from sales_data
order by region;

--Task7
select 
    customer_id,
	customer_name,
	Sum(total_amount) as total_purchase,
	Rank() Over (Order By Sum(total_amount) Desc) as customer_rank
from sales_data
group by customer_id, customer_name
order by customer_rank;

--Task8
--Calculate the Difference Between Current and Previous Sale Amount per Customer
select * from sales_data;

select 
    customer_id,
	customer_name,
	order_date,
	total_amount,
	total_amount
      - Lag(total_amount) over (Partition By customer_id order by order_date)
	  as diff_from_prev_sale
from sales_data
order by customer_id, order_date;

--Task9
select * from sales_data;
SELECT *
FROM (
    SELECT 
        product_category,
        product_name,
        unit_price,
        ROW_NUMBER() OVER (
            PARTITION BY product_category 
            ORDER BY unit_price DESC
        ) AS price_rank
    FROM sales_data
) ranked
WHERE price_rank <= 3
ORDER BY product_category, price_rank;

--Task10
select
     region,
	 order_date,
	 total_amount,
	 Sum(total_amount) over (
	    partition by region
		order by order_date
	 ) as cumulative_sales
from sales_data
order by region, order_date;

--Task11
select 
    product_category,
	order_date,
	total_amount,
	Sum(total_amount) over (
	    partition by product_category
		order by order_date
	) as cumulative_revenue
from sales_data
order by product_category, order_date;

--Task12
CREATE TABLE Numbers (ID INT);
INSERT INTO Numbers VALUES (1), (2), (3), (4), (5);

SELECT 
    ID,
    SUM(ID) OVER (ORDER BY ID) AS SumPreValues
FROM Numbers;

SELECT 
    ID,
    SUM(ID) OVER (ORDER BY ID) AS SumPreValues
FROM Numbers;

--Task13
select * from OneColumn;

select 
   value,
   Sum(Value) over (order by value) as [Sum of Previous]
from OneColumn;

--Task14
--1st solution

select customer_id, customer_name
from sales_data
group by customer_id, customer_name
Having count(distinct product_category) > 1;

--2nd solution
WITH unique_categories AS (
    SELECT DISTINCT customer_id, customer_name, product_category
    FROM sales_data
)
SELECT DISTINCT
    customer_id,
    customer_name
FROM (
    SELECT 
        customer_id,
        customer_name,
        COUNT(product_category) OVER (PARTITION BY customer_id) AS category_count
    FROM unique_categories
) AS t
WHERE category_count > 1;

--Task15
--Find Customers with Above-Average Spending in Their Region

WITH regional_avg AS (
    SELECT
        customer_id,
        customer_name,
        region,
        SUM(total_amount) AS total_spent,
        AVG(SUM(total_amount)) OVER (PARTITION BY region) AS avg_spent_in_region
    FROM sales_data
    GROUP BY customer_id, customer_name, region
)
SELECT
    customer_id,
    customer_name,
    region,
    total_spent,
    avg_spent_in_region
FROM regional_avg
WHERE total_spent > avg_spent_in_region
ORDER BY region, total_spent DESC;

--Task16
select 
     customer_id,
	 customer_name,
	 region,
	 Sum(total_amount) as total_spent,
	 Rank() over (partition by region order by sum(total_amount) desc) as Spending_Rank
from sales_data
group by customer_id, customer_name, region
order by region, spending_rank;

--Task17
select 
     customer_id,
	 customer_name,
	 order_date,
	 total_amount,
	 Sum(total_amount) over (
	    partition by customer_id
		order by order_date
	 ) as cumulative_sales
from sales_data
order by customer_id, order_date;

--Task18
SELECT 
    FORMAT(order_date, 'yyyy-MM') AS month,
    SUM(total_amount) AS total_sales,
    (SUM(total_amount) - LAG(SUM(total_amount)) OVER (ORDER BY FORMAT(order_date, 'yyyy-MM')))
        * 100.0 / LAG(SUM(total_amount)) OVER (ORDER BY FORMAT(order_date, 'yyyy-MM')) AS growth_rate
FROM sales_data
GROUP BY FORMAT(order_date, 'yyyy-MM')
ORDER BY month;

--Task19
SELECT *
FROM (
    SELECT 
        customer_id,
        customer_name,
        order_date,
        total_amount,
        LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS prev_amount
    FROM sales_data
) t
WHERE total_amount > prev_amount;

--Task20
--Identify Products that prices are above the average product price
select * from sales_data;

WITH avg_cte AS (
    SELECT 
        product_name,
        unit_price,
        AVG(unit_price) OVER () AS avg_price
    FROM sales_data
)
SELECT 
    product_name,
    unit_price,
    avg_price
FROM avg_cte
WHERE unit_price > avg_price;

--Or

SELECT 
    product_name,
    unit_price
FROM sales_data
WHERE unit_price > (SELECT AVG(unit_price) FROM sales_data);


--Task21
SELECT 
    Id,
    Grp,
    Val1,
    Val2,
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) = 1 
        THEN SUM(Val1 + Val2) OVER (PARTITION BY Grp)
    END AS SumPerGroup
FROM MyData;

--Task22
WITH cte AS (
    SELECT 
        ID,
        Cost,
        Quantity,
        ROW_NUMBER() OVER (PARTITION BY ID, Quantity ORDER BY ID) AS rn
    FROM TheSumPuzzle
)
SELECT 
    ID,
    SUM(Cost) AS TotalCost,
    SUM(CASE WHEN rn = 1 THEN Quantity ELSE 0 END) AS TotalQuantity
FROM cte
GROUP BY ID;

--Task23
--From following set of integers, write an SQL statement to determine the expected outputs


    SELECT 
        SeatNumber,
        LAG(SeatNumber) OVER (ORDER BY SeatNumber) AS PrevSeat,
        LEAD(SeatNumber) OVER (ORDER BY SeatNumber) AS NextSeat
    FROM Seats
)
SELECT 
    PrevSeat + 1 AS [Gap Start],
    SeatNumber - 1 AS [Gap End]
FROM SeatCTE
WHERE SeatNumber - PrevSeat > 1;
