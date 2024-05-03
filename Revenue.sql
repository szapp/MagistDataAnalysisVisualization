/*
Average monthly revenue of Magist's tech sellers between April 2017 and April 2018.

The tables `order_items`, and `orders` contain the times of purchase and reference the table `products`.
Tech sellers are determined by the `product_categoriy_name_translation` related to the `products`.
The price of the `products` is aggregated with a sum and grouped for years and months.

*/

USE magist;

SELECT 
    ROUND(SUM(price), 2) AS `revenue`,
    MONTH(order_purchase_timestamp) AS `month`,
    YEAR(order_purchase_timestamp) AS `year`,
    1170000 as `eniac_average`
FROM
    order_items
        JOIN
    products USING (product_id)
        JOIN
    orders USING (order_id)
        JOIN
    product_category_name_translation USING (product_category_name)
WHERE
    order_purchase_timestamp BETWEEN '2017-04-01' AND '2018-04-01'
        AND product_category_name_english IN ('audio' , 'consoles_games',
        'electronics',
        'computers_accessories',
        'computers',
        'signaling_and_security',
        'tablets_printing_image',
        'telephony')
GROUP BY `year` , `month`
ORDER BY `year` , `month`;
