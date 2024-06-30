# EXPLORATORY DATA ANALYSIS 
  select *
  from layoffs_stagging2 ;
  
  select max(total_laid_off),max(percentage_laid_off)
  from layoffs_stagging2 ;
  
  
  select *
  from layoffs_stagging2 
  where percentage_laid_off = 1
  order by total_laid_off desc;
  
  
  select company,SUM(total_laid_off) 
  from layoffs_stagging2 
  group by company
  order by SUM(total_laid_off)  desc ;
  
   select min(`date`),MAX(`date`)
  from layoffs_stagging2 ;
  
  select industry,SUM(total_laid_off) 
  from layoffs_stagging2 
  group by industry
  order by SUM(total_laid_off)  desc ;
  
   select YEAR(`date`),SUM(total_laid_off) 
  from layoffs_stagging2 
  group by YEAR(`date`)
  order by YEAR(`date`) desc ;
  
   select stage,SUM(total_laid_off) 
  from layoffs_stagging2 
  group by stage
  order by SUM(total_laid_off)  desc ;
  
   select company,SUM(percentage_laid_off) 
  from layoffs_stagging2 
  group by company
  order by SUM(percentage_laid_off)  desc ;
  
  select SUBSTRING(`date`,1,7) AS `Month`,SUM(total_laid_off)
  from layoffs_stagging2
  where SUBSTRING(`date`,1,7) IS NOT NULL
  group by `month`
  ORDER BY `month` asc ;
  
  WITH Rolling_total AS
  (select SUBSTRING(`date`,1,7) AS `Month`,SUM(total_laid_off) AS total_off
  from layoffs_stagging2
  where SUBSTRING(`date`,1,7) IS NOT NULL
  group by `month`
  ORDER BY `month` asc)
  select `month`,total_off,
  SUM(total_off) OVER(ORDER BY `month`) AS rolling_total
  from Rolling_total ;
  
  select company,SUM(total_laid_off) 
  from layoffs_stagging2 
  group by company
  order by SUM(total_laid_off)  desc ;
  
   select company,YEAR(`date`),SUM(total_laid_off) 
  from layoffs_stagging2 
  group by company,YEAR(`date`)
  order by SUM(total_laid_off) DESC ;
  
  WITH Company_Year(company,years,total_laid_off) AS
  (select company,YEAR(`date`),SUM(total_laid_off) 
  from layoffs_stagging2 
  group by company,YEAR(`date`)
  ), Company_Year_Rank AS
  (select *,
  DENSE_RANK()OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
  from Company_Year
  where years IS NOT NULL
  )
  select * 
  from Company_Year_Rank 
  where Ranking <= 5 ;
  
  
  
  
  
  
  