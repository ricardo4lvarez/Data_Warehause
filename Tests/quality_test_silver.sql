/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy, 
    and standardization across the 'silver' layer. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.
*/

------------------------------------------------ Table 1 ------------------------------------------------
-- Check for duplicates and/or null values in primary key
SELECT
	actor_id,
	COUNT(actor_id)
FROM bronze.actor
	GROUP BY actor_id
	HAVING COUNT(actor_id) > 1;

-- Making sure there are no blank spaces in the names
SELECT
	first_name
FROM bronze.actor
	WHERE first_name != TRIM(first_name);

-- Verify and handle missing values
SELECT
	*
FROM bronze.actor
	WHERE actor_id IS NULL
		OR first_name IS NULL
		OR last_name IS NULL
		OR last_update IS NULL;

SELECT
	actor_id,
	CONCAT(UPPER(LEFT(first_name,1)), LOWER(RIGHT(first_name, LEN(first_name)-1))) AS first_name,
	CONCAT(UPPER(LEFT(last_name,1)), LOWER(RIGHT(last_name, LEN(last_name)-1))) AS last_name,
	last_update
FROM bronze.actor;

------------------------------------------------ Table 2 ------------------------------------------------
-- Check for duplicates and/or null values in primary key
SELECT
	address_id,
	COUNT(address_id)
FROM bronze.address
	GROUP BY address_id
	HAVING COUNT(address_id) > 1;

-- Check for blanck spaces
SELECT address FROM bronze.address
	WHERE address != TRIM(address);

-- Drop adress2 and get rid of decimal points in postal_code and phone
SELECT
	address_id,
	address,
	COALESCE(district, 'n/a'),
	city_id,
	COALESCE(REPLACE(postal_code,'.0',''), 'n/a') AS postal_code,
	COALESCE(REPLACE(phone,'.0',''), 'n/a') AS phone,
	last_update
FROM bronze.address;

------------------------------------------------ Table 3 ------------------------------------------------
-- Making sure there are no blank spaces in the names
SELECT name FROM bronze.category
	WHERE name != TRIM(name);
/* CONCLUSION: No transformations required*/

------------------------------------------------ Table 4 ------------------------------------------------
-- Check for duplicates and/or null values in primary key
SELECT city_id, COUNT(city_id) FROM bronze.city
	GROUP BY city_id
	HAVING COUNT(city_id) > 1;

-- Check for blanck spaces
SELECT city FROM bronze.city
	WHERE city != TRIM(city);

-- Check for null values
SELECT * FROM bronze.city
	WHERE city_id IS NULL
		OR city IS NULL
		OR country_id IS NULL
		OR last_update IS NULL;
/* CONCLUSION: No transformations required*/

------------------------------------------------ Table 5 ------------------------------------------------
-- Check for missing values
SELECT country FROM bronze.country
	WHERE country != TRIM(country);

-- Check for null values
SELECT * FROM bronze.country
	WHERE country_id IS NULL
		OR country IS NULL
		OR last_update IS NULL;

-- Checking for duplicates
SELECT country_id, COUNT(country_id) FROM bronze.country
	GROUP BY country_id
	HAVING COUNT(country_id) > 1;
/* CONCLUSION: No transformations required*/

------------------------------------------------ Table 6 ------------------------------------------------
-- Check for duplicates and/or null values in primary key
SELECT 
	customer_id, 
	COUNT(customer_id) 
FROM bronze.customer
	GROUP BY customer_id
	HAVING COUNT(customer_id) > 1;

-- Making sure there are no blank spaces in the names
SELECT
	first_name,
	last_name,
	email
FROM bronze.customer
	WHERE first_name != TRIM(first_name)
		OR last_name != TRIM(last_name)
		OR email != TRIM(email);
-- Format first and last name, and email; also changing bool format.
SELECT
	customer_id,
	store_id,
	CONCAT(LEFT(first_name, 1), LOWER(RIGHT(first_name, LEN(first_name)-1))) AS first_name,
	CONCAT(LEFT(last_name, 1), LOWER(RIGHT(last_name, LEN(last_name)-1))) AS last_name,
	LOWER(email) AS email,
	address_id,
	activebool,
	create_date,
	last_update,
	CASE
		WHEN active = 1 THEN 'True'
		WHEN active = 0 THEN 'False'
	END AS active
FROM bronze.customer;

SELECT * FROM silver.customer;
------------------------------------------------ Table 7 ------------------------------------------------

-- Replace and get rid of some characters for better understanding.
SELECT
	film_id,
	title,
	description,
	release_year,
	language_id,
	rental_duration,
	rental_rate,
	length_,
	replacement_cost,
	rating,
	REPLACE(REPLACE(REPLACE(REPLACE(special_features, '"', ''), ';', ', '), '{', ''), '}','') AS special_features,
	full_text,
	last_update
FROM bronze.film;

------------------------------------------------ Table 8 ------------------------------------------------
SELECT
	actor_id,
	film_id,
	last_update
FROM bronze.film_actor;
/* CONCLUSION: No transformations required*/

------------------------------------------------ Table 9 ------------------------------------------------

SELECT
	film_id,
	category_id,
	last_update
FROM bronze.film_category;
/* CONCLUSION: No transformations required*/

------------------------------------------------ Table 10 ------------------------------------------------

SELECT
	inventory_id,
	film_id,
	store_id,
	last_update
FROM bronze.inventory;
/* CONCLUSION: No transformations required*/

------------------------------------------------ Table 11 ------------------------------------------------
SELECT
	language_id,
	name,
	last_update
FROM bronze.language;
/* CONCLUSION: No transformations required*/

------------------------------------------------ Table 12 ------------------------------------------------
-- Okay, rental_id is getting duplicates; while analizing the structure I noticed both rental and payment "customer_id" must be the same, otherwise they will be removed.
SELECT 
	bp.payment_id,
	bp.customer_id,
	bp.staff_id,
	bp.rental_id,
	bp.amount,
	bp.payment_date
FROM bronze.payment bp
LEFT JOIN bronze.rental br
ON bp.rental_id = br.rental_id
	WHERE bp.customer_id = br.customer_id;

------------------------------------------------ Table 13 ------------------------------------------------

SELECT
	rental_id,
	rental_date,
	inventory_id,
	customer_id,
	return_date,
	staff_id,
	last_update
FROM bronze.rental;
/* CONCLUSION: No transformations required*/

------------------------------------------------ Table 14 ------------------------------------------------

-- Treat null values
SELECT
	staff_id,
	first_name,
	last_name,
	address_id,
	LOWER(email),
	store_id,
	active,
	username,
	password,
	last_update,
	COALESCE(picture, 'n/a')
FROM bronze.staff;

------------------------------------------------ Table 15 ------------------------------------------------

SELECT
	store_id,
	manager_staff_id,
	address_id,
	last_update
FROM bronze.store;
/* CONCLUSION: No transformations required*/
