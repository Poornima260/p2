
---Table creation
CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);

SELECT *
FROM retail_sales

--explore--

SELECT COUNT(*) FROM retail_sales;

--count of unique customers

SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

---Category Count: Identify all unique product categories in the dataset.
SELECT DISTINCT category FROM retail_sales;

----Null Value Check: Check for any null values in the dataset and delete records with missing data.
SELECT *
FROM retail_sales

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
	
---delete null records

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;


---3. Data Analysis & Findings
--Q1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:

SELECT *
from retail_sales
where sale_date='2022-11-05'

--Q2.
SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantity >= 4
--Q3.
SELECT category, 
       SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY category;

--Q4.
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'

SELECT category, 
       gender, 
       COUNT(transactions_id) AS total_transactions
FROM retail_sales
GROUP BY category, gender
ORDER BY category, gender;

WITH monthly_avg_sales AS (
  SELECT 
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    ROUND(AVG(total_sale)) AS avg_sale,
    RANK() OVER (
      PARTITION BY EXTRACT(YEAR FROM sale_date)
      ORDER BY AVG(total_sale) DESC
    ) AS sale_rank
  FROM retail_sales
  GROUP BY year, month
)

SELECT year, month, avg_sale
FROM monthly_avg_sales
WHERE sale_rank = 1;

WITH monthly_avg_sales AS (
  SELECT 
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    ROUND(AVG(total_sale)) AS avg_sale,
    RANK() OVER (
      PARTITION BY EXTRACT(YEAR FROM sale_date)
      ORDER BY AVG(total_sale) DESC
    ) AS sale_rank
  FROM retail_sales
  GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date)
)

SELECT year, month, avg_sale
FROM monthly_avg_sales
WHERE sale_rank = 1;

SELECT category, 
       COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;



