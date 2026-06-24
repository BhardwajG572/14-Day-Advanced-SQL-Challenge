/*
=============================================================================
Platform: Mock Interview (Custom BUILD)
Problem: Inventory Stockout Risk
Concept: Conditional Aggregation (Single-Row Pivot)
=============================================================================

Business Use Case:
The FMCG Supply Chain team needs a daily health check of their warehouses. 
Instead of a massive list of individual products, the VP of Supply Chain wants 
a simple, single-row dashboard that shows exactly how many products are 
completely Out of Stock, how many are at Low Stock risk, and how many are Safe.

Approach (Single-Row Pivot):
Because we need exactly one row representing the entire company's inventory, 
we deliberately DO NOT use a GROUP BY clause. We simply use SUM(CASE WHEN...) 
to evaluate every single row in the table. If it matches a specific condition 
(e.g., stock_level = 0), we add 1 to that specific column's bucket. The SQL 
engine automatically collapses the results into a single global summary row.
*/

SELECT 
    SUM(CASE WHEN stock_level = 0 THEN 1 ELSE 0 END) AS out_of_stock_count, 
    SUM(CASE WHEN stock_level >= 1 AND stock_level <= 50 THEN 1 ELSE 0 END) AS low_stock_count, 
    SUM(CASE WHEN stock_level > 50 THEN 1 ELSE 0 END) AS safe_stock_count
FROM warehouse_inventory;