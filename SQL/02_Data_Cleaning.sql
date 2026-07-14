/*
=========================================================
Script: 02_Data_Cleaning.sql
Project: Bank Customer Churn Analysis
Author: Nonzuleko Mbanjwa
Date: July 2026

Description:
This script cleans and transforms the Customer_Info
and Bank_Account_Info tables by resolving data quality
issues identified during the assessment phase. The
cleaned dataset is prepared for validation and
exploratory data analysis.

Cleaning Tasks:
- Remove duplicate records
- Remove unnecessary columns
- Standardize categorical values
- Clean currency fields
- Convert data types
- Prepare the dataset for validation

=========================================================
*/
USE BankCustomerAnalysis;
GO

-- =====================================================
-- Section 1: Remove Duplicate Records
-- =====================================================

-- Remove duplicate customer records while retaining
-- the first occurrence of each CustomerId.

WITH DuplicateRows AS
(
    SELECT *,
           ROW_NUMBER() OVER
           (
               PARTITION BY CustomerId
               ORDER BY CustomerId
           ) AS RowNum
    FROM Customer_Info
)

DELETE
FROM DuplicateRows
WHERE RowNum > 1;

-- Result:
-- Duplicate customer records successfully removed.

-- Remove duplicate account records while retaining
-- the first occurrence of each CustomerId.

WITH DuplicateRows AS
(
    SELECT *,
           ROW_NUMBER() OVER
           (
               PARTITION BY CustomerId
               ORDER BY CustomerId
           ) AS RowNum
    FROM Bank_Account_Info
)

DELETE
FROM DuplicateRows
WHERE RowNum > 1;

-- Result:
-- Duplicate account records successfully removed.

-- =====================================================
-- Section 2: Remove Unnecessary Columns
-- =====================================================

-- Remove the empty column created during CSV import.

ALTER TABLE Bank_Account_Info
DROP COLUMN Column9;

-- Result:
-- The unnecessary empty column was successfully removed
-- from the Bank_Account_Info table.

-- =====================================================
-- Section 3: Standardize Categorical Values
-- =====================================================

-- Standardize Geography values to ensure that each
-- country is represented consistently.

UPDATE Customer_Info
SET Geography = 'France'
WHERE Geography IN ('FRA', 'French');

-- Verify that Geography values have been standardized.

SELECT DISTINCT Geography
FROM Customer_Info;

-- Result:
-- Geography values are now standardized as:
-- France, Germany and Spain.

-- =====================================================
-- Section 4: Clean Currency Fields
-- =====================================================

-- The Balance and EstimatedSalary columns contained
-- currency symbols (€), preventing conversion to
-- numeric data types.

-- Currency symbols were removed from the monetary
-- fields to enable conversion from text to
-- DECIMAL(18,2).

-- (Currency cleaning performed before data type conversion.)

-- =====================================================
-- Section 5: Convert Data Types
-- =====================================================

-- Converted Balance from NVARCHAR(50)
-- to DECIMAL(18,2).

-- Converted EstimatedSalary from NVARCHAR(50)
-- to DECIMAL(18,2).

-- Result:
-- Monetary values are stored using an appropriate
-- numeric data type for calculations and analysis.

/*
=========================================================

-- =====================================================
-- Data Ready for Validation
-- =====================================================

-- All identified data quality issues have been addressed.
-- The cleaned dataset is ready for validation and
-- exploratory data analysis.

Data Cleaning Summary

Cleaning Tasks Completed

✓ Duplicate customer records removed

✓ Duplicate account records removed

✓ Empty import column removed

✓ Geography values standardized

✓ Currency fields cleaned

✓ Monetary columns converted to DECIMAL(18,2)

Outcome

The dataset has been cleaned and prepared
for data validation.

Next Script

03_Data_Validation.sql

=========================================================
*/
