
************************************ 
************************************ GDP Growth Rates 

import excel ${path_input}/outcomes/gdp/imf-dm-export-20210421.xls, sheet("NGDP_RPCH") clear

// drop B C D E F G H I J K L M N O P Q R S T U AQ AR AS AT AU
rename A country

local year=1980
foreach var of varlist B-AV{
	rename `var' gdp_growth`year'
	local year = `year'+1
}

drop in 1/2
drop in 196/229
kountry country, from(other) m
tabulate country if MARKER==0
drop MARKER
destring gdp_growth*, replace force

//prevent some NAs in merging
// replace NAMES_STD="Democratic Republic of Congo" if country=="Congo, Dem. Rep. of the"
save ${path_data}/gdp_growth.dta, replace

*** MERGE COUNTRIES LIST DATA WITH GDP DATA 
use ${path_data}/countries.dta, replace
merge 1:1 NAMES_STD using ${path_data}/gdp_growth.dta
drop if _merge==2
drop _merge country 

save ${path_data}/gdp.dta, replace

************************************ 
************************************ GDP Per Capita Growth Rates 

import delimited ${path_input}/outcomes/gdppc/API_NY.GDP.PCAP.KD.ZG_DS2_en_csv_v2_2708489.csv, encoding(UTF-8) rowrange(6) clear 

rename v1 country
rename v2 iso

local year = 1960
forvalues num = 5/65{
	
	rename v`num' gdppc_growth`year'
	local year = `year' + 1
}

keep country iso gdppc_growth*
kountry iso, from(iso3c) m
drop if MARKER==0
drop MARKER

save ${path_data}/gdppc.dta, replace

************************************ 
************************************ Covid-19 deaths

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

save ${path_data}/total_deaths.dta, replace

*** load lookup table, prepare for merge
import delimited ${path_input}/outcomes/covid_deaths/UID_ISO_FIPS_LookUp_Table.csv, clear 

drop if province_state != ""
// save "./input/outcomes/covid_deaths/lookup.dta", replace
save ${path_data}/lookup.dta, replace

*** merge total_deaths.dta and lookup.dta
use ${path_data}/total_deaths.dta, replace
merge 1:1 country_region using ${path_data}/lookup.dta
gen total_deaths_per_million = (total_deaths/population)*1000000
keep country_region iso3 total_deaths_per_million
save ${path_data}/covid_deaths.dta, replace

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

save ${path_data}/covid_cases.dta, replace

************************************ 
************************************ Excess Mortality

// *** load excess mortality data, prepare for merge
// import delimited ${path_input}/outcomes/excess_deaths/excess-mortality-raw-death-count.csv, clear 
// drop if deaths_2020_all_ages ==.

// egen total_deaths = sum(deaths_2020_all_ages), by(entity) // generate total number of deaths in 2020
// egen total_expected_deaths = sum(average_deaths_2015_2019_all_age), by(entity)

// gen date = date(day, "YMD")
// format date %td
// egen start_date = min(date), by(entity)
// format start_date %td
// egen end_date = max(date), by(entity)
// format end_date %td

// gen excess_deaths_count = total_deaths - total_expected_deaths 

// kountry entity, from(other) m
// drop if MARKER!=1
// drop MARKER

// bysort NAMES_STD: gen dup = cond(_N==1, 0,_n) 
// drop if dup > 1
// drop dup

// drop if end_date < td(01dec2020)
// keep NAMES_STD excess_deaths_count
// *** save
// save ${path_data}/excess_deaths.dta, replace

import delimited ${path_input}/outcomes/excess_deaths/all_monthly_excess_deaths2.csv, clear
save ${path_data}/excess_deaths_monthly.dta, replace

import delimited ${path_input}/outcomes/excess_deaths/all_quarterly_excess_deaths2.csv, clear 
save ${path_data}/excess_deaths_quarterly.dta, replace

import delimited ${path_input}/outcomes/excess_deaths/all_weekly_excess_deaths2.csv, clear 
save ${path_data}/excess_deaths_weekly.dta, replace

use ${path_data}/excess_deaths_weekly.dta, clear
append using ${path_data}/excess_deaths_monthly.dta
append using ${path_data}/excess_deaths_quarterly.dta

drop if year != 2020
egen excess_deaths2020 = sum(excess_deaths), by(country region)

gen start_date0 = date(start_date, "YMD")
format start_date0 %td
egen start_date2020 = min(start_date0), by(country region)
format start_date2020 %td

gen end_date0 = date(end_date, "YMD")
format end_date0 %td
egen end_date2020 = max(end_date0), by(country region)
format end_date2020 %td

kountry region, from(other) m
drop if MARKER!=1
drop MARKER

bysort NAMES_STD: gen dup = cond(_N==1, 0,_n) 
drop if dup > 1
drop dup 
drop start_date0 end_date0

drop if start_date2020 > td(01feb2020)
drop if end_date2020 < td(01dec2020)
keep NAMES_STD excess_deaths2020
*** save
save ${path_data}/excess_deaths.dta, replace


// egen total_deaths_2020 = sum(total_deaths), by(country region) // generate total number of deaths in 2020
// egen total_expected_deaths_2020 = sum(average_deaths_2015_2019_all_age), by(country region)

// gen date = date(day, "YMD")
// format date %td
// egen start_date = min(date), by(entity)
// format start_date %td
// egen end_date = max(date), by(entity)
// format end_date %td

// gen excess_deaths_count = total_deaths - total_expected_deaths 

// kountry entity, from(other) m
// drop if MARKER!=1
// drop MARKER

// bysort NAMES_STD: gen dup = cond(_N==1, 0,_n) 
// drop if dup > 1
// drop dup

// drop if end_date < td(01dec2020)
// keep NAMES_STD excess_deaths_count
// *** save
// save ${path_data}/excess_deaths.dta, replace
*********************************** 
************************************ Merge all outcomes data 

*** load gdp.dta and merge with covid_deaths.dta
use ${path_data}/gdp.dta, clear

merge 1:m NAMES_STD using ${path_data}/gdppc.dta
drop if _merge==2
drop _merge country iso


merge 1:m iso3 using ${path_data}/covid_deaths.dta
drop if _merge==2
drop country_region _merge

merge 1:1 NAMES_STD using ${path_data}/covid_cases.dta
drop if _merge!=3
drop _merge

merge 1:m NAMES_STD using ${path_data}/excess_deaths.dta
drop if _merge==2
drop _merge

save ${path_data}/outcomes.dta, replace





