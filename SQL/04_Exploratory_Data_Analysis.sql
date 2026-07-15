/*
=========================================================
Script: 04_Exploratory_Data_Analysis.sql
Project: Bank Customer Churn Analysis
Author: Nonzuleko Mbanjwa
Date: July 2026

Description:
This script performs exploratory data analysis (EDA)
on the cleaned bank customer dataset to identify
patterns, trends, and potential factors influencing
customer churn.

Objectives:
- Understand customer demographics
- Measure customer churn
- Explore customer behaviour
- Identify patterns associated with churn
- Generate insights for business decision-making

=========================================================
*/
USE BankCustomerAnalysis;
GO

-- =====================================================
-- Section 1: Dataset Overview
-- =====================================================

-- Total number of customers.

SELECT
    COUNT(*) AS TotalCustomers
FROM Customer_Info;

-- Total number of account records.

SELECT
    COUNT(*) AS TotalAccounts
FROM Bank_Account_Info;

-- =====================================================
-- Section 2: Overall Churn Analysis
-- =====================================================
-- Overall customer churn.

SELECT

    COUNT(*) AS TotalCustomers,

    SUM(
        CASE
            WHEN Exited = 1 THEN 1
            ELSE 0
        END
    ) AS ChurnedCustomers,

    SUM(
        CASE
            WHEN Exited = 0 THEN 1
            ELSE 0
        END
    ) AS RetainedCustomers,

    ROUND(
        (
            SUM(
                CASE
                    WHEN Exited = 1 THEN 1
                    ELSE 0
                END
            ) * 100.0
        ) / COUNT(*),
    2) AS OverallChurnRate

FROM Bank_Account_Info;


