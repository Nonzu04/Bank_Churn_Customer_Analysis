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

-- =====================================================
-- Section 3: Customer Demographic Analysis
-- =====================================================

-- =====================================================
-- Section 3: Customer Demographic Analysis
-- =====================================================

-- Analyse customer churn across different age groups.
-- The objective is to determine which age segment has
-- the highest churn rate.

SELECT

    CASE
        WHEN c.Age < 40 THEN 'Young Adult'
        WHEN c.Age < 60 THEN 'Middle Age'
        ELSE 'Senior'
    END AS AgeGroup,

    COUNT(*) AS TotalCustomers,

    SUM(
        CASE
            WHEN b.Exited = 1 THEN 1
            ELSE 0
        END
    ) AS ChurnedCustomers,

    ROUND(
        (
            SUM(
                CASE
                    WHEN b.Exited = 1 THEN 1
                    ELSE 0
                END
            ) * 100.0
        ) / COUNT(*),
    2) AS ChurnRate

FROM Customer_Info AS c

INNER JOIN Bank_Account_Info AS b
    ON c.CustomerId = b.CustomerId

GROUP BY
    CASE
        WHEN c.Age < 40 THEN 'Young Adult'
        WHEN c.Age < 60 THEN 'Middle Age'
        ELSE 'Senior'
    END

ORDER BY ChurnRate DESC;

-- Result:
-- Middle-aged customers recorded the highest churn rate
-- (37.09%), indicating that this age segment is the
-- most likely to leave the bank.

-- -----------------------------------------------------

-- Analyse customer churn by gender.

USE BankCustomerAnalysis;

GO

SELECT

c.Gender,

Count(b.Exited) As TotalUnactiveByGender,
ROUND(
    (
        SUM(
            CASE
                WHEN b.Exited = 1 THEN 1
                ELSE 0
            END
        ) * 100.0
    ) / COUNT(*),
2) AS ChurnRate


FROM Customer_Info AS c

inner JOIN Bank_Account_Info AS b

ON c.CustomerId = b.CustomerId



Group By Gender;

-- Result:
-- Female customers recorded a higher churn rate
-- (25.07%) compared to male customers (16.46%).


-- -----------------------------------------------------

