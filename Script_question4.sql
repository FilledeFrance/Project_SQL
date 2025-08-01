--4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?


--meziroční koeficienty rustu průměrných mezd: 
SELECT 
n_year,
salary_year_avg/LAG(salary_year_avg) OVER (PARTITION BY industry_branch_code ORDER BY n_year) AS salary_coef_growth
FROM t_sarka_motylova_project_sql_primary_final
WHERE 
	industry_branch_code IS NULL 
GROUP BY 
	n_year,
	salary_year_avg,
	industry_branch_code
ORDER BY 
	n_year, 
	salary_coef_growth;



--meziroční prumerné koef. rustu za vsechny ceny:

WITH growth_calc AS (
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
)
SELECT 
    n_year,
    AVG(price_coef_growth) AS all_prices_coef_growth
FROM growth_calc
GROUP BY 
	n_year
ORDER BY 
	n_year;


--teď to spojim do jedne tabulky:

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
)
SELECT 
    a.n_year,
    a.all_prices_coef_growth,
    s.salary_coef_growth,
    (s.salary_coef_growth - a.all_prices_coef_growth) AS diff_absolut,
    (a.all_prices_coef_growth/s.salary_coef_growth) AS diff_relativ
FROM avg_price_growth AS a
LEFT JOIN salary_growth AS s ON a.n_year = s.n_year
ORDER BY 
	a.n_year;