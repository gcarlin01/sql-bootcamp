-- TIME - contains only time (hours, minutes and seconds)
-- DATE - contains only the dates
-- TIMESTAMP - contains date and time 
-- TIMESTAMPTZ - contains date, time and timezone


SHOW ALL                  -- runtime parameters

SHOW TIMEZONE             -- shows my timezone

SELECT NOW()              -- returns timestamp with timezone

SELECT TIMEOFDAY()        -- returns same info as NOW() but as string 

SELECT CURRENT_TIME       -- returns current time with timezone 

SELECT CURRENT_DATE       -- returns current date 


SELECT EXTRACT(YEAR FROM payment_date)
AS myyear
FROM payment                            -- EXTRACT extracts a sub-component of a date value. We can extract YEAR, MONTH, QUARTER, ETC..


SELECT AGE(payment_date)
FROM payment                            -- AGE returns how old a date is.


SELECT TO_CHAR(payment_date, 'MONTH-YYY')
FROM payment                               -- TO_CHAR() is a general function to convert data types to text.
                                           -- Patterns of output must be inculded, for more info:  https://www.postgresql.org/docs/12/functions-formatting-html  


-- Challenge Questions:

-- 1. During which months did payments occur? Format your answer to return back the full month name

SELECT DISTINCT(TO_CHAR(payment_date, 'MONTH'))
FROM payment

-- 2. How many payments ocurred on a Monday?

SELECT COUNT(*)
FROM payment
WHERE TO_CHAR(payment_date, 'D') = '2'

-- or 

Select COUNT(*)
FROM payment 
WHERE EXTRACT(dow FROM payment_date) = 1


-- For mathematical functions refer to:  https://www.postgresql.org/docs/12/functions-math.html

SELECT ROUND(rental_rate/replacement_cost, 4)*100
AS percent_cost
FROM film                       -- Gettting the percentage of the rental_rate on regards of the film replacement_cost.


-- For string functions and operators refer to:  https://www.postgresql.org/docs/12/functions-string.html

SELECT LENGTH(first_name)
FROM customer;                -- self-explanatory..


SELECT first_name || ' ' || upper(last_name)
AS full_name
FROM customer                 --  String concatination setting las_name in upper case


-- creating custom emails:

SELECT LOWER(LEFT(first_name, 1)) || LOWER(last_name) || '@mycompany.com'
AS custom_email
FROM customer;                -- output= "jely@mycompany.com""msmith@mycompany.com"


-- Sub-querying:

SELECT student, grade
FROM test_scores
WHERE garde > (SELECT AVG(grade)
FROM test_scores)               -- How can we get a list of students who scored better than the average grade?
                            

SELECT title, rental_rate
FROM film
WHERE rental_rate >
(SELECT AVG(rental_rate) FROM film)


SELECT student, grade
FROM test_scores
WHERE student IN(SELECT student
FROM honor_roll_table)              -- IN can be used here in sort of join functionality for multiple results


SELECT film_id, title
FROM film
WHERE film_id IN
(SELECT inventory.film_id
FROM rental
INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30')

SELECT column_name
FROM table_name
WHERE EXISTS 
(SELECT column_name 
FROM table_name
WHERE condition)                    -- EXISTS used in subquery which expects a true validation
                                    -- NOT EXISTS same but expects a false validation 

SELECT first_name, last_name
FROM customer AS c
WHERE EXISTS                        -- NOT EXISTS 
(SELECT * FROM payment AS p
WHERE p.customer_id = c.customer_id
AND amount > 11)
        
Self-Join: 
SELECT f1.title, f2.title, f1.length
FROM film AS f1
INNER JOIN film AS f2 
ON f1.film_id != f2.film_id
AND f1.length = f2.length         -- creates a join to itslef, must add allias AS to differentiate
