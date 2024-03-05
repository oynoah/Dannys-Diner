/*Product purchased by the customer just before becoming a member*/
WITH first_date_of_order AS (
SELECT 
    sales.customer_id AS customer_id,
    menu.product_name AS product_name,
    MAX(sales.order_date) AS order_date
FROM sales JOIN menu USING(product_id)
GROUP BY sales.customer_id,menu.product_name
ORDER BY MAX(sales.order_date)
),
membership_date AS (
SELECT join_date, customer_id
FROM members
)

SELECT 
    fdoo.customer_id,
    fdoo.product_name,
    fdoo.order_date
FROM first_date_of_order AS fdoo JOIN membership_date AS md USING(customer_id)
WHERE fdoo.order_date < md.join_date;

-- Query by Noah Oyugi --