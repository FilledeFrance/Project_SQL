CREATE TABLE t_sarka_motylova_project_sql_secondary_final AS
SELECT 
ec.country, 
ec.year, 
ec.gdp, 
ec.population, 
ec.gini
FROM economies AS ec
LEFT JOIN countries AS c
	ON ec.country = c.country
WHERE c.continent = 'Europe'
	AND ec."year" > 2005
	AND ec."year" <2019
	


SELECT *
FROM t_sarka_motylova_project_sql_secondary_final
ORDER BY 
	country, 
	year;

	
--pro smazani tabulky:	

DROP TABLE t_sarka_motylova_project_sql_secondary_final 
