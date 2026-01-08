# World Life Expectancy Project (Data Cleaning)


SELECT * 
FROM world_life_expectancy
;


SELECT Country,
	Year, 
    CONCAT(Country, Year),
    COUNT(CONCAT(Country, Year))
FROM world_life_expectancy
GROUP BY Country, Year, CONCAT(Country, Year)
HAVING COUNT(CONCAT(Country, Year)) > 1
;

# Assign Row_Number to each country/year combination to finds duplicate(anything that isn't 1 is duplicate
SELECT *
FROM (SELECT Country, 
    Year,
    CONCAT(Country, Year) AS Country_Year,
    ROW_NUMBER() OVER(PARTITION BY Country, Year ORDER BY Country, Year) AS row_num
FROM world_life_expectancy) AS subquery
WHERE row_num > 1
;

SELECT *
FROM world_life_expectancy
WHERE Row_ID IN (
			SELECT Row_ID
				FROM (SELECT Row_ID,
							Country, 
							Year,
							CONCAT(Country, Year) AS Country_Year,
							ROW_NUMBER() OVER(PARTITION BY Country, Year ORDER BY Country, Year) AS row_num
						FROM world_life_expectancy) AS row_table
				WHERE row_num > 1)
;

DELETE FROM world_life_expectancy
WHERE Row_ID IN (
			SELECT Row_ID
				FROM (SELECT Row_ID,
							Country, 
							Year,
							CONCAT(Country, Year) AS Country_Year,
							ROW_NUMBER() OVER(PARTITION BY Country, Year ORDER BY Country, Year) AS row_num
						FROM world_life_expectancy) AS row_table
				WHERE row_num > 1)
;


SELECT * 
FROM world_life_expectancy
;

# Working with blank values 
SELECT *
FROM world_life_expectancy
WHERE Status = ''
;

# This is to see what kind of status is available to be fill in for blanks
SELECT DISTINCT(Status)
FROM world_life_expectancy
;

SELECT DISTINCT(Country)
FROM world_life_expectancy
WHERE Status = 'Developing'
;

# All of the blank values of developing country have been updated 
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country
SET t1.Status = 'Developing'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developing'
;

# All of the blank values of developed country have been updated 
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country
SET t1.Status = 'Developed'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developed'
;

# Now we are working with life expectancy
SELECT * 
FROM world_life_expectancy
WHERE `Life expectancy` = ''
;

SELECT Country,
	Year,
    `Life expectancy`
FROM world_life_expectancy
#WHERE `Life expectancy` = ''
;

SELECT t1.Country, t1.Year, t1.`Life expectancy`,
   t2.Country,t2.Year, t2.`Life expectancy`,
   t3.Country,t3.Year, t3.`Life expectancy`,
ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2, 1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country
    AND t1.year = t2.year - 1
JOIN world_life_expectancy t3
	ON t1.country = t3.country
    AND t1.year = t3.year + 1
WHERE t1.`Life expectancy` = ''
;


UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country
    AND t1.year = t2.year - 1
JOIN world_life_expectancy t3
	ON t1.country = t3.country
    AND t1.year = t3.year + 1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2, 1)
WHERE  t1.`Life expectancy` = ''
;































