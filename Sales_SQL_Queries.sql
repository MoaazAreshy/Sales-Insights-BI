-- ============================================================
--  TOP 10 SQL QUERIES
--  Database: Sales_Insights  |  Table: Orders_Data
-- ============================================================


-- Q1: Total sales, profit, and orders per year
SELECT
    YEAR(CONVERT(DATE, Order_Date, 103))  AS Year,
    COUNT(DISTINCT Order_ID)             AS Total_Orders,
    ROUND(SUM(Sales), 2)                 AS Total_Sales,
    ROUND(SUM(Profit), 2)                AS Total_Profit,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2) AS Profit_Margin_Pct
FROM Orders_Data
GROUP BY YEAR(CONVERT(DATE, Order_Date, 103))
ORDER BY Year;


-- Q2: How does discount level affect profit?
SELECT
    CASE
        WHEN Discount = 0       THEN '0% - No Discount'
        WHEN Discount <= 0.10   THEN '1-10%'
        WHEN Discount <= 0.30   THEN '11-30%'
        WHEN Discount <= 0.50   THEN '31-50%'
        ELSE '51%+'
    END                          AS Discount_Bucket,
    COUNT(*)                     AS Order_Count,
    ROUND(AVG(Sales), 2)         AS Avg_Sales,
    ROUND(AVG(Net_Profit_A), 2)  AS Avg_Net_Profit,
    ROUND(SUM(Net_Profit_A), 2)  AS Total_Net_Profit
FROM Orders_Data
GROUP BY
    CASE
        WHEN Discount = 0       THEN '0% - No Discount'
        WHEN Discount <= 0.10   THEN '1-10%'
        WHEN Discount <= 0.30   THEN '11-30%'
        WHEN Discount <= 0.50   THEN '31-50%'
        ELSE '51%+'
    END
ORDER BY MIN(Discount);


-- Q3: Which markets generate the most sales and profit?
SELECT
    Market,
    COUNT(DISTINCT Order_ID)  AS Total_Orders,
    ROUND(SUM(Sales), 2)      AS Total_Sales,
    ROUND(SUM(Profit), 2)     AS Total_Profit,
    ROUND(AVG(Sales), 2)      AS AOV,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2) AS Profit_Margin_Pct
FROM Orders_Data
GROUP BY Market
ORDER BY Total_Sales DESC;


-- Q4: Top 10 products by profit
SELECT TOP 10
    Product_Name,
    COUNT(Order_ID)          AS Times_Ordered,
    SUM(Quantity)            AS Units_Sold,
    ROUND(SUM(Sales), 2)     AS Total_Sales,
    ROUND(SUM(Profit), 2)    AS Total_Profit,
    ROUND(AVG(Sales), 2)     AS Avg_Order_Value
FROM Orders_Data
GROUP BY Product_Name
ORDER BY Total_Profit DESC;


-- Q5: High-price low-volume vs low-price high-volume products
SELECT
    Product_Name,
    ROUND(AVG(Sales), 2)     AS Avg_Unit_Price,
    SUM(Quantity)            AS Total_Units_Sold,
    ROUND(SUM(Sales), 2)     AS Total_Sales,
    ROUND(SUM(Profit), 2)    AS Total_Profit,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2) AS Profit_Margin_Pct,
    CASE
        WHEN AVG(Sales) >= 1000 AND SUM(Quantity) < 20  THEN 'High-Price Low-Volume'
        WHEN AVG(Sales) < 500   AND SUM(Quantity) >= 50 THEN 'Low-Price High-Volume'
        ELSE 'Mid-Range'
    END AS Product_Strategy
FROM Orders_Data
GROUP BY Product_Name
ORDER BY Total_Profit DESC;


-- Q6: Customer loyalty tiers
SELECT
    c.Customer_Name,
    COUNT(DISTINCT o.Order_ID)   AS Total_Orders,
    ROUND(SUM(o.Sales), 2)       AS Total_Spent,
    ROUND(AVG(o.Sales), 2)       AS Avg_Order_Value,
    CASE
        WHEN COUNT(DISTINCT o.Order_ID) >= 10 THEN 'VIP'
        WHEN COUNT(DISTINCT o.Order_ID) >= 5  THEN 'Loyal'
        WHEN COUNT(DISTINCT o.Order_ID) >= 2  THEN 'Returning'
        ELSE 'One-Time'
    END AS Loyalty_Tier
FROM Orders_Data o
JOIN Customers_Data c ON o.Customer_ID = c.CustomerID
GROUP BY c.Customer_Name
ORDER BY Total_Orders DESC;


-- Q7: Preferred shipping mode — cost and lead time
SELECT
    Ship_Mode,
    COUNT(DISTINCT Order_ID)      AS Total_Orders,
    ROUND(SUM(Shipping_Cost), 2)  AS Total_Shipping_Cost,
    ROUND(AVG(Shipping_Cost), 2)  AS Avg_Shipping_Cost,
    ROUND(AVG(DATEDIFF(DAY, CONVERT(DATE, Order_Date, 103), CONVERT(DATE, Ship_Date, 103))), 2) AS Avg_Lead_Time_Days,
    ROUND(SUM(Sales), 2)          AS Total_Sales
FROM Orders_Data
GROUP BY Ship_Mode
ORDER BY Total_Orders DESC;


-- Q8: Monthly shipping cost trend
SELECT
    YEAR(CONVERT(DATE, Order_Date, 103))      AS Year,
    MONTH(CONVERT(DATE, Order_Date, 103))     AS Month_Num,
    DATENAME(MONTH, CONVERT(DATE, Order_Date, 103)) AS Month_Name,
    ROUND(SUM(Shipping_Cost), 2)             AS Total_Shipping_Cost,
    COUNT(DISTINCT Order_ID)                 AS Total_Orders,
    ROUND(AVG(Shipping_Cost), 2)             AS Avg_Shipping_Cost_Per_Order
FROM Orders_Data
GROUP BY
    YEAR(CONVERT(DATE, Order_Date, 103)),
    MONTH(CONVERT(DATE, Order_Date, 103)),
    DATENAME(MONTH, CONVERT(DATE, Order_Date, 103))
ORDER BY Year, Month_Num;


-- Q9: Sales and profit by segment
SELECT
    Segment,
    COUNT(DISTINCT Order_ID)   AS Total_Orders,
    SUM(Quantity)              AS Units_Sold,
    ROUND(SUM(Sales), 2)       AS Total_Sales,
    ROUND(SUM(Profit), 2)      AS Total_Profit,
    ROUND(AVG(Rating), 2)      AS Avg_Rating
FROM Orders_Data
GROUP BY Segment
ORDER BY Total_Profit DESC;


-- Q10: Order status breakdown
SELECT
    Status,
    COUNT(DISTINCT Order_ID) AS Order_Count,
    ROUND(
        COUNT(DISTINCT Order_ID) * 100.0 /
        SUM(COUNT(DISTINCT Order_ID)) OVER (), 2
    )                        AS Percentage,
    ROUND(SUM(Sales), 2)     AS Total_Sales,
    ROUND(SUM(Profit), 2)    AS Total_Profit
FROM Orders_Data
GROUP BY Status
ORDER BY Order_Count DESC;


-- ============================================================
--  END OF FILE
-- ============================================================