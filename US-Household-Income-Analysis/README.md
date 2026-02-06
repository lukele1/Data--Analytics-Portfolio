# US Household Income Analysis

## Project Overview
Exploratory data analysis of US household income data examining geographic and economic patterns across states, counties, and community types. This project includes comprehensive data cleaning and explores relationships between household income and geographic characteristics.

## Dataset
* **Source**: US Census Bureau - American Community Survey (2010-2014)
* **Records**: 32,292 geographic entries
* **States**: All 50 US states plus territories
* **Key Variables**: State, County, City, Type (community classification), Mean Income, Median Income, Land Area (ALand), Water Area (AWater)

## Data Cleaning Process
* Removed duplicate records using ROW_NUMBER() window function with PARTITION BY
* Fixed state name inconsistencies ('georia' → 'Georgia', 'alabama' → 'Alabama')
* Standardized community type values ('Boroughs' → 'Borough')
* Filled missing Place values for Autauga County records
* Validated land and water area measurements for data quality
* Cleaned column name encoding issues in statistics table

## Key Findings

### 1. Income by Development Status
* **Highest income states**: District of Columbia, Connecticut, New Jersey
* **Lowest income states**: Puerto Rico, Mississippi, Arkansas
* Coastal and northeastern states show significantly higher average household income
* Southern and rural states consistently rank lower in average income

### 2. Community Type Analysis
* **Urban areas** (Cities, Municipalities) have highest average household income
* **Rural tracks and CDPs** show substantially lower income levels
* Community types with >100 records show more reliable statistical patterns
* Urban classification is a strong predictor of higher household income

### 3. Geographic Patterns
* **Land area leaders**: Alaska (1.48 trillion sq meters), Texas, California
* **Water area leaders**: Alaska (563 billion sq meters), Michigan, Florida
* Coastal states have significantly higher water area measurements
* No direct correlation between land/water area and income levels

### 4. Statistical Insights
* Mean income consistently higher than median income across all areas
* Large gap between mean and median suggests income inequality within regions
* Community types with fewer than 100 records show unreliable income patterns
* Urban-rural income divide is substantial across all states

## SQL Techniques Used
* **Data Cleaning**: ROW_NUMBER(), PARTITION BY, UPDATE statements, ALTER TABLE
* **Aggregate Functions**: SUM, AVG, COUNT, ROUND
* **Joins**: INNER JOIN to combine geographic and income data
* **Grouping & Filtering**: GROUP BY with multiple columns, HAVING clause
* **Sorting & Ranking**: ORDER BY, LIMIT for top/bottom analysis
* **Conditional Filtering**: WHERE clauses to exclude invalid data (Mean <> 0)
* **Subqueries**: Nested queries for duplicate detection and complex filtering

## Tools & Technologies
* **Database**: MySQL Workbench
* **Analysis Type**: Data Cleaning & Exploratory Data Analysis (EDA)
* **Key Skills**: Data quality validation, geographic analysis, income analysis

## Insights & Observations
* Economic development and urbanization strongly influence household income
* The income gap between urban and rural communities remains substantial
* Data quality issues (duplicates, typos, missing values) required careful preprocessing
* Geographic features (land/water area) do not directly predict income levels
* State-level averages mask significant within-state variation

## Future Analysis Opportunities
* Create interactive Tableau/Power BI visualizations by state and community type
* Analyze income inequality metrics within states and counties
* Compare income trends across multiple census periods (time-series analysis)
* Build predictive models for household income based on geographic features
* Regional clustering analysis to identify similar economic zones
* Correlation analysis between population density and income levels
