/*
=============================================================================
Platform: Mock Interview (Custom BUILD)
Problem: Order Frequency Histogram
Concept: Pre-Aggregation (The "Double Group By")
=============================================================================

Business Use Case:
The Marketing team is trying to measure customer loyalty and retention in our
E-commerce platform. To visualize the distribution of our customer base, they 
need a histogram showing the order frequency (how many orders were placed) 
and how many unique customers fall into each frequency bucket.

Approach:
1. Pre-Aggregation (Inner Group By): Group by `customer_id` and count their 
   `order_id`s to find the total lifetime orders for each individual customer.
2. The Outer Group By (The Histogram): In the main query, group by the newly 
   created `order_frequency` column. Then, count the `customer_id`s to see 
   exactly how many users belong in that specific frequency bucket.
*/

WITH customer_totals AS (
    -- Pre-aggregating the total orders per customer
    SELECT 
        customer_id, COUNT(order_id) AS order_frequency
    FROM customer_orders 
    GROUP BY customer_id
)
-- The Outer Group is to build the histogram
SELECT 
    order_frequency, 
    COUNT(customer_id) AS customer_count
FROM customer_totals
GROUP BY order_frequency
ORDER BY order_frequency ASC;