--2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
SELECT 
category_code,
price_name,
salary_year_avg,
price_year_avg,
round(salary_year_avg/price_year_avg::numeric,0) AS n_units,
n_year,
price_unit
FROM t_sarka_motylova_project_sql_primary_final
WHERE category_code IN (114201,111301)-- kod pro chleba: 111301 a pro mleko: 114201
	AND industry_branch_code IS NULL
	AND n_year IN (2006,2018)
ORDER BY category_code, n_year;