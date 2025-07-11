-- DATA CLEANING

SELECT *
FROM layoffs;

-- 1. Duplicates
-- 2. Standarize the Data
-- 3. No Null
-- 4. Remove Any Columns

CREATE TABLE layoff_staging
LIKE layoffs;

INSERT layoff_staging
SELECT *
FROM layoffs;

SELECT * ,
ROW_NUMBER() OVER (PARTITION BY
company,industry,total_laid_off,percentage_laid_off,'date') AS row_Num
FROM layoff_staging;

WITH duplicate_cte AS
(
SELECT * ,
ROW_NUMBER() OVER (PARTITION BY company,location,
industry,total_laid_off,percentage_laid_off,'date' ,
stage,country,funds_raised_millions) AS row_Num
FROM layoff_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num> 1 ;

SELECT *
FROM layoff_staging
WHERE company = 'Cazoo';

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL ,
  `row_num`INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

INSERT INTO layoffs_staging2
SELECT * ,
ROW_NUMBER() OVER (PARTITION BY company,location,
industry,total_laid_off,percentage_laid_off,'date' ,
stage,country,funds_raised_millions) AS row_Num
FROM layoff_staging ;

DELETE 
FROM layoffs_staging2
WHERE row_num > 1;

SELECT * 
FROM layoffs_staging2 ;

-- Standardizing data
SELECT company, TRIM(company)
FROM layoffs_staging2 ;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT * 
FROM layoffs_staging2 ;

SELECT DISTINCT industry
FROM layoffs_staging2 
ORDER BY 1 ;

SELECT *
FROM layoffs_staging2 
WHERE industry LIKE 'Crypto%' ;

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%' ;

SELECT DISTINCT country
FROM layoffs_staging2 
ORDER BY 1;

SELECT *
FROM layoffs_staging2 
WHERE country LIKE 'United States%' ;

SELECT DISTINCT country, TRIM(trailing '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = TRIM(trailing '.' FROM country)
WHERE industry LIKE 'United States%' ;

SELECT *
FROM layoffs_staging2; 

SELECT `date`,
STR_TO_DATE(`date`,'%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`,'%m/%d/%Y') ;

SELECT `date`
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoffs_staging2;

-- NO NULLS

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL ;


UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '' ;

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

SELECT *
FROM layoffs_staging2
WHERE company LIKE 'Bally%';

SELECT *
FROM layoffs_staging2 T1
JOIN layoffs_staging2 T2
	ON T1.company = T2.company
WHERE (T1.industry IS NULL OR T1.industry = '')
AND T2.industry IS NOT NULL;

UPDATE layoffs_staging2 T1
JOIN layoffs_staging2 T2
	ON T1.company = T2.company
SET T1.industry = T2.industry
WHERE T1.industry IS NULL 
AND T2.industry IS NOT NULL;

SELECT *
FROM layoffs_staging2 ;


SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL ;

DELETE 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL ;

SELECT *
FROM layoffs_staging2;


ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

