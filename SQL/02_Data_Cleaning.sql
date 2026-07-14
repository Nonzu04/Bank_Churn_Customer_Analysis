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

-- =====================================================
-- Section 2: Remove Unnecessary Columns
-- =====================================================

-- Remove the empty column created during CSV import.

ALTER TABLE Bank_Account_Info
DROP COLUMN Column9;
