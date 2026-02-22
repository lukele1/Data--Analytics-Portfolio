SELECT * FROM churn_modelling_clean;

-- Total churn rate percentage
SELECT 
    Exited,
    COUNT(*) AS customer_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM churn_modelling_clean), 2) AS percentage
FROM churn_modelling_clean
GROUP BY Exited
ORDER BY Exited;

-- Lost revenue total
SELECT 
    COUNT(*) as churned_customers,
    ROUND(SUM(Balance), 0) as total_balance_lost,
    ROUND(SUM(Balance) * 0.02, 0) as annual_revenue_lost
FROM churn_modelling
WHERE Exited = 1;

-- Calculate overall churn rate and financial impact
SELECT 
    COUNT(*) as total_customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) as churned_customers,
    ROUND(SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as churn_rate,
    ROUND(SUM(CASE WHEN Exited = 1 THEN Balance ELSE 0 END) / 1000000, 2) as balance_lost_millions,
    ROUND(SUM(CASE WHEN Exited = 1 THEN Balance ELSE 0 END) * 0.02 / 1000000, 2) as revenue_lost_millions
FROM churn_modelling;

-- Churn rate is high, so now I want to see if it varies by country
SELECT 
    Geography,
    COUNT(*) AS Total_customers,
    SUM(Exited) AS Churned_customers,
    ROUND(SUM(Exited) * 100 / COUNT(*), 2) AS Churn_rate
FROM churn_modelling_clean
GROUP BY Geography
ORDER BY Churn_rate DESC;

-- Germany has the highest churn rate, so let's look at its financial impact
SELECT 
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) as churned,
    ROUND(SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as churn_rate,
    ROUND(SUM(CASE WHEN Exited = 1 THEN Balance ELSE 0 END)/1000000, 2) as balance_lost_millions
FROM churn_modelling
WHERE Geography = 'Germany';

-- Now let's see if gender plays a role in who is leaving
SELECT 
    Gender,
    COUNT(*) AS Total_customers,
    SUM(Exited) AS Churned_customers,
    ROUND(SUM(Exited) * 100 / COUNT(*), 2) AS Churn_rate
FROM churn_modelling_clean
GROUP BY Gender
ORDER BY Churn_rate DESC;

-- Churn rate by number of products
SELECT 
    NumOfProducts,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned_customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS churn_rate
FROM churn_modelling_clean
GROUP BY NumOfProducts
ORDER BY NumOfProducts;

-- Check customer percentage and churn rate by number of products
SELECT 
    NumOfProducts,
    COUNT(*) AS customer_count,
    SUM(Exited) AS churned,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS churn_rate,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM churn_modelling_clean), 2) AS pct_of_customers
FROM churn_modelling_clean
GROUP BY NumOfProducts
ORDER BY NumOfProducts;

-- Churn rate by active member status
SELECT 
    CASE WHEN IsActiveMember = 1 THEN 'Active' ELSE 'Inactive' END AS member_status,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned_customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS churn_rate
FROM churn_modelling_clean
GROUP BY IsActiveMember
ORDER BY churn_rate DESC;

-- Churn rate by estimated salary
SELECT 
    CASE 
        WHEN EstimatedSalary < 50000 THEN '1. Under $50K'
        WHEN EstimatedSalary BETWEEN 50000 AND 100000 THEN '2. $50K-$100K'
        WHEN EstimatedSalary BETWEEN 100001 AND 150000 THEN '3. $100K-$150K'
        WHEN EstimatedSalary > 150000 THEN '4. Over $150K'
    END AS salary_range,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned_customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS churn_rate
FROM churn_modelling_clean
GROUP BY salary_range
ORDER BY salary_range;

-- Churn rate by credit score
SELECT 
    CASE 
        WHEN CreditScore < 600 THEN '1. Poor (<600)'
        WHEN CreditScore BETWEEN 600 AND 700 THEN '2. Fair (600-700)'
        WHEN CreditScore BETWEEN 701 AND 800 THEN '3. Good (701-800)'
        WHEN CreditScore > 800 THEN '4. Excellent (>800)'
    END AS credit_range,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned_customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS churn_rate
FROM churn_modelling_clean
GROUP BY credit_range
ORDER BY credit_range;

-- Churn rate by account balance
SELECT
    CASE 
        WHEN Balance = 0 THEN '1. Zero Balance'
        WHEN Balance > 0 AND Balance < 50000 THEN '2. Low ($1 - $50K)'
        WHEN Balance BETWEEN 50000 AND 100000 THEN '3. Medium ($50K - $100K)'
        WHEN Balance > 100000 THEN '4. High (> $100K)'
    END AS balance_range,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned_customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS churn_rate
FROM churn_modelling_clean
GROUP BY balance_range
ORDER BY balance_range;

-- Churn rate by tenure
SELECT 
    CASE 
        WHEN Tenure <= 2 THEN '1. New (0-2 years)'
        WHEN Tenure BETWEEN 3 AND 5 THEN '2. Medium (3-5 years)'
        WHEN Tenure BETWEEN 6 AND 8 THEN '3. Long (6-8 years)'
        WHEN Tenure > 8 THEN '4. Very Long (9+ years)'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned_customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS churn_rate
FROM churn_modelling_clean
GROUP BY tenure_group
ORDER BY tenure_group;

-- Churn rate by age group
SELECT 
    CASE 
        WHEN Age < 30 THEN '1. Under 30'
        WHEN Age BETWEEN 30 AND 40 THEN '2. 30-40'
        WHEN Age BETWEEN 41 AND 50 THEN '3. 41-50'
        WHEN Age > 50 THEN '4. Over 50'
    END AS age_group,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned_customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS churn_rate
FROM churn_modelling_clean
GROUP BY age_group
ORDER BY age_group;

-- Financial impact of churn among customers aged 40 and above
SELECT 
    COUNT(*) as churned_40plus,
    ROUND(SUM(Balance)/1000000, 2) as balance_lost_millions,
    ROUND(SUM(Balance) * 0.02 / 1000000, 2) as annual_revenue_millions
FROM churn_modelling
WHERE Exited = 1 AND Age >= 40;
