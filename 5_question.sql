
-- zjistím meziroční rozdíly HDP v ČR
SELECT 
	tps.country ,
	tps.`year` ,
	tps.GDP ,
	lag(tps.GDP) OVER (ORDER BY tps.`year`) AS previous_GDP,
	ROUNd((tps.GDP - (lag(tps.GDP) OVER (ORDER BY tps.`year`))) * 100 / (lag(tps.GDP) OVER (ORDER BY tps.`year`)), 2) AS growth_GDP
FROM t_petra_setlova_project_sql_secondary_final tps 
WHERE tps.country = 'Czech Republic';


-- zjistím meziroční rozdíly HDP v ČR a propojím s VIEW percentualni rozdíl cen a mezd v letech 'v_petra_setlova_diff_prices_wages '(viz úkol č.4)
SELECT 
	tps.country ,
	tps.`year` ,
	tps.GDP ,
	ROUNd((tps.GDP - (lag(tps.GDP) OVER (ORDER BY tps.`year`))) * 100 / (lag(tps.GDP) OVER (ORDER BY tps.`year`)), 2) AS growth_GDP,
	vps.growth_wages ,
	vps.growth_prices 
FROM t_petra_setlova_project_sql_secondary_final tps 
LEFT JOIN v_petra_setlova_diff_prices_wages AS vps
	ON vps.`year` = tps.`year`
WHERE tps.country = 'Czech Republic';


-- finální dotaz
select 
a.*
from (
	SELECT 
		tps.country ,
		tps.`year` ,
		tps.GDP ,
		ROUNd((tps.GDP - (lag(tps.GDP) OVER (ORDER BY tps.`year`))) * 100 / (lag(tps.GDP) OVER (ORDER BY tps.`year`)), 2) AS growth_GDP,
		vps.growth_wages ,
		vps.growth_prices  
	FROM t_petra_setlova_project_sql_secondary_final tps 
	LEFT JOIN v_petra_setlova_diff_prices_wages AS vps
		ON vps.`year` = tps.`year`
	WHERE tps.country = 'Czech Republic'
	) a
where a.growth_GDP > 5 -- pak srovnám s > 2
;




