/*
=============================================================================
Platform: Mock Interview (Custom BUILD)
Problem: Discount Analysis
Concept: Conditional Aggregation (Pivoting rows to columns)
=============================================================================

Business Use Case:
The Merchandising team needs to evaluate the effectiveness of their discount 
strategy. They want to know, for each product category, how many units are 
being sold at full price versus how many are sold using a promo code to ensure 
they aren't overly reliant on discounts to drive volume.

Approach:
1. The Collapse: We use a standard GROUP BY product_category to ensure our 
   final output has exactly one row per category.
2. The Total: A standard SUM(units_sold) gives the baseline volume.
3. The Pivot (Conditional Aggregation): We use SUM(CASE WHEN...) to evaluate 
   each row. If the row matches the discount type, we add that row's `units_sold` 
   into the bucket. If it doesn't match, we add 0. This effectively pivots our 
   row data into distinct columns.
*/

SELECT 
    product_category, 
    SUM(units_sold) AS total_units, 
    SUM(CASE WHEN discount_applied = 'Promo Code' THEN units_sold ELSE 0 END) AS promo_units, 
    SUM(CASE WHEN discount_applied = 'Full Price' THEN units_sold ELSE 0 END) AS full_price_units
FROM order_items 
GROUP BY product_category;