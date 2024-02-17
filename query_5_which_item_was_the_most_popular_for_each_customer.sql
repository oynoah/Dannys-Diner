/*Which item was the most popular amongst each customer*/
WITH most_ordered_items AS (
SELECT 
    customer_id AS customer_id,
    menu.product_name AS product_name,
    COUNT(product_id) AS total_orders
FROM sales JOIN menu USING(product_id)
GROUP BY customer_id, product_name
),
max_orders AS (
SELECT 
    customer_id AS customer_id,
    MAX(total_orders) AS max_total_orders
FROM most_ordered_items
GROUP BY customer_id
)

SELECT 
    most_ordered_items.customer_id,
    most_ordered_items.product_name,
    most_ordered_items.total_orders
FROM most_ordered_items JOIN max_orders ON most_ordered_items.customer_id = max_orders.customer_id
                                        AND most_ordered_items.total_orders = max_orders.max_total_orders
ORDER BY total_orders DESC;
    
-- Query by Noah Oyugi -- 
