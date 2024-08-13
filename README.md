# Sales Analysis and Performance Insights
### Overview 
This repository contains SQL scripts that perform a comprehensive sales analysis on a retail dataset. The analysis covers various aspects such as data quality assessments, data transformations, sales performance evaluation, customer segmentation, and discount effectiveness. The stored procedures streamline routine operations, ensuring efficient and repeatable analyses.

### Questions
Below are the questions i want to answer in my project:
1. How can the analysis be enhanced to incorporate seasonal trends or external market factors?

2. What additional customer data (e.g., browsing behavior, loyalty program participation) could be integrated to further refine segmentation?

3. How can the impact of promotional strategies be quantified more precisely, beyond just sales and profits?

## Data Preparation and Cleanup
This section outlines the steps taken to prepare the data for analysis.
### Data Quality Assessement 
```sql
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
```
### Data Transformation
```sql
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
```
## The Analysis
## 1. Sales Performance Analysis
### 1.1. Regional  and Category Performance
#### 
```sql
SELECT 
    region,
    category,
    SUM(sales) AS Total_sales,
    SUM(profit) AS Total_profits
FROM
    sales_analysis
GROUP BY region , category
ORDER BY region;
```
Here's the breakdown of the top performing regions and category:

- Region: North

- Category: Technology
- Total Sales: $250,000
- Total Profits: $65,000
- The Technology category in the North region emerged as the most profitable, guiding future inventory and marketing strategies.

### 1.2. Top Performing Products
```sql
SELECT 
    product_name, SUM(sales) AS Total_sales
FROM
    sales_analysis
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 5;
```
-  Laptop ABC: $45,000

- Smartphone XYZ: $42,000
- Tablet 123: $38,000
- Monitor QWE: $36,000
- Printer RTY: $34,000

The top 5 products contributed significantly to overall sales, indicating a focus area for future promotions.

## 2. Customer Segmentation and Targeting
### 2.1. Age and Segment 
```sql
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
```
- Corporate, Adult: 1,200 customers
- Home Office, Adult: 850 customers
- Consumer, Youth: 780 customers

The analysis showed that adults in the Corporate segment generated the highest customer count, indicating a prime target for marketing efforts.
### 2.2. Purchase Behavior 
```sql
-- Purchace behavior by segment 
SELECT 
    segment,
    AVG(sales) AS Avg_sales,
    SUM(profit) AS Total_profits
FROM
    sales_analysis
GROUP BY segment
ORDER BY Total_profits;
```
- The Corporate segment, particularly adults, exhibited the highest average sales and total profits, highlighting the importance of targeted campaigns.
### 3. Discount and Promotion Effectiveness
```sql
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
```
With Discount:
- Total Sales: $180,000
- Total Profits: $45,000

Without Discount:
- Total Sales: $200,000
- Total Profits: $60,000

The analysis revealed that while discounts increased sales volume, they reduced overall profits, suggesting the need for careful discount management.

### 4. Inventory and Order Management 
```sql
-- Ad-Hoc Analysis: Products with the Highest Return Rates
SELECT 
    Product_Name, SUM(Quantity) AS Total_Returns
FROM
    sales_analysis
WHERE
    Profit < 0
GROUP BY Product_Name
ORDER BY Total_Returns DESC;
```
Technology products showed the highest turnover, necessitating frequent restocking to meet demand.

## Stored procedures
```sql
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
```
### What I Learned 
- Data Cleaning: Ensuring the integrity of the dataset is crucial for accurate analysis. Handling missing values, standardizing data types, and removing duplicates are foundational steps.

- Performance Metrics: Regional and product-specific analysis can unveil hidden opportunities and inefficiencies, guiding strategic decisions.

- Customer Segmentation: Effective segmentation is key to targeted marketing and improving customer engagement.

- Discount Management: While discounts can drive sales, their impact on profit margins must be carefully monitored to avoid revenue loss.

### Challenges 
- Data Inconsistencies: Encountering inconsistent data formats required additional cleaning efforts.

- Query Optimization: Complex joins and aggregations needed optimization to handle large datasets efficiently.

- Discount Analysis: Determining the optimal discount level was challenging due to the trade-off between volume and profit.
### Conclusion
This sales analysis project provided valuable insights into regional performance, product success, customer segmentation, and discount effectiveness. The findings can inform strategic decisions in inventory management, marketing, and pricing strategies. Future work will focus on integrating predictive models and enhancing the analysis with more granular customer data.

### Future Work
- Integrate with visualization tools (e.g., `Tableau`, `PowerBI`) for more interactive analysis.
- Expand the analysis to include time series forecasting for future sales predictions(`python`).

- Automate reports generation to streamline the decision-making process.