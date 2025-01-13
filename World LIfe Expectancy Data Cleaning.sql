# World Life Expectancy Data Cleaning

-- First step completed was removing any and all duplicates from the raw data -- 

SELECT 
    *
FROM
    worldlifexpectancy
;

-- After discecting the data, came upon the realization that multiple countries were inputed multiple times, ran queries to locate and remove the duplicate --

Select country, year, concat(country, year), count(concat(country, year))
from	worldlifexpectancy
GROUP BY country, year, concat(country, year)
Having count(concat(country, year)) > 1
;

-- Once gathered the duplicates, next step was to locate the row location for accurate deletion of data -- 

Select * 
From (
Select Row_ID, 
concat(country, year),
ROW_NUMBER() Over(Partition by concat(country, year) order by concat(country, year)) as Row_Num
from worldlifexpectancy
) as Row_Table
where Row_Num > 1
;

-- The row location has been identified, then created a query to finalize the cleaning of duplicates -- 

Delete From worldlifexpectancy
where 
	Row_ID in (
	Select Row_ID 
from (
	Select Row_ID,
	concat(country, year),
	ROW_NUMBER() Over(Partition by concat(country, year) order by concat(country, year)) as Row_Num
	from worldlifexpectancy
	) as Row_Table
where Row_Num > 1
)
;


-- Next step was to identify any "blank" or empty data cells that haven't been populated --
-- THe column labeled "Status" had a few rows missing data, and moved forward filling the blanks with their appropriate data -- 

Select * 
from worldlifexpectancy
WHERE Status = ''
;

Select distinct(status)
from worldlifexpectancy
WHERE Status <> ''
;

Select DISTINCT(country)
from worldlifexpectancy
where status = 'developing'
;

Update worldlifexpectancy
set status = 'developing' 
where country in (Select DISTINCT(country)
					from worldlifexpectancy
					where status = 'developing');

Update worldlifexpectancy t1
join worldlifexpectancy t2
	on t1.country = t2.country
SET t1.status = 'Developing'
where t1.status = ''
and t2.status <> ''
and t2.status = 'Developing'
;

-- Initiated the previous steps for the countries labeled "developing" but now for the countries who status should be updated to developed --


Select * 
from worldlifexpectancy
WHERE country = 'United States of America'
;

Update worldlifexpectancy t1
join worldlifexpectancy t2
	on t1.country = t2.country
SET t1.status = 'Developed'
where t1.status = ''
and t2.status <> ''
and t2.status = 'Developed'
;

Select * 
from worldlifexpectancy
;


-- Created a query to caluclate the missing data regarding countries life expectancy. The year of 2018 for the country Afghanistan was missing data -- 
-- Utilizing the join feature, I was able to apply the correct calculation inside the query to update the appropriate data inside the cell -- 

Select * 
From worldlifexpectancy
# Where `Lifeexpectancy` = ''
;

Select country, year, `Lifeexpectancy`
From worldlifexpectancy
# Where `Lifeexpectancy` = ''
;

Select t1.country, t1.year, t1.`Lifeexpectancy`, 
t2.country, t2.year, t2.`Lifeexpectancy`,
t3.country, t3.year, t3.`Lifeexpectancy`,
round((t2.`Lifeexpectancy` + t3.`Lifeexpectancy`)/ 2,1)
From worldlifexpectancy t1
join worldlifexpectancy t2
	on t1.country = t2.country
    and t1.year = t2.year - 1
join worldlifexpectancy t3
	on t1.country = t3.country
    and t1.year = t3.year + 1
    where t1.`Lifeexpectancy` = ''
    ;
    
    
Update worldlifexpectancy t1
join worldlifexpectancy t2
	on t1.country = t2.country
    and t1.year = t2.year - 1
join worldlifexpectancy t3
	on t1.country = t3.country
    and t1.year = t3.year + 1
set t1.`Lifeexpectancy` = round((t2.`Lifeexpectancy` + t3.`Lifeexpectancy`)/ 2,1)
where t1.`Lifeexpectancy` = ''
;

select * 
from worldlifexpectancy
;

