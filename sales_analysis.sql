-- =========================================================
-- SALES DATA ANALYSIS - SQL PROJECT
-- Tool: MySQL
-- =========================================================


-- =========================================================
-- 1. DATABASE SETUP
-- =========================================================

CREATE DATABASE IF NOT EXISTS sales_analysis;

USE sales_analysis;

-- =========================================================
-- 2. DATA VERIFICATION
-- =========================================================

-- Check sample records
SELECT *
FROM sales_data
LIMIT 10;


-- Check total number of records
SELECT COUNT(*) AS Total_Records
FROM sales_data;


-- Check customer table
SELECT *
FROM customers_data
LIMIT 10;


-- Check total number of customers
SELECT COUNT(*) AS Total_Customers
FROM customers_data;

-- =========================================================
-- 3. SALES PERFORMANCE ANALYSIS
-- =========================================================

-- Total Orders
SELECT COUNT(Order_ID) AS Total_Orders
FROM sales_data;


-- Total Sales
SELECT SUM(Sales_INR) AS Total_Sales
FROM sales_data;


-- Total Quantity Sold
SELECT SUM(Quantity) AS Total_Quantity
FROM sales_data;


-- Average Sales per Order
SELECT AVG(Sales_INR) AS Average_Order_Value
FROM sales_data;


-- Highest Sales Order
SELECT MAX(Sales_INR) AS Highest_Order_Sales
FROM sales_data;


-- Lowest Sales Order
SELECT MIN(Sales_INR) AS Lowest_Order_Sales
FROM sales_data;

-- =========================================================
-- 4. PROFITABILITY ANALYSIS
-- =========================================================

-- Total Cost
SELECT SUM(Cost_INR) AS Total_Cost
FROM sales_data;


-- Total Profit
SELECT SUM(Profit_INR) AS Total_Profit
FROM sales_data;


-- Overall Profit Margin
SELECT
    SUM(Profit_INR) / SUM(Sales_INR) AS Profit_Margin
FROM sales_data;


-- Highest Profit from a Single Order
SELECT MAX(Profit_INR) AS Highest_Order_Profit
FROM sales_data;


-- Lowest Profit from a Single Order
SELECT MIN(Profit_INR) AS Lowest_Order_Profit
FROM sales_data;

-- =========================================================
-- 5. STATE-WISE ANALYSIS
-- =========================================================

-- State-wise Total Sales
SELECT
    State,
    SUM(Sales_INR) AS Total_Sales
FROM sales_data
GROUP BY State
ORDER BY Total_Sales DESC;


-- State-wise Total Profit
SELECT
    State,
    SUM(Profit_INR) AS Total_Profit
FROM sales_data
GROUP BY State
ORDER BY Total_Profit DESC;


-- State-wise Total Orders
SELECT
    State,
    COUNT(Order_ID) AS Total_Orders
FROM sales_data
GROUP BY State
ORDER BY Total_Orders DESC;


-- State-wise Profit Margin
SELECT
    State,
    SUM(Profit_INR) / SUM(Sales_INR) AS Profit_Margin
FROM sales_data
GROUP BY State
ORDER BY Profit_Margin DESC;

-- =========================================================
-- 6. PRODUCT ANALYSIS
-- =========================================================

-- Product-wise Total Sales
SELECT
    Product,
    SUM(Sales_INR) AS Total_Sales
FROM sales_data
GROUP BY Product
ORDER BY Total_Sales DESC;


-- Product-wise Total Profit
SELECT
    Product,
    SUM(Profit_INR) AS Total_Profit
FROM sales_data
GROUP BY Product
ORDER BY Total_Profit DESC;


-- Product-wise Total Quantity Sold
SELECT
    Product,
    SUM(Quantity) AS Total_Quantity
FROM sales_data
GROUP BY Product
ORDER BY Total_Quantity DESC;


-- Product-wise Number of Orders
SELECT
    Product,
    COUNT(Order_ID) AS Total_Orders
FROM sales_data
GROUP BY Product
ORDER BY Total_Orders DESC;


-- Product-wise Profit Margin
SELECT
    Product,
    SUM(Profit_INR) / SUM(Sales_INR) AS Profit_Margin
