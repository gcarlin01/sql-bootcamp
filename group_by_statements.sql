-- Most Common Aggregate Functions: // Aggregate function calls happen only in the SELECT or HAVING clause.
-- - AVG() = average returns a floating point value with many decimal places, might be best to use with ROUND() to specify precision after the decimal
-- - COUNT()
-- - MAX()
-- - MIN()
-- - SUM()


SELECT MIN(replacement_cost) FROM film;      -- Minimum replacement cost for a film, MIN and MAX only returns a single value

SELECT MAX(replacement_cost), MIN(replacement_cost)
FROM film;                                                -- This will come back as two values MIN and MAX 

SELECT ROUND(AVG(replacement_cost), 2)
FROM film;                                          -- AVG of replacement_cost rounded up to 2 decimal 

SELECT SUM(replacement_cost)
FROM film;                                      -- SUM of replacement_cost

SELECT customer_id,SUM(amount)
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 5;                                    -- What are the top 5 customer ids that are expending the most amount of money

SELECT DATE(payment_date),SUM(amount)
FROM payment
GROUP BY DATE(payment_date)
ORDER BY SUM(amount) DESC;                  -- DATE function returns the day for any timestamp (sec,min,hrs). What specific dates did we collect the most payment amounts


-- Challenge Questions:

-- 1. How many payments did each staff member handle and who gets the bonus?

SELECT staff_id,COUNT(amount)
FROM payment
GROUP BY staff_id
ORDER BY COUNT(amount)DESC

-- 2. What is the average replacement cost per MPAA rating?

SELECT rating, ROUND(AVG(replacement_cost), 2) 
FROM film
GROUP BY rating;

-- 3. What are the customer ids of the top 5 customers by total spend?

SELECT customer_id, SUM(amount) 
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 5;


SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100;               -- Using HAVING which comes after GROUP BY since WHERE comes before the GROUP BY and could not be used with SUM(amount) 


-- Challenge Questions: 

-- 1. What customer_ids are elegible for platinum status(40 or more transaction payments)?

SELECT customer_id, COUNT(amount)
FROM payment
GROUP BY customer_id
HAVING COUNT(amount) >= 40;

-- 2. What are the customer_ids of customers who have spent more than $100 in payment transactions with our staff_id member 2?

SELECT customer_id, SUM(amount)
FROM payment
WHERE staff_id = 2
GROUP BY customer_id
HAVING SUM(amount) > 100;
