
/*
=============================================================================
Platform: LeetCode
Problem: 1204. Last Person to Fit in the Bus
Link: https://leetcode.com/problems/last-person-to-fit-in-the-bus/
Concept: Running Totals, Threshold Filtering, Window Functions
=============================================================================

Business Use Case:
This query pattern is essential for any business tracking cumulative limits. 
In a banking or fintech environment, this exact logic is used to track a 
customer's daily transaction limits—allowing us to identify exactly which 
transaction triggered a freeze, or calculating exactly when a client's 
cumulative credit exposure hits its absolute maximum cap.

Approach:
1. firstly i created  a CTE to calculate the running total of the weight as people boarding the bus 
   , ordered sequentially by their turn.

2. In main query , just filtered the results to only include people who kept the total bus weight below or equal to 1000 kg (Our limit)
3. Then I , sorted the entire filtered value to descending order and applied a LIMIT 1 to isolate the very last 
person who safely fit.
   
*/




WITH CTE AS (
    SELEct person_id , person_name  , weight , turn,
    SUM(weight) OVER (order by turn asc) as "Total_Weight"
    from Queue
)
SELECT person_name 
from CTE 
where Total_weight<=1000
ORDER BY total_weight DESC
LIMIT 1