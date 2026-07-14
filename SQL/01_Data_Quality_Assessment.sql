/*
-- =====================================================
-- Section 1: Initial Data Inspection
-- =====================================================
=========================================================
Script: 01_Data_Quality_Assessment.sql
Project: Bank Customer Churn Analysis
Author: Nonzuleko Mbanjwa
Date: July 2026

Description:
This script performs an initial data quality assessment
of the Customer_Info and Bank_Account_Info tables.
The goal is to identify data quality issues before
performing data cleaning and transformation.

Checks Performed:
- Initial data inspection
- Duplicate records
- Missing values
- NULL values
- Category consistency
- Data types
- Empty columns

=========================================================
*/

USE BankCustomerAnalysis;
GO

-- =====================================================
-- Section 1: Initial Data Inspection
-- =====================================================

-- Display all records from the Customer_Info table
-- to understand the structure of the customer dataset.
SELECT *
FROM Customer_Info;

-- Display all records from the Bank_Account_Info table
-- to understand the structure of the account dataset.
SELECT *
FROM Bank_Account_Info;

-- =====================================================
-- Section 2: Duplicate Record Assessment
-- =====================================================

-- Check for duplicate Customer IDs in the Customer_Info table.
-- A valid CustomerId should uniquely identify each customer.
SELECT
    CustomerId,
    COUNT(*) AS NumberOfRecords
FROM Customer_Info
GROUP BY CustomerId
HAVING COUNT(*) > 1;

-- Inspect the duplicate customer record identified during
-- the duplicate assessment.
SELECT *
FROM Customer_Info
WHERE CustomerId = 15628319;

-- Check for duplicate Customer IDs in the
-- Bank_Account_Info table.
SELECT
    CustomerId,
    COUNT(*) AS NumberOfRecords
FROM Bank_Account_Info
GROUP BY CustomerId
HAVING COUNT(*) > 1;

-- Inspect the duplicate account record identified during
-- the duplicate assessment.
SELECT *
FROM Bank_Account_Info
WHERE CustomerId = 15634602;

-- =====================================================
-- Section 3: Missing Values Assessment
-- =====================================================

-- Identify customer records with missing Age values.
-- Age is an important demographic attribute used for
-- customer segmentation and churn analysis.

SELECT *
FROM Customer_Info
WHERE Age IS NULL;

-- Check for NULL Customer IDs.
-- CustomerId is the primary identifier and should
-- never contain NULL values.

SELECT *
FROM Customer_Info
WHERE CustomerId IS NULL;

-- Check for NULL Customer IDs in the
-- Bank_Account_Info table.

SELECT *
FROM Bank_Account_Info
WHERE CustomerId IS NULL;

-- =====================================================
-- Section 4: Category Consistency Assessment
-- =====================================================

-- Inspect Geography values to identify inconsistent
-- category labels.

SELECT DISTINCT Geography
FROM Customer_Info;

-- Inspect Gender values.

SELECT DISTINCT Gender
FROM Customer_Info;

-- Inspect credit card values.

SELECT DISTINCT HasCrCard
FROM Bank_Account_Info;

-- Inspect active membership values.

SELECT DISTINCT IsActiveMember
FROM Bank_Account_Info;

-- =====================================================
-- Section 5: Data Type Assessment
-- =====================================================

-- Inspect the Balance column before converting
-- it from text to a numeric data type.

-- Inspect Balance values before conversion.

SELECT TOP (20)
    Balance
FROM Bank_Account_Info;

-- Inspect EstimatedSalary values before conversion.

SELECT TOP (20)
    EstimatedSalary
FROM Customer_Info;

-- Inspect the Balance column and Estimate Salary before converting
-- it from text to a numeric data type.

SELECT
    Balance,
    REPLACE(Balance, '€', '') AS CleanBalance
FROM Bank_Account_Info;

-- Inspect the EstimatedSalary column before
-- converting it from text to a numeric data type.

SELECT
    EstimatedSalary,
    REPLACE(EstimatedSalary, '€', '') AS CleanSalary
FROM Customer_Info;

/*
=========================================================
Data Quality Assessment Summary

Issues Identified:

✓ Duplicate CustomerId records
✓ Missing Age values
✓ NULL surname values
✓ Inconsistent Geography categories
✓ Currency symbols stored in numeric fields
✓ Empty column created during CSV import

Outcome

The identified issues will be corrected in
02_Data_Cleaning.sql before analytical processing
and dashboard development.


=========================================================
*/

