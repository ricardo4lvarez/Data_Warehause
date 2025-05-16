/*
 ---------------------------------------
 	Crear base de datos y esquemas 
 --------------------------------------- 
 
	PROPÓSITO:
	Este script sirve para crear la base de datos y los esquemas con los que voy a estar trabajando. Todos ellos se encuentran en la carpeta de "docs" en el repositorio.

	ADVERTENCIA:
	Especial atención al manipular los dos primeros comandos, ya que eliminan toda la base de datos y la crean desde 0.
 */
 
USE master;
GO
-- Eliminamos y creamos la base de datos desde 0
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'datawarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO
-- Creamos la base de datos
CREATE DATABASE datawarehouse;
GO

USE datawarehouse;
GO
-- Creamos los esquemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
