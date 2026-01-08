# World Life Expectancy Analysis

## Project Overview
Exploratory data analysis of global life expectancy data spanning multiple years and countries. This project includes comprehensive data cleaning and explores relationships between life expectancy and various socioeconomic and health factors.

## Dataset
- **Source**: World Life Expectancy dataset
- **Records**: 2,941 rows
- **Countries**: 193 unique countries
- **Time Span**: 15-year period
- **Key Variables**: Life expectancy, GDP, Adult Mortality, BMI, Status (Developed/Developing), Measles, Polio, Diphtheria, HIV/AIDS

## Data Cleaning Process
- Removed duplicate records using ROW_NUMBER() window function
- Filled missing Status values (Developed/Developing) using self-joins
- Imputed blank life expectancy values by averaging adjacent years
- Ensured data quality by filtering zero values in analysis

## Key Findings

### 1. Development Status Impact
- **Developed countries**: Average life expectancy of 79.2 years (32 countries)
- **Developing countries**: Average life expectancy of 66.83 years (161 countries)
- **13-year gap** between developed and developing nations
- 83% of countries in dataset are classified as developing

### 2. Economic Correlation
- Strong positive correlation between GDP and life expectancy
- Countries with GDP > 1500 show significantly higher average life expectancy
- Lower GDP countries consistently have lower life expectancy outcomes

### 3. Temporal Trends
- Global average life expectancy shows upward trend over the analysis period
- Individual countries show varying rates of improvement
- Some countries improved life expectancy by over 20 years during the 15-year span

### 4. Country-Specific Analysis
- Analyzed rolling totals of adult mortality for trend visualization
- United States data examined for longitudinal patterns
- Identified countries with the largest life expectancy gains

## SQL Techniques Used
- **Data Cleaning**: ROW_NUMBER(), Self-joins, UPDATE statements
- **Aggregate Functions**: AVG, MIN, MAX, SUM, COUNT
- **Grouping & Filtering**: GROUP BY, HAVING clauses
- **Window Functions**: OVER(), PARTITION BY for rolling calculations
- **Conditional Logic**: CASE statements for categorization
- **String Operations**: CONCAT for composite keys
- **Subqueries**: Nested queries for complex filtering

## Tools & Technologies
- **Database**: MySQL
- **Analysis Type**: Exploratory Data Analysis (EDA)
- **Key Skills**: Data cleaning, statistical analysis, window functions

## Insights & Observations
- Economic development strongly influences population health outcomes
- The life expectancy gap between developed and developing nations remains substantial
- Data quality issues (blanks, duplicates) required careful preprocessing
- Temporal analysis reveals positive global health trends over time

## Future Analysis Opportunities
- Investigate BMI data quality and correlation with life expectancy
- Analyze impact of disease prevalence (HIV/AIDS, Measles) on mortality
- Regional comparisons (continents, geographic clusters)
- Predict life expectancy using multiple regression models
- Time series forecasting for future trends
