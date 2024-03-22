SELECT SUM(amount) AS net_revenue
FROM payment;                              -- set a new name (net_revenue) for your column. the AS statement can only be present in the SELECT  


SELECT payment_id, payment.customer_id, first_name 
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id; -- Inner Join joins both tables and returns whatever you select based on mutual customer_id in this case.


SELECT * FROM customer
FULL OUTER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE customer.customer_id IS null 
OR payment.customer_id IS null;             -- Outer Join joins everything but when used with WHERE and setting the parallel values to null throws the not common elements of the join


SELECT film.film_id, title, inventory_id
FROM film  
LEFT OUTER JOIN inventory 
ON inventory.film_id = film.film_id
WHERE inventory.film_id IS null;           -- LEFT OUTER JOIN or LEFT JOIN when used with when and setting table b column value to null gives you only the value for table a that is NOT in table b 


SELECT film.film_id, title, inventory_id
FROM film  
RIGHT OUTER JOIN inventory 
ON inventory.film_id = film.film_id
WHERE film.film_id IS null;                 -- Same concept as LEFT OUTER JOIN


SELECT * FROM Sales2021_Q1
UNION
SELECT * FROM Sales2021_Q2                 -- Union joins two tables together


-- Challenge Questions:

-- 1. What are the emails of the customers who live in California?

SELECT email FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE address.district = 'California';

-- 2. Get a list of all movies "Nick Wahlberg" has been in.

SELECT title, actor.first_name, actor.last_name FROM film
INNER JOIN film_actor ON film.film_id = film_actor.film_id
INNER JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE actor.first_name = 'Nick' AND actor.last_name = 'Wahlberg'
