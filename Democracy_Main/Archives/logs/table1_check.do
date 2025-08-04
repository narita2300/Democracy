
********************************************************************************
* Table 1: Descriptive Statistics
********************************************************************************

clear 

*** Change to appropriate directory
cd ${path_dropbox}/tables

*** Load data 
use ${path_data}/total.dta, replace

********************************************************************************
* Outcomes

summ mean_growth_rate_2001_2019, detail

summ gdp_growth2020, detail

summ total_deaths_per_million, detail

********************************************************************************
* Treatments

summ democracy_vdem2000, detail

summ democracy_vdem2019, detail

********************************************************************************
* Controls

summ total_gdp2000, detail

summ total_gdp2019, detail

summ abs_lat, detail

summ mean_temp_1991_2000, detail

summ mean_temp_2001_2016, detail

summ mean_precip_1991_2000, detail

summ mean_precip_1991_2016, detail

summ pop_density2000, detail
 
summ pop_density2019, detail

summ median_age2000, detail

summ median_age2020, detail

summ diabetes_prevalence2019, detail

********************************************************************************
* IVs

summ logem4, detail

summ lpd1500s, detail

summ legor_uk, detail

summ EngFrac, detail

summ EurFrac, detail

summ bananas, detail

summ coffee, detail

summ copper, detail

summ maize, detail

summ millet, detail

summ rice, detail

summ silver, detail

summ sugarcane, detail

summ rubber, detail

summ wheat, detail

********************************************************************************
* Mechanisms

summ mean_agr_va_growth_2001_2019, detail

summ mean_manu_va_growth_2001_2019, detail

summ mean_serv_va_growth_2001_2019, detail

summ mean_capital_growth_2001_2019, detail

summ mean_labor_growth_2001_2019, detail

summ mean_tfpgrowth_2001_2019, detail

summ mean_import_value_2001_2019, detail

summ mean_export_value_2001_2019, detail


