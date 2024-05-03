/*
Recurrence of common complaints among reviews of tech products.

The table `order_items` references the tables `order_reviews` and `products`.
Reviews based on tech sellers are determined by the `product_categoriy_name_translation` related to the `products`.
The individual review topics are aggregated across the review scores for each topic.
The topics are determined by commonly used phrases or words in the review titles and/or review messages.

*/

USE magist;

SELECT
	review_score,
    count(distinct p0.order_id) as `total`,
	count(distinct p1.order_id) as `delivery_related`,
    count(distinct p2.order_id) as `delayed`,
    count(distinct p3.order_id) as `not_delivered`,
    count(distinct p4.order_id) as `communication`,
    count(distinct p5.order_id) as `order_accuracy`,
    count(distinct p6.order_id) as `cancelation_and_refund`,
    count(distinct p7.order_id) as `product_quality`
FROM
	order_items
LEFT JOIN
    products USING (product_id)
LEFT JOIN
    product_category_name_translation USING (product_category_name)
LEFT JOIN
	order_reviews using(order_id)
    
/*
All reviews that contain any of the topics
*/
LEFT JOIN
	(SELECT review_score, order_id FROM order_reviews WHERE
		-- DELAYED
		review_comment_title LIKE '%demora%'
		OR review_comment_title LIKE '%demora na entrega%'
		OR review_comment_title LIKE '%entrega atrasada%'
		OR
		review_comment_message LIKE '%demora%'
		OR review_comment_message LIKE '%demora na entrega%'
		OR review_comment_message LIKE '%entrega atrasada%'

		-- NON-DELIVERED
		OR
		review_comment_title LIKE '%n_o entregue%'
		OR review_comment_title LIKE '%produto n_o entregue%'
		OR review_comment_title LIKE '%entrega n_o realizada%'
		OR review_comment_title LIKE '%ainda n_o recebi%'
		OR
		review_comment_message LIKE '%n_o entregue%'
		OR review_comment_message LIKE '%produto n_o entregue%'
		OR review_comment_message LIKE '%entrega n_o realizada%'
		OR review_comment_message LIKE '%ainda n_o recebi%'

		-- BAD COMMUNICATION
		OR
		review_comment_title LIKE '%falta de comunica__o%'
		OR review_comment_title LIKE '%n_o respondem%'
		OR review_comment_title LIKE '%dif_cil de contatar%'
		OR review_comment_title LIKE '%sem resposta%'
		OR review_comment_title LIKE '%n_o retornam contatos%'
		OR review_comment_title LIKE '%n_o atendem%'
		OR review_comment_title LIKE '%dif_cil de entrar em contato%'
		OR review_comment_title LIKE '%falta de suporte%'
		OR review_comment_title LIKE '%atendimento ruim%'
		OR review_comment_title LIKE '%n_o respondem%'
		OR review_comment_title LIKE '%dif_cil de contatar%'
		OR review_comment_title LIKE '%falta de suporte%'
		OR review_comment_title LIKE '%n_o atendem%'
		OR
		review_comment_message LIKE '%falta de comunica__o%'
		OR review_comment_message LIKE '%n_o respondem%'
		OR review_comment_message LIKE '%dif_cil de contatar%'
		OR review_comment_message LIKE '%sem resposta%'
		OR review_comment_message LIKE '%n_o retornam contatos%'
		OR review_comment_message LIKE '%n_o atendem%'
		OR review_comment_message LIKE '%dif_cil de entrar em contato%'
		OR review_comment_message LIKE '%falta de suporte%'
		OR review_comment_message LIKE '%atendimento ruim%'
		OR review_comment_message LIKE '%n_o respondem%'
		OR review_comment_message LIKE '%dif_cil de contatar%'
		OR review_comment_message LIKE '%falta de suporte%'
		OR review_comment_message LIKE '%n_o atendem%'

		-- ORDER ACCURACY
		OR
		review_comment_title LIKE '%produto errado%'
		OR review_comment_title LIKE '%pedido incompleto%'
		OR review_comment_title LIKE '%pedido veio quebrado%'
		OR review_comment_title LIKE '%pedido n_o veio correto%'
		OR review_comment_title LIKE '%produto veio diferente%'
		OR
		review_comment_message LIKE '%produto errado%'
		OR review_comment_message LIKE '%pedido incompleto%'
		OR review_comment_message LIKE '%pedido veio quebrado%'
		OR review_comment_message LIKE '%pedido n_o veio correto%'
		OR review_comment_message LIKE '%produto veio diferente%'

		-- CANCELATION AND REFUND
		OR
		review_comment_title LIKE '%cancelamento n_o efetuado%'
		OR review_comment_title LIKE '%quero devolver o produto%'
		OR review_comment_title LIKE '%devolu__o solicitada%'
		OR review_comment_title LIKE '%estorno n_o realizado%'
		OR review_comment_title LIKE '%n_o recebi meu dinheiro de volta%'
		OR
		review_comment_message LIKE '%cancelamento n_o efetuado%'
		OR review_comment_message LIKE '%quero devolver o produto%'
		OR review_comment_message LIKE '%devolu__o solicitada%'
		OR review_comment_message LIKE '%estorno n_o realizado%'
		OR review_comment_message LIKE '%n_o recebi meu dinheiro de volta%'

		-- PRODUCT QUALITY
		OR
		review_comment_title LIKE '%produto com defeito%'
		OR review_comment_title LIKE '%produto quebrado%'
		OR review_comment_title LIKE '%produto divergente%'
		OR review_comment_title LIKE '%qualidade ruim%'
		OR review_comment_title LIKE '%produto não funciona%'
		OR
		review_comment_message LIKE '%produto com defeito%'
		OR review_comment_message LIKE '%produto quebrado%'
		OR review_comment_message LIKE '%produto divergente%'
		OR review_comment_message LIKE '%qualidade ruim%'
		OR review_comment_message LIKE '%produto não funciona%'
    ) p0 USING (order_id, review_score)

