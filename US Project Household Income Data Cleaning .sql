# US Project Household Income Data Cleaning 


SELECT * FROM US_Project.USHouseholdIncome;

SELECT * FROM US_Project.ushouseholdincome_statistics;


-- Searching for any and all duplicates in the raw data -- 

SELECT 
    id, COUNT(id)
FROM
    USHouseholdIncome
GROUP BY id
HAVING COUNT(id) > 1
;



select * 
from ( 
select row_id,
id,
row_number() over (partition by id order by id ) row_num
from USHouseholdIncome
) duplicates
where row_num > 1
;

-- Deleted all duplicates from the raw data set -- 
 
Delete from	 USHouseholdIncome
where row_id in (
select row_id
from ( 
select row_id,
id,
row_number() over (partition by id order by id ) row_num
from USHouseholdIncome
) duplicates
where row_num > 1)
;


-- Conduct the same search for duplicates from the other data set statistics -- 
-- No duplicates found -- 
SELECT 
    id, COUNT(id)
FROM
    ushouseholdincome_statistics
GROUP BY id
HAVING COUNT(id) > 1
;

Select Distinct State_Name
from USHouseholdIncome
Order by 1
;

-- Updating the misspelling of the state name Georgia which is spelled "georia" --
-- Updating the misspelling of the state name Alabama which is spelled "alabama" -- 

update USHouseholdIncome 
set State_Name = 'Georgia'
Where State_name = 'georia'
;

update USHouseholdIncome 
set State_Name = 'Alabama'
Where State_name = 'alabama'
;

-- Checkiing the column State_ab for any errors -- 
-- No errors in the column --

Select Distinct State_ab
from USHouseholdIncome
Order by 1
;

-- After noticing a blank cell under the column "Place", I moved forward with updating the cell with the appropriate location based off similar county names -- 


Update USHouseholdIncome
set place = 'Autaugaville'
where county = 'Autauga County'
and city = 'Vinemont'
;

Select *
from USHouseholdIncome
;


-- Looking into the "Type" column, there were a couple misspelled names that caused a duplicate. Adjsuted the misppelled names to the appropriate "Type" -- 

Select type, count(type)
from USHouseholdIncome
group by type 
; 

Update USHouseholdIncome
set type = 'Borough'
where type = 'Boroughs'
;

Update USHouseholdIncome
set type = 'CDP'
where type = 'CPD'
;

-- Noticed odd congruencies with the columns aland and awater, and to verify I searched looking for anomolies of same being labeled a 0 -- 
-- Realized that some counties are solely water meaning no issues in the data set -- 

Select Aland, Awater 
from USHouseholdIncome
where (Aland = '0' or Aland = '' or Aland = 'null')
;













    
