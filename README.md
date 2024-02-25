# SQL_project_Petra_Setlova
Vypracování SQL projektu Engeto (DA 16_01_2024)

## Zadání projektu
Na vašem analytickém oddělení nezávislé společnosti, která se zabývá životní úrovní občanů, jste se dohodli, že se pokusíte odpovědět na pár definovaných výzkumných otázek, které adresují dostupnost základních potravin široké veřejnosti. Kolegové již vydefinovali základní otázky, na které se pokusí odpovědět a poskytnout tuto informaci tiskovému oddělení. Toto oddělení bude výsledky prezentovat na následující konferenci zaměřené na tuto oblast.

Potřebují k tomu od vás připravit robustní datové podklady, ve kterých bude možné vidět porovnání dostupnosti potravin na základě průměrných příjmů za určité časové období.

Jako dodatečný materiál připravte i tabulku s HDP, GINI koeficientem a populací dalších evropských států ve stejném období, jako primární přehled pro ČR.

Datové sady, které je možné použít pro získání vhodného datového podkladu.

## Primární tabulky:
czechia_payroll – Informace o mzdách v různých odvětvích za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR. 
czechia_payroll_calculation – Číselník kalkulací v tabulce mezd. czechia_payroll_industry_branch – Číselník odvětví v tabulce mezd. czechia_payroll_unit – Číselník jednotek hodnot v tabulce mezd. czechia_payroll_value_type – Číselník typů hodnot v tabulce mezd. 
czechia_price – Informace o cenách vybraných potravin za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR. 
czechia_price_category – Číselník kategorií potravin, které se vyskytují v našem přehledu.

## Číselníky sdílených informací o ČR:
czechia_region – Číselník krajů České republiky dle normy CZ-NUTS 2. 
czechia_district – Číselník okresů České republiky dle normy LAU.

## Dodatečné tabulky:
countries - Všemožné informace o zemích na světě, například hlavní město, měna, národní jídlo nebo průměrná výška populace. 
economies - HDP, GINI, daňová zátěž, atd. pro daný stát a rok.

## Výzkumné otázky:
1.	Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2.	Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
3.	Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší procentuální meziroční nárůst)?
4.	Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
5.	Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?

## Výstup projektu:
Pomozte kolegům s daným úkolem. Výstupem by měly být dvě tabulky v databázi, ze kterých se požadovaná data dají získat. Tabulky pojmenujte t_{jmeno}{prijmeni}project_SQL_primary_final (pro data mezd a cen potravin za Českou republiku sjednocených na totožné porovnatelné období – společné roky) a t{jmeno}{prijmeni}_project_SQL_secondary_final (pro dodatečná data o dalších evropských státech).

Dále připravte sadu SQL, které z vámi připravených tabulek získají datový podklad k odpovězení na vytyčené výzkumné otázky. Pozor, otázky/hypotézy mohou vaše výstupy podporovat i vyvracet! Záleží na tom, co říkají data.

# Vytvořené tabulky
## Primární tabulka

Primární tabulka s názvem 't_petra_setlova_project_SQL_primary_final' byla vytvořena seskupením dat z tabulek 'czechia_payroll' a 'czechia_price'. Propojení tabulek bylo provedeno přes rok sběru dat. Z tabulky 'czechia_payroll' byly vybrány pouze záznamy s hodnotou 'Průměrná hrubá mzda na zaměstnance' a mzdy byly přepočteny na celé úvazky. Z tabulky 'czechia_price' byla data omezena pouze na záznamy za celou republiku, proto byly vybrány ve sloupci s kódem krajů hodnoty NULL. Dále byla připojena tabulka 'czechia_price_category' pro získání jmen položek a tabulka 'czechia_payroll_industry_branch' pro upřesnění průmyslových odvětví. Výsledná tabulka obsahuje data ve sloupcích kategorie potravin, jejich cena, rok, průmyslové odvětví a průměrné mzda v daném odvětví.

