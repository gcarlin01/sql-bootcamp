-- CASE: statement triggered when only certain condition is met (like if/else).
-- There are GENERAL CASE statements and CASE EXPRESSIONS

-- 1. GENERAL CASE statement syntax:

CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ELSE some_othe_result
END
 
-- Example:
 
SELECT a,
CASE WHEN a = 1 THEN 'one'
     WHEN a = 2 THEN 'two'
ELSE 'other' AS label
END 
FROM test;


-- 2. CASE expression  syntax: first evaluates an expression, then compares the result with each value in the WHEN caluses sequentially

CASE expression
    WHEN value1 THEN result1
    WHEN value2 THEN result2
    ELSE some_other-result
END

-- Example:

SELECT a,
    CASE a WHEN 1 THEN 'one',
           WHEN 2 THEN 'two'
           ELSE 'other'
    END 
FROM test;



-- Examples of both:

SELECT customer_id,
CASE 
	WHEN (customer_id <= 100) THEN 'Premium'
	WHEN (customer_id BETWEEN 100 and 200) THEN 'Plus' 
	ELSE 'Normal'
END AS customer_class
FROM customer


SELECT customer_id,
CASE customer_id
	WHEN 2 THEN 'Winner'
	WHEN 5 THEN 'Second Place'
	ELSE 'Not a winner'
END AS raffle_results
FROM customer


SELECT 
SUM(CASE rental_rate 
	 WHEN 0.99 THEN 1
	 ELSE 0
END) AS number_of_bargains
FROM film


SELECT 
SUM(CASE rental_rate 
	 WHEN 0.99 THEN 1
	 ELSE 0
END) AS bargains,
SUM(CASE rental_rate 
	 WHEN 2.99 THEN 1
	 ELSE 0
END) AS regular,
SUM(CASE rental_rate 
	 WHEN 4.99 THEN 1
	 ELSE 0
END) AS premium
FROM film


-- Challenge question:

-- 1. Use Case to re-create this table?

SELECT 
SUM(CASE rating
	WHEN 'R' THEN 1
	ELSE 0
END) AS r,
SUM(CASE rating
	WHEN 'PG' THEN 1
	ELSE 0
END) AS pg,
SUM(CASE rating
	WHEN 'PG-13' THEN 1
	ELSE 0
END) AS pg13
FROM film



-- COALESCE funtion: becomes useful when querying a table that contains null values, since this funtcion when given arguments it returns the first non null value.

-- COALESCE Syntax:

SELECT item, (price - COALESCE(discount, 0))
AS final
FROM table                        --  COALESCE first check the discount values and return the non null values, if there is a null value it returns 0 (second argument)



-- CAST operator: converts one data type into another, not every data type can be CAST 

-- CAST Syntax: 

SELECT CAST('5' AS INTEGER)         -- Postrgresql cast opertor can be: SELECT '5'::INTEGER

-- example:

SELECT CAST('5' AS INTEGER) AS new_int

SELECT CHAR_LENGTH(CAST(inventory_id AS VARCHAR))
FROM rental


-- NULLIF function: takes 2 inputs and returns NULL if both are equal, otherwise it returns the first argument passsed

-- NULLIF Syntax:

NULLIF(10, 10)        -- it would return NULL

NULL(10, 12)          -- it would return 10

-- Example: 

SELECT (
SUM(CASE WHEN department = 'A' THEN 1
   		 ELSE 0
END) /
NULLIF(SUM(CASE WHEN department = 'B' THEN 1                 -- Here there are no 'B' and returns NULL
   		 ELSE 0
END), 0)

) AS department_ratio
FROM depts


-- VIEW: database object that is of a stored query, it does not store data, simply stores the query.

-- Example: 
CREATE VIEW customer_info AS
SELECT first_name, last_name, address FROM customer
INNER JOIN address
ON customer.address_id = address.address_id

-- adding data to view:
CREATE OR REPLACE VIEW customer_info AS
SELECT first_name, last_name, address, district FROM customer
INNER JOIN address
ON customer.address_id = address.address_id

-- remove a view:
DROP VIEW IF EXISTS customer_info

-- changing name of the view:
ALTER VIEW customer_info RENAME TO c_info


-- IMPORT/EXPORT 

-- mostyly for CSV import
-- The IMPORT command does not provide tables.
-- Best way is to create the tables manually matching the column names and then import your csv 