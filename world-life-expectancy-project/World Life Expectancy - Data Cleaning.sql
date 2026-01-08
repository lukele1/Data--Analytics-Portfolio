-- Initial data exploration
SELECT * 
FROM world_life_expectancy;


-- STEP 1: IDENTIFYING DUPLICATES
-- Find duplicate Country/Year combinations using GROUP BY and HAVING
-- Any count > 1 indicates duplicate records
SELECT Country,
    Year, 
    CONCAT(Country, Year) AS Country_Year,
    COUNT(CONCAT(Country, Year)) AS duplicate_count
FROM world_life_expectancy
GROUP BY Country, Year, CONCAT(Country, Year)
HAVING COUNT(CONCAT(Country, Year)) > 1;


-- Alternative method: Use ROW_NUMBER() window function to identify duplicates
-- Assigns sequential numbers to each Country/Year combination
-- Any row_num > 1 is a duplicate
SELECT *
FROM (
    SELECT Country, 
        Year,
        CONCAT(Country, Year) AS Country_Year,
        ROW_NUMBER() OVER(PARTITION BY Country, Year ORDER BY Country, Year) AS row_num
    FROM world_life_expectancy
) AS subquery
WHERE row_num > 1;


-- Preview specific duplicate rows that will be deleted (by Row_ID)
-- This shows the exact records to be removed before executing DELETE
SELECT *
FROM world_life_expectancy
WHERE Row_ID IN (
    SELECT Row_ID
    FROM (
        SELECT Row_ID,
            Country, 
            Year,
            CONCAT(Country, Year) AS Country_Year,
            ROW_NUMBER() OVER(PARTITION BY Country, Year ORDER BY Country, Year) AS row_num
        FROM world_life_expectancy
    ) AS row_table
    WHERE row_num > 1
);


-- Delete duplicate records, keeping only the first occurrence (row_num = 1)
-- Removed 3 duplicates: Ireland 2022, Senegal 2009, Zimbabwe 2019
DELETE FROM world_life_expectancy
WHERE Row_ID IN (
    SELECT Row_ID
    FROM (
        SELECT Row_ID,
            Country, 
            Year,
            CONCAT(Country, Year) AS Country_Year,
            ROW_NUMBER() OVER(PARTITION BY Country, Year ORDER BY Country, Year) AS row_num
        FROM world_life_expectancy
    ) AS row_table
    WHERE row_num > 1
);


-- Verify duplicates have been removed
SELECT * 
FROM world_life_expectancy;


-- STEP 2: FILLING MISSING STATUS VALUES
-- Identify all rows where Status field is blank
SELECT *
FROM world_life_expectancy
WHERE Status = '';


-- Check available Status values in the dataset
-- Results: 'Developing' and 'Developed' are the only two valid values
SELECT DISTINCT(Status)
FROM world_life_expectancy
WHERE Status <> '';


-- Preview countries currently marked as 'Developing'
SELECT DISTINCT(Country)
FROM world_life_expectancy
WHERE Status = 'Developing';


-- Update blank Status values to 'Developing' for countries that have 'Developing' status in other years
-- Uses self-join to match countries with their existing status
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
    ON t1.Country = t2.Country
SET t1.Status = 'Developing'
WHERE t1.Status = ''
  AND t2.Status <> ''
  AND t2.Status = 'Developing';


-- Update blank Status values to 'Developed' for countries that have 'Developed' status in other years
-- Uses self-join to match countries with their existing status
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
    ON t1.Country = t2.Country
SET t1.Status = 'Developed'
WHERE t1.Status = ''
  AND t2.Status <> ''
  AND t2.Status = 'Developed';


-- STEP 3: FILLING MISSING LIFE EXPECTANCY VALUES
-- Identify all rows where Life Expectancy is blank
SELECT * 
FROM world_life_expectancy
WHERE `Life expectancy` = '';


-- View Life Expectancy data for context and validation
SELECT Country,
    Year,
    `Life expectancy`
FROM world_life_expectancy;
-- WHERE `Life expectancy` = ''


-- Preview calculation: Show blank Life Expectancy alongside previous year, next year, and calculated average
-- Uses self-join to get adjacent years' data (t2 = previous year, t3 = next year)
-- Formula: (previous_year + next_year) / 2
SELECT t1.Country, t1.Year, t1.`Life expectancy`,
       t2.Country, t2.Year, t2.`Life expectancy`,
       t3.Country, t3.Year, t3.`Life expectancy`,
       ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2, 1) AS calculated_avg
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
    ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1  -- t2 is the previous year
JOIN world_life_expectancy t3
    ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1  -- t3 is the next year
WHERE t1.`Life expectancy` = '';


-- Update blank Life Expectancy values with average of previous and next year
-- Uses self-join technique to access adjacent years' data
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
    ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1  -- Previous year
JOIN world_life_expectancy t3
    ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1  -- Next year
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2, 1)
WHERE t1.`Life expectancy` = '';