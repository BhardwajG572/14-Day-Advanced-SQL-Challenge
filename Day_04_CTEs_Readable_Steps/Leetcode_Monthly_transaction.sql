/*
=============================================================================
Platform: LeetCode
Problem: 1193. Monthly Transactions I
Link: https://leetcode.com/problems/monthly-transactions-i/
Concept: Conditional Aggregation, Date Formatting, Grouping
=============================================================================

Business Use Case:
In a global e-commerce or BFSI setting, analysts must constantly monitor transaction volumes and approval rates across different regions to detect payment gateway outages, regional fraud spikes, or shifts in revenue generation.

Approach:
1. Data Preparation (CTE): Extracted the Year and Month from the raw timestamp 
   using DATE_FORMAT() to create a clean grouping variable.
2. Grouping: Collapsed the dataset to a summary level using a standard 
   GROUP BY month, country.
3. Conditional Aggregation: Utilized the SUM(CASE WHEN...) pattern to pivot 
   the data, successfully isolating the count and total value of "approved" 
   transactions without needing to write multiple independent subqueries.
*/

WITH CTE AS (
    -- In first step , we basically focus on creating Month column , so that on the basis of month , we could fetch important details.
    SELECT 
        country, 
        state, 
        amount,
        DATE_FORMAT(trans_date, '%Y-%m') AS month 
    FROM Transactions 
)
-- Using month that we extracted , is now used in main query to deal with it clearly. 
SELECT 
    month,
    country,
    COUNT(state) AS trans_count, 
    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count, 
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM CTE
GROUP BY 
    month, 
    country;