--5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?

-- spocitam si koef. rustu pro HDP:
SELECT 
n_year,
gdp/LAG(gdp) OVER (ORDER BY n_year) AS gdp_coef_growth,
gdp_per_cap/LAG(gdp_per_cap) OVER (ORDER BY n_year) AS gdp_per_cap_coef_growth
FROM t_sarka_motylova_project_sql_primary_final
 GROUP BY 
	n_year,
	gdp,
	gdp_per_cap
ORDER BY 
	n_year; 


--pak to spojim s tím, co už mám z úlohy č. 4:

WITH price_growth AS (
    SELECT 
        category_code, 
        price_name,
        n_year,
        price_year_avg / LAG(price_year_avg) OVER (PARTITION BY category_code ORDER BY n_year) AS price_coef_growth
    FROM t_sarka_motylova_project_sql_primary_final 
    GROUP BY
        category_code, 
        price_name,
        n_year,
        price_year_avg
),
avg_price_growth AS (
    SELECT 
        n_year,
        AVG(price_coef_growth) AS all_prices_coef_growth
    FROM price_growth
    GROUP BY n_year
),
salary_growth AS (
    SELECT 
        n_year, 
        salary_year_avg / LAG(salary_year_avg) OVER (PARTITION BY industry_branch_code ORDER BY n_year) AS salary_coef_growth
    FROM t_sarka_motylova_project_sql_primary_final  
    WHERE industry_branch_code IS NULL
    GROUP BY 
        industry_branch_code,
        n_year,
        salary_year_avg
),
gdp_data AS (
    SELECT 
n_year,
gdp/LAG(gdp) OVER (ORDER BY n_year) AS gdp_coef_growth,
gdp_per_cap/LAG(gdp_per_cap) OVER (ORDER BY n_year) AS gdp_per_cap_coef_growth
FROM t_sarka_motylova_project_sql_primary_final
 GROUP BY 
	n_year,
	gdp,
	gdp_per_cap
)
SELECT 
    a.n_year,
    a.all_prices_coef_growth,
    s.salary_coef_growth,
    g.gdp_coef_growth,
    g.gdp_per_cap_coef_growth
FROM avg_price_growth AS a
LEFT JOIN salary_growth AS s ON a.n_year = s.n_year
LEFT JOIN gdp_data AS g ON a.n_year = g.n_year
ORDER BY 
	a.n_year;