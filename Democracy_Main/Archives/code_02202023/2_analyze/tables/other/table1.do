********************************************************************************
* Table 1: Descriptive Statistics
********************************************************************************
clear

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use "./output/total.dta", replace

****************
*** Outcomes ***
****************

// Row 1: GDP Growth Rate in 2020
tabstat gdp_growth, stats(n mean sd min median max)

// Row 2: Covid-19-related Deaths Per Million
tabstat total_deaths_per_million, stats(n mean sd min median max)

***********************
*** Democracy Index ***
***********************

// Row 3: Democracy Index (Freedom House)
tabstat democracy_fh, stats(n mean sd min median max)

// Row 4: Democracy Index (Center for Systemic Peace)
tabstat democracy_csp, stats(n mean sd min median max)

// Row 5: Democracy Index (Economist Intelligence Unit)
tabstat democracy_eiu, stats(n mean sd min median max)

**************************
*** Weights & Controls ***
**************************

// Row 6: Population
tabstat population, stats(n mean sd min median max)

// Row 7: GDP
tabstat total_gdp, stats(n mean sd min median max)

// Row 8: Absolute Latitude
tabstat abs_lat, stats(n mean sd min median max)

// Row 9: Mean Temperature
tabstat mean_temp, stats(n mean sd min median max)

// Row 10: Mean Precipitation
tabstat mean_precip, stats(n mean sd min median max)

// Row 11: Population Density
tabstat pop_density, stats(n mean sd min median max)

// Row 12: Median Age
tabstat median_age, stats(n mean sd min median max)

// Row 13: Diabetes Prevalence
tabstat diabetes_prevalence, stats(n mean sd min median max)

***********
*** IVs ***
***********

// Row 14: Log European Settler Mortality 
tabstat logem, stats(n mean sd min median max)

// Row 15: Fraction Speaking English
tabstat EngFrac, stats(n mean sd min median max)

// Row 16: Fraction Speaking European
tabstat EurFrac, stats(n mean sd min median max)

// Row 17: Log Frankel-Romer Trade Share
tabstat logFrankRom, stats(n mean sd min median max)

// Row 18: British Legal Origin
tabstat legor_uk, stats(n mean sd min median max)

// Row 19: French Legal Origin
tabstat legor_fr, stats(n mean sd min median max)

// Row 20: German Legal Origin
tabstat legor_ge, stats(n mean sd min median max)

// Row 21: Scandinavian Legal Origin
tabstat legor_sc, stats(n mean sd min median max)

// Row 22: Bananas
tabstat bananas, stats(n mean sd min median max)

// Row 23: Coffee
tabstat coffee, stats(n mean sd min median max)

// Row 24: Copper
tabstat copper, stats(n mean sd min median max)

// Row 25: Maize
tabstat maize, stats(n mean sd min median max)

// Row 26: Millet
tabstat millet, stats(n mean sd min median max)

// Row 27: Rice
tabstat rice, stats(n mean sd min median max)

// Row 28: Rubber
tabstat rubber, stats(n mean sd min median max)

// Row 29: Silver
tabstat silver, stats(n mean sd min median max)

// Row 30: Sugarcane
tabstat sugarcane, stats(n mean sd min median max)

// Row 31: Wheat
tabstat wheat, stats(n mean sd min median max)

// Row 32: Log Population Density in 1500s
tabstat lpd1500s, stats(n mean sd min median max)

************************
*** Policy Responses ***
************************
* Make sample consistent across mechanism variables
drop if containmenthealth10==. | coverage10 ==. | days_betw_10th_case_and_policy ==.

// Row 33: Containment Health Index at 10th Covid-19 Case
tabstat containmenthealth10, stats(n mean sd min median max)

// Row 34: Coverage of Containment Measures at 10th Covid-19 Case
tabstat coverage10 if containmenthealth10!=. , stats(n mean sd min median max) 

// Row 35: Days between 10th Covid-19 Case and Any Containment Measure
tabstat days_betw_10th_case_and_policy if containmenthealth10!=., stats(n mean sd min median max)





 

