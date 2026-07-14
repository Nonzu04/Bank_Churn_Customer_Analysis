/*
=========================================================
Script: 03_Data_Validation.sql
Project: Bank Customer Churn Analysis
Author: Nonzuleko Mbanjwa
Date: July 2026

Description:
This script validates the cleaned Customer_Info and
Bank_Account_Info tables to ensure that all data
quality issues have been resolved. Validation confirms
that the dataset is accurate, consistent, and ready
for exploratory analysis and dashboard development.

Validation Tasks:
- Create Primary Keys
- Verify referential integrity
- Validate table relationships
- Validate INNER JOIN results
- Confirm dataset readiness

=========================================================
*/
USE BankCustomerAnalysis;
GO

-- =====================================================
-- Section 1: Create Primary Keys
-- =====================================================

-- Create a Primary Key on Customer_Info.

ALTER TABLE Customer_Info
ADD CONSTRAINT PK_Customer_Info
PRIMARY KEY (CustomerId);

-- Result:
-- CustomerId is now enforced as a unique identifier.

-- Create a Primary Key on Bank_Account_Info.

ALTER TABLE Bank_Account_Info
ADD CONSTRAINT PK_Bank_Account_Info
PRIMARY KEY (CustomerId);

-- Result:
-- CustomerId is now enforced as a unique identifier.

-- =====================================================
-- Section 2: Referential Integrity Validation
-- =====================================================

-- Check for customers that do not have
-- matching account records.

SELECT c.CustomerId
FROM Customer_Info AS c
LEFT JOIN Bank_Account_Info AS b
ON c.CustomerId = b.CustomerId
WHERE b.CustomerId IS NULL;

-- Check for account records that do not have
-- matching customer records.

SELECT b.CustomerId
FROM Bank_Account_Info AS b
LEFT JOIN Customer_Info AS c
ON b.CustomerId = c.CustomerId
WHERE c.CustomerId IS NULL;

-- Result:
-- Both queries returned zero rows,
-- confirming referential integrity.
