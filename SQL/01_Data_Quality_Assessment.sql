
-- =====================================================
-- Section 1: Initial Data Inspection
-- =====================================================
/*
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

