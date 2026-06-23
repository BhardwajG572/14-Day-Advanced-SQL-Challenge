/*
=============================================================================
Platform: Mock Interview (Custom BUILD)
Problem: The Whale Customer
Concept: Assembly Line, Cross Joins, Cross-Layer Math
=============================================================================

Business Use Case:
The Executive Leadership team tracks "Whale Customers" (ultra-high-net-worth 
buyers) to monitor revenue concentration risk. We need to isolate the absolute 
top-spending customer and find out exactly what percentage of all-time company 
revenue that single person represents.

Approach:
1. Box 1 (Company Total): we firstly calculate the grand total of all revenue. This CTE 
   returns exactly 1 row and 1 column.
2. Box 2 (The Whale):we then  do group by customer(customer_id), calculate their total spend, sort 
   descending, and LIMIT 1 to find the absolute top spender. This CTE returns 
   exactly 1 row .
3. The Cross Join: Because both CTEs return exactly one row, we can simply 
   list them both in the FROM  clause (FROM company_total, whale_customer). 
   This safely combines them , allowing us to divide the whale's total by the 
   company's total in the SELECT statement.
*/


WITH company_total as (
    SELECT SUM(spend_amount) as grand_total
    from customer_transactions
),
whale_customers as (
    SELECT customer_id , SUM(spend_amount) as customer_total_revenue
    from customer_transactions
    group by customer_id
    order by SUM(spend_amount) DESC
    LIMIT 1 
)
SELECT customer_id as whale_customer_id , 
ROUND((1.0*customer_total_revenue / grand_total)*100.0,2) as revenue_percentage
from whale_customers , company_total