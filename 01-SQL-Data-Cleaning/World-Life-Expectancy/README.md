# World Life Expectancy - Data Cleaning Project

SQL data cleaning project on global health dataset.

## Project Overview
- **Records:** 2,941 rows
- **Countries:** 193
- **Years:** 2007-2022
- **Tools:** MySQL

## Data Cleaning Tasks Completed

### 1. Duplicate Removal
- Identified duplicate Country/Year combinations using `GROUP BY` and `HAVING`
- Used `ROW_NUMBER()` window function to flag duplicates
- Removed 3 duplicate records (Ireland 2022, Senegal 2009, Zimbabwe 2019)

### 2. Missing Status Values
- Filled blank Status fields with 'Developing' or 'Developed'
- Used self-join to match countries with existing status values

### 3. Missing Life Expectancy Values
- Calculated missing values using average of previous and next year
- Used self-join technique to access adjacent years' data

## SQL Techniques Used
- Window Functions (`ROW_NUMBER()`)
- Self-Joins (multiple table aliases)
- Subqueries
- `GROUP BY` and `HAVING` clauses
- `UPDATE` statements with `JOIN`

## Files
- `data_cleaning.sql` - Complete SQL queries with detailed comments
- `WorldLifeExpectancy.csv` - Original dataset

## Key Learnings
- How to identify and remove duplicates using window functions
- Self-join techniques for filling missing values
- Importance of previewing changes before executing DELETE/UPDATE statements
- Best practices for data cleaning workflows

---

[← Back to SQL Data Cleaning Projects](../)
