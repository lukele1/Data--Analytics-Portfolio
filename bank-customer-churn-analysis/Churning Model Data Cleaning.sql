-- Dataset info
SELECT 
    COUNT(*) AS total_records,
    COUNT(DISTINCT CustomerId) AS unique_Id,
    COUNT(*) - COUNT(DISTINCT CustomerId) AS potential_duplicates
FROM churn_modelling;

-- see all the columns
SELECT *
FROM churn_modelling
LIMIT 5;

-- check duplicates
SELECT *
FROM (
    SELECT 
        *,
        ROW_NUMBER() OVER(
            PARTITION BY CustomerId 
            ORDER BY CustomerId
        ) AS row_num
    FROM churn_modelling
) AS ranked
WHERE row_num > 1;

-- No duplicates but if there are then this step we delete the duplicate but make sure to have a backup dataset

-- check Null
-- quick check for any null 
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN RowNumber IS NULL 
             OR CustomerId IS NULL 
             OR Surname IS NULL
             OR CreditScore IS NULL
             OR Geography IS NULL
             OR Gender IS NULL
             OR Age IS NULL
             OR Tenure IS NULL
             OR Balance IS NULL
             OR NumOfProducts IS NULL
             OR HasCrCard IS NULL
             OR IsActiveMember IS NULL
             OR EstimatedSalary IS NULL
             OR Exited IS NULL
        THEN 1 ELSE 0 END) AS rows_with_any_null,
    COUNT(*) - SUM(CASE WHEN RowNumber IS NULL 
                        OR CustomerId IS NULL 
                        OR Surname IS NULL
                        OR CreditScore IS NULL
                        OR Geography IS NULL
                        OR Gender IS NULL
                        OR Age IS NULL
                        OR Tenure IS NULL
                        OR Balance IS NULL
                        OR NumOfProducts IS NULL
                        OR HasCrCard IS NULL
                        OR IsActiveMember IS NULL
                        OR EstimatedSalary IS NULL
                        OR Exited IS NULL
                   THEN 1 ELSE 0 END) AS completely_clean_rows
FROM churn_modelling;

-- No Null now I will check for empty/blank string
SELECT 
    SUM(CASE WHEN Surname = '' THEN 1 ELSE 0 END) AS surname_blanks,
    SUM(CASE WHEN Geography = '' THEN 1 ELSE 0 END) AS geography_blanks,
    SUM(CASE WHEN Gender = '' THEN 1 ELSE 0 END) AS gender_blanks
FROM churn_modelling;


SELECT 
    SUM(CASE WHEN Surname != TRIM(Surname) THEN 1 ELSE 0 END) AS surname_needs_trim,
    SUM(CASE WHEN Geography != TRIM(Geography) THEN 1 ELSE 0 END) AS geography_needs_trim,
    SUM(CASE WHEN Gender != TRIM(Gender) THEN 1 ELSE 0 END) AS gender_needs_trim
FROM churn_modelling;

-- only those columns because those are text strings the rest are numbers 
-- Now is standarization step
SELECT 
    Geography,
    COUNT(*) AS occurrences
FROM churn_modelling
GROUP BY Geography
ORDER BY UPPER(Geography), occurrences DESC;

SELECT 
    Gender,
    COUNT(*) AS occurrences
FROM churn_modelling
GROUP BY Gender
ORDER BY UPPER(Gender), occurrences DESC;

-- extra spaces
SELECT 
    SUM(CASE WHEN Surname != TRIM(Surname) THEN 1 ELSE 0 END) AS surname_spaces,
    SUM(CASE WHEN Geography != TRIM(Geography) THEN 1 ELSE 0 END) AS geography_spaces,
    SUM(CASE WHEN Gender != TRIM(Gender) THEN 1 ELSE 0 END) AS gender_spaces
FROM churn_modelling;

CREATE TABLE churn_modelling_clean AS
SELECT *
FROM churn_modelling;