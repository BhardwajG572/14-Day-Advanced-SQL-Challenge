/*
=============================================================================
Platform: Mock Interview (Custom BUILD)
Problem: Customer Timeline Dashboard
Concept: Conditional Aggregation (SUM(CASE WHEN...))
=============================================================================

Business Use Case:
The CRM team is migrating to a new email marketing tool. Instead of having 
multiple rows of purchases for a single customer across different years, 
they need one single row per customer showing their lifetime value, their 
2022 value, and their 2023 value side-by-side to trigger automated VIP emails.

Approach (Conditional Aggregation / Pivot):
1. The Collapse: We use a standard GROUP BY customer_id to ensure our 
   final output has exactly one row per customer.
2. The Total: A standard SUM(amount) gives the baseline lifetime spend.
3. The Pivot: We use SUM(CASE WHEN...) to evaluate the purchase_year of each row. 
   If the year matches the target (e.g., 2022), we add that row's `amount` 
   into the specific column's bucket. If it doesn't match, we add 0.
*/

SELECT 
    customer_id, 
    SUM(amount) AS lifetime_spend, 
    SUM(CASE WHEN purchase_year = 2022 THEN amount else 0 END) AS spend_2022, 
    SUM(CASE WHEN purchase_year = 2023 THEN amount else 0 END) AS spend_2023
FROM customer_purchases 
GROUP BY customer_id;