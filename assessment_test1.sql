-- Assessment test:

-- 1. Return the customer_ids of customers who have spent at least $110 with the staff member who has an id of 2?
-- 2. How many films begin with the letter J?
-- 3. What customer has the highest customer Id number whise name starts with an E and has an address Id lower than 500?

-- My answers: 
-- 1.
SELECT customer_id, SUM(amount)
FROM payment
WHERE staff_id = 2
GROUP BY customer_id
HAVING SUM(amount) >= 110;

-- 2. 
SELECT COUNT(title) FROM film
WHERE title LIKE 'J%';

-- 3. 
SELECT first_name, last_name FROM customer
WHERE first_name LIKE 'E%' AND address_id < 500
ORDER BY customer_id DESC
LIMIT 1;
