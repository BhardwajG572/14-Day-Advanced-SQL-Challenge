/*
=============================================================================
Platform: LeetCode
Problem: 1164. Product Price at a Given Date
Link: https://leetcode.com/problems/product-price-at-a-given-date/
Concept: CTEs, Window Functions, UNION ALL, Point-in-Time Analysis
=============================================================================

Business Use Case:
In retail data science, tracking pricing history is notoriously difficult because prices overwrite over time. This query is an example of "Point-in-Time" 
(PiT) reporting. It is critical for auditing historical revenue, resolving past customer billing disputes, or generating clean training data for machine 
learning models that need to know exactly what a product cost on a specific day.

Approach ("Parallel CTE " , we have to connect two independent CTE and return comprehensive output.
1. Created a CTE (RankedPrices) to isolate all price changes that occurred on or before our target date ('2019-08-16'). 
   Used RANK() ORDER BY change_date DESC to force the most recent valid price into the rnk = 1 position.

2. Used a separate query with a NOT IN clause to identify any products that had NO price changes prior to the target date, 
   assigning them the system default price of 10.

3. Used UNION ALL to seamlessly stitch both independent Queries into a single, comprehensive output.

*/

WITH RankedPrices AS (
    SELECT 
        product_id, 
        new_price AS price, 
        change_date, 
        RANK() OVER (PARTITION BY product_id ORDER BY change_date DESC) as rnk 
    FROM Products 
    WHERE change_date <= '2019-08-16'
)
-- Track 1: Products with a price change before/on the target date
SELECT 
    product_id, 
    price 
FROM RankedPrices
WHERE rnk = 1

UNION ALL

-- Track 2: Products with no price change before/on the target date (Default to 10)
SELECT DISTINCT 
    product_id, 
    10 AS price 
FROM Products 
WHERE product_id NOT IN (
    SELECT product_id 
    FROM RankedPrices
);