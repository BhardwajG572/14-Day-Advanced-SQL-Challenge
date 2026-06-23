-- Pre Aggregation  & The Assembly Line : 
/*
=============================================================================
Platform: Mock Interview (Custom BUILD)
Problem: Transaction Averages
Concept: Pre-Aggregation & The Assembly Line
=============================================================================

Business Use Case:
Store managers want to know if their cashiers are successfully upselling at 
the register. We need to find the average number of items a customer buys in 
a single transaction across the entire company to establish a baseline.


Approach : 
1. First we did Pre-Aggregation inside CTE by transaction_id , count the item_ids to find the total size of each individual basket.
2. In main Query , calculate the Average of those basket sizes , we also multiply by 1.0 to ensure float/decimal division prevents integer
truncation befor rounding to 2 decimal places.

*/

WITH CTE AS (
    SELECT transaction_id , SUM(price) as total_customer_purchase , COUNT(item_id) as total_count
    from checkout_items
    group by transaction_id
)
SELECT ROUND(AVG(total_count *1.0 ),2) as avg_transaction_size from CTE 