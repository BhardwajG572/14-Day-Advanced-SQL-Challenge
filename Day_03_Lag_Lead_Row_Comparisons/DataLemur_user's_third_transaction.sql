/*
=============================================================================
Platform: DataLemur
Problem: User's Third Transaction (Uber)
Link: https://datalemur.com/questions/sql-third-transaction
Concept: Window Functions (ROW_NUMBER), CTEs
=============================================================================

Business Use Case:
Identifying the Nth transaction of a user is a fundamental retention and cohort 
analysis technique. In a ride-sharing or e-commerce environment, analyzing 
a user's 3rd transaction helps data scientists determine when a user 
transitions from "trial" to "habitual/retained" behavior.

Approach that i follow : 

1. Created a CTE to assign a sequential row number to every transaction, isolated per user (PARTITION BY user_id) and ordered chronologically 
   (ORDER BY transaction_date ASC).
2. Utilized ROW_NUMBER() instead of RANK() to ensure a strict 1, 2, 3 sequence, 
   safeguarding against potential tie-breaking bugs if two transactions 
   shared the exact same timestamp.
3. Queried the CTE to filter strictly for the 3rd transaction.

*/

WITH CTE AS (
    SELECT 
        user_id, 
        spend, 
        transaction_date,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY transaction_date ASC) as rnk
     FROM transactions 
)
SELECT user_id, spend, transaction_date 
FROM CTE 
WHERE rnk = 3; 
-- there are some user_id who did not their 3rd transactions , so clearly ignore them and fetch only those user_id whose 3rd transactions is present .
