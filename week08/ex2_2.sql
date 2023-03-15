SELECT store.store_id, SUM(payment.amount) 
FROM store
	LEFT JOIN payment ON store.manager_staff_id = payment.staff_id
WHERE payment.payment_date >= 
	DATE_TRUNC(
		'month', 
		(
			SELECT MAX(payment_date) 
			FROM payment)
		)
GROUP BY store.store_id 
ORDER BY SUM(payment.amount) DESC;

EXPLAIN ANALYSE SELECT store.store_id, SUM(payment.amount) 
FROM store
	LEFT JOIN payment ON store.manager_staff_id = payment.staff_id
WHERE payment.payment_date >= 
	DATE_TRUNC(
		'month', 
		(
			SELECT MAX(payment_date) 
			FROM payment)
		)
GROUP BY store.store_id 
ORDER BY SUM(payment.amount) DESC;

-- Query's most expensive step:
-- WHERE comparison: 
-- 					WHERE payment.payment_date >= 
--						DATE_TRUNC(
--							'month', 
--							(
--								SELECT MAX(payment_date) 
--								FROM payment)
--							)
               
-- Solution: create index payment_date