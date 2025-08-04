
*** load covid-19 deaths data, prepare for merge
import delimited ${path_input}/outcomes/covid_deaths/time_series_covid19_deaths_global.csv, varnames(nonames) numericcols(3) clear 

keep v1 v2 v349
rename v1 province_state
rename v2 country_region
rename v349 deaths
drop if deaths=="12/31/20"
destring deaths, replace
egen total_deaths = sum(deaths), by(country_region)

//drop duplicates
bysort country_region total_deaths: gen dup = cond(_N==1, 0,_n) 
drop if dup > 1
drop province_state deaths dup

save ${path_output}/data/total_deaths.dta, replace

*** load lookup table, prepare for merge
import delimited ${path_input}/outcomes/covid_deaths/UID_ISO_FIPS_LookUp_Table.csv, clear 

drop if province_state != ""
// save "./input/outcomes/covid_deaths/lookup.dta", replace
save ${path_output}/data/lookup.dta, replace

*** merge total_deaths.dta and lookup.dta
use ${path_output}/data/total_deaths.dta, replace
merge 1:1 country_region using ${path_output}/data/lookup.dta
gen total_deaths_per_million = (total_deaths/population)*1000000
keep country_region iso3 total_deaths_per_million
save ${path_output}/data/covid_deaths.dta, replace
