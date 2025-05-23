/*
=============================================================================
                    CREATE DIMENSION: gold.dim_customers
=============================================================================
*/
CREATE VIEW gold.dim_customers AS
	SELECT
		cus.customer_id AS customer_key,
		cus.first_name,
		cus.last_name,
		cus.email,
		adr.phone,
		adr.address,
		adr.district,
		adr.postal_code,
		city.city,
		country.country,
		cus.active AS is_active,
		cus.create_date
	FROM silver.customer AS cus
		LEFT JOIN silver.address AS adr
			ON cus.address_id = adr.address_id
		LEFT JOIN silver.city AS city
			ON adr.city_id = city.city_id
		LEFT JOIN silver.country AS country
			ON city.country_id = country.country_id;*/


/*
=============================================================================
                    CREATE DIMENSION: gold.dim_film
=============================================================================
*/

CREATE VIEW gold.dim_film AS
	WITH tabla AS (
		SELECT
		  f.film_id,
		  f.title,
		  STRING_AGG(CONCAT(a.first_name, ' ', a.last_name), ', ') AS actor_list
		FROM silver.film AS f
		LEFT JOIN silver.film_actor fa 
			ON f.film_id = fa.film_id
		LEFT JOIN silver.actor a 
			ON fa.actor_id = a.actor_id
		GROUP BY f.film_id, f.title)
	SELECT
		f.film_id AS film_key,
		f.title,
		f.description,
		f.release_year,
		f.rental_duration,
		f.rental_rate,
		f.length_,
		f.replacement_cost,
		f.rating,
		l.name AS language,
		c.name AS category,
		t.actor_list,
		f.special_features,
		f.full_text
	FROM silver.film AS f
		LEFT JOIN silver.language AS l
			ON f.language_id = l.language_id
		LEFT JOIN tabla AS t
			ON f.film_id = t.film_id
		LEFT JOIN silver.film_category fc
			ON  f.film_id = fc.film_id
		LEFT JOIN silver.category c
			ON fc.category_id = c.category_id;


/*
=============================================================================
                    CREATE DIMENSION: gold.dim_store
=============================================================================
*/

CREATE VIEW gold.dim_store AS
	SELECT
		st.store_id AS store_key,
		ad.phone,
		ad.address,
		ad.district,
		ad.postal_code,
		city.city,
		country.country,
		sf.username AS manager,
		sf.password AS manager_password,
		sf.active AS manager_is_active,
		sf.picture AS manager_picture
	FROM silver.store AS st
	LEFT JOIN silver.staff AS sf
	ON st.manager_staff_id = sf.staff_id
	LEFT JOIN silver.address AS ad
	ON st.address_id = ad.address_id
	LEFT JOIN silver.city AS city
	ON ad.city_id = city.city_id
	LEFT JOIN silver.country AS country
	ON city.country_id = country.country_id
  
/*
=============================================================================
                    CREATE DIMENSION: gold.dim_inventory
=============================================================================
*/

CREATE VIEW gold.dim_inventory AS
	SELECT
		inventory_id AS inventory_key,
		film_id AS film_key,
		store_id AS store_key
	FROM silver.inventory;


/*
=============================================================================
                    CREATE DIMENSION: gold.dim_rental
=============================================================================
*/

 CREATE VIEW gold.dim_payment_rental AS
	SELECT
		p.payment_id AS payment_key,
		p.customer_id AS customer_key,
		r.inventory_id AS inventory_key,
		s1.first_name AS payment_staff_first_name,
		s1.last_name AS payment_staff_last_name,
		s1.active AS payment_staff_is_active,
		s1.password AS payment_staff_password,
		s2.first_name AS rental_staff_first_name,
		s2.last_name AS rental_staff_last_name,
		s2.active AS rental_staff_is_active,
		s2.password AS rental_staff_password,
		p.amount,
		r.rental_date,
		p.payment_date,
		r.return_date
	FROM silver.payment AS p
		LEFT JOIN silver.rental AS r
	ON p.rental_id = r.rental_id
	LEFT JOIN silver.staff AS s1
		ON p.staff_id = s1.staff_id
	LEFT JOIN silver.staff AS s2
		ON r.staff_id = s2.staff_id;

