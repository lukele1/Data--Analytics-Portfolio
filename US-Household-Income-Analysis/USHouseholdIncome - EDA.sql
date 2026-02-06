# US Household Income Exploratory Data Analysis

SELECT * 
FROM us_household_income
;

SELECT *
FROM us_household_income_statistics
;

# Exploratory: States ordered by water area (descending)
SELECT State_Name, SUM(Aland), SUM(Awater) 
FROM us_household_income
GROUP BY State_Name
ORDER BY 3 DESC 
;

# Top 10 states by total land area
SELECT State_Name, SUM(Aland), SUM(Awater) 
FROM us_household_income
GROUP BY State_Name
ORDER BY 2 DESC 
LIMIT 10
;


# Top 10 states by total water area
SELECT State_Name, SUM(Aland), SUM(Awater) 
FROM us_household_income
GROUP BY State_Name
ORDER BY 3 DESC 
LIMIT 10
;

# Full join of geography and income statistics (excluding zero mean values)
SELECT *
FROM us_household_income hi
INNER JOIN us_household_income_statistics his
	ON hi.id = his.id
WHERE Mean <> 0
;

# Detailed view: State, county, community type, and income statistics 
SELECT hi.State_Name,
	County,
	Type,
    `Primary`,
    Mean, 
    Median
FROM us_household_income hi
INNER JOIN us_household_income_statistics his
	ON hi.id = his.id
WHERE Mean <> 0
;

# Bottom 10 states by average mean household income
SELECT hi.State_Name,
    ROUND(AVG(Mean), 1), 
    ROUND(AVG(Median), 1)
FROM us_household_income hi
INNER JOIN us_household_income_statistics his
	ON hi.id = his.id
WHERE Mean <> 0
GROUP BY hi.State_Name
ORDER BY 2
LIMIT 10
;

# Top 10 states by average mean household income
SELECT hi.State_Name,
    ROUND(AVG(Mean), 1), 
    ROUND(AVG(Median), 1)
FROM us_household_income hi
INNER JOIN us_household_income_statistics his
	ON hi.id = his.id
WHERE Mean <> 0
GROUP BY hi.State_Name
ORDER BY 2 DESC
LIMIT 10
;

# Top 20 community types by average mean income (with counts)
SELECT Type,
	COUNT(Type),
    ROUND(AVG(Mean), 1), 
    ROUND(AVG(Median), 1)
FROM us_household_income hi
INNER JOIN us_household_income_statistics his
	ON hi.id = his.id
WHERE Mean <> 0
GROUP BY Type
ORDER BY 3 DESC
LIMIT 20
;

# Top 20 community types by average median income (with counts)
SELECT Type,
	COUNT(Type),
    ROUND(AVG(Mean), 1), 
    ROUND(AVG(Median), 1)
FROM us_household_income hi
INNER JOIN us_household_income_statistics his
	ON hi.id = his.id
WHERE Mean <> 0
GROUP BY Type
ORDER BY 4 DESC
LIMIT 20
;

# Investigate: All records where Type is 'Community'
SELECT *
FROM us_household_income
WHERE Type = 'Community'
;

# Community types with statistically significant sample sizes (>100 records)
# Ordered by average median income to show highest-earning community types
# Filters out outliers like Municipality, CDP, County with insufficient data
SELECT Type,
	COUNT(Type),
    ROUND(AVG(Mean), 1), 
    ROUND(AVG(Median), 1)
FROM us_household_income hi
INNER JOIN us_household_income_statistics his
	ON hi.id = his.id
WHERE Mean <> 0
GROUP BY 1
HAVING COUNT(Type) > 100
ORDER BY 4 DESC
LIMIT 20
;

# Average household income by city (within each state), ordered by highest mean income
SELECT hi.State_Name,
	City,
    ROUND(AVG(Mean),1),
    ROUND(AVG(Median),1)
FROM us_household_income hi
INNER JOIN us_household_income_statistics his
	ON hi.id = his.id
GROUP BY hi.State_Name, City
ORDER BY 3 DESC
;

















































































