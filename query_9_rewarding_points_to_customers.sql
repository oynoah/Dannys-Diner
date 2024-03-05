/*Rewarding points to customers*/
SELECT 
    sales.customer_id AS customer_id,
    SUM(CASE WHEN menu.product_id = 'sushi' THEN menu.price*10*2
		ELSE menu.price*10 END) AS points
FROM sales JOIN menu USING(product_id)
GROUP BY sales.customer_id
ORDER BY points DESC; 

-- Query by Noah Oyugi --       