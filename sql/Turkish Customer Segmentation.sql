
-- OBJECTIVE 1: How is the shopping distribution according to gender?
-- WHY: To understand the primary customer base and identify market share by gender.
SELECT 
    gender, 
    COUNT(gender) AS Total_Orders, 
    ROUND((COUNT(gender) * 100.0 / (SELECT COUNT(*) FROM customer)), 2) AS Percentage 
FROM customer 
GROUP BY gender 
ORDER BY Total_Orders DESC;


-- OBJECTIVE 2: Which gender did we sell more products to?
-- WHY: Identifies which group purchased the highest total physical quantity of items, 
-- useful for inventory planning.
SELECT 
    gender, 
    SUM(quantity) AS Total_Quantity_Sold 
FROM customer 
GROUP BY gender 
ORDER BY Total_Quantity_Sold DESC;


-- OBJECTIVE 3: Which gender generated more revenue?
-- WHY: Frequency and volume don't always equal profit. This step calculates 
-- the actual financial impact (Price * Quantity) of each demographic.
SELECT 
    gender, 
    SUM(price * quantity) AS Revenue 
FROM customer 
GROUP BY gender 
ORDER BY Revenue DESC;


-- OBJECTIVE 4: Distribution of purchase categories relative to gender
-- WHY: Identifies "Hero Categories" for different segments to aid targeted marketing.
SELECT 
    category, 
    gender, 
    COUNT(customer_id) AS Total_Order, 
    SUM(price * quantity) AS Revenue_Generated 
FROM customer 
GROUP BY category, gender 
ORDER BY Revenue_Generated DESC;


-- OBJECTIVE 5: How is the shopping distribution according to age?
-- WHY: Groups customers into age brackets to see generational order volume.
-- LOGIC: The CASE statement creates custom labels for age ranges.
SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25' 
        WHEN age BETWEEN 26 AND 35 THEN '26-35' 
        WHEN age BETWEEN 36 AND 45 THEN '36-45' 
        WHEN age BETWEEN 46 AND 55 THEN '46-55' 
        WHEN age BETWEEN 56 AND 65 THEN '56-65' 
        WHEN age > 65 THEN '65+' 
    END AS Age_Group, 
    COUNT(invoice_no) AS Total_Orders,
    ROUND((COUNT(invoice_no) * 100.0 / (SELECT COUNT(*) FROM customer)), 2) AS Percentage 
FROM customer 
GROUP BY Age_Group 
ORDER BY Total_Orders DESC;


-- OBJECTIVE 6: Product sales volume by age group
-- WHY: Identifies which age bracket is responsible for the highest quantity of items sold.
SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25' 
        WHEN age BETWEEN 26 AND 35 THEN '26-35' 
        WHEN age BETWEEN 36 AND 45 THEN '36-45' 
        WHEN age BETWEEN 46 AND 55 THEN '46-55' 
        WHEN age BETWEEN 56 AND 65 THEN '56-65' 
        WHEN age > 65 THEN '65+' 
    END AS Age_Group, 
    SUM(quantity) AS Total_Products_Sold, 
    ROUND((SUM(quantity) * 100.0 / (SELECT SUM(quantity) FROM customer)), 2) AS Percentage 
FROM customer 
GROUP BY Age_Group 
ORDER BY Total_Products_Sold DESC;


-- OBJECTIVE 7: Which Age Category Generated More Revenue?
-- WHY: To find out which generation spends the most money, not just buys the most items.
SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25' 
        WHEN age BETWEEN 26 AND 35 THEN '26-35' 
        WHEN age BETWEEN 36 AND 45 THEN '36-45' 
        WHEN age BETWEEN 46 AND 55 THEN '46-55' 
        WHEN age BETWEEN 56 AND 65 THEN '56-65' 
        WHEN age > 65 THEN '65+' 
    END AS Age_Group, 
    SUM(price * quantity) AS Revenue_Generated, 
    ROUND((SUM(price * quantity) * 100.0 / (SELECT SUM(price * quantity) FROM customer)), 2) AS Percentage_of_Total_Revenue 
FROM customer 
GROUP BY Age_Group 
ORDER BY Revenue_Generated DESC;


-- OBJECTIVE 8: Distribution Of Purchase Categories Relative To Other Columns
-- WHY: Re-evaluating category performance combined with gender segments.
SELECT 
    category, 
    gender, 
    COUNT(customer_id) AS Total_Order, 
    SUM(price * quantity) AS Revenue_Generated 
FROM customer 
GROUP BY category, gender 
ORDER BY Revenue_Generated DESC;


-- OBJECTIVE 9: Does The Payment Method Have A Relation With Other Columns?
-- WHY: Helps optimize checkout processes, reduce transaction fees, and partner with gateways.

-- 9.1 Total Consumers in Each Payment Method
SELECT 
    payment_method, 
    COUNT(payment_method) AS Total_Use_of_Method 
FROM customer 
GROUP BY payment_method 
ORDER BY Total_Use_of_Method DESC;

-- 9.2 Payment Method Relation With Gender
SELECT 
    payment_method, 
    gender, 
    COUNT(gender) AS Total_Consumer 
FROM customer 
GROUP BY payment_method, gender 
ORDER BY Total_Consumer DESC;

-- 9.3 Payment Method Relation With Age Group
SELECT 
    payment_method, 
    CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25' 
        WHEN age BETWEEN 26 AND 35 THEN '26-35' 
        WHEN age BETWEEN 36 AND 45 THEN '36-45' 
        WHEN age BETWEEN 46 AND 55 THEN '46-55' 
        WHEN age BETWEEN 56 AND 65 THEN '56-65' 
        WHEN age > 65 THEN '65+' 
    END AS Age_Group, 
    COUNT(age) AS Total_Consumer 
FROM customer 
GROUP BY payment_method, Age_Group 
ORDER BY Total_Consumer DESC;

-- 9.4 Payment Method Relation With Category
SELECT 
    payment_method, 
    category, 
    COUNT(category) AS No_of_Payments 
FROM customer 
GROUP BY payment_method, category 
ORDER BY No_of_Payments DESC;


-- OBJECTIVE 10: How Is The Distribution Of The Payment Method?
-- WHY: A final standalone check of payment method popularity across the entire dataset.
SELECT 
    payment_method, 
    COUNT(payment_method) AS Total_Use_of_Method 
FROM customer 
GROUP BY payment_method 
ORDER BY Total_Use_of_Method DESC;