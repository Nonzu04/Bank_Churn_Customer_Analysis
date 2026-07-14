
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

