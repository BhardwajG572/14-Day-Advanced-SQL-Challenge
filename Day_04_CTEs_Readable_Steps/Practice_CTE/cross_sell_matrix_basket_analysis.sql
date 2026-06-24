/*
=============================================================================
Platform: Mock Interview (Custom BUILD)
Problem: The Cross-Sell Matrix (Basket Analysis)
Concept: Conditional Aggregation in HAVING + Assembly Line
=============================================================================

Business Use Case:
The E-commerce merchandising team wants to launch a special bundle deal for 
Laptops and Wireless Mice. We need to find the baseline number of unique 
customers who have historically purchased *both* of these items at any point 
in their lifetime to evaluate the market size for this campaign.

Approach  : 
1. In CTE , we group by customer_id , and find out each customer's purchase history ,
And using CASE when , we find that the quantity of laptop purchase and wiress mouse is there or not
(and if it is there ) then we considered that customer as prominent customer.

2. In main query , we counted the customer_id who is left out  , these are the customers which bought laptop and mouse in past.
*/

WITH CTE AS (
    SELECT customer_id ,
    from customer_purchases
    group by customer_id
    HAVING  SUM(CASE WHEN product_name = 'Laptop' Then 1 else 0 END ) > 0  AND 
    SUM(CASE WHEN product_name = 'Wireless Mouse' Then 1 else 0 END) > 0

)
SELECT COUNT(customer_id) as cross_sell_customers
from CTE 
