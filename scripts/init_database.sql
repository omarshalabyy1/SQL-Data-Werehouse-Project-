/*
===============================================================================
 Script: Create Data Warehouse Database
 Project: SQL Data Warehouse Project
 Description:
     Creates the DataWarehouse database and its schemas used throughout
     the ETL and analytics pipeline.

 Layers:
     • Bronze - Raw data ingestion
     • Silver - Cleaned and transformed data
     • Gold   - Business-ready analytical model
===============================================================================
*/

USE master;
GO

/*----------------------------------------------------------------------------
  Drop the database if it already exists (Development Only)
----------------------------------------------------------------------------*/
IF DB_ID(N'DataWarehouse') IS NOT NULL
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

/*----------------------------------------------------------------------------
  Create Database
----------------------------------------------------------------------------*/
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

/*----------------------------------------------------------------------------
  Create Schemas
----------------------------------------------------------------------------*/
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO

/*----------------------------------------------------------------------------
  Verify Schema Creation
----------------------------------------------------------------------------*/
SELECT
    schema_id,
    name AS schema_name
FROM sys.schemas
WHERE name IN ('bronze', 'silver', 'gold')
ORDER BY schema_name;
GO
