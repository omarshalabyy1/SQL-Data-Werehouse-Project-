/*
===============================================================================
Project      : Data With Braa - DWH, EDA & Analysis
Script Name  : 00_init_database.sql
Author       : Omar Shalaby

Description  :
Initializes the SQL Server environment for the Data Warehouse project.

This script creates the project database and initializes the Bronze,
Silver, and Gold schemas used throughout the Data Warehouse and
analytics lifecycle.

This script is designed for learning and development purposes.
The database creation section is intended to establish the initial
project environment.

===============================================================================

Architecture

Bronze  → Raw data ingested from source systems
Silver  → Cleaned, standardized, and validated data
Gold    → Business-ready analytical data

===============================================================================

Workflow

1. Connect to the master database.
2. Create the project database.
3. Switch to the project database.
4. Create the Bronze, Silver, and Gold schemas.
5. Verify the database structure.

===============================================================================

Note

This repository follows the SQL Data Warehouse tutorial by Data With
Baraa and serves as a hands-on learning project for understanding:

- Relational databases
- Data Warehousing
- Medallion Architecture
- ETL
- Data Modeling
- Exploratory Data Analysis (EDA)
- Advanced SQL Analytics
- Business Intelligence

===============================================================================
*/


/*=============================================================================
  1. Create Database
=============================================================================*/

USE master;
GO

CREATE DATABASE DataWithBraa_DWH_EDA_Analysis;
GO


/*=============================================================================
  2. Switch to Project Database
=============================================================================*/

USE DataWithBraa_DWH_EDA_Analysis;
GO


/*=============================================================================
  3. Create Medallion Architecture Schemas
=============================================================================*/

-- Bronze: Raw source data / landing layer
CREATE SCHEMA bronze;
GO

-- Silver: Cleansed and standardized data
CREATE SCHEMA silver;
GO

-- Gold: Business-ready analytical data
CREATE SCHEMA gold;
GO


/*=============================================================================
  4. Validate Schema Creation
=============================================================================*/

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

Why use separate schemas?

The Bronze, Silver, and Gold architecture separates the data pipeline
into logical layers with different responsibilities.

Bronze
-------
Contains raw data ingested from source systems with minimal or no
transformations.

Silver
------
Contains cleaned, standardized, and validated data prepared for
downstream analytical processing.

Gold
----
Contains business-ready dimensional and fact structures designed
for reporting, analytics, and Business Intelligence.


Why use DB_ID()?

DB_ID() returns the database ID for a specified database name.

It can be used in SQL Server administrative scripts to determine
whether a database exists before performing database-level operations.

Example:

    DB_ID(N'DataWarehouse')

If the database does not exist, DB_ID() returns NULL.


Why use SINGLE_USER WITH ROLLBACK IMMEDIATE?

When rebuilding a development database, SQL Server may have active
connections to the database.

SINGLE_USER restricts the database to a single connection, while
ROLLBACK IMMEDIATE terminates existing connections and rolls back
active transactions.

This allows the database to be dropped reliably before recreation.

This approach is appropriate for controlled development environments,
but should be used with caution because dropping the database
permanently removes its data and objects.


Best Practices Applied

✓ Clear script naming and numbering
✓ Descriptive documentation
✓ Separation of database and schema responsibilities
✓ Medallion Architecture
✓ Explicit database context switching
✓ Validation after object creation
✓ Consistent naming conventions
✓ Development-oriented and repeatable project structure

===============================================================================
*/
```
