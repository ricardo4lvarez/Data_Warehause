/*
	=======================================
	  CARGA DE DATOS EN LA CAPA DE PLATA
	=======================================
	PROPÓSITO
	• Este script sirve para crear el StoredProcedure para cargar todos los datos a partir de una carpeta local.
	• Si observan que los archivos llevan el prefijo "l_" quiere decir "limpio", ya que tuve que hacer unas pequeñas transformaciones mediante el script de Python adjunto para poder insertar la data.
	• Así mismo se hace un debug para observar cuánto tiempo tardan las operaciones y si hay algún error en la carga.
*/

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 

	BEGIN TRY

		SET @batch_start_time = GETDATE();
		PRINT '===============================';
		PRINT 'CARGANDO CAPA DE PLATA';
		PRINT '===============================';
		PRINT '';

		------------------------------------------------ TABLA 1 ------------------------------------------------
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: silver.actor';
		TRUNCATE TABLE silver.actor;
		PRINT '>> Cargando datos en: silver.actor';
		
		INSERT INTO silver.actor(
			actor_id,
			first_name,
			last_name,
			last_update
		)
		SELECT
			actor_id,
			first_name,
			last_name,
			last_update
		FROM bronze.actor;

		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
		PRINT '-----------------------';

		------------------------------------------------ TABLA 2 ------------------------------------------------
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: silver.address';
		TRUNCATE TABLE silver.address;
		PRINT '>> Cargando datos en: silver.address';
		INSERT INTO silver.address(
			address_id,
			address,
			district,
			city_id,
			postal_code,
			phone,
			last_update
		)
		SELECT
			address_id,
			address,
			district,
			city_id,
			REPLACE(postal_code,'.0','') AS postal_code,
			REPLACE(phone,'.0','') AS phone,
			last_update
		FROM bronze.address;

		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
		PRINT '-----------------------';

		------------------------------------------------ TABLA 3 ------------------------------------------------
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: silver.category';
		TRUNCATE TABLE silver.category;
		PRINT '>> Cargando datos en: silver.category';		
		INSERT INTO silver.category(
			category_id,
			name,
			last_update 
		)
		SELECT
			category_id,
			name,
			last_update
		FROM bronze.category;

		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
		PRINT '-----------------------';

		------------------------------------------------ TABLA 4 ------------------------------------------------
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: silver.city';
		TRUNCATE TABLE silver.city;
		PRINT '>> Cargando datos en: silver.city';		
		INSERT INTO silver.city(
			city_id,
			city,
			country_id,
			last_update
		)
		SELECT
			city_id,
			city,
			country_id,
			last_update
		FROM bronze.city;

		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
		PRINT '-----------------------';

		------------------------------------------------ TABLA 5 ------------------------------------------------
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: silver.country';
		TRUNCATE TABLE silver.country;
		PRINT '>> Cargando datos en: silver.country';		
		INSERT INTO silver.country(
			country_id,
			country,
			last_update
		)
		SELECT
			country_id,
			country ,
			last_update
		FROM bronze.country;

		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
		PRINT '-----------------------';

		------------------------------------------------ TABLA 6 ------------------------------------------------
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: silver.customer';
		TRUNCATE TABLE silver.customer;
		PRINT '>> Cargando datos en: silver.customer';
		
		INSERT INTO silver.customer(
			customer_id,
			store_id,
			first_name,
			last_name,
			email,
			address_id,
			activebool,
			create_date,
			last_update,
			active
		)
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
			(CASE
				WHEN active = 1 THEN 'True'
				ELSE 'False'
			END) AS active
		FROM bronze.customer;

		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
		PRINT '-----------------------';

		------------------------------------------------ TABLA 7 ------------------------------------------------
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: silver.film';
		TRUNCATE TABLE silver.film;
		PRINT '>> Cargando datos en: silver.film';		
		INSERT INTO silver.film(
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
 			special_features,
 			full_text,
 			last_update
		)
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

		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
		PRINT '-----------------------';

		------------------------------------------------ TABLA 8 ------------------------------------------------
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: silver.film_actor';
		TRUNCATE TABLE silver.film_actor;
		PRINT '>> Cargando datos en: silver.film_actor';		
		INSERT INTO silver.film_actor(
			actor_id,
			film_id,
			last_update
		)
		SELECT
			actor_id,
			film_id,
			last_update
		FROM bronze.film_actor;

		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
		PRINT '-----------------------';

		------------------------------------------------ TABLA 9 ------------------------------------------------
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: silver.film_category';
		TRUNCATE TABLE silver.film_category;
		PRINT '>> Cargando datos en: silver.film_category';		
		INSERT INTO silver.film_category(
			film_id,
			category_id,
			last_update
		)
		SELECT
			film_id,
			category_id,
			last_update
		FROM bronze.film_category;

		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
		PRINT '-----------------------';

		------------------------------------------------ TABLA 10 ------------------------------------------------
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: silver.inventory';
		TRUNCATE TABLE silver.inventory;
		PRINT '>> Cargando datos en: silver.inventory';		
		INSERT INTO silver.inventory(
			inventory_id,
			film_id,
			store_id,
			last_update
		)
		SELECT
			inventory_id,
			film_id,
			store_id,
			last_update
		FROM bronze.inventory;

		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
		PRINT '-----------------------';

		------------------------------------------------ TABLA 11 ------------------------------------------------
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: silver.language';
		TRUNCATE TABLE silver.language;
		PRINT '>> Cargando datos en: silver.language';		
		INSERT INTO silver.language(
			language_id,
			name,
			last_update
		)
		SELECT
			language_id,
			name,
			last_update
		FROM bronze.language;

		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
		PRINT '-----------------------';

		------------------------------------------------ TABLA 12 ------------------------------------------------
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: silver.payment';
		TRUNCATE TABLE silver.payment;
		PRINT '>> Cargando datos en: silver.payment';		
		INSERT INTO silver.payment(
			payment_id,
			customer_id,
			staff_id,
			rental_id,
			amount,
			payment_date
		)
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

		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
		PRINT '-----------------------';

		------------------------------------------------ TABLA 13 ------------------------------------------------
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: silver.rental';
		TRUNCATE TABLE silver.rental;
		PRINT '>> Cargando datos en: silver.rental';		
		INSERT INTO silver.rental(
			rental_id,
			rental_date,
			inventory_id,
			customer_id,
			return_date,
			staff_id,
			last_update
		)
		SELECT
			rental_id,
			rental_date,
			inventory_id,
			customer_id,
			return_date,
			staff_id,
			last_update
		FROM bronze.rental;

		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
		PRINT '-----------------------';

		------------------------------------------------ TABLA 14 ------------------------------------------------
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: silver.staff';
		TRUNCATE TABLE silver.staff;
		PRINT '>> Cargando datos en: silver.staff';		
		INSERT INTO silver.staff(
			staff_id,
			first_name,
			last_name,
			address_id,
			email,
			store_id,
			active,
			username,
			password,
			last_update,
			picture
		)
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

		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
		PRINT '-----------------------';

		------------------------------------------------ TABLA 15 ------------------------------------------------
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: silver.store';
		TRUNCATE TABLE silver.store;
		PRINT '>> Cargando datos en: silver.store';		
		INSERT INTO silver.store(
			store_id,
			manager_staff_id,
			address_id,
			last_update
		)
		SELECT
			store_id,
			manager_staff_id,
			address_id,
			last_update
		FROM bronze.store;

		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';

		SET @batch_end_time = GETDATE();
		PRINT '=========================================='
		PRINT '¡CARGA DE DATOS EXITOSA!';
		PRINT '   - Duración total: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' segundos';
		PRINT '=========================================='

	END TRY
	BEGIN CATCH
		PRINT '=============================';
		PRINT 'UN ERROR HA OCURRIDO DURANTE LA CARGA DE LA CAPA DE PLATA';
		PRINT 'Error Message: ' + ERROR_MESSAGE();
		PRINT 'Error Message: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message: ' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '=============================';
	END CATCH
END
