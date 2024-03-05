/*Total items and value bought by customers before they become a member*/
WITH total_orders AS (
SELECT 
    sales.customer_id AS customer_id,
    menu.product_id AS product_id,
    SUM(menu.price) AS total_amt_spent,
    sales.order_date AS order_date
FROM sales JOIN menu USING(product_id)
GROUP BY sales.customer_id,menu.product_id,sales.order_date
ORDER BY sales.order_date
),
membership_date AS (
SELECT 
    join_date, 
    customer_id
FROM members
)

SELECT 
    t_o.customer_id,
    COUNT(DISTINCT t_o.product_id) AS product_qty,
    SUM(total_amt_spent) AS total_amt_spent,
    t_o.order_date
FROM total_orders AS t_o JOIN membership_date AS md USING(customer_id)
WHERE t_o.order_date < md.join_date
GROUP BY t_o.customer_id, t_o.order_date
ORDER BY t_o.order_date;