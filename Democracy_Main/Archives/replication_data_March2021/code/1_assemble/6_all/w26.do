
*** import countries data 
use ${path_output}/data/countries.dta, replace

*** merge with outcomes.dta
merge 1:1 NAMES_STD using ${path_output}/data/outcomes.dta, nogenerate

*** merge with democracy.dta
merge 1:1 NAMES_STD using ${path_output}/data/democracy.dta, nogenerate

*** merge with controls.dta
merge 1:1 NAMES_STD using ${path_output}/data/controls.dta, nogenerate

*** merge with IVs.dta
merge 1:1 NAMES_STD using ${path_output}/data/IVs.dta, nogenerate

*** merge with containmenthealth10.dta
merge 1:1 NAMES_STD using ${path_output}/data/containmenthealth10.dta
drop if _merge==2
drop _merge

*** merge with coverage10.dta
merge 1:1 NAMES_STD using ${path_output}/data/coverage10.dta
drop if _merge==2
drop _merge

*** merge with introduce_policy.dta
merge 1:1 NAMES_STD using ${path_output}/data/introduce_policy.dta
drop if _merge==2
drop _merge

*** drop unnecessary columns
drop iso3 legor_so

*** drop observations for which we don't have data for gdp_growth and total_deaths_per_million

drop if gdp_growth ==. | total_deaths_per_million==.| democracy_fh==. | population==. | abs_lat ==. | mean_temp==. | mean_precip==. |pop_density==. | median_age==. | diabetes_prevalence==. 

*** merge
*** Generate number of days between policy introduction and 10th confirmed case ***
gen days_betw_10th_case_and_policy = introduce_policy - cases_over10
drop introduce_policy cases_over10 

*** label variables

label variable countries "Country Name"
label variable gdp_growth "GDP Growth Rate in 2020"
label variable total_deaths_per_million "Total Covid-19-related Deaths Per Million"
label variable democracy_fh "Democracy Index"
label variable democracy_csp "Democracy Index"
label variable democracy_eiu "Democracy Index"
label variable population "Population"
label variable total_gdp "GDP"
label variable abs_lat "Absolute Latitude"
label variable mean_temp "Mean Temperature"
label variable mean_precip "Mean Precipitation"
label variable pop_density "Population Density"
label variable median_age "Median Age"
label variable diabetes_prevalence "Diabetes Prevalence"
label variable logem "Log European Settler Mortality"
label variable EngFrac "Fraction Speaking English"
label variable EurFrac "Fraction Speaking European"
label variable logFrankRom "Log Frankel-Romer Trade Share"
label variable legor_uk "British Legal Origin"
label variable legor_fr "French Legal Origin"
label variable legor_ge "German Legal Origin"
label variable legor_sc "Scandinavian Legal Origin"
label variable bananas "Bananas"
label variable coffee "Coffee"
label variable copper "Copper"
label variable maize "Maize"
label variable millet "Millet"
label variable rice "Rice"
label variable rubber "Rubber"
label variable silver "Silver"
label variable sugarcane "Sugarcane"
label variable wheat "Wheat"
label variable lpd1500s "Log Population Density in 1500s"
label variable containmenthealth10 "Containment Health Index at 10th Confirmed Case"
label variable coverage10 "Coverage of Containment Measure at 10th Confirmed Case"
label variable days_betw_10th_case_and_policy "Days between 10th Confirmed Case and Any Containment Measure"

*** Save dataset ***
save ${path_output}/total.dta, replace
