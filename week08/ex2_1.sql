SELECT film.film_id, film.title 
FROM film
	LEFT JOIN inventory ON     film.film_id = inventory.film_id
	LEFT JOIN rental ON        inventory.inventory_id = rental.inventory_id
	LEFT JOIN film_category ON film.film_id = film_category.film_id
	LEFT JOIN category ON      film_category.category_id = category.category_id
WHERE (film.rating = 'R' or film.rating = 'PG-13')
	AND (category.name = 'Horror' or category.name = 'Sci-fi')
GROUP BY film.film_id
HAVING COUNT(rental.rental_id) = 0
ORDER BY film.film_id;

EXPLAIN ANALYSE SELECT film.film_id, film.title 
FROM film
	LEFT JOIN inventory ON     film.film_id = inventory.film_id
	LEFT JOIN rental ON        inventory.inventory_id = rental.inventory_id
	LEFT JOIN film_category ON film.film_id = film_category.film_id
	LEFT JOIN category ON      film_category.category_id = category.category_id
WHERE (film.rating = 'R' or film.rating = 'PG-13')
	AND (category.name = 'Horror' OR category.name = 'Sci-fi')
GROUP BY film.film_id
HAVING COUNT(rental.rental_id) = 0
ORDER BY film.film_id;

-- Query's most expensive steps: joining the inventory, joining the film category
-- Solution: create index film_id, create index category_id
