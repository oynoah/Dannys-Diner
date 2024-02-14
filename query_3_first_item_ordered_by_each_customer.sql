/* What was the first item from the menu purchased by each customer */
SELECT DISTINCT sales.customer_id, 
       menu.product_name
FROM sales JOIN menu USING(product_id)
WHERE sales.order_date = (SELECT MIN(sales.order_date)
                          FROM sales);

-- Query by Noah Oyugi --