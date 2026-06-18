/*
=============================================================================
Platform: LeetCode
Problem: 1341. Movie Rating
Link: https://leetcode.com/problems/movie-rating/
Concept: Parallel Tracks Pattern, UNION ALL, String Date Filtering
=============================================================================

Business Use Case:
This "Parallel Tracks" architecture is used to build executive summary dashboards. 
Often, a VP wants to see "Top User" and "Top Product" in a single summary table 
even though those two metrics come from completely different baseline calculations.

Approach:
1. Track 1 (Top User): Joined Users and MovieRating, grouped by name. 
   Selected ONLY the name column (aliased as 'results'). Sorted by count DESC, 
   then name ASC for the lexicographical tie-breaker, and applied LIMIT 1.
2. Track 2 (Top Movie): Joined Movies and MovieRating. Used the LIKE operator 
   to easily filter for February 2020 dates. Grouped by title, sorted by 
   average rating DESC and title ASC, and applied LIMIT 1.
3. Glued the two independent queries together vertically using UNION ALL.
*/

(
    -- Track 1: Find the top user
    SELECT u.name AS results
    FROM Users u 
    JOIN MovieRating mr ON u.user_id = mr.user_id 
    GROUP BY u.name
    ORDER BY COUNT(mr.rating) DESC, u.name ASC
    LIMIT 1
)

UNION ALL 

(
    -- Track 2: Find the top movie in Feb 2020
    SELECT m.title AS results 
    FROM Movies m 
    JOIN MovieRating mr ON m.movie_id = mr.movie_id 
    WHERE mr.created_at LIKE '2020-02%'
    GROUP BY m.title
    ORDER BY AVG(mr.rating) DESC, m.title ASC
    LIMIT 1
);