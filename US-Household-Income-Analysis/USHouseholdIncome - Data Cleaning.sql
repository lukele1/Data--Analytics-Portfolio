# US Household Income Data Cleaning

SELECT * 
FROM us_project.us_household_income;

SELECT * 
FROM us_project.us_household_income_statistics;


# Fixing us_household_income_statistics column name
# This removes the characters 'ï»¿' that sometimes appear
ALTER TABLE us_household_income_statistics RENAME COLUMN `ï»¿id` TO `id`;

# DUPLICATES

# Checking row count in the main household income table
SELECT COUNT(id) 
FROM us_household_income;
# Checking row count in the statistics table
SELECT COUNT(id) 
FROM us_household_income_statistics;

# Getting row number for each record, partitioned by id
# This assigns a sequential number to each occurrence of the same id
# If an id appears only once, it gets row_num = 1
# If an id appears multiple times (duplicates), they get row_num = 1, 2, 3, etc.
SELECT row_id,
	id,
	ROW_NUMBER()OVER(PARTITION BY id ORDER BY row_id) AS row_num
FROM us_household_income
;

# Using subquery to identify the specific rows that are duplicates
# This filters to show only records where row_num > 1, meaning they are duplicate entries
# These are the records that need to be removed or investigated
SELECT *
FROM (SELECT row_id,
			id,
			ROW_NUMBER()OVER(PARTITION BY id ORDER BY row_id) AS row_num
		FROM us_household_income) AS table_row
WHERE row_num >1
;
# Testing query to preview which duplicate rows will be deleted
# This shows all the duplicate records that will be removed
SELECT *
FROM us_household_income
WHERE row_id IN (
			SELECT row_id
			FROM (SELECT row_id,
			ROW_NUMBER()OVER(PARTITION BY id ORDER BY row_id) AS row_num
			FROM us_household_income) AS table_row
			WHERE row_num > 1)
;
# Deleting duplicate rows from the us_household_income table
# This removes all duplicate entries while keeping the first occurrence
DELETE FROM us_household_income
WHERE row_id IN (
			SELECT row_id
			FROM (SELECT row_id,
			ROW_NUMBER()OVER(PARTITION BY id ORDER BY row_id) AS row_num
			FROM us_household_income) AS table_row
			WHERE row_num > 1)
;

# Now checking for duplicates in the us_household_income_statistics table
# Assigning row numbers to each id group to identify potential duplicates
SELECT id,
	ROW_NUMBER()OVER(PARTITION BY id ORDER BY id) AS row_num
FROM us_household_income_statistics
;

# Filtering to see if there are any duplicate records in the statistics table
# If this returns no rows, then there are no duplicates
# Result: No duplicates found in this table - all ids are unique
SELECT *
FROM(
	SELECT id,
	ROW_NUMBER()OVER(PARTITION BY id ORDER BY id) AS row_num
	FROM us_household_income_statistics) AS table_row_2
WHERE row_num > 1
;


-- Now working on fixing incorrect data formats
-- This includes: misspellings, wrong capitalization (upper/lower case), typos, etc.

# Viewing all data from both tables to understand the data structure
SELECT * 
FROM us_project.us_household_income;

SELECT * 
FROM us_project.us_household_income_statistics;

# Counting occurrences of each State_Name to identify potential duplicates or variations
# This helps spot states that appear with different spellings or capitalizations
SELECT State_Name, 
	COUNT(State_Name)
FROM us_household_income
GROUP BY State_Name
;

# Getting a distinct list of all state names, sorted alphabetically
# This makes it easier to visually spot misspellings, typos, or capitalization issues
SELECT DISTINCT State_Name 
FROM us_household_income
ORDER BY 1
;

# Fixing misspelled state name: 'georia' should be 'Georgia'
UPDATE us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia';

# Fixing incorrect capitalization: 'alabama' should be 'Alabama'
UPDATE us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama';


# Investigating records in Autauga County to identify data issues
SELECT * 
FROM us_household_income
WHERE County = 'Autauga County'
ORDER BY 1
;

# Fixing missing Place name in Autauga County
# The Place field was blank/NULL for the record where City = 'Vinemont' in Autauga County
# Filling in the missing Place value with 'Autaugaville' based on the county location
UPDATE us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont'
;


# Counting occurrences of each Type to identify inconsistencies or variations
SELECT Type,
	COUNT(Type)
FROM us_household_income
GROUP BY Type
;

# Standardizing Type values: changing 'Boroughs' to 'Borough' 
# This ensures consistency in the Type field across all records
UPDATE us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs'
;

# Checking for records with missing or zero land area (ALand)
# This identifies potential data quality issues where land area wasn't recorded
SELECT Aland, Awater
FROM us_household_income
WHERE (Aland = 0 OR Aland = '' OR Aland IS NULL)
;

# Checking for records with missing or zero water area (AWater)
# This identifies potential data quality issues where water area wasn't recorded
SELECT Aland, Awater
FROM us_household_income
WHERE (Awater = 0 OR Awater = '' OR Awater IS NULL)
;

# Checking for records where BOTH land area AND water area are missing/zero
# These records may be incomplete or problematic since every geographic area 
# should have at least some land or water area recorded
SELECT Aland, Awater
FROM us_household_income
WHERE (Awater = 0 OR Awater = '' OR Awater IS NULL)
AND  (Aland = 0 OR Aland = '' OR Aland IS NULL)
;


























