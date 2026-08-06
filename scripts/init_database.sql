/*
===============================================================================
 Project      : SQL Data Warehouse Project
 Script Name  : 00_init_database.sql
 Author       : Omar Shalaby
 Description  :
    Initializes the SQL Server environment for the Data Warehouse project.

    This script is designed for learning and development purposes.
    It recreates the DataWarehouse database from scratch each time it
    is executed, ensuring a clean and consistent environment for every
    ETL run and SQL exercise.

 Architecture
 ------------------------------------------------------------------------------
    Bronze  → Raw data ingested from source systems
    Silver  → Cleaned and transformed data
    Gold    → Business-ready analytical data

 Workflow
 ------------------------------------------------------------------------------
    1. Connect to the master database.
    2. Check whether the DataWarehouse database exists.
    3. Close any active connections.
    4. Drop the existing database.
    5. Create a fresh DataWarehouse database.
    6. Create the Bronze, Silver, and Gold schemas.
    7. Verify the database structure.

 Note
 ------------------------------------------------------------------------------
    This repository follows the SQL Data Warehouse tutorial by
    Data With Baraa and serves as a hands-on learning project for
    understanding Data Warehousing, ETL, Data Modeling, and SQL Analytics.

===============================================================================
*/

------------------------------------------------------------------------------
-- STEP 1
-- Switch to the master database.
--
-- Database-level operations such as CREATE DATABASE and DROP DATABASE
-- should always be executed from the master database.
------------------------------------------------------------------------------
USE master;
GO

------------------------------------------------------------------------------
-- STEP 2
-- Check whether the DataWarehouse database already exists.
--
-- DB_ID() returns the database ID if it exists; otherwise it returns NULL.
-- Making the script idempotent allows it to be executed repeatedly
-- without manual cleanup.
------------------------------------------------------------------------------
IF DB_ID(N'DataWarehouse') IS NOT NULL
BEGIN

    --------------------------------------------------------------------------
    -- Close existing connections.
    --
    -- Even in a single-developer environment, SQL Server may keep
    -- connections open through SSMS, IntelliSense, or future tools such
    -- as Power BI.
    --
    -- Setting SINGLE_USER with ROLLBACK IMMEDIATE guarantees that the
    -- database can be dropped without connection-related errors.
    --------------------------------------------------------------------------
    ALTER DATABASE DataWarehouse
        SET SINGLE_USER
        WITH ROLLBACK IMMEDIATE;

    --------------------------------------------------------------------------
    -- Remove the existing database.
    --
    -- Recreating the database ensures that every execution starts from
    -- a clean state, making development, testing, and learning repeatable.
    --------------------------------------------------------------------------
    DROP DATABASE DataWarehouse;

END;
GO

------------------------------------------------------------------------------
-- STEP 3
-- Create the DataWarehouse database.
--
-- SQL Server automatically creates:
-- • Primary data file (.mdf)
-- • Transaction log (.ldf)
-- • Default filegroup
-- • System metadata
------------------------------------------------------------------------------
CREATE DATABASE DataWarehouse;
GO

------------------------------------------------------------------------------
-- STEP 4
-- Change the execution context to the newly created database.
------------------------------------------------------------------------------
USE DataWarehouse;
GO

------------------------------------------------------------------------------
-- STEP 5
-- Create the Bronze schema.
--
-- Purpose:
-- Stores raw data exactly as received from the source systems.
--
-- This layer acts as the landing zone for ETL processes.
------------------------------------------------------------------------------
CREATE SCHEMA bronze;
GO

------------------------------------------------------------------------------
-- STEP 6
-- Create the Silver schema.
--
-- Purpose:
-- Stores cleaned, validated, and transformed data.
--
-- Typical operations performed in this layer:
-- • Data cleansing
-- • Standardization
-- • Deduplication
-- • Data validation
-- • Business rule implementation
------------------------------------------------------------------------------
CREATE SCHEMA silver;
GO

------------------------------------------------------------------------------
-- STEP 7
-- Create the Gold schema.
--
-- Purpose:
-- Stores business-ready datasets optimized for reporting,
-- dashboards, and analytical workloads.
--
-- Typical objects:
-- • Fact Tables
-- • Dimension Tables
-- • Business Views
-- • Aggregated Tables
------------------------------------------------------------------------------
CREATE SCHEMA gold;
GO

------------------------------------------------------------------------------
-- STEP 8
-- Verify the initialization.
--
-- Expected Schemas:
-- • bronze
-- • silver
-- • gold
------------------------------------------------------------------------------
SELECT
    schema_id,
    name AS schema_name
FROM sys.schemas
WHERE name IN ('bronze', 'silver', 'gold')
ORDER BY schema_name;
GO

/*
===============================================================================
 Learning Notes
===============================================================================

Why recreate the database?
--------------------------
Starting from a clean database ensures that every ETL execution is
repeatable and prevents issues caused by leftover objects or data.

Why use separate schemas?
-------------------------
The Bronze, Silver, and Gold architecture separates the ETL pipeline
into logical layers:

Bronze
    Raw source data with minimal or no transformations.

Silver
    Cleaned, standardized, and validated data prepared for analytics.

Gold
    Business-ready dimensional models used for reporting and
    business intelligence.

Why use DB_ID()?
----------------
DB_ID() is the recommended SQL Server function for checking whether
a database exists. It is concise, efficient, and commonly used in
administrative scripts.

Why use SINGLE_USER WITH ROLLBACK IMMEDIATE?
--------------------------------------------
SQL Server cannot drop a database while active connections exist.
This command disconnects any sessions and rolls back unfinished
transactions, allowing the database to be recreated reliably.

Best Practices Applied
----------------------
✓ Idempotent script (safe to rerun)
✓ Well-documented sections
✓ Layered schema architecture
✓ Clear separation of responsibilities
✓ Repeatable development environment
✓ Verification after object creation

===============================================================================
 End of Script
===============================================================================
*/
