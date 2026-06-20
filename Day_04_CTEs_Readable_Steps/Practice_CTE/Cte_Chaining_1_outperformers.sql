-- Table : store_sales
-- Columns : store_id , revenue 

-- our Task: > 1. Write a CTE that calculates the overall average revenue across all stores.
-- 2. In your main outer query, return the store_id of any store whose individual revenue is 
-- strictly greater than the overall average you calculated in the CTE.


WiTH cte as (
    SELECT AVG(revenue) as overall_avg
    from store_sales

)
SELECT store_id 
from store_sales
where revenue > (select overall_avg from cte)