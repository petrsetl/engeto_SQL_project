
-- začnu tím, že si vytvořím view, abych mohla porovnat mzdy v průběhu let - je to pro optimalizaci dat v tabulce
CREATE OR REPLACE VIEW v_petra_setlova_industry_wages as
SELECT 
	ps.industry ,
	ps.`year` ,
	round(avg(ps.average_wages)) AS avarage_wages
FROM t_petra_setlova_project_sql_primary_final ps
GROUP BY ps.industry , ps.`year`;


SELECT * FROM v_petra_setlova_industry_wages vpsiw 

-- ted si vytvořím srovnávací pohled
CREATE OR REPLACE VIEW v_petra_setlova_industry_wages_comparison as
SELECT 
	vps.industry,
	vps.`year` AS year,
	vps.avarage_wages AS wages,
	CASE 
		WHEN vps2.avarage_wages > vps.avarage_wages THEN 'mzda roste'
		ELSE 'klesa'
	END	wage_comparison,
	round((vps2.avarage_wages - vps.avarage_wages) / vps.avarage_wages, 2) * 100 AS percentage_change
FROM v_petra_setlova_industry_wages vps
JOIN v_petra_setlova_industry_wages vps2 
	ON vps2.industry = vps.industry
	AND vps2.`year`= vps.`year`+ 1;


SELECT * FROM v_petra_setlova_industry_wages_comparison vpsiwc


SELECT DISTINCT 
	* 
FROM v_petra_setlova_industry_wages_comparison vpsiwc 
ORDER BY percentage_change DESC 
;


