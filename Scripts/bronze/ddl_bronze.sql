/*
 	=========================================
 		CREATE TABLES
 	=========================================
	PURPOSE: 
	Creates the 15 tables, each one for a file.
 
 	------------------------------
 		  WARNING!
 	------------------------------
	 BE CAREFUL with DROPING the tables if you already have data.
  */


-- Table 1
IF OBJECT_ID('bronze.actor', 'U') IS NOT NULL
    DROP TABLE bronze.actor;
GO
CREATE TABLE bronze.actor(
	actor_id INT,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	last_update DATETIMEOFFSET
);
GO

-- Table 2
IF OBJECT_ID('bronze.adress', 'U') IS NOT NULL
    DROP TABLE bronze.adress;
GO
CREATE TABLE bronze.adress(
	address_id INT,
	address VARCHAR(60),
	address2 VARCHAR(60),
	district VARCHAR(60),
	city_id INT,
	postal_code INT,
	phone VARCHAR(20),
	last_update DATETIMEOFFSET
);
GO

-- Table 3
IF OBJECT_ID('bronze.category', 'U') IS NOT NULL
    DROP TABLE bronze.category;
GO
CREATE TABLE bronze.category(
	category_id INT,
	name VARCHAR (50),
	last_update DATETIMEOFFSET
);
GO

-- Table 4
IF OBJECT_ID('bronze.city', 'U') IS NOT NULL
    DROP TABLE bronze.city;
GO
CREATE TABLE bronze.city(
	city_id INT,
	city VARCHAR(60),
	country_id INT,
	last_update DATETIMEOFFSET
);
GO

-- Table 5
IF OBJECT_ID('bronze.country', 'U') IS NOT NULL
    DROP TABLE bronze.country;
GO
CREATE TABLE bronze.country(
	country_id INT,
	country VARCHAR(60),
	last_update DATETIMEOFFSET
);
GO

-- Table 6
IF OBJECT_ID('bronze.customer', 'U') IS NOT NULL
    DROP TABLE bronze.customer;
GO
CREATE TABLE bronze.customer(
	customer_id INT,
	store_id INT,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(60),
	address_id INT,
	activebool BIT,
	create_date DATE,
	last_update DATETIMEOFFSET,
	active BIT
);
GO

-- Table 7
IF OBJECT_ID('bronze.film', 'U') IS NOT NULL
    DROP TABLE bronze.film;
GO
CREATE TABLE bronze.film(
	film_id INT,
	title VARCHAR (50),
	description TEXT,
	release_year SMALLINT,
	language_id INT,
	original_language_id INT,
	rental_duration INT,
	rental_rate FLOAT,
 	length_ INT,
 	replacement_cost FLOAT,
 	rating VARCHAR(10),
 	last_update DATETIMEOFFSET,
 	special_features VARCHAR(70),
 	fulltext_ TEXT
);
GO

-- Table 8
IF OBJECT_ID('bronze.film_actor', 'U') IS NOT NULL
    DROP TABLE bronze.film_actor;
GO
CREATE TABLE bronze.film_actor(
	actor_id INT,
	film_id INT,
	last_update DATETIMEOFFSET
);
GO

-- Table 9
IF OBJECT_ID('bronze.film_category', 'U') IS NOT NULL
    DROP TABLE bronze.film_category;
GO
CREATE TABLE bronze.film_category(
	film_id INT,
	category_id INT,
	last_update DATETIMEOFFSET
);
GO

-- Table 10
IF OBJECT_ID('bronze.inventory', 'U') IS NOT NULL
    DROP TABLE bronze.inventory;
GO
CREATE TABLE bronze.inventory(
	inventory_id INT,
	film_id INT,
	store_id INT,
	last_update DATETIMEOFFSET
);
GO

-- Table 11
IF OBJECT_ID('bronze.language', 'U') IS NOT NULL
    DROP TABLE bronze.language;
GO
CREATE TABLE bronze.language(
	language_id INT,
	name VARCHAR (25),
	last_update DATETIMEOFFSET
);
GO

-- Table 12
IF OBJECT_ID('bronze.payment', 'U') IS NOT NULL
    DROP TABLE bronze.payment;
GO
CREATE TABLE bronze.payment(
	payment_id INT,
	customer_id INT,
	staff_id INT,
	rental_id INT,
	amount FLOAT,
	payment_date DATETIMEOFFSET
);
GO

-- Table 13
IF OBJECT_ID('bronze.rental', 'U') IS NOT NULL
    DROP TABLE bronze.rental;
GO
CREATE TABLE bronze.rental(
	rental_id INT,
	rental_date DATETIME,
	inventory_id INT,
	customer_id INT,
	return_date DATETIME,
	staff_id INT,
	last_update DATETIMEOFFSET
);
GO

-- Table 14
IF OBJECT_ID('bronze.staff', 'U') IS NOT NULL
    DROP TABLE bronze.staff;
GO
CREATE TABLE bronze.staff(
	staff_id INT,
	first_name VARCHAR(10),
	last_name VARCHAR(10),
	address_id INT,
	email VARCHAR (50),
	store_id INT,
	active BIT,
	username VARCHAR(10),
	password VARCHAR(50),
	last_update DATETIMEOFFSET,
	picture VARCHAR(15)
);
GO

-- Table 15
IF OBJECT_ID('bronze.store', 'U') IS NOT NULL
    DROP TABLE bronze.store;
GO
CREATE TABLE bronze.store(
	store_id INT,
	manager_staff_id INT,
	address_id INT,
	last_update DATETIMEOFFSET
);
