
-- zjistím prumernou cenu potravin v letech
CREATE OR REPLACE VIEW v_petra_setlova_food_prices as
SELECT 
	ps.food_category ,
	ps.`year` ,
	round(avg(ps.prices),2) AS prices
FROM t_petra_setlova_project_sql_primary_final ps
GROUP BY ps.food_category , ps.`year` ;

-- zjistim percentualni rozdil cen v letech 
CREATE OR REPLACE VIEW v_petra_setlova_prices_perc_diff as
SELECT 
	vpsf.food_category,
	vpsf.`year` ,
	vpsf.prices,
	round(((vpsf.prices - vpsf2.prices) / vpsf2.prices * 100), 2) AS perc_growth_prices
FROM v_petra_setlova_food_prices vpsf
LEFT JOIN v_petra_setlova_food_prices vpsf2
	on  vpsf2.food_category = vpsf.food_category
	AND vpsf2.`year` + 1 = vpsf.`year` ;


SELECT 
	vpsd.food_category ,
	round(avg(vpsd.perc_growth_prices), 2) AS growth_prices
FROM v_petra_setlova_prices_perc_diff vpsd	
GROUP BY vpsd.food_category 
ORDER BY round(avg(vpsd.perc_growth_prices), 2) 
LIMIT 1;


