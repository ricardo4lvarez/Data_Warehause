/*
 ---------------------------------------
 	Create Data Base and Schemas
 --------------------------------------- 
 
	PURPOSE:
	Create the database and schemas.

	WARNING:
	If you already have data in the tables and/or schemas the data will be errased when executing the script.
 */
 
USE master;
GO
-- Drop the complete Data Base
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'datawarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO
-- Creating Data Base
CREATE DATABASE datawarehouse;
GO

USE datawarehouse;
GO
--Creating Schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
