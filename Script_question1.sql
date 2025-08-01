-- 1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
SELECT 
industry_branch_code,
n_year,
industry_name, 
salary_year_avg,
LAG(salary_year_avg) OVER (PARTITION BY industry_branch_code ORDER BY n_year) AS salary_lag,
CASE
        WHEN salary_year_avg - LAG(salary_year_avg) OVER (PARTITION BY industry_branch_code ORDER BY n_year) > 0 THEN 'up'
        WHEN salary_year_avg - LAG(salary_year_avg) OVER (PARTITION BY industry_branch_code ORDER BY n_year) < 0 THEN 'down'
         ELSE 'start'
    END AS salary_trend
FROM t_sarka_motylova_project_sql_primary_final
GROUP BY 
	industry_branch_code,
	n_year,
	industry_name,
	salary_year_avg
ORDER BY 
	--salary_trend, n_year, industry_branch_code; --nebo moznost prehodit poradi - jestli me zajimaji vic roky nebo odvetvi
	salary_trend, industry_branch_code, n_year;
	--industry_branch_code, n_year;

