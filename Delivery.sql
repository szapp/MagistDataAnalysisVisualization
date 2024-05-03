/*
Delivery time of tech orders

The tables `order_items`, and `orders` contain the estimated and actual times of delivery and reference the table `products`.
Tech orders are determined by the `product_categoriy_name_translation` related to the `products`.

*/

USE magist;

SELECT
	YEAR(order_estimated_delivery_date) AS `year`,
	SUM(order_delivered_customer_date < order_estimated_delivery_date) / COUNT(order_id) AS `delivered_on_time`,
    SUM(order_delivered_customer_date >= order_estimated_delivery_date) / COUNT(order_id) AS `delivery_delayed`,
    SUM(order_delivered_customer_date IS NULL OR order_estimated_delivery_date IS NULL) / COUNT(order_id) AS `unknown`
FROM
	order_items
		LEFT JOIN
	orders USING (order_id)
		LEFT JOIN
	products USING (product_id)
		LEFT JOIN
    product_category_name_translation USING (product_category_name)
WHERE
	order_status IN ('delivered', 'shipped')
AND
	YEAR(order_estimated_delivery_date) IN ('2017' , '2018')
AND
	product_category_name_english IN (
		'audio' ,
        'computers',
        'computers_accessories',
        'consoles_games',
        'electronics',
        'fixed_telephony',
        'pc_gamer',
        'signaling_and_security',
        'tablets_printing_image',
        'telephony',
        'watches_gifts'
)
GROUP BY `year`
ORDER BY `year`;
