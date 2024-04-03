

-- zjistím ceny a mzdy v letech
CREATE OR REPLACE VIEW v_petra_setlova_prices_vs_wages AS
SELECT 
	ps.`year`  ,
	round(avg(ps.prices), 2) AS prices ,
	round(avg(ps.average_wages)) AS average_wages 
FROM t_petra_setlova_project_sql_primary_final ps
GROUP BY ps.`year`; 


-- zjistím percentualni rozdíl cen a mezd v letech
CREATE OR REPLACE VIEW v_petra_setlova_diff_prices_wages AS
SELECT 
	vps.`year`,
	round(((vps.prices - vps2.prices) / vps2.prices * 100), 2) AS growth_prices,
	round(((vps.average_wages - vps2.average_wages) / vps2.average_wages * 100), 2) AS growth_wages
FROM v_petra_setlova_prices_vs_wages vps
JOIN v_petra_setlova_prices_vs_wages vps2
	ON vps2.`year`+ 1 = vps.`year`;


-- Finalní dotaz

SELECT 	
	a.*
FROM (
	SELECT 
		vps.*,
		(vps.growth_prices - vps.growth_wages) AS diff_prices_wages,
		CASE
			WHEN (vps.growth_prices - vps.growth_wages) > 10 THEN 1
			ELSE 0
		END	AS diff_more_than_10
	FROM v_petra_setlova_diff_prices_wages vps
	ORDER BY diff_prices_wages DESC 
	) a
ORDER BY a.diff_prices_wages DESC ;































