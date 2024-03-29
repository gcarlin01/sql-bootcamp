SELECT * FROM film;	       -- Selects all columns from film table

SELECT * FROM actor;	   -- selects all columns from actor table

SELECT last_name, first_name FROM actor;    -- selects last_name and first_name columns from actor table

SELECT first_name, last_name, email FROM customer;    -- selects last_name, first_name and email columns from customer table

SELECT DISTINCT (release_year) FROM film;    -- selects non-repetitive/unique  release_year  columns from film table //** DISTINCT can be used with or without ()

SELECT release_year FROM film;     -- selects release_year column from film table

SELECT DISTINCT rental_rate FROM film;

SELECT COUNT (rating) FROM film;      -- COUNT is a function that must be used with () and counts the number of rows of desired column

SELECT COUNT (DISTINCT rating) FROM film;     -- COUNT can be used with DISTINCT 

SELECT COUNT(*) FROM payment;     -- it is very common to see the COUNT with the * since it would throw the same number of rows as the other columns

SELECT * FROM film 
WHERE language_id = '1' AND title = 'Agent Truman';     -- WHERE must come right after from, must include single quote and exact name it can be used with AND, OR, and !(for not)		
														
SELECT * FROM customer
ORDER BY store_id, first_name ASC;     -- ASC ascending or just leave blank, DESC descending order, also you can pass multiple columns to order by

SELECT * FROM payment
WHERE amount != 0.00
ORDER BY payment_date DESC	    
LIMIT 5;                            -- gets 5 latest payments using DESC (latest/recent) WHERE the payment was not $0 and LIMIT set to 5 

SELECT COUNT(*) FROM payment	   
WHERE amount BETWEEN 8 AND 9;       -- count of payment amount using BETWEEN and NOT BETWEEN


SELECT COUNT(*) FROM payment
WHERE payment_date BETWEEN '2007-02-01' AND '2007-02-15';      -- count of all payments done between Feb 1st and 15 (BETWEEN is exclusive, so no transactions 																	done on the 15 will show up,  in contrast NOT BETWEEN is Inclusive

SELECT COUNT(*) FROM payment
WHERE amount IN (0.99, 1.99, 1.98);      -- Instead of doing WHERE …AND …AND, just use IN for multiple WHERE statements, it can be used with NOT as well as NOT IN 

SELECT * FROM customer
WHERE first_name LIKE 'J%' AND last_name LIKE 'S%';      -- LIKE = case sensitive uses _ wildcard for any 1 letter and % for any number of letters and ILIKE does the 															same but is case unsensitive, % takes blank as well. LIKE and ILIKE also take the NOT operator 

-- Challenge Questions: 
-- 1. How many payment transactions were greater than $5.00?

SELECT COUNT(*) FROM payment
WHERE amount > 5.00;

-- 2. How many actors have a first name that starts with the letter P?

SELECT COUNT(*) FROM actor
WHERE first_name LIKE 'P%';

-- 3. How many unique districts are our customers from?

SELECT COUNT (DISTINCT(district)) FROM address;

-- 4. Retrieve the list of names fro those distinct districts from the previous question

SELECT DISTINCT(district) FROM address;

-- 5. How many films have a rating of R and a replacement cost between $5 and $15?

SELECT COUNT(*) FROM film
WHERE rating = 'R'
AND replacement_cost BETWEEN 5 AND 15;

-- 6. How many films have the word Truman somewhere in the title?

SELECT COUNT(*) FROM film
WHERE title LIKE '%Truman%';