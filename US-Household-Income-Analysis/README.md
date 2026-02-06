# US Household Income Data Analysis

## Project Overview
This project demonstrates SQL data cleaning and exploratory data analysis techniques using US household income data from the 2010-2014 American Community Survey. The analysis examines income patterns across states, counties, and different community types while exploring the relationship between geographic characteristics and household income levels.

## Dataset Information
- **Source**: US Census Bureau - American Community Survey (2010-2014)
- **Records**: 32,000+ geographic entries across all 50 states
- **Key Fields**: Geographic identifiers (state, county, city), income statistics (mean, median), land/water area measurements

## Project Structure
```
US-Household-Income-Analysis/
│
├── data/
│   ├── USHouseholdIncome.csv                    # Geographic and demographic data
│   └── USHouseholdIncome_Statistics.csv         # Income statistics by area
│
├── sql_scripts/
│   ├── USHouseholdIncome_-_Data_Cleaning.sql    # Data quality and cleaning queries
│   └── USHouseholdIncome_-_EDA.sql              # Exploratory analysis queries
│
└── README.md
```

## Analysis Workflow

### 1. Data Cleaning (`USHouseholdIncome_-_Data_Cleaning.sql`)

**Key Cleaning Steps:**
- **Duplicate Removal**: Identified and removed duplicate records using window functions (ROW_NUMBER with PARTITION BY)
- **Standardization**: Fixed state name inconsistencies
  - Corrected misspelling: 'georia' → 'Georgia'
  - Fixed capitalization: 'alabama' → 'Alabama'
- **Type Standardization**: Unified community type values ('Boroughs' → 'Borough')
- **Missing Data Handling**: Filled in missing Place values for specific counties
- **Data Validation**: Checked for records with missing or zero land/water area values

**Technical Highlights:**
- Used window functions for duplicate detection
- Applied UPDATE statements for data corrections
- Validated data quality with aggregate queries

### 2. Exploratory Data Analysis (`USHouseholdIncome_-_EDA.sql`)

**Key Analysis Questions:**

1. **Geographic Analysis**
   - Top 10 states by total land area
   - Top 10 states by total water area

2. **Income Analysis by State**
   - States with highest average household income
   - States with lowest average household income
   - Comparison of mean vs median income by state

3. **Community Type Analysis**
   - Income patterns across different community types (City, Town, CDP, etc.)
   - Filtered for statistically significant sample sizes (>100 records)
   - Identified highest-earning community types

4. **City-Level Analysis**
   - Average household income by city within each state
   - Identified cities with highest mean and median income

**SQL Techniques Demonstrated:**
- INNER JOINs to combine geographic and income data
- Aggregate functions (SUM, AVG, COUNT, ROUND)
- GROUP BY with multiple columns
- HAVING clause for filtering aggregated results
- ORDER BY and LIMIT for ranking results
- WHERE conditions to filter out invalid data (Mean <> 0)

## Key Findings

### Income Insights
- **Highest Income States**: District of Columbia, Connecticut, and New Jersey lead in average household income
- **Lowest Income States**: Puerto Rico, Mississippi, and Arkansas have the lowest average household income
- **Community Types**: Urban areas and municipalities show higher average income compared to rural tracks and CDPs

### Geographic Patterns
- **Largest Land Area**: Alaska, Texas, and California dominate in total land area
- **Water Area**: Alaska, Michigan, and Florida have the most water area
- Coastal states generally show higher water area measurements

## Technical Skills Demonstrated
- **SQL Fundamentals**: SELECT, JOIN, WHERE, GROUP BY, ORDER BY
- **Data Cleaning**: Duplicate detection, data standardization, missing value handling
- **Window Functions**: ROW_NUMBER() with PARTITION BY
- **Aggregate Analysis**: COUNT, SUM, AVG with multiple grouping levels
- **Data Quality**: Validation queries and filtering techniques
- **Query Optimization**: Using subqueries and CTEs effectively

## Tools Used
- **Database**: MySQL Workbench
- **Language**: SQL
- **Dataset Format**: CSV files

## How to Use This Project

1. **Set up the database**:
```sql
   CREATE DATABASE us_project;
   USE us_project;
```

2. **Import the CSV files** into your MySQL database as:
   - `us_household_income`
   - `us_household_income_statistics`

3. **Run the cleaning script first**:
   - Execute `USHouseholdIncome_-_Data_Cleaning.sql` to prepare the data

4. **Run the exploratory analysis**:
   - Execute `USHouseholdIncome_-_EDA.sql` to generate insights

## Future Enhancements
- Add visualizations using Tableau or Power BI
- Perform time-series analysis with additional years of data
- Create calculated fields for income inequality metrics
- Analyze correlation between geographic features and income levels
- Build predictive models for income estimation

## Connect With Me
- **LinkedIn**: [Your LinkedIn URL]
- **Portfolio**: [Your Portfolio Website]
- **Email**: [Your Email]

---
*This project is part of my data analytics portfolio demonstrating SQL proficiency for data cleaning and exploratory analysis.*
