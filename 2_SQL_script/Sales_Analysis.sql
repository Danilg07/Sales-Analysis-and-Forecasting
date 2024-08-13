# 1. Data Quality Assessement 
-- Checking for missing values
SELECT 
    COUNT(*)
FROM
    sales
WHERE
    Profit IS NULL; 
-- Checking data types
describe sales;
describe customers;
describe products;
-- Identify duplicates
SELECT 
    Order_ID, COUNT(*)
FROM
    sales
GROUP BY Order_ID
HAVING COUNT(*) > 1;

# 2. Data Transformation
-- Cleaning the Discount values
UPDATE sales 
SET 
    Discount = CAST(REPLACE(Discount, '%', '') AS DECIMAL (5 , 2 ));
-- Joining tables 
CREATE VIEW sales_analysis AS
    SELECT 
        s.*,
        p.Product_Name,
        p.Category,
        p.Sub_Category,
        c.Customer_Name,
        c.Segment,
        c.Age,
        c.Region
    FROM
        sales s
            JOIN
        customers c ON s.Customer_ID = c.Customer_ID
            JOIN
        products p ON s.product_ID = p.product_ID;

# 3. Sales performance analysis and profitability
-- Total Sales and Profits by Region and Category
SELECT 
    region,
    category,
    SUM(sales) AS Total_sales,
    SUM(profit) AS Total_profits
FROM
    sales_analysis
GROUP BY region , category
ORDER BY region;
-- Top 5 performing products
SELECT 
    product_name, SUM(sales) AS Total_sales
FROM
    sales_analysis
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 5;

# 4 Customer Segmentation and Targeting
-- Segment customers by age and segment
SELECT 
    segment,
    CASE
        WHEN age < 25 THEN 'Youth'
        WHEN age BETWEEN 25 AND 50 THEN 'Adult'
        ELSE 'Senior'
    END AS Age_grp,
    COUNT(*) AS Customer_count
FROM
    customers
GROUP BY Segment , Age_grp
ORDER BY Customer_count DESC;
-- Purchace behavior by segment 
SELECT 
    segment,
    AVG(sales) AS Avg_sales,
    SUM(profit) AS Total_profits
FROM
    sales_analysis
GROUP BY segment
ORDER BY Total_profits;

# 5. Discount and Promotion Effectiveness
-- Sales and profit with and without discounts
SELECT 
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    CASE
        WHEN discount > 0 THEN 'With discount'
        ELSE 'Without discount'
    END AS discount_flag
FROM
    sales_analysis
GROUP BY discount_flag;
-- Top 5 discount levels impacting profit
SELECT 
    discount,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM
    sales_analysis
GROUP BY discount
ORDER BY total_profit DESC
LIMIT 5;

# 6. Customer Retention and Churn Analysis
-- Repeat purchase rate
SELECT 
    Customer_ID, Customer_Name, COUNT(*) AS Purchase_Count
FROM
    sales_analysis
GROUP BY Customer_ID , Customer_Name
HAVING Purchase_Count > 1
ORDER BY Purchase_Count DESC;
-- Identifying potential churn (customers with only one purchase)
SELECT 
    Customer_ID, Customer_Name, COUNT(*) AS Purchase_Count
FROM
    sales_analysis
GROUP BY Customer_ID , Customer_Name
HAVING Purchase_Count = 1;

# 7. Reports
-- Creating a view for sales performance by category
CREATE VIEW sales_performance_category AS
    SELECT 
        Category,
        SUM(Sales) AS Total_Sales,
        SUM(Profit) AS Total_Profit
    FROM
        sales_analysis
    GROUP BY Category;
-- Store a procedure to generate a summary report
DELIMITER //
CREATE PROCEDURE generate_categorical_report()
BEGIN
    SELECT * FROM sales_performance_category;
END //
DELIMITER ; 
-- Creating a view for Sales performance by Region
CREATE VIEW sales_performance_region AS
    SELECT 
        Region,
        SUM(Sales) AS Total_Sales,
        SUM(Profit) AS Total_Profit
    FROM
        sales_analysis
    GROUP BY Region;

-- Store a procedure to generate a summary report
DELIMITER //
CREATE PROCEDURE generate_regional_report()
BEGIN
    SELECT * FROM sales_performance_region;
END //
DELIMITER ;
# 8. Ad-Hoc Analysis
-- Ad-Hoc Analysis: Top Customers by Profit Contribution in a Specific Region
SELECT 
    Customer_Name, Region, SUM(Profit) AS Total_Profit
FROM
    sales_analysis
WHERE
    Region = 'West'
GROUP BY Customer_Name , Region
ORDER BY Total_Profit DESC
LIMIT 10;
-- Ad-Hoc Analysis: Products with the Highest Return Rates
SELECT 
    Product_Name, SUM(Quantity) AS Total_Returns
FROM
    sales_analysis
WHERE
    Profit < 0
GROUP BY Product_Name
ORDER BY Total_Returns DESC;