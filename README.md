# Data Cleaning Project (SQL)

## 🧹 Overview
This project involved cleaning and standardizing a dataset of company layoffs using SQL. The goal was to prepare the raw data for future analysis by handling duplicates, formatting issues, nulls, and inconsistencies.

## 🛠 Tools Used
- MySQL

## 🔧 Cleaning Steps Performed
1. Removed duplicate records using `ROW_NUMBER()`
2. Standardized text fields using `TRIM()` and `LIKE` statements
3. Corrected inconsistent values (e.g., "Crypto%" → "Crypto")
4. Converted date fields into proper `DATE` format
5. Replaced empty strings with NULLs and filled missing industry data where possible
6. Removed rows with no layoff data
7. Final cleanup by dropping temporary columns

## 📌 Key Highlights
- Used CTEs and staging tables for safe transformation
- Applied string functions and data type conversion for standardization
- Improved data quality for better downstream analysis




