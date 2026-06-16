/*
=============================================================================
Platform: DataLemur
Problem: Card Launch Success (JPMorgan Chase)
Link: https://datalemur.com/questions/card-launch-success
Concept: Window Functions (ROW_NUMBER), CTEs, Chronological Sorting
=============================================================================

Business Use Case:
Tracking the initial launch performance of a new financial product (like a credit card) is critical for retail banking. 
This query isolates the "month one" acquisition metrics, allowing product managers to benchmark new card launches against historical portfolio data to estimate immediate market penetration.

Approach:
1. Created a CTE to assign a sequential row number to every month of issuance 
   data, isolated per credit card (PARTITION BY card_name).

2. Sorted the window chronologically using the dual-column date structure 
   (ORDER BY issue_year, issue_month ).

3. Used ROW_NUMBER() as a defensive measure to ensure only a single strict 
   'first' record is flagged, even in the event of pipeline duplication.

4. Filtered the main query for row 1 to isolate the launch month, and ordered the final output by the highest issued amount to highlight top performers 

*/

WITH monthly_cards_issued_CTE AS (

    SELECT card_name , issued_amount ,
    RANK() OVER (partition by card_name order by issue_year,issue_month ) as row_rnk
    from monthly_cards_issued
)

SELECT card_name , issued_amount
FROM monthly_cards_issued_CTE
where row_rnk = 1 
order by issued_amount DESC