FROM sales_data
GROUP BY Product
ORDER BY Profit_Margin DESC;

-- =========================================================
-- 7. CUSTOMER SEGMENT & CATEGORY ANALYSIS
-- =========================================================

-- Customer Segment-wise Total Sales
SELECT
    Customer_Segment,
    SUM(Sales_INR) AS Total_Sales
FROM sales_data
GROUP BY Customer_Segment
ORDER BY Total_Sales DESC;


-- Customer Segment-wise Total Profit
SELECT
    Customer_Segment,
    SUM(Profit_INR) AS Total_Profit
FROM sales_data
GROUP BY Customer_Segment
ORDER BY Total_Profit DESC;


-- Customer Segment-wise Number of Orders
SELECT
    Customer_Segment,
    COUNT(Order_ID) AS Total_Orders
FROM sales_data
GROUP BY Customer_Segment
ORDER BY Total_Orders DESC;


-- Category-wise Total Sales
SELECT
    Category,
    SUM(Sales_INR) AS Total_Sales
FROM sales_data
GROUP BY Category
ORDER BY Total_Sales DESC;


-- Category-wise Total Profit
SELECT
    Category,
    SUM(Profit_INR) AS Total_Profit
FROM sales_data
GROUP BY Category
ORDER BY Total_Profit DESC;


-- Payment Mode-wise Number of Orders
SELECT
    Payment_Mode,
    COUNT(Order_ID) AS Total_Orders
FROM sales_data
GROUP BY Payment_Mode
ORDER BY Total_Orders DESC;

-- =========================================================
-- 8. CUSTOMER ANALYSIS & JOIN
-- =========================================================

-- Customer details with their orders
SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.Customer_City,
    s.Order_ID,
    s.Product,
    s.Sales_INR
FROM customers_data c
INNER JOIN sales_data s
ON c.Customer_ID = s.Customer_ID;


-- Customer-wise Total Sales
SELECT
    c.Customer_ID,
    c.Customer_Name,
    SUM(s.Sales_INR) AS Total_Sales
FROM customers_data c
INNER JOIN sales_data s
ON c.Customer_ID = s.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
ORDER BY Total_Sales DESC;


-- Customer-wise Total Profit
SELECT
    c.Customer_ID,
    c.Customer_Name,
    SUM(s.Profit_INR) AS Total_Profit
FROM customers_data c
INNER JOIN sales_data s
ON c.Customer_ID = s.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
ORDER BY Total_Profit DESC;

-- =========================================================
-- 9. LEFT JOIN CUSTOMER ANALYSIS
-- =========================================================

-- Display all customers and their orders
-- Including customers with no orders
SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.Customer_City,
    s.Order_ID,
    s.Product,
    s.Sales_INR
FROM customers_data c
LEFT JOIN sales_data s
ON c.Customer_ID = s.Customer_ID;


-- Find customers who have no matching orders
SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.Customer_City
FROM customers_data c
LEFT JOIN sales_data s
ON c.Customer_ID = s.Customer_ID
WHERE s.Order_ID IS NULL;


-- Calculate total sales for every customer
-- Customers with no sales will show 0
SELECT
    c.Customer_ID,
    c.Customer_Name,
    COALESCE(SUM(s.Sales_INR), 0) AS Total_Sales
FROM customers_data c
LEFT JOIN sales_data s
ON c.Customer_ID = s.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
ORDER BY Total_Sales DESC;

-- =========================================================
-- 10. ADVANCED JOIN ANALYSIS
-- =========================================================


-- RIGHT JOIN
-- Display all customers and their matching sales orders
SELECT
    c.Customer_ID,
    c.Customer_Name,
    s.Order_ID,
    s.Product,
    s.Sales_INR
FROM sales_data s
RIGHT JOIN customers_data c
ON s.Customer_ID = c.Customer_ID;


-- RIGHT JOIN
-- Find customers who have no matching sales orders
SELECT
    c.Customer_ID,
    c.Customer_Name
FROM sales_data s
RIGHT JOIN customers_data c
ON s.Customer_ID = c.Customer_ID
WHERE s.Order_ID IS NULL;