## Sekundární tabulka
Sekundární tabulka s názvem 't_petra_setlova_project_SQL_secondary_final' byla vytvořena seskupením dat z tabulky 'economies' a tabulky 'countries'. Propojení bylo provedeno přes sloupec country. Výběr byl omezen pouze na záznamy v letech 2006 až 2018, aby došlo ke sjednocení totožného porovnatelného období z Primární tabulky, kde je přehled za ČR. Dále byl výběr dat zúžen přes podmínku výběru kontinentů, kde byla vybrána pouze Evropa. Výsledná tabulka obsahuje data ve sloupcích země, rok a HDP.

# Výzkumné otázky
## Výzkumná otázka č. 1

__Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?__

Z primární tabulky byl vytvořen pohled pro zjištění průměrné mzdy v průběhu let a následně došlo k napojení pohledu 'v_petra_setlova_industry_wages' samo na sebe, abychom získali informace o meziročním srovnání mezd a procentuálním rozdílu.

Zjištění: 

Za celkové období 2006 až 2018 je ve všech průmyslových odvětvích pozitivní růst mezd. Nicméně v průběhu zkoumaných let docházelo v některých odvětvích i k poklesu mezd. Nejvíce mzdy klesaly v roce 2012 a to v 11 průmyslových odvětvích. Nejvíce mzdy rostly v roce 2007 v odvětvích 'Těžba a dobývání a Výroba a rozvod elektřiny, plynu, tepla a klimatiz. Vzduchu'.

## Výzkumná otázka č. 2

__Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?__

Z primární tabulky byl vytvořen pohled 'v_petra_setlova_prices' pro získání dat o průměrných daných potravin za období 2006 a 2018. Pak byl vytvořen druhý pohled 'v_petra_setlova_wages' pro zjištění průměrné mzdy ve sledovaném období. Následně došlo ke spojení obou pohledů pomocí klíče roků.

Zjištění: 

V roce 2006 bylo možné zakoupit 1.313 kg chleba a v roce 2018 to bylo 1365 kg. V roce 2006 bylo možné zakoupit 1.466 litrů mléka a 1.670 litrů v roce 2018.

## Výzkumná otázka č. 3

__Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuálně meziroční nárůst)?__

Z primární tabulky byl vytvořen pohled pro získání průměrných cen potravin v letech.  'v_petra_setlova_food_prices'. Následně byl vytvořen druhý pohled 'v_petra_setlova_prices_perc_diff' pro zjištění procentuálního rozdílu cen potravin v letech.

Zjištění: 

V letech 2006 až 2018 nejpomaleji zdražovala kategorie potravin Cukr krystalový. kdy se dokonce na konci sledovaného období prodával mnohem levněji než na začátku sledovaného období v roce 2006.

## Výzkumná otázka č. 4
__Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd
(větší než 10 %)?__

Nejdříve byl z primární tabulky vytvořen pohled 'v_petra_setlova_prices_vs_wages' s průměrnými cenami potravin a mezd v letech. Pro zjištění procentuálního rozdílu cen a mezd byl daný pohled napojen sám na sebe. Ve finálním dotazu byl použit dočasný sloupec, pro potvrzení či vyvracení hypotézy, zda u některé z potravin došlo k většímu než 10% zdražení oproti růstu cen.

Zjištění: 

V žádném roce nedošlo k výraznému (větší než 10 %) meziročnímu nárustu cen potravin ve srovnání s nárustem mezd. Největší rozdíl byl v roce 2013.

## Výzkumná otázka č. 5

__Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?__

Pro zodpovězení dotazu byla spojena data ze sekundární tabulky s již vytvořeným pohledem procentuálního rozdílu cen a mezd (viz otázka č.4). Data byla omezena jen na ČR. Nejednoznačná je otázka hranice výrazného růstu HDP. Pro zodpovězení byla stanovena hranice růstu nad 5 %. Pro zjištění, zda se růst HDP projevil jak ve stejném nebo následujícím roce byla data porovnána s růstem HDP nad 2 %.

Zjištění: 

K výraznému zvýšení HDP došlo v letech 2007, 2015, 2017. Pozitivní byl ve stejných letech i růst mezd, i když v roce 2015 došlo jen k méně významnému růstu. Na růst cen potravin se výrazné zvýšení HDP nepotvrdilo, protože v roce 2015 došlo dokonce k poklesu cen potravin. Výrazné zvýšení HDP se pozitivně ve mzdách projevilo i v následujícím roce, u cen závislost na změně HDP není.




