/*
=============================================================================
Platform: Mock Interview (Custom BUILD)
Problem: Category Leaders Homepage
Concept: Parallel Tracks, UNION ALL, ORDER BY ... LIMIT
=============================================================================

Business Use Case:
The E-commerce Engineering team needs to build a widget for the homepage. 
They want to display the top 2 trending items from the "Electronics" category 
stacked directly above the top 2 items from the "Home Goods" category so the 
frontend developers can seamlessly map the query output to the user interface.

Steps : 
1. So firstly i found the total units_sold , and we grouped by category and product_name , that helps us to 
see for particular category , what is the totoal units sold , and filterd by category name 'electronics' and later by 'home goods' 

2. Secondly we do the same thing with the help fo category name 'Home goods'
In short : Query the table, filter strictly for 'Home Goods', sort by 
   units_sold DESC, and LIMIT 2
*/
(


    SELECT category , product_name , SUM(units_sold)
    from category_sales 
    where category = 'Electronics'
    group by category , product_name 
    order by SUM(units_sold) DESC 
    LIMIT 2 


)


UNION ALL 


(


    SELECT category , product_name , SUM(units_sold)
    from category_sales 
    where category = 'Home Goods'
    group by category , product_name 
    order by SUM(units_sold) DESC 
    LIMIT 2 
)
