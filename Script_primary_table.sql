CREATE TABLE t_sarka_motylova_project_sql_primary_final AS
SELECT 
czpc.name AS price_name,
cpr.category_code,
round(avg(cpr.value)::numeric,2) AS price_year_avg,
czpc.price_value,
czpc.price_unit,
czp.industry_branch_code,
cpib.name AS industry_name,
round(avg(czp.value)::numeric,0) AS salary_year_avg,
czp.payroll_year AS n_year,
round((ec.gdp/ec.population)::NUMERIC,0) AS gdp_per_cap,
ec.gdp
FROM czechia_price AS cpr
RIGHT JOIN 
	czechia_payroll AS czp
	ON  date_part('year', cpr.date_from) = czp.payroll_year
LEFT JOIN
	czechia_price_category AS czpc 
	ON  cpr.category_code = czpc.code 
LEFT JOIN 
	czechia_payroll_industry_branch AS cpib 
	ON czp.industry_branch_code = cpib.code 
LEFT JOIN 
	economies AS ec
	ON date_part('year', cpr.date_from) = ec.year
WHERE cpr.region_code IS NULL --vyfiltruje pouze ceny za celou CR
	AND	czp.value_type_code =5958 --vyfiltruje prum mzdy
	AND czp.calculation_code=200 --vyfiltruje pouze mzdy prepoctene na plne uvazky
	AND czp.payroll_year>2005 
	AND czp.payroll_year<2019--protoze udaje o cenach jsou jen mezi lety 2006-18
	AND ec.country ='Czech Republic'
GROUP BY 
	n_year,
	cpr.category_code,
	czp.industry_branch_code,
	price_name,
	czpc.price_value,
	czpc.price_unit,
	industry_name,
	ec.gdp,
	ec.population