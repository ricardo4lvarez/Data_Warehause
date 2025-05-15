/*
 ---------------------------------------
 	Crear base de datos y esquemas 
 --------------------------------------- 
 
	PROPÓSITO:
	Este script sirve para crear la base de datos y los esquemas con los que voy a estar trabajando. Todos ellos se encuentran en la carpeta de "docs" en el repositorio.

	ADVERTENCIA:
	Especial atención al manipular los dos primeros comandos, ya que eliminan toda la base de datos y la crean desde 0.
 */

-- Eliminamos y creamos la base de datos desde 0
DROP DATABASE IF EXISTS DataWarehouse; 
CREATE DATABASE IF NOT EXISTS DataWarehouse;

USE DataWarehouse;

-- Creamos los esquemas
CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;
