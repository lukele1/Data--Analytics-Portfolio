# World Life Expectancy Project (Exploratory Data Analysis)

SELECT *
FROM world_life_expectancy
;

-- This query analyzes life expectancy changes by country over a 15-year period
-- It calculates the minimum, maximum, and total increase in life expectancy for each country
-- Results are ordered by the largest life expectancy improvements
SELECT Country,
    MIN(`Life expectancy`),
    MAX(`Life expectancy`),
    ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`), 1) AS Life_Increase_15_Years
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
    AND MAX(`Life expectancy`) <> 0
ORDER BY Life_Increase_15_Years DESC;

-- This query calculates the average life expectancy globally for each year
-- Results show the trend in average life expectancy over time, rounded to 2 decimal places
SELECT Year, 
	ROUND(AVG(`Life expectancy`), 2)
FROM world_life_expectancy
WHERE `Life expectancy` <> 0
GROUP BY Year
ORDER BY Year
;


SELECT *
FROM world_life_expectancy
;

-- This query examines the relationship between GDP and life expectancy by country
-- Results are ordered by GDP (highest to lowest) to identify wealthier nations and their life expectancy
SELECT Country,
	ROUND(AVG(`Life expectancy`), 2) AS Life_Expectancy,
    ROUND(AVG(GDP), 1) AS GDP
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Expectancy > 0
	AND GDP > 0
ORDER BY GDP DESC
;


-- This query compares life expectancy between high-GDP and low-GDP countries
-- It uses 1500 as the threshold to categorize countries into two groups
-- This analysis helps identify the correlation between economic wealth and longevity
SELECT 
SUM(CASE WHEN GDP > 1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP > 1500 THEN `Life expectancy` ELSE NULL END) High_GDP_Life_Expectancy,
SUM(CASE WHEN GDP < 1500 THEN 1 ELSE 0 END) Low_GDP_Count,
AVG(CASE WHEN GDP < 1500 THEN `Life expectancy` ELSE NULL END) Low_GDP_Life_Expectancy
FROM world_life_expectancy
;


-- This query compares life expectancy between developed and developing countries
-- It includes the count of distinct countries in each category to provide context for the averages
-- Results show 32 developed countries (avg 79.2 years) vs 161 developing countries (avg 66.83 years)
-- The 13-year life expectancy gap is significant, and the sample size difference (5x more developing countries)
-- confirms this disparity affects the majority of the world's nations
SELECT Status, 
	COUNT(DISTINCT Country), 
    ROUND(AVG(`Life expectancy`), 2) AS Life_Expectancy
FROM world_life_expectancy
GROUP BY Status
;

-- This query explores the relationship between BMI and life expectancy by country
-- It calculates the average life expectancy and average BMI for each country
-- Results are sorted by BMI (lowest to highest) to examine if lower BMI correlates with life expectancy
SELECT Country,
	ROUND(AVG(`Life expectancy`), 2) AS Life_Expectancy,
    ROUND(AVG(BMI), 1) AS BMI
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Expectancy > 0
	AND BMI > 0
ORDER BY BMI ASC
;

-- This query analyzes life expectancy and adult mortality trends for the United States over time
-- It includes a rolling total of adult mortality, which accumulates year by year for the country
-- The rolling total helps visualize the cumulative burden of adult deaths across the time period
SELECT Country,
	Year,
	`Life expectancy`,
    `Adult Mortality`,
    SUM(`Adult Mortality`)OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM world_life_expectancy
WHERE Country LIKE '%United States%'
;



















