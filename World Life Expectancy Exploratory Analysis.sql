# World Life Expectancy Project ( Exploratory Data Analysis ) 

Select *
from worldlifexpectancy
;

-- Initial exploratory analysis was to calculate the life span increase over the previous 15 years -- 
-- I noticed a trend with countries having the lowest life expectancy also had the largest increase over the years -- 
-- This would correlate due a large portion of these countries categorized as developing. As the country advances over the years, citizens life spans increase --  


SELECT 
    country,
    MIN(`Lifeexpectancy`),
    MAX(`Lifeexpectancy`),
    ROUND(MAX(`Lifeexpectancy`) - MIN(`Lifeexpectancy`),
            1) AS Life_Increase_15_Years
FROM
    worldlifexpectancy
GROUP BY country
HAVING MIN(`Lifeexpectancy`) <> 0
    AND MAX(`Lifeexpectancy`) <> 0
ORDER BY Life_Increase_15_Years DESC
;

-- In an effort to compare, I analyzed the average life expectancy for the entire data set -- 
-- Over the past 15 years, lfie expectancy globally has incrased annually -- 
-- Reasons could be as developing countries are continuing to evolve, in which leads to higher standards of life resulting in longer life spans -- 


SELECT 
    year, ROUND(AVG(`Lifeexpectancy`), 2)
FROM
    worldlifexpectancy
WHERE
    `Lifeexpectancy` <> 0
        AND `Lifeexpectancy` <> 0
GROUP BY year
ORDER BY year
;

-- Created a query to find the correlation of countries GDP to their life expectancy -- 
-- As figured, the countries with the highest GDP ended up having highest life expectancy -- 
-- Countries with the higher GDPs have access to better resources such as healthcare, food, water, etc -- 
-- Inversely, countries with lower GDPs means weaker economies simply dont have the adequate resources to sustain higher life expectancies for their population --  



select country, round(avg(`Lifeexpectancy`),1) as Life_exp, round(avg(gdp),1) as GDP
from worldlifexpectancy
group by country
having Life_exp > 0 
and gdp > 0
order by gdp desc
;

-- Created a case query to analyze the amount of countries that would qualify for a high gdp or low gdp. -- 
-- Selected the gdp number at 1500 since that was the median of the total gdp given -- 
-- Results show that of the 2900 countries involved, a little over 1300 counties qualified for a high gdp year over the past 15 years, with an average life expectancy of 74 year -- 
-- Leaving around 1600 countires categorized as a low gdp, totaling an average life expectancy of 65 years. -- 
-- Equating to a 9 year difference of life expectancy for high gdp to low gdp countries -- 
-- This data can be skewed due to calculating a countries data over a 15 year period rather than a specific year or the most recent year to date -- 

SELECT 
    SUM(CASE
        WHEN GDP >= 1500 THEN 1
        ELSE 0
    END) High_GDP_Count,
    AVG(CASE
        WHEN GDP >= 1500 THEN `Lifeexpectancy`
        ELSE NULL
    END) High_GDP_LIfe_Expectancy,
    SUM(CASE
        WHEN GDP <= 1500 THEN 1
        ELSE 0
    END) Low_GDP_Count,
    AVG(CASE
        WHEN GDP <= 1500 THEN `Lifeexpectancy`
        ELSE NULL
    END) Low_GDP_LIfe_Expectancy
FROM
    worldlifexpectancy
;

-- For this analysis, decided to analyze each countries life expectancy based off their status of developing or developed -- 
-- Data showed a 12 year difference regarding countries status. Developed countries around 79 years while developing countries around 67 years -- 
-- This further highlights the descrepency towards life expectancy detereminded by economic conditions -- 

Select status, round(avg(`Lifeexpectancy`),1)
from worldlifexpectancy
GROUP BY status
;

-- Piggy backing off the most recent query, I decided to count the amount of countries that are both developed or developing -- 
-- A total of 32 countries equate to the status of developed -- 
-- A total of 161 countries equate to the status of developing --

Select status, count(distinct country), round(avg(`Lifeexpectancy`),1)
from worldlifexpectancy
GROUP BY status
;

-- Lets compare the life expectancy in comparison to a countries average bmi -- 
-- Trends show that countries with the lowest average life expectancy more than likely have a below average bmi -- 
-- Inversely, countries with the highest average life expectancy had an above average bmi -- 

select country, round(avg(`Lifeexpectancy`),1) as Life_exp, round(avg(bmi),1) as BMI
from worldlifexpectancy
group by country
having Life_exp > 0 
and BMI > 0
order by BMI desc
;

-- Lastly, created a query that provided data for countries with the word "united" in search of their adult mortality over the past 15 years -- 
-- Initiated a rolling total for the calculation -- 
-- United Arab Emirates total adult mortality of 1073 -- 
-- United Kingdom of Great Britian totoal adult mortality of 1126 --
-- United Republic of Tanzania total adult mortality of 4871 -- 
-- United States of America total adult mortality of 931 -- 


Select country, year, `Lifeexpectancy`, `AdultMortality`,
sum(`AdultMortality`) over(Partition by country order by year) as Rolling_Total
From worldlifexpectancy
where country like '%United%'
;









