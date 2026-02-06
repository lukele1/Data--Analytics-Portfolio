# HR Analytics Dashboard

## Project Overview
Exploratory data analysis of HR employee data examining attrition patterns across departments, demographics, and compensation levels. This project includes comprehensive data cleaning and explores relationships between employee characteristics and attrition rates.

## Dataset
* **Source**: HR employee data from organizational records (2016-2020)
* **Records**: 1,470 employee records
* **Attrition**: 238 employees left (16% attrition rate)
* **Key Variables**: Department, Job Role, Gender, Age, Education, Salary, Years at Company, Attrition Status

## Data Cleaning Process
* Standardized gender column values (e.g., 'Female', 'female', '"Female"' → 'Female')
* Removed null values and replaced with 0 for numeric columns
* Changed data types to whole numbers after null replacement
* Validated employee count and attrition count fields for accuracy
* Ensured data consistency across all department records
* Prepared clean dataset for DAX measure calculations

## Key Findings

### #1. Attrition by Demographics
* **Gender**: 151 male employees and 87 female employees experienced attrition
* **Age Groups**: Highest attrition in 26-35 age group (116 employees)
* Young professionals (26-35) are most likely to leave the organization
* Male employees show higher absolute attrition numbers

### #2. Attrition by Education
* **Education Impact**: Life Sciences (89) and Medical (63) backgrounds have highest attrition
* **Technical Degree**: 32 employees with technical degrees left the company
* **Marketing**: 36 employees with marketing background experienced attrition
* Education background is a significant predictor of attrition patterns

### #3. Compensation Patterns
* **Salary Analysis**: Employees earning up to 5K show significantly higher attrition (163 employees)
* **Income Brackets**: 5K-10K salary range shows 49 attritions, 10K-15K shows 21 attritions
* Lower compensation levels strongly correlate with higher turnover
* Salary is the most significant factor in employee retention

### #4. Tenure & Department Insights
* **Attrition by Tenure**: Peaks in first 1-2 years (59 employees), gradually decreases over time
* **High-Risk Roles**: Research Scientists (100), Human Resources (58), Sales Representatives (44)
* **Low-Risk Roles**: Manufacturing Directors (5), Laboratory Technicians (31)
* Early career retention programs are critical for reducing turnover

## Power BI Techniques Used
* **Data Cleaning**: Power Query transformations for standardizing text values
* **DAX Measures**: Custom attrition rate calculation: SUM(hr_data[attrition_count])/SUM(hr_data[employeecount])
* **Visualizations**: Donut charts, bar charts, area charts, matrix tables
* **Interactive Elements**: Department slicers for dynamic filtering
* **Data Modeling**: Relationships between employee attributes and attrition metrics
* **Conditional Formatting**: Color-coded visualizations for better insight clarity

## Tools & Technologies
* **Power BI Desktop**: Interactive dashboard creation and data visualization
* **Power Query**: Data cleaning & exploratory data analysis (EDA)
* **DAX**: Custom measures for attrition rate calculations
* **Key Skills**: Data quality validation, HR analytics, business intelligence, dashboard design

## Insights & Observations
* Attrition rate of 16% (238 out of 1,470 employees) indicates retention challenges
* Compensation is the strongest predictor of employee turnover
* Early career employees (years 1-2) require targeted retention programs
* Research Scientist role shows concerning attrition levels (100 employees)
* Gender-based attrition patterns suggest need for diversity retention strategies
* Education background correlates significantly with attrition likelihood

## Future Analysis Opportunities
* Integrate employee satisfaction survey data for sentiment analysis
* Analyze attrition trends over time with time-series forecasting
* Build predictive attrition model using machine learning techniques
* Deep-dive analysis by manager performance and team dynamics
* Correlation analysis between promotion rates and retention
* Cost analysis of attrition impact on organizational productivity
