/*
	=======================================
	  LOAD DATA IN BRONZE LAYER
	=======================================
	PURPOSE:
	• This stored procedure loads data into the 'bronze' schema from external CSV files. 
	• It performs the following actions:
		- Truncates the bronze tables before loading data.
		- Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

	PARAMETERS:
	• None. This stored procedure does not accept any parameters or return any values.

	USAGE EXAMPLE:
    	EXEC bronze.load_bronze;
	
	IMPORTANT
	• The files have the "l_" prefix wich means they were cleaned with the "handling_data_format.ipynb" script.
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 

	BEGIN TRY

		SET @batch_start_time = GETDATE();
		PRINT '===============================';
		PRINT 'CARGANDO CAPA DE BRONCE';
		PRINT '===============================';
		PRINT '';

		-- Table 1
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: bronze.actor';
		TRUNCATE TABLE bronze.actor;
		PRINT '>> Cargando datos en: bronze.actor';
		BULK INSERT bronze.actor
		FROM 'D:/Memoria/SQL/Movies/l_actor.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
		PRINT '-----------------------';

		-- Table 2
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: bronze.address';
		TRUNCATE TABLE bronze.address;
		PRINT '>> Cargando datos en: bronze.address';
		BULK INSERT bronze.address
		FROM 'D:/Memoria/SQL/Movies/l_address.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
		PRINT '-----------------------';

		-- Table 3
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: bronze.category';
		TRUNCATE TABLE bronze.category;
		PRINT '>> Cargando datos en: bronze.category';
		BULK INSERT bronze.category
		FROM 'D:/Memoria/SQL/Movies/l_category.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
		PRINT '-----------------------';

		-- Table 4
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: bronze.city';
		TRUNCATE TABLE bronze.city;
		PRINT '>> Cargando datos en: bronze.city';
		BULK INSERT bronze.city
		FROM 'D:/Memoria/SQL/Movies/l_city.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
		PRINT '-----------------------';

		-- Table 5
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: bronze.country';
		TRUNCATE TABLE bronze.country;
		PRINT '>> Cargando datos en: bronze.country';
		BULK INSERT bronze.country
		FROM 'D:/Memoria/SQL/Movies/l_country.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
		PRINT '-----------------------';

		-- Table 6
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: bronze.customer';
		TRUNCATE TABLE bronze.customer;
		PRINT '>> Cargando datos en: bronze.customer';
		BULK INSERT bronze.customer
		FROM 'D:/Memoria/SQL/Movies/l_customer.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
		PRINT '-----------------------';

		-- Table 7
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: bronze.film';
		TRUNCATE TABLE bronze.film;
		PRINT '>> Cargando datos en: bronze.film';
		BULK INSERT bronze.film
		FROM 'D:/Memoria/SQL/Movies/l_film.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
		PRINT '-----------------------';

		-- Table 8
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: bronze.film_actor';
		TRUNCATE TABLE bronze.film_actor;
		PRINT '>> Cargando datos en: bronze.film_actor';
		BULK INSERT bronze.film_actor
		FROM 'D:/Memoria/SQL/Movies/l_film_actor.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
		PRINT '-----------------------';

		-- Table 9
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: bronze.film_category';
		TRUNCATE TABLE bronze.film_category;
		PRINT '>> Cargando datos en: bronze.film_category';
		BULK INSERT bronze.film_category
		FROM 'D:/Memoria/SQL/Movies/l_film_category.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
		PRINT '-----------------------';

		-- Table 10
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: bronze.inventory';
		TRUNCATE TABLE bronze.inventory;
		PRINT '>> Cargando datos en: bronze.inventory';
		BULK INSERT bronze.inventory
		FROM 'D:/Memoria/SQL/Movies/l_inventory.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
		PRINT '-----------------------';

		-- Table 11
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: bronze.language';
		TRUNCATE TABLE bronze.language;
		PRINT '>> Cargando datos en: bronze.language';
		BULK INSERT bronze.language
		FROM 'D:/Memoria/SQL/Movies/l_language.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
		PRINT '-----------------------';

		-- Table 12
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: bronze.payment';
		TRUNCATE TABLE bronze.payment;
		PRINT '>> Cargando datos en: bronze.payment';
		BULK INSERT bronze.payment
		FROM 'D:/Memoria/SQL/Movies/l_payment.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
		PRINT '-----------------------';

		-- Table 13
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: bronze.rental';
		TRUNCATE TABLE bronze.rental;
		PRINT '>> Cargando datos en: bronze.rental';
		BULK INSERT bronze.rental
		FROM 'D:/Memoria/SQL/Movies/l_rental.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
		PRINT '-----------------------';

		-- Table 14
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: bronze.staff';
		TRUNCATE TABLE bronze.staff;
		PRINT '>> Cargando datos en: bronze.staff';
		BULK INSERT bronze.staff
		FROM 'D:/Memoria/SQL/Movies/l_staff.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Duracion: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
		PRINT '-----------------------';

		-- Table 15
		SET @start_time = GETDATE();

		PRINT '>> Truncando tabla: bronze.store';
		TRUNCATE TABLE bronze.store;
		PRINT '>> Cargando datos en: bronze.store';
		BULK INSERT bronze.store
		FROM 'D:/Memoria/SQL/Movies/l_store.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n',
			TABLOCK
		);
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
		PRINT 'UN ERROR HA OCURRIDO DURANTE LA CARGA DE LA CAPA DE BRONCE';
		PRINT 'Error Message: ' + ERROR_MESSAGE();
		PRINT 'Error Message: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message: ' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '=============================';
	END CATCH
END
