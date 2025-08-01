# Project_SQL

## OBSAH
Repozitar obsahuje 7 SQL skriptů - 2 pro vytvoreni podkladovych tabulek (Script_primary_table a Script_secondary_table) s potrebnymi daty a 5 obsahujici kod potrebny pro zodpovezeni 5 vyzkumnych otazek (Scirpt1 až Script5).

Dale repozitar obsahuje tento markdown soubor s vysvetlenim toho, jak byly podkladove tabulky vytvoreny a s odpovedmi na otazky.

## POPIS TABULEK
### PRIMARNI TABULKA
Primarni tabulka obsahuje udaje o cenach potravin, mzdach a HDP pro Ceskou republiku za jednotlive roky od roku 2006 do roku 2018. 
Jedna se tedy o fuzi z puvodnich tabulek czechia_price, czechia_payroll a economies. 

Informace o cenach jsou rozdeleny do kategorii podle typu potravin. Kazda kategorie ma svuj slovni nazev (price_name) a kod, ktery k ni prislusi (category_code). Zjistene prumerne ceny v danem roce jsou pro jednotlive kategorie potravin uvedeny v Kč (price_year_avg). 
Mnozstvi potraviny v dane kategorii (price_value), ktere bylo mozne za danou cenu koupit, je uvedeno bud v kg nebo v litrech (price_unit).

Podobne je to v pripade mezd, u kterych tabulka uvadi prumernou mesicni mzdu (v Kč) pro jednotliva odvetvi pracovnich cinnosti v danem roce prepoctena na plne uvazky. Kazda kategori odvetvi ma svuj slovni popis (industry_name) a k ni nalezici kod (industry_branch_code).
Tam, kde industry_branch_code chybi, se jedna o prumernou mzdu ve vsech odvetvich, tedy souhrnne za celou CR.  

Pro HDP zde mame HDP celkove (v Kč) za rok a HDP per capita, tedy HDP na 1 obyvatele. 

### SEKUNDARNI TABULKA
Sekundarni tabulka vznikla vyfiltrovanim z tabulky economies. Obsahuje informaci o HDP, populaci a hodnote Giniho koeficientu za jednotlive roky pro stejne obdobi jako primarni tabulka, tedy 2006-2018, pro velke mnozstvi evropskych statu.

## ODPOVEDI NA VYZKUMNE OTAZKY
### 1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
Odpověd na otazku přinasi sloupec salary_trend s oznacenim trendu vývoje (down/up).
Do r. 2008 u všech odvetvi mzdy rostly.
Od r. 2009 došlo u nektrych k poklesu (předevšim u zemedelstvi, težba a dobývání, pohostinství, činnosti v oblasti nemovitostí). 
V následujících letech se přidávaly i další profese, jak se postupně projevil dopad celosvětové ekonomické krize.
Nejhorsi byl rok 2013, kdy došlo k poklesu u nejvice odvetví a k poklesu pro prumer všech odvětvi (industry_branch_code = NULL).

### 2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
V 1. obdobi (r. 2006) bylo mozne koupit za prumernou mzdu 1 212 kg chleba a 1 353 litru mleka.
V poslednim sledovanem obdobi (r. 2018) bylo mozne za prumernou mzdu koupit 1 322 kg chleba a 1 617 litru mleka.
Počet kg chleba počet litrů mléka, které bylo možné za průměrnou mzdu koupit, pro jednotlivá období (2006 a 2018) zobrazuje sloupec n_units.
Mzdy i ceny v roce 2018 oproti roku 2006 rostly. Nicméně mzdy rostly více, takže v roce 2018 bylo možné kopit za průměrnou mzdu více chleba i mléka než v roce 2006.

### 3.	Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? 
Na základě hodnot koeficientů rustů pro jednotlivé kategorie protravin (sloupec price_coef_growth) lze určit, že za sledované období (2006-2018) nejvice rostly ceny paprik a dale take másla. Naopak mirne klesaly ceny cukru krystal a dale rajských jablek.

### 4.	Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
Ve sledovanem obdobi (2006-2018) neni v pripade cen potravin pozorovatelny výrazně vyšší růst oproti mzdam (nad 10 %). 
Ve sloupci abs.difference vidime rozdil koeficentu rustu mezd a koeficientu rustu cen potravin, tzn. zaporne hodnoty znaci roky, ve kterých mzdy rostly pomaleji nez ceny potravin. 
Nejzapornejsi hodnota, tedy nejvetsi rozdil mezi vývojem cen potravin a mezd, náleží roku 2013, což byl rok ekonomicke krize v cele EU. Nicmene i zde je rozdil přibližně 6 %.

### 5.	Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
Nevidím zde nejakou jednoduše popsatelnou zavislost mezi HPD, platy a cenami (vše vyjádřeno koeficienty růstu). 
Lze říct, že ceny reagují na změny HDP citlivěji než mzdy. Lze zde pozorovat určité zpožení - v roce 2014-16 HDP po krizi z roku 2013 opět rostlo, zatímco ceny ještě mírně klesly/stagnovaly, naopak v roce 2012 HDP kleslo a ceny stále rostly. 
Mzdy mají naproti tomu stabilne rostoucí trend, výjimkou byl jen rok 2013, ve kterém HDP klesalo 2. rok za sebou.
Koeficient růstu HDP per capita byl v každém roce nepatrně nižší než v případě absolutního HDP, což je dáno meziročním růstem populace. 

