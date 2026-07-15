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
-- Analyse customer churn across different countries.



-- Result:
-- Germany recorded the highest churn rate (32.44%),
-- followed by Spain (16.67%) and France (16.15%).

-- =====================================================
-- Section 4: Customer Behaviour Analysis
-- =====================================================

-- Analyse customer churn based on account tenure.

USE BankCustomerAnalysis;
GO

SELECT
    CASE
        WHEN b.Tenure < 3 THEN 'New Customer'
        WHEN b.Tenure < 7 THEN 'Established Customer'
        ELSE 'Loyal Customer'
    END AS TenureGroup,

    COUNT(*) AS TotalChurnedCustomers,
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
        WHEN b.Tenure < 3 THEN 'New Customer'
        WHEN b.Tenure < 7 THEN 'Established Customer'
        ELSE 'Loyal Customer'
    END


ORDER BY TotalChurnedCustomers DESC;

-- Result:
-- New customers recorded the highest churn rate
-- (21.15%), while loyal customers showed the
-- lowest churn rate (19.51%).


-- -----------------------------------------------------

-- Analyse customer churn by account balance.

USE BankCustomerAnalysis;
GO

SELECT
    CASE
        WHEN b.Balance < 50000 THEN 'Low Balance'
        WHEN b.Balance < 100000 THEN 'Medium Balance'
        ELSE 'High Balance'
    END AS AccountBalanceGroup,

    COUNT(*) AS TotalChurnedCustomers,
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
        WHEN b.Balance < 50000 THEN 'Low Balance'
        WHEN b.Balance < 100000 THEN 'Medium Balance'
        ELSE 'High Balance'
    END


ORDER BY TotalChurnedCustomers DESC;

-- Result:
-- Customers with high account balances recorded
-- the highest churn rate (25.23%), suggesting
-- high-value customers are more likely to leave.


-- -----------------------------------------------------

-- Analyse customer churn by active membership.

USE BankCustomerAnalysis;

GO

SELECT

b.IsActiveMember,

Count(b.Exited) As TotalUnactiveByActiveMember ,
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


Group By IsActiveMember;

-- Result:
-- Inactive customers recorded a significantly
-- higher churn rate (26.85%) than active
-- customers (14.27%).


-- -----------------------------------------------------

-- Analyse customer churn by number of products held.



-- Result:
-- Customers with multiple products recorded the
-- highest churn rate (85.89%), while customers
-- with two products recorded the lowest churn
-- rate (7.58%).


-- -----------------------------------------------------

-- Analyse customer churn across different credit
-- score categories.

<Credit Score Query>

-- Result:
-- Customers with poor credit scores recorded
-- the highest churn rate (22.02%), while customers
-- with good credit scores showed lower churn rates.
