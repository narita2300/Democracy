************************************ 
************************************ Covid-19 deaths

*** load covid-19 deaths data, prepare for merge
import delimited ${path_input}/outcomes/covid_deaths/time_series_covid19_deaths_global_May.csv, varnames(nonames) numericcols(3) clear 

keep v1 v2 v469
rename v1 province_state
rename v2 country_region
rename v469 deaths
drop if deaths=="4/30/21"
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

************************************ 
************************************ Covid-19 Cases

import delimited ${path_input}/outcomes/covid_cases/time_series_covid19_confirmed_global.csv, varnames(nonames) clear 

keep v1 v2 v349
rename v1 province_state
rename v2 country_region
rename v349 cases
drop if cases=="12/31/20"
destring cases, replace
egen total_cases = sum(cases), by(country_region)

//drop duplicates
bysort country_region total_cases: gen dup = cond(_N==1, 0,_n) 
drop if dup > 1
drop province_state cases dup

kountry country_region, from(other) m
drop if MARKER!=1
keep NAMES_STD total_cases

save ${path_output}/data/covid_cases.dta, replace

************************************ 
************************************ Excess Mortality

*** load excess mortality data, prepare for merge
import delimited "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/outcomes/excess_deaths/excess-mortality-raw-death-count.csv", clear 

egen total_deaths = sum(deaths_2020_all_ages), by(entity) // generate total number of deaths in 2020
egen total_expected_deaths = sum(average_deaths_2015_2019_all_age), by(entity)
gen date = date(day, "YMD")
format date %td
egen start_date = min(date), by(entity)
format start_date %td
egen end_date = max(date), by(entity)
format end_date %td
gen excess_deaths_count = total_deaths - total_expected_deaths 

kountry entity, from(other) m
drop if MARKER!=1
drop MARKER
// keep NAMES_STD excess_deaths_percentage excess_deaths_count

bysort NAMES_STD: gen dup = cond(_N==1, 0,_n) 
drop if dup > 1
drop dup

// **** merge 
// merge 1:1 NAMES_STD using "./output/total.dta"
// drop if _merge!=3

keep NAMES_STD excess_deaths_count
*** save
save ${path_output}/data/excess_deaths.dta, replace





