
-- vytvoření SEKUNDARY TABLE

/*
 * economies - země (evropské)
 * economies - rok
 * economies - GDP
 */


CREATE OR REPLACE TABLE t_Petra_Setlova_project_SQL_secondary_final as
SELECT 
	e.country ,
	e.`year` ,
	e.GDP 
FROM economies e 
JOIN countries c 
	ON c.country = e.country 
	AND e.`year`BETWEEN 2006 AND 2018
WHERE c.continent = 'Europe';




































