------------------------------------------------ TABLA 1 ------------------------------------------------
-- Determina si hay datos nulos y/o repetidos en la llave primaria
SELECT
	actor_id,
	COUNT(actor_id)
FROM bronze.actor
	GROUP BY actor_id
	HAVING COUNT(actor_id) > 1;

-- Asegurarse que no haya nombres con espacios en blanco
SELECT
	first_name
FROM bronze.actor
	WHERE first_name != TRIM(first_name);

-- Verificar y manejar los valores nulos
SELECT
	*
FROM bronze.actor
	WHERE actor_id IS NULL
		OR first_name IS NULL
		OR last_name IS NULL
		OR last_update IS NULL;
/* CONCLUSIÓN: No se ocupan transformaciones*/

------------------------------------------------ TABLA 2 ------------------------------------------------
-- Determina si hay datos nulos y/o repetidos en la llave primaria
SELECT
	address_id,
	COUNT(address_id)
FROM bronze.address
	GROUP BY address_id
	HAVING COUNT(address_id) > 1;

-- Tratar los espacios antes y después en la dirección
SELECT address FROM bronze.address
	WHERE address != TRIM(address);

-- Eliminar address2 y quitar los puntos decimales de postal_code y phone
SELECT
	address_id,
	address,
	district,
	city_id,
	REPLACE(postal_code,'.0','') AS postal_code,
	REPLACE(phone,'.0','') AS phone,
	last_update
FROM bronze.address;
/* CONCLUSIÓN:Se ocupan transformaciones*/
------------------------------------------------ TABLA 3 ------------------------------------------------
-- Revisar que no haya espacios en blanco en los nombres
SELECT name FROM bronze.category
	WHERE name != TRIM(name);
/* CONCLUSIÓN: No se ocupan transformaciones*/

------------------------------------------------ TABLA 4 ------------------------------------------------
-- Revisar que no haya PK_id repetidos
SELECT city_id, COUNT(city_id) FROM bronze.city
	GROUP BY city_id
	HAVING COUNT(city_id) > 1;

-- Comprobar por espacios en blanco
SELECT city FROM bronze.city
	WHERE city != TRIM(city);

-- Comprobar existencia de valores nulos
SELECT * FROM bronze.city
	WHERE city_id IS NULL
		OR city IS NULL
		OR country_id IS NULL
		OR last_update IS NULL;
/* CONCLUSIÓN: No se ocupan transformaciones*/

------------------------------------------------ TABLA 5 ------------------------------------------------
-- Revisar que no haya espacios en blanco
SELECT country FROM bronze.country
	WHERE country != TRIM(country);

-- Revisar por valores nulos
SELECT * FROM bronze.country
	WHERE country_id IS NULL
		OR country IS NULL
		OR last_update IS NULL;

-- Revisar si hay duplicados
SELECT country_id, COUNT(country_id) FROM bronze.country
	GROUP BY country_id
	HAVING COUNT(country_id) > 1;
/* CONCLUSIÓN: No se ocupan transformaciones*/

------------------------------------------------ TABLA 6 ------------------------------------------------
-- Revisar que no haya PK repetidas
SELECT 
	customer_id, 
	COUNT(customer_id) 
FROM bronze.customer
	GROUP BY customer_id
	HAVING COUNT(customer_id) > 1;

-- Revisar por espacios vacíos dentro de los nombres
SELECT
	first_name,
	last_name,
	email
FROM bronze.customer
	WHERE first_name != TRIM(first_name)
		OR last_name != TRIM(last_name)
		OR email != TRIM(email);
-- Dar formato a los nombes y al email, así como 
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
------------------------------------------------ TABLA 7 ------------------------------------------------

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

------------------------------------------------ TABLA 8 ------------------------------------------------
SELECT
	actor_id,
	film_id,
	last_update
FROM bronze.film_actor;

------------------------------------------------ TABLA 9 ------------------------------------------------

SELECT
	film_id,
	category_id,
	last_update
FROM bronze.film_category;

------------------------------------------------ TABLA 10 ------------------------------------------------

SELECT
	inventory_id,
	film_id,
	store_id,
	last_update
FROM bronze.inventory;

------------------------------------------------ TABLA 11 ------------------------------------------------
SELECT
	language_id,
	name,
	last_update
FROM bronze.language;

------------------------------------------------ TABLA 12 ------------------------------------------------
-- Okay, en este caso si hay repeticiones en el rental_id siendo que debería ser único; analizando la estructura de las tablas he podido observar que los "customer_id" coinciden en todos los casos (ya que debe ser el mismo cliente en ambos casos), por ello aquellos que no coincidan en ese campo serán desechados
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

------------------------------------------------ TABLA 13 ------------------------------------------------

SELECT
	rental_id,
	rental_date,
	inventory_id,
	customer_id,
	return_date,
	staff_id,
	last_update
FROM bronze.rental;

------------------------------------------------ TABLA 14 ------------------------------------------------

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
	picture
FROM bronze.staff;

------------------------------------------------ TABLA 14 ------------------------------------------------

SELECT
	store_id,
	manager_staff_id,
	address_id,
	last_update
FROM bronze.store;