-- FULL OUTER JOIN equivalent in MySQL
-- MySQL does not directly support FULL OUTER JOIN
SELECT
    c.Customer_ID,
    c.Customer_Name,
    s.Order_ID,
    s.Product,
    s.Sales_INR
FROM customers_data c
LEFT JOIN sales_data s
ON c.Customer_ID = s.Customer_ID

UNION

SELECT
    c.Customer_ID,
    c.Customer_Name,
    s.Order_ID,
    s.Product,
    s.Sales_INR
FROM customers_data c
RIGHT JOIN sales_data s
ON c.Customer_ID = s.Customer_ID;


-- CROSS JOIN
-- Create every possible combination of Customer_Type and Product
SELECT DISTINCT
    c.Customer_Type,
    s.Product
FROM customers_data c
CROSS JOIN sales_data s;


-- SELF JOIN
-- Match customers who belong to the same city
SELECT
    c1.Customer_Name AS Customer_1,
    c2.Customer_Name AS Customer_2,
    c1.Customer_City
FROM customers_data c1
INNER JOIN customers_data c2
ON c1.Customer_City = c2.Customer_City
AND c1.Customer_ID < c2.Customer_ID;

-- =========================================================
-- 11. CUSTOMER SUMMARY & FINAL BUSINESS ANALYSIS
-- =========================================================


-- Customer-level Summary
SELECT
    c.Customer_ID,
    c.Customer_Name,
    COUNT(s.Order_ID) AS Total_Orders,
    COALESCE(SUM(s.Sales_INR), 0) AS Total_Sales,
    COALESCE(SUM(s.Profit_INR), 0) AS Total_Profit,
    COALESCE(
        SUM(s.Profit_INR) / NULLIF(SUM(s.Sales_INR), 0),
        0
    ) AS Profit_Margin
FROM customers_data c
LEFT JOIN sales_data s
ON c.Customer_ID = s.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
ORDER BY Total_Sales DESC;


-- Top 10 Customers by Total Profit
SELECT
    c.Customer_ID,
    c.Customer_Name,
    SUM(s.Profit_INR) AS Total_Profit
FROM customers_data c
INNER JOIN sales_data s
ON c.Customer_ID = s.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
ORDER BY Total_Profit DESC
LIMIT 10;

-- =========================================================
-- 12. KEY BUSINESS INSIGHTS
-- =========================================================

-- 1. Identify the state with the highest total sales.

SELECT
    State,
    SUM(Sales_INR) AS Total_Sales
FROM sales_data
GROUP BY State
ORDER BY Total_Sales DESC
LIMIT 1;


-- 2. Identify the state with the highest total profit.

SELECT
    State,
    SUM(Profit_INR) AS Total_Profit
FROM sales_data
GROUP BY State
ORDER BY Total_Profit DESC
LIMIT 1;


-- 3. Identify the most profitable product.

SELECT
    Product,
    SUM(Profit_INR) AS Total_Profit
FROM sales_data
GROUP BY Product
ORDER BY Total_Profit DESC
LIMIT 1;


-- 4. Identify the customer segment with the highest sales.

SELECT
    Customer_Segment,
    SUM(Sales_INR) AS Total_Sales
FROM sales_data
GROUP BY Customer_Segment
ORDER BY Total_Sales DESC
LIMIT 1;


-- 5. Identify the top 10 customers by total profit.

SELECT
    c.Customer_ID,
    c.Customer_Name,
    SUM(s.Profit_INR) AS Total_Profit
FROM customers_data c
INNER JOIN sales_data s
ON c.Customer_ID = s.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
ORDER BY Total_Profit DESC
LIMIT 10;


-- =========================================================
-- 13. BUSINESS INSIGHTS SUMMARY
-- =========================================================

-- 1. Gujarat generated the highest total sales of ₹16,64,620.

-- 2. Gujarat generated the highest total profit of ₹2,63,975.17.

-- 3. Laptop was the most profitable product with total profit
--    of ₹8,28,751.19.

-- 4. Small Business was the highest-sales customer segment
--    with total sales of ₹53,69,040.

-- 5. Megha Malhotra was the top customer by total profit
--    with profit of ₹1,03,059.89.
