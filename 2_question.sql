
--  zjištění jména foodcategory --'Mléko polotučné pasterované', 'Chléb konzumní kmínový'
SELECT DISTINCT
	ps.food_category 
FROM t_petra_setlova_project_sql_primary_final ps;

-- zjištění sledovaného období -- '2006'-'2018'
SELECT DISTINCT 
	ps.`year` 
FROM t_petra_setlova_project_sql_primary_final ps
WHERE ps.food_category IN ('Mléko polotučné pasterované', 'Chléb konzumní kmínový');

-- zjištění ceny mléka a cleba ve sledovaném období
CREATE OR REPLACE VIEW v_petra_setlova_prices as
SELECT 
	ps.food_category ,
	round(avg(ps.prices),2) AS avarage_price,
	ps.`year` 
FROM t_petra_setlova_project_sql_primary_final ps
WHERE ps.food_category IN ('Mléko polotučné pasterované', 'Chléb konzumní kmínový')
	AND ps.`year` IN (2006,2018)
	GROUP BY ps.food_category , ps.`year` ;

SELECT * FROM v_petra_setlova_prices vpsp; 

-- zjištění průměrné mzdy sledovaném období
CREATE OR REPLACE VIEW v_petra_setlova_wages as
SELECT 
	ps.`year` ,
	round(avg(ps.average_wages)	,2) AS avarage_wages
FROM t_petra_setlova_project_sql_primary_final ps
WHERE ps.`year` IN (2006,2018)
GROUP BY ps.`year` ;

SELECT * FROM v_petra_setlova_wages vpsw; 

-- výpočet množství potravin za sledované období
SELECT 
	vpsp.food_category ,
	vpsp.avarage_price ,
	vpsp.`year`,
	vpsw.avarage_wages ,
	round((vpsw.avarage_wages / vpsp.avarage_price)) AS quantity
FROM v_petra_setlova_prices vpsp
JOIN v_petra_setlova_wages vpsw 
	ON vpsw.`year` = vpsp.`year`;
