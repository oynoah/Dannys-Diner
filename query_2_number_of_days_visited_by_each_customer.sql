/* How many days has each customer visited the restaurant */
SELECT 
    customer_id AS customer_id,
    COUNT(DISTINCT order_date) AS number_number_of_days
FROM sales
GROUP BY customer_id
ORDER BY COUNT(DISTINCT order_date) DESC;
