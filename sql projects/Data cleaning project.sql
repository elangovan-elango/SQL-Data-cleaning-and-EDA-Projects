select * from  layoffs;

CREATE TABLE layoffs_staging
LIKE layoffs;

select * from  layoffs_staging;

INSERT layoffs_staging
SELECT * FROM layoffs ;

select * ,
ROW_NUMBER() OVER(
PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
from  layoffs_staging;

WITH duplicate_cte AS
(select * ,
ROW_NUMBER() OVER(
PARTITION BY company,industry,total_laid_off,percentage_laid_off,`date`) AS row_num
from  layoffs_staging

)
select *from duplicate_cte where row_num > 1 ;

select * from layoffs_staging
where company='casper';

WITH duplicate_cte AS
(select * ,
ROW_NUMBER() OVER(
PARTITION BY company,industry,total_laid_off,percentage_laid_off,`date`) AS row_num
from  layoffs_staging

)
DELETE
from duplicate_cte where row_num > 1 ;



CREATE TABLE `layoffs_stagging2`(
`company` text,
`location` text,
`industry` text,
`total_laid_off` int DEFAULT NULL,
`percentage_laid_off` text,
`date` text,
`stage` text,
`country` text,
`funds_raised_millions` int DEFAULT NULL,
`row_num`int
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select * from layoffs_stagging2;

insert into layoffs_stagging2
select * ,
ROW_NUMBER() OVER(
PARTITION BY company,industry,total_laid_off,percentage_laid_off,`date`) AS row_num
from  layoffs_staging;

select * from layoffs_stagging2;

DELETE
FROM layoffs_stagging2
where row_num > 1;

select *
FROM layoffs_stagging2
where row_num > 1;

-- Standardizing data 

select company,TRIM(company) from layoffs_stagging2;

UPDATE layoffs_stagging2
set company = TRIM(company);

select *
from layoffs_stagging2
where industry like 'crypto%';

UPDATE layoffs_stagging2
set industry = 'crypto'
where industry like 'crypto%';

select distinct industry
from layoffs_stagging2;

select distinct country,TRIM(TRAILING '.' FROM country)
from layoffs_stagging2;

UPDATE layoffs_stagging2
SET country = TRIM(TRAILING '.' FROM country)
where country like 'United States%';

select * from layoffs_stagging2;

select `date`,
STR_TO_DATE(`date`,'%m/%d/%Y') 
from layoffs_stagging2 ;

UPDATE layoffs_stagging2
set `date`= STR_TO_DATE(`date`,'%m/%d/%Y') ;

select `date` from layoffs_stagging2;

ALTER TABLE layoffs_stagging2
MODIFY COLUMN `date` DATE;

select * from layoffs_stagging2
where total_laid_off IS NULL
AND percentage_laid_off IS NULL;

select t1.industry,t2.industry
from layoffs_stagging2 t1
join layoffs_stagging2 t2
  on t1.company = t2.company
  where t1.industry IS NULL 
  AND t2.industry IS NOT NULL;

UPDATE layoffs_stagging2 t1
join layoffs_stagging2 t2
  on t1.company = t2.company
  set  t1.industry = t2.industry
    where (t1.industry IS NULL or t1.industry ='')
  AND t2.industry IS NOT NULL;
  
  update layoffs_stagging2
  set industry = NULL
  where industry  = '';
  
  select *
  from  layoffs_stagging2
  where company='Airbnb';
  
  select *
  from layoffs_stagging2
  where total_laid_off IS NULL 
  AND percentage_laid_off IS NULL ;

DELETE
 from layoffs_stagging2
  where total_laid_off IS NULL 
  AND percentage_laid_off IS NULL ;
  
ALTER TABLE layoffs_stagging2
DROP COLUMN row_num;


  select *
  from layoffs_stagging2 ;

