/*
=============================================================================
Platform: LeetCode
Problem: 534. Game Play Analysis III
Link: https://leetcode.com/problems/game-play-analysis-iii/
Concept: Running Totals, Window Functions (SUM OVER)
=============================================================================

Business Use Case: 
This query structure is foundational for BFSI and retail analytics. It demonstrates 
how to calculate cumulative metrics over time, such as tracking a customer's 
Year-to-Date (YTD) transaction volume or monitoring a running credit exposure balance.

Approach:
Utilized the SUM() window function partitioned by the player_id. By ordering by the 
event date within the OVER() clause, SQL implicitly applies a frame of 
RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW, perfectly generating a running 
total that we want.
*/

SELECT 
    player_id, 
    event_date, 
    SUM(games_played) OVER (
        PARTITION BY player_id 
        ORDER BY event_date
    ) AS games_played_so_far
FROM Activity;