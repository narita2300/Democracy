*** load gdp.dta and merge with covid_deaths.dta
use ${path_output}/data/gdp.dta, clear
merge 1:m iso3 using ${path_output}/data/covid_deaths.dta
drop if _merge==2
drop country_region _merge

merge 1:1 NAMES_STD using ${path_output}/data/covid_cases.dta
drop if _merge!=3
drop _merge

merge 1:m NAMES_STD using ${path_output}/data/excess_deaths.dta
drop if _merge==2
drop _merge

save ${path_data}/outcomes.dta, replace



