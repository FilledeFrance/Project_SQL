--3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? 
SELECT 
category_code, 
price_name,
n_year,
price_year_avg/LAG(price_year_avg) OVER (PARTITION BY category_code ORDER BY n_year) AS price_coef_growth
FROM t_sarka_motylova_project_sql_primary_final
GROUP BY
	category_code, 
	price_name,
	n_year,
	price_year_avg
ORDER BY 
	--category_code, n_year, price_name;
	n_year, price_coef_growth; 

-- takto jsem získala koeficienty růstu mezi jednotlivými roky, ale nedokazu z toho rict, co rostlo celkově nejpomaleji přes všechny roky. Jen pro každý rok zvlášť.
--- abych to mohla říci celkově, tak si musím udělat průměr z těch koeficientů růstu:

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
    category_code,
    price_name,
    AVG(price_coef_growth) AS avg_price_coef_growth
FROM growth_calc
GROUP BY 
	category_code, 
	price_name
ORDER BY avg_price_coef_growth;