/* What is the total amount each customer spent at the restaurant */
WITH total_quantity AS (SELECT product_id AS product_id,
							   customer_id AS customer_id,
							   COUNT(*) AS total_quantity
						FROM sales
						GROUP BY product_id,customer_id
						ORDER BY total_quantity),
	 menu_prices AS (SELECT product_id AS product_id,
                            price AS price
					 FROM menu),
	 total_revenue AS (SELECT total_quantity.product_id AS product_id,
							  menu_prices.price*total_quantity.total_quantity AS total_revenue
                       FROM total_quantity JOIN menu_prices USING(product_id))

SELECT total_quantity.customer_id AS customer_id,
	   SUM(total_revenue.total_revenue) AS total_revenue
FROM total_quantity JOIN total_revenue USING(product_id)
GROUP BY total_quantity.customer_id
ORDER BY SUM(total_revenue.total_revenue) DESC;

-- Query by Noah Oyugi --