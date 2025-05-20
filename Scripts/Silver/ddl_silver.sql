/*
 * =========================================
 * CREACIÓN DE TABLAS
 * =========================================
 * Este Script sirve para crear las 15 tablas en base a los .csv.
 * 
 * ------------------------------
 * 			PRECAUCIÓN
 * ------------------------------
 * CUIDADO con ELIMINAR las tablas si ya cuentan con registros.
 * */

 USE datawarehouse;
-- TABLA 1
IF OBJECT_ID('silver.actor', 'U') IS NOT NULL
    DROP TABLE silver.actor;
GO
CREATE TABLE silver.actor(
	actor_id INT,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	last_update DATETIME,
	dwh_create_date DATETIME DEFAULT GETDATE()
);
GO

-- TABLA 2
IF OBJECT_ID('silver.address', 'U') IS NOT NULL
    DROP TABLE silver.address;
GO
CREATE TABLE silver.address(
	address_id INT,
	address VARCHAR(60),
	district VARCHAR(60),
	city_id INT,
	postal_code VARCHAR(10),
	phone VARCHAR(20),
	last_update DATETIME,
	dwh_create_date DATETIME DEFAULT GETDATE()
);
GO

-- TABLA 3
IF OBJECT_ID('silver.category', 'U') IS NOT NULL
    DROP TABLE silver.category;
GO
CREATE TABLE silver.category(
	category_id INT,
	name VARCHAR (50),
	last_update DATETIME,
	dwh_create_date DATETIME DEFAULT GETDATE()
);
GO

-- TABLA 4
IF OBJECT_ID('silver.city', 'U') IS NOT NULL
    DROP TABLE silver.city;
GO
CREATE TABLE silver.city(
	city_id INT,
	city VARCHAR(60),
	country_id INT,
	last_update DATETIME,
	dwh_create_date DATETIME DEFAULT GETDATE()
);
GO

-- TABLA 5
IF OBJECT_ID('silver.country', 'U') IS NOT NULL
    DROP TABLE silver.country;
GO
CREATE TABLE silver.country(
	country_id INT,
	country VARCHAR(60),
	last_update DATETIME,
	dwh_create_date DATETIME DEFAULT GETDATE()
);
GO

-- TABLA 6
IF OBJECT_ID('silver.customer', 'U') IS NOT NULL
    DROP TABLE silver.customer;
GO
CREATE TABLE silver.customer(
	customer_id INT,
	store_id INT,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(60),
	address_id INT,
	activebool VARCHAR(10),
	create_date DATE,
	last_update DATETIME,
	active VARCHAR(10),
	dwh_create_date DATETIME DEFAULT GETDATE()
);
GO

-- TABLA 7
IF OBJECT_ID('silver.film', 'U') IS NOT NULL
    DROP TABLE silver.film;
GO
CREATE TABLE silver.film(
	film_id INT,
	title VARCHAR (50),
	description TEXT,
	release_year SMALLINT,
	language_id INT,
	rental_duration INT,
	rental_rate FLOAT,
 	length_ INT,
 	replacement_cost FLOAT,
 	rating VARCHAR(10),
 	last_update DATETIME,
 	special_features VARCHAR(70),
 	full_text TEXT,
	dwh_create_date DATETIME DEFAULT GETDATE()
);
GO

-- TABLA 8
IF OBJECT_ID('silver.film_actor', 'U') IS NOT NULL
    DROP TABLE silver.film_actor;
GO
CREATE TABLE silver.film_actor(
	actor_id INT,
	film_id INT,
	last_update DATETIME,
	dwh_create_date DATETIME DEFAULT GETDATE()
);
GO

-- TABLA 9
IF OBJECT_ID('silver.film_category', 'U') IS NOT NULL
    DROP TABLE silver.film_category;
GO
CREATE TABLE silver.film_category(
	film_id INT,
	category_id INT,
	last_update DATETIME,
	dwh_create_date DATETIME DEFAULT GETDATE()
);
GO

-- TABLA 10
IF OBJECT_ID('silver.inventory', 'U') IS NOT NULL
    DROP TABLE silver.inventory;
GO
CREATE TABLE silver.inventory(
	inventory_id INT,
	film_id INT,
	store_id INT,
	last_update DATETIME,
	dwh_create_date DATETIME DEFAULT GETDATE()
);
GO

-- TABLA 11
IF OBJECT_ID('silver.language', 'U') IS NOT NULL
    DROP TABLE silver.language;
GO
CREATE TABLE silver.language(
	language_id INT,
	name VARCHAR (25),
	last_update DATETIME,
	dwh_create_date DATETIME DEFAULT GETDATE()
);
GO

-- TABLA 12
IF OBJECT_ID('silver.payment', 'U') IS NOT NULL
    DROP TABLE silver.payment;
GO
CREATE TABLE silver.payment(
	payment_id INT,
	customer_id INT,
	staff_id INT,
	rental_id INT,
	amount FLOAT,
	payment_date DATETIME,
	dwh_create_date DATETIME DEFAULT GETDATE()
);
GO

-- TABLA 13
IF OBJECT_ID('silver.rental', 'U') IS NOT NULL
    DROP TABLE silver.rental;
GO
CREATE TABLE silver.rental(
	rental_id INT,
	rental_date DATETIME,
	inventory_id INT,
	customer_id INT,
	return_date DATETIME,
	staff_id INT,
	last_update DATETIME,
	dwh_create_date DATETIME DEFAULT GETDATE()
);
GO

-- TABLA 14
IF OBJECT_ID('silver.staff', 'U') IS NOT NULL
    DROP TABLE silver.staff;
GO
CREATE TABLE silver.staff(
	staff_id INT,
	first_name VARCHAR(10),
	last_name VARCHAR(10),
	address_id INT,
	email VARCHAR (50),
	store_id INT,
	active VARCHAR(10),
	username VARCHAR(10),
	password VARCHAR(50),
	last_update DATETIME,
	picture VARCHAR(15),
	dwh_create_date DATETIME DEFAULT GETDATE()
);
GO

-- TABLA 15
IF OBJECT_ID('silver.store', 'U') IS NOT NULL
    DROP TABLE silver.store;
GO
CREATE TABLE silver.store(
	store_id INT,
	manager_staff_id INT,
	address_id INT,
	last_update DATETIME,
	dwh_create_date DATETIME DEFAULT GETDATE()
);