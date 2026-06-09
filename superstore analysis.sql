-- ============================================
-- Superstore Sales Analysis
-- Author: Prajakta Gawade
-- Tool: MySQL
-- Dataset: Superstore (9994 rows, 2014-2017)
-- ============================================


create database superstore_analysis;
use superstore_analysis;
show tables;

RENAME TABLE `sample - superstore` TO `superstore`;
select * from superstore limit 10;

-- DATA QUALITY CHECKS
-- ============================================

-- Check total row count
SELECT COUNT(*) AS total_rows 
FROM superstore;

-- Check for duplicates
SELECT `Row ID`, COUNT(*) AS cnt
FROM superstore 
GROUP BY `Row ID`
HAVING cnt > 1;

-- Check for NULL values
SELECT 
  SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS null_sales,
  SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS null_profit,
  SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS null_quantity,
  SUM(CASE WHEN `Order ID` IS NULL THEN 1 ELSE 0 END) AS null_orderid,
  SUM(CASE WHEN `Customer ID` IS NULL THEN 1 ELSE 0 END) AS null_customerid
FROM superstore;

-- Result: No duplicates, no NULLs. No cleaning required.

SELECT `Order Date`, `Ship Date` 
FROM superstore 
LIMIT 5;


-- Query 1: Revenue by Category
SELECT 
  Category,
  ROUND(SUM(Sales), 2) AS total_revenue,
  ROUND(SUM(Profit), 2) AS total_profit,
  ROUND(SUM(Profit)/SUM(Sales) * 100, 2) AS profit_margin_pct
FROM superstore
GROUP BY Category
ORDER BY total_revenue DESC;


-- Query 2: Monthly Sales Trend Over the Years
SELECT 
  YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS order_year,
  MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS order_month,
  ROUND(SUM(Sales), 2) AS monthly_sales,
  ROUND(SUM(Profit), 2) AS monthly_profit
FROM superstore
GROUP BY order_year, order_month
ORDER BY order_year, order_month;

-- Query 3: Top 10 Most Profitable Products
SELECT 
  `Product Name`,
  Category,
  `Sub-Category`,
  ROUND(SUM(Sales), 2) AS total_sales,
  ROUND(SUM(Profit), 2) AS total_profit,
  ROUND(SUM(Profit)/SUM(Sales) * 100, 2) AS profit_margin_pct
FROM superstore
GROUP BY `Product Name`, Category, `Sub-Category`
ORDER BY total_profit DESC
LIMIT 10;

-- Query 4: Regional Discount Impact Analysis
SELECT 
  Region,
  ROUND(AVG(Discount) * 100, 2) AS avg_discount_pct,
  ROUND(SUM(Sales), 2) AS total_sales,
  ROUND(SUM(Profit), 2) AS total_profit,
  COUNT(DISTINCT `Order ID`) AS total_orders
FROM superstore
GROUP BY Region
ORDER BY avg_discount_pct DESC;


-- Query 5: Best and Worst Performing Sub-Categories
SELECT 
  `Sub-Category`,
  Category,
  ROUND(SUM(Sales), 2) AS total_sales,
  ROUND(SUM(Profit), 2) AS total_profit,
  ROUND(SUM(Profit)/SUM(Sales) * 100, 2) AS profit_margin_pct,
  COUNT(DISTINCT `Order ID`) AS total_orders
FROM superstore
GROUP BY `Sub-Category`, Category
ORDER BY total_profit DESC;

-- Query 6: Customer Segmentation by Revenue
SELECT 
  `Customer Name`,
  Segment,
  ROUND(SUM(Sales), 2) AS total_spent,
  ROUND(SUM(Profit), 2) AS total_profit,
  COUNT(DISTINCT `Order ID`) AS total_orders,
  CASE 
    WHEN SUM(Sales) >= 10000 THEN 'High Value'
    WHEN SUM(Sales) >= 5000 THEN 'Medium Value'
    ELSE 'Low Value'
  END AS customer_tier
FROM superstore
GROUP BY `Customer Name`, Segment
ORDER BY total_spent DESC
LIMIT 20;

-- Query 7: Shipping Mode vs Average Delivery Days

SELECT 
  `Ship Mode`,
  COUNT(DISTINCT `Order ID`) AS total_orders,
  ROUND(AVG(DATEDIFF(
    STR_TO_DATE(`Ship Date`, '%m/%d/%Y'),
    STR_TO_DATE(`Order Date`, '%m/%d/%Y')
  )), 1) AS avg_delivery_days,
  ROUND(SUM(Sales), 2) AS total_sales,
  ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY `Ship Mode`
ORDER BY avg_delivery_days ASC;


-- Query 8: Top 10 Customers by Revenue using RANK()

SELECT *
FROM (
  SELECT 
    `Customer Name`,
    Segment,
    Region,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    COUNT(DISTINCT `Order ID`) AS total_orders,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS sales_rank
  FROM superstore
  GROUP BY `Customer Name`, Segment, Region
) ranked_customers
WHERE sales_rank <= 10;


-- Query 9: Month over Month Sales Growth using CTE + LAG()

WITH monthly_sales AS (
  SELECT 
    YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS yr,
    MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS mn,
    ROUND(SUM(Sales), 2) AS total_sales
  FROM superstore
  GROUP BY yr, mn
)
SELECT 
  yr,
  mn,
  total_sales,
  LAG(total_sales) OVER (ORDER BY yr, mn) AS prev_month_sales,
  ROUND((total_sales - LAG(total_sales) OVER (ORDER BY yr, mn)) 
    / LAG(total_sales) OVER (ORDER BY yr, mn) * 100, 2) AS growth_pct
FROM monthly_sales
ORDER BY yr, mn;

-- Query 10: Profit Margin by Category and Region

SELECT 
  Region,
  Category,
  ROUND(SUM(Sales), 2) AS total_sales,
  ROUND(SUM(Profit), 2) AS total_profit,
  ROUND(SUM(Profit)/SUM(Sales) * 100, 2) AS profit_margin_pct,
  CASE
    WHEN SUM(Profit)/SUM(Sales) * 100 >= 15 THEN 'High Margin'
    WHEN SUM(Profit)/SUM(Sales) * 100 >= 5 THEN 'Medium Margin'
    ELSE 'Low Margin'
  END AS margin_category
FROM superstore
GROUP BY Region, Category
ORDER BY Region, profit_margin_pct DESC;