# US Household Income Exploratory Data Analysis

SELECT * FROM US_Project.USHouseholdIncome;

SELECT * FROM US_Project.ushouseholdincome_statistics;


-- Created a query to find the top ten states based off tota landmass -- 
-- The top 10: Alaska, Texas, Oregon, California, Montana, Colorado, Nevada, Arizona, Utah, New Mexico -- 
-- Each of the top 10 states are located in the western part of the United States -- 

Select State_Name, sum(Aland), sum(Awater)
from USHouseholdIncome 
group by State_Name
order by 2 desc
limit 10
;

-- Created a query to find the top ten states with the largest amounts of water -- 
-- Top 10: Alaska, Michicgan, Texas, Florida, Hawaii, Wisconsin, Minnesota, California, Louisiana, North Carolina -- 
-- More geo diverse top 10 list regarding states with largest amounts water -- 


Select State_Name, sum(Aland), sum(Awater)
from USHouseholdIncome 
group by State_Name
order by 3 desc
limit 10
;



SELECT * FROM US_Project.USHouseholdIncome;

SELECT * FROM US_Project.ushouseholdincome_statistics;



-- Joining the tables together for further exploratory analysis -- 

SELECT 
    *
FROM
    USHouseholdIncome u
        JOIN
    ushouseholdincome_statistics us
    ON u.id = us.id
;

SELECT 
    *
FROM
    USHouseholdIncome u
        inner JOIN
    ushouseholdincome_statistics us 
    ON u.id = us.id
    where mean <> '0'
;


SELECT 
    *
FROM
    USHouseholdIncome u
        inner JOIN
    ushouseholdincome_statistics us 
    ON u.id = us.id
    where mean <> 0
    and median <> 0
;

-- Created a query to find the states with the highest mean household income -- 
-- District of Columbia, Connecticut, New Jersey, Maryland, Massachusetts

SELECT u.State_Name, round(avg(Mean),1), round(avg(Median),1)
FROM
    USHouseholdIncome u
        inner JOIN
    ushouseholdincome_statistics us 
    ON u.id = us.id
	where mean <> 0
    and median <> 0
    group by u.State_Name
    order by 2 desc
    limit 5
;

-- Created a query to find the states with the lowest mean household income -- 
-- Puerto Rico, Mississippi, Arkansas, West Virginia, Alabama --
SELECT u.State_Name, round(avg(Mean),1), round(avg(Median),1)
FROM
    USHouseholdIncome u
        inner JOIN
    ushouseholdincome_statistics us 
    ON u.id = us.id
	where mean <> 0
    and median <> 0
    group by u.State_Name
    order by 2 asc
    limit 5
;


-- Created a query to find the top 5 states with the highest median household income -- 
-- New Jersey, Connecticut, Massachusetts, Wyoming, Maryland -- 

SELECT u.State_Name, round(avg(Mean),1), round(avg(Median),1)
FROM
    USHouseholdIncome u
        inner JOIN
    ushouseholdincome_statistics us 
    ON u.id = us.id
	where mean <> 0
    and median <> 0
    group by u.State_Name
    order by 3 desc
    limit 10
;

-- Created a query to find the top 5 states with the lowest median household income -- 
-- Puerto Rico, Arkansas, Mississippi, Louisiana, Oklahoma -- 
SELECT u.State_Name, round(avg(Mean),1), round(avg(Median),1)
FROM
    USHouseholdIncome u
        inner JOIN
    ushouseholdincome_statistics us 
    ON u.id = us.id
	where mean <> 0
    and median <> 0 
    group by u.State_Name
    order by 3 asc
    limit 5
;




