CREATE TABLE t_sarka_motylova_project_sql_secondary_final AS
SELECT 
country, 
"year", 
gdp, 
population, 
gini
FROM economies AS ec
WHERE country IN ('Luxembourg', 'Sweden', 'Ireland', 'San Marino', 'Portugal', 'Malta', 'Albania', 'Ukraine', 'Latvia', 'Slovakia', 'Bosni and Herzegovina','Cyprus', 'Serbia','Belgium','Monaco', 'Georgia', 'United Kingdom', 'Germany','Slovenia','Greece','Poland','Finland','France','Belarus','Netherlands','Spain','Italy','Lichtenstein','Estonia','Denmark','Switzerland','Hungary','Austria','Lithunia','Bulgaria','Croatia','Andorra')
	AND ec."year" > 2005
	AND ec."year" <2019


SELECT *
FROM t_sarka_motylova_project_sql_secondary_final
ORDER BY 
	country, 
	year;

	
--pro smazani tabulky:	
DROP TABLE t_sarka_motylova_project_sql_secondary_final 