WITH order_records AS(
SELECT
    members.customer_id AS customer_id,
    menu.product_name AS product_name,
    menu.price AS price,
    members.join_date AS join_date,
    sales.order_date AS order_date
FROM members JOIN sales USING(customer_id)
			 JOIN menu USING(product_id)
),
first_week_orders AS (
SELECT 
    order_records.customer_id AS customer_id,
    order_records.product_name AS product_name,
    order_records.price AS price,
    order_records.order_date AS order_date
FROM order_records 
WHERE (order_records.order_date BETWEEN order_records.join_date AND DATE_ADD(order_records.order_date, INTERVAL 5 DAY)) 
      AND (DATE_FORMAT(order_records.order_date,'%Y-%m')='2021-01')
),
january_orders AS (
SELECT 
    order_records.customer_id AS customer_id,
    order_records.product_name AS product_name,
    order_records.price AS price,
    order_records.order_date AS order_date
FROM order_records
WHERE DATE_FORMAT(order_records.order_date,'%Y-%m')='2021-01'
)

SELECT 
    january_points.customer_id AS customer_ID,
    SUM(january_points.points) AS points
FROM (
          SELECT 
              customer_id AS customer_id, 
              SUM(price*10*2) AS points
          FROM first_week_orders 
          GROUP BY customer_id
      UNION
          SELECT 
              customer_id AS customer_id, 
              SUM( CASE WHEN product_name = 'sushi' THEN price*10*2 ELSE price*10 END) AS points
          FROM january_orders 
          WHERE order_date NOT IN (SELECT order_date FROM first_week_orders) 
          GROUP BY customer_id
	) AS january_points
GROUP BY customer_id
ORDER BY points DESC;

-- Query by Noah Oyugi --