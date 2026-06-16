/*
=============================================================================
Platform: DataLemur
Problem: Y-on-Y Growth Rate (Wayfair)
Link: https://datalemur.com/questions/yoy-growth-rate
Concept: Window Functions (LAG), CTEs, Percentage Calculations
=============================================================================

Business Use Case:
Year-over-Year (YoY) growth is arguably the most highly scrutinized metric in 
any retail or BFSI earnings report. It neutralizes seasonal fluctuations 
(like holiday shopping spikes) to reveal the true underlying growth trajectory 
of a product line, loan portfolio, or regional sales division.

My Approach:
1. Created a base CTE (curr_year_CTE) to aggregate the total spend per product 
   for each distinct year.
2. Used a second CTE (prev_yr_cte) featuring the LAG() window function. 
   Crucially, partitioned by product_id to ensure we only compare apples-to-apples 
   (the same product's performance over time), ordered chronologically.
3. In the final query, calculated the YoY percentage change, utilizing NULLIF() 
   on the denominator to safeguard against divide-by-zero errors for a product's 
   first year on the market.
*/
WITH curr_year_CTE as (
  -- We aggregated total spend per product , per year
  SELECT
  EXTRACT(YEAR from transaction_date) as "year",
  product_id , SUM(spend) as "curr_year_spend" 
  from user_transactions
  group by product_id , EXTRACT(YEAR from transaction_date)

),


prev_yr_cte AS (
  --  Used LAG to pull the previous year's spend FOR THE SAME PRODUCT
  SELECT 
    year,
    product_id, 
    curr_year_spend, 
    LAG(curr_year_spend, 1) OVER (
      PARTITION BY product_id ORDER BY year ASC
    ) AS prev_year_spend
  FROM curr_year_CTE
)
--  Calculating the YoY Percentage Rate
SELECT 
  year, 
  product_id, 
  curr_year_spend, 
  prev_year_spend, 
  ROUND(100.0 * (curr_year_spend - prev_year_spend) / NULLIF(prev_year_spend, 0), 2) AS yoy_rate 
FROM prev_yr_cte;