/*
Delivery related reviews
*/
LEFT JOIN
	(SELECT review_score, order_id FROM order_reviews WHERE
		-- DELAYED
		review_comment_title LIKE '%demora%'
		OR review_comment_title LIKE '%demora na entrega%'
		OR review_comment_title LIKE '%entrega atrasada%'
		OR
		review_comment_message LIKE '%demora%'
		OR review_comment_message LIKE '%demora na entrega%'
		OR review_comment_message LIKE '%entrega atrasada%'

		-- NON-DELIVERED
		OR
		review_comment_title LIKE '%n_o entregue%'
		OR review_comment_title LIKE '%produto n_o entregue%'
		OR review_comment_title LIKE '%entrega n_o realizada%'
		OR review_comment_title LIKE '%ainda n_o recebi%'
		OR
		review_comment_message LIKE '%n_o entregue%'
		OR review_comment_message LIKE '%produto n_o entregue%'
		OR review_comment_message LIKE '%entrega n_o realizada%'
		OR review_comment_message LIKE '%ainda n_o recebi%'
	) p1 USING (order_id, review_score)

/*
Reviews complaining about delays
*/
LEFT JOIN
	(SELECT review_score, order_id FROM order_reviews WHERE
		-- DELAYED
		review_comment_title LIKE '%demora%'
		OR review_comment_title LIKE '%demora na entrega%'
		OR review_comment_title LIKE '%entrega atrasada%'
		OR
		review_comment_message LIKE '%demora%'
		OR review_comment_message LIKE '%demora na entrega%'
		OR review_comment_message LIKE '%entrega atrasada%'
	) p2 USING (order_id, review_score)
    
/*
Reviews complaining about non-deliveries
*/
LEFT JOIN
    (SELECT review_score, order_id FROM order_reviews WHERE
		-- NON-DELIVERED
		review_comment_title LIKE '%n_o entregue%'
		OR review_comment_title LIKE '%produto n_o entregue%'
		OR review_comment_title LIKE '%entrega n_o realizada%'
		OR review_comment_title LIKE '%ainda n_o recebi%'
		OR
		review_comment_message LIKE '%n_o entregue%'
		OR review_comment_message LIKE '%produto n_o entregue%'
		OR review_comment_message LIKE '%entrega n_o realizada%'
		OR review_comment_message LIKE '%ainda n_o recebi%'
	) p3 USING (order_id, review_score)
    
