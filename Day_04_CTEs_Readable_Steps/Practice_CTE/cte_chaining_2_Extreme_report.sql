/*
=============================================================================
Platform: Mock Interview (Custom BUILD)
Problem: The Extremes Report (Leader & Laggard)
Concept: Parallel Tracks Pattern, UNION ALL, Sorting
=============================================================================

Business Use Case:
The VP of Regional Sales doesn't have time to look through a massive 
spreadsheet of employee performance. For the weekly all-hands meeting, they 
want a simple, two-row summary slide showing the absolute highest-performing 
salesperson and the absolute lowest-performing salesperson stacked perfectly 
into a single view to allocate shoutouts and additional training.

Approach (Parallel Tracks):
1. Track 1 (The Leader): Query the table, sort by total_sales DESC to put 
   the highest seller at the top, and use LIMIT 1 to grab just that row.
   Alias the sales column to 'metric' to match the requested output.
2. Track 2 (The Laggard): Query the table independently, sort by total_sales 
   ASC to put the lowest seller at the top, and use LIMIT 1.
3. The Execution: Use UNION ALL to stitch both independent tracks together 
   vertically into a single, clean executive summary.
*/
-- 
-- Finding highest total -sales (Track 1 )

(
    SELECT employee_name , total_sales as metric 
    from employee_sales 
    order by total_sales DESC
    limit 1 
)

UNION ALL
-- Finding lowest total sales (Track 2 )

(
    SELECT employee_name , total_sales as metric 
    from employee_sales 
    order by total_sales ASC
    limit 1 
)