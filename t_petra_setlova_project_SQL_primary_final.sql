-- PRIMARY TABLE

-- vytvoření PRIMARY TABLE  pro další práci 

CREATE OR REPLACE TABLE t_Petra_Setlova_project_SQL_primary_final as
SELECT 
	cpc.name AS food_category,
	cp.value AS prices,
	YEAR(cp.date_from) AS year,
	cpib.name AS industry,
	cpay.value AS average_wages
FROM czechia_payroll cpay 
JOIN czechia_price cp 
	ON YEAR(cp.date_from) = cpay.payroll_year 
	AND cpay.value_type_code = 5958
	AND cp.region_code IS NULL
	AND cpay.calculation_code = 200
JOIN czechia_price_category cpc 
	ON cpc.code = cp.category_code 
JOIN czechia_payroll_industry_branch cpib 
	ON cpib.code = cpay.industry_branch_code ;

SELECT * FROM t_petra_setlova_project_sql_primary_final tpspspf 



