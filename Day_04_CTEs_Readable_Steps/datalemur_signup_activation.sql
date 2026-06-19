/*
=============================================================================
Platform: DataLemur
Problem: Signup Activation Rate (TikTok)
Link: https://datalemur.com/questions/signup-confirmation-rate
Concept: LEFT JOINs, Conditional Aggregation, Distinct Counts, Decimal Math
=============================================================================

Business Use Case:

The "Activation Rate" is one of the most critical KPIs for product growth teams. It measures funnel drop-off between a user expressing intent (creating an account) 
and actually completing the onboarding loop (confirming the email/text). Tracking this helps engineering teams identify if verification texts are failing to send, 
or if the confirmation UI is too confusing for new users.

Approach:

1. Foundation (LEFT JOIN): Used the `emails` table as the base and LEFT JOINed the `texts` table. This ensures users who never received or replied to a text 
   remain in the dataset to act as the baseline denominator.

2. The Denominator: Used COUNT(DISTINCT e.email_id) to calculate the total number of unique signups, preventing duplicates if a user received multiple texts.

3. The Numerator: Used a conditional COUNT(DISTINCT) coupled with a CASE WHEN statement to strictly isolate and count unique users who eventually achieved 
   a 'Confirmed' status.

4. The Math: Multiplied the numerator by 1.0 to force float-point decimal math, preventing SQL from truncating the result to zero, and rounded to 2 decimal places.

*/


SELECT 
  ROUND(
    1.0 * COUNT(DISTINCT CASE WHEN t.signup_action = 'Confirmed' THEN e.email_id ELSE NULL END) 
    / COUNT(DISTINCT e.email_id), 
  2) AS confirm_rate

FROM emails e
LEFT JOIN texts t 
ON e.email_id = t.email_id ;