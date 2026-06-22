/*
=============================================================================
Platform: Mock Interview (Custom BUILD)
Problem: Store Tier Segmentation
Concept: Pre-Aggregation, The "Double Group By", CASE WHEN
=============================================================================

Business Use Case:
The Operations team is allocating next year's budget. Stores that generate 
massive annual revenue (>$100k) are classified as "High Performers" and get 
extra budget for renovations. All other stores get a "Standard" budget. 
Operations needs to know exactly how many unique stores fall into each bucket.

Approach (The Double Group By):
1. Pre-Aggregation (Inner Group By): The database only logs daily sales, so 
   we cannot immediately bucket the stores. First, we must build a CTE to 
   GROUP BY store_id and SUM their revenue to calculate the lifetime total 
   for each individual store.
2. The Outer Group By: In the main query, we apply a CASE WHEN statement to 
   evaluate the newly calculated lifetime revenue and assign the text labels 
   ('High Performer' or 'Standard Performer'). We then GROUP BY those exact 
   labels and COUNT the store IDs to build our final histogram.
*/

with store_sales as (

    SELECT store_id , 
    SUM(revenue) as total_lifetime_revenue
    from employee_sales 
    group by store_id 
),
store_bucket as (

    SELECT 
     Case   
            WHEN total_lifetime_reveneu > 100000 then 'High Performer' 
            ELSE 'Standard Performer'
            END as tier_bucket

     from store_sales


)
SELECT tier_bucket ,
COUNT(store_id) as store_count 
from store_bucket 
group by tier_bucket 