/* What is the most purchased item on the menu and how many time was it purchased by all customers */
WITH most_purchased_item AS (
	SELECT 
		menu.product_name AS product_name,
        sales.product_id AS product_id,
		COUNT(*) AS count_of_orders
	FROM sales JOIN menu USING(product_id)
    GROUP BY sales.product_id, menu.product_name
    ORDER BY COUNT(*) DESC
    LIMIT 1
),
customer_purchases_per_item AS (
	SELECT 
		sales.customer_id AS customer_id,
        menu.product_name AS product_name,
        COUNT(*) AS count_of_orders
	FROM sales JOIN MENU USING(product_id)
    GROUP BY sales.customer_id, menu.product_name
)

SELECT customer_id, product_name, count_of_orders
FROM customer_purchases_per_item
WHERE product_name = (SELECT product_name
					  FROM most_purchased_item);

-- Query by Noah Oyugi -- 