/*
Reviews complaining about bad communication and customer service
*/
LEFT JOIN
    (SELECT review_score, order_id FROM order_reviews WHERE
		-- BAD COMMUNICATION
		review_comment_title LIKE '%falta de comunica__o%'
		OR review_comment_title LIKE '%n_o respondem%'
		OR review_comment_title LIKE '%dif_cil de contatar%'
		OR review_comment_title LIKE '%sem resposta%'
		OR review_comment_title LIKE '%n_o retornam contatos%'
		OR review_comment_title LIKE '%n_o atendem%'
		OR review_comment_title LIKE '%dif_cil de entrar em contato%'
		OR review_comment_title LIKE '%falta de suporte%'
		OR review_comment_title LIKE '%atendimento ruim%'
		OR review_comment_title LIKE '%n_o respondem%'
		OR review_comment_title LIKE '%dif_cil de contatar%'
		OR review_comment_title LIKE '%falta de suporte%'
		OR review_comment_title LIKE '%n_o atendem%'
		OR
		review_comment_message LIKE '%falta de comunica__o%'
		OR review_comment_message LIKE '%n_o respondem%'
		OR review_comment_message LIKE '%dif_cil de contatar%'
		OR review_comment_message LIKE '%sem resposta%'
		OR review_comment_message LIKE '%n_o retornam contatos%'
		OR review_comment_message LIKE '%n_o atendem%'
		OR review_comment_message LIKE '%dif_cil de entrar em contato%'
		OR review_comment_message LIKE '%falta de suporte%'
		OR review_comment_message LIKE '%atendimento ruim%'
		OR review_comment_message LIKE '%n_o respondem%'
		OR review_comment_message LIKE '%dif_cil de contatar%'
		OR review_comment_message LIKE '%falta de suporte%'
		OR review_comment_message LIKE '%n_o atendem%'
	) p4 USING (order_id, review_score)
    
/*
Reviews complaining about incorrect orders or quantity
*/
LEFT JOIN
    (SELECT review_score, order_id FROM order_reviews WHERE
		-- ORDER ACCURACY
		review_comment_title LIKE '%produto errado%'
		OR review_comment_title LIKE '%pedido incompleto%'
		OR review_comment_title LIKE '%pedido veio quebrado%'
		OR review_comment_title LIKE '%pedido n_o veio correto%'
		OR review_comment_title LIKE '%produto veio diferente%'
		OR
		review_comment_message LIKE '%produto errado%'
		OR review_comment_message LIKE '%pedido incompleto%'
		OR review_comment_message LIKE '%pedido veio quebrado%'
		OR review_comment_message LIKE '%pedido n_o veio correto%'
		OR review_comment_message LIKE '%produto veio diferente%'		
	) p5 USING (order_id, review_score)
    
/*
Reviews complaining about cancelation and refund issues
*/
LEFT JOIN
    (SELECT review_score, order_id FROM order_reviews WHERE
		-- CANCELATION AND REFUND
		review_comment_title LIKE '%cancelamento n_o efetuado%'
		OR review_comment_title LIKE '%quero devolver o produto%'
		OR review_comment_title LIKE '%devolu__o solicitada%'
		OR review_comment_title LIKE '%estorno n_o realizado%'
		OR review_comment_title LIKE '%n_o recebi meu dinheiro de volta%'
		OR
		review_comment_message LIKE '%cancelamento n_o efetuado%'
		OR review_comment_message LIKE '%quero devolver o produto%'
		OR review_comment_message LIKE '%devolu__o solicitada%'
		OR review_comment_message LIKE '%estorno n_o realizado%'
		OR review_comment_message LIKE '%n_o recebi meu dinheiro de volta%'
	) p6 USING (order_id, review_score)
    
/*
Reviews complaining about bad product quality
*/
LEFT JOIN
    (SELECT review_score, order_id FROM order_reviews WHERE
		-- PRODUCT QUALITY
		review_comment_title LIKE '%produto com defeito%'
		OR review_comment_title LIKE '%produto quebrado%'
		OR review_comment_title LIKE '%produto divergente%'
		OR review_comment_title LIKE '%qualidade ruim%'
		OR review_comment_title LIKE '%produto não funciona%'
		OR
		review_comment_message LIKE '%produto com defeito%'
		OR review_comment_message LIKE '%produto quebrado%'
		OR review_comment_message LIKE '%produto divergente%'
		OR review_comment_message LIKE '%qualidade ruim%'
		OR review_comment_message LIKE '%produto não funciona%'
	) p7 USING (order_id, review_score)

/*
General where clauses
*/
WHERE
-- Exclude invalid reviews (no score)
	review_score IS NOT NULL
AND
-- Only within the tech products
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

/*
Grouping by score
*/
GROUP BY review_score
ORDER BY review_score;
