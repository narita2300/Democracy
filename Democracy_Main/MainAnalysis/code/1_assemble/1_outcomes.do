
************************************ 
************************************ GDP Growth Rates 

import delimited "${path_input}/outcomes/gdp/API_NY.GDP.MKTP.KD.ZG_DS2_en_csv_v2_6508481.csv", varnames(5) clear 

local y = 1960
forvalues i = 5/68 {
	rename v`i' var`y'
	local y = `y' + 1
}

*Reshape the data from wide to long to merge with GDP deflator
reshape long var, i(countryname countrycode) j(year)
ren var gdp_growth

tempfile gdpgrowth
save `gdpgrowth', replace

*Merge with GDP deflator
import delimited "${path_input}/outcomes/gdp/WDI_gdp_deflator_03042024.csv", varnames(1) clear 
keep if seriescode == "NY.GDP.DEFL.ZS"
reshape long yr, i(countryname countrycode) j(year)
ren yr gdp_deflator
merge 1:1 countrycode year using `gdpgrowth'
drop if _merge != 3 //remove years - 2023
drop _merge

destring gdp_deflator, force replace

encode countrycode, gen(countrycode_num)
xtset countrycode_num year
gen real_gdp_growth = 1- L.gdp_deflator/gdp_deflator * (1-gdp_growth)

*Reshape from long to wide
keep countryname countrycode year real_gdp_growth 
ren real_gdp_growth gdp_growth
reshape wide gdp_growth, i(countrycode countryname) j(year)
kountry countrycode, from (iso3c) m
ren countryname country
drop gdp_growth1960-gdp_growth1980
save ${path_data}/gdp_growth.dta, replace


*** MERGE COUNTRIES LIST DATA WITH GDP DATA 
use ${path_data}/countries.dta, replace
merge 1:1 NAMES_STD using ${path_data}/gdp_growth.dta
drop if _merge==2
drop _merge country 

*drop B

save ${path_data}/gdp.dta, replace


************************************ 
************************************ GDP Growth Rates: 1961-1980

import delimited ${path_input}/outcomes/gdp/API_NY.GDP.MKTP.KD.ZG_DS2_en_csv_v2_6508481.csv, encoding(UTF-8) rowrange(6) clear 

rename v1 country
rename v2 iso

local year= 1960
forvalues num = 5/65{
	rename v`num' gdp_growth`year'
	local year = `year' + 1
}

keep country iso gdp_growth1961-gdp_growth1980
kountry iso, from(iso3c) m
drop if MARKER==0
drop MARKER

save ${path_data}/gdp2.dta, replace
************************************ 
************************************ GDP Per Capita Growth Rates 

import delimited ${path_input}/outcomes/gdppc/API_NY.GDP.PCAP.KD.ZG_DS2_en_csv_v2_6508499.csv, encoding(UTF-8) rowrange(6) clear 

rename v1 country
rename v2 iso

local year = 1960
forvalues num = 5/67{
	
	rename v`num' gdppc_growth`year'
	local year = `year' + 1
}

keep country iso gdppc_growth*
kountry iso, from(iso3c) m
drop if MARKER==0
drop MARKER

save ${path_data}/gdppc.dta, replace

*********************************** 
************************************ Population Growth

import delimited ${path_input}/outcomes/population_growth/population_growth.csv, clear

rename country NAMES_STD

save ${path_data}/population_growth.dta, replace

*********************************** 
************************************ CO2 Emissions

import delimited ${path_input}/outcomes/CO2/co2_emissions.csv, clear

rename country NAMES_STD

save ${path_data}/co2_emissions.dta, replace

*********************************** 
************************************ Energy

import delimited ${path_input}/channels21st/new_channels/energy.csv, clear

rename country NAMES_STD

save ${path_data}/energy.dta, replace

*********************************** 
************************************ Tax Revenue

import delimited ${path_input}/outcomes/taxes_gdp/taxes_gdp.csv, clear

rename country NAMES_STD

save ${path_data}/taxes_gdp.dta, replace

*********************************** 
************************************ Median Age
import delimited ${path_input}/outcomes/median_age/median_age.csv, clear

rename country NAMES_STD

save ${path_data}/median_age.dta, replace


// ************************************ 
// ************************************ Covid-19 deaths
//
// *** load covid-19 deaths data, prepare for merge
// import delimited ${path_input}/outcomes/old_outcomes/covid_deaths.csv, clear
//
// rename country NAMES_STD
//
// save ${path_data}/covid_deaths.dta, replace



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

import delimited ${path_input}/outcomes/old_outcomes/excess_deaths_who.csv, clear

rename country NAMES_STD

save "${path_data}/excess_deaths_who.dta", replace


************************************ 
************************************ Total GDP: 1800s (Maddison)
import excel "${path_input}/outcomes/gdppc/horizontal-file_02-2010.xls", sheet("GDP") cellrange(A2:GR198) clear

rename A country
drop B-K
// rename L YR1820

local year = 1820
foreach var of varlist L-GR {
	di "`var'"
	label variable `var' "GDP in Million 1990 International Geary-Khamis Dollars in `year' "
	rename `var' total_gdp`year'_maddison
	local year = `year'+1

}

kountry country, from(other) m
drop if MARKER == 0
drop MARKER

save ${path_data}/total_gdp_1800s.dta, replace


************************************ 
************************************ GDP per capita: 1800s (Maddison)
import excel "${path_input}/outcomes/gdppc/horizontal-file_02-2010.xls", sheet("PerCapita GDP") cellrange(A2:GR198) clear

rename A country
drop B-K
// rename L YR1820

local year = 1820
foreach var of varlist L-GR {
	di "`var'"
	label variable `var' "GDP Per Capita 1990 International Geary-Khamis Dollars in `year' "
	rename `var' gdppc`year'_maddison
	local year = `year'+1
}

kountry country, from(other) m
drop if MARKER == 0
drop MARKER

save ${path_data}/gdppc_1800s.dta, replace


// *********************************** 
// ************************************ Life Expectancy 
//
// import delimited ${path_input}/outcomes/life_expectancy/life_expectancy.csv, clear
//
// rename country NAMES_STD
//
// save ${path_data}/life_expectancy.dta, replace
//
//
// *********************************** 
// ************************************ Life Expectancy HALE
//
// import delimited ${path_input}/outcomes/life_expectancy_hale/life_expectancy_hale.csv, clear
//
// rename country NAMES_STD
//
// save ${path_data}/life_expectancy_hale.dta, replace


*********************************** 
************************************ Child Mortality

import delimited ${path_input}/outcomes/child_mortality/child_mortality.csv, clear

rename country NAMES_STD

save ${path_data}/child_mortality.dta, replace


************************************ 
************************************ World Inequality Database

// local periods "1981 1991 2001 2011"
local percentiles "p90p100 p99p100 p0p50 p50p51"
local percentile_names "top10 top1 bot50 med"
local fnum = 1


* For 2001-2019 period
local start_year 2001
local end_year 2019
local lst ""
forvalues year = `start_year'/`end_year' {
    local lst "`lst' `year'"
}
forvalues p = 1/4 {
    local perc : word `p' of `percentiles'
    local perc_name : word `p' of `percentile_names'

    wid, indicators(shweal) perc(`perc') ages(992) pop(j) year(`lst') clear
    keep country year val
    sort country year
    by country: gen growth_rate = (val - val[_n-1]) / val[_n-1] * 100 if _n > 1
    drop if growth_rate == .
    collapse (mean) mean_growth_rate = growth_rate, by(country)
    rename mean_growth_rate mean_`perc_name'_inc_shr_2001_2019
    tempfile f`fnum'
    save `f`fnum''
    local ++fnum
}

* Calculate growth rates from 2020 to 2022
local start_year 2020
local end_year 2022
local lst ""
forvalues year = `start_year'/`end_year' {
    local lst "`lst' `year'"
}
forvalues p = 1/4 {
    local perc : word `p' of `percentiles'
    local perc_name : word `p' of `percentile_names'

    wid, indicators(shweal) perc(`perc') ages(992) pop(j) year(`lst') clear
    keep country year val
	
	* For top1 percentile, store the single year variables
    if "`perc'" == "p99p100" {
        preserve
        reshape wide val, i(country) j(year)
        rename val* top1_income_share_*
        tempfile top1_levels
        save `top1_levels'
        restore
    }
    
	sort country year

    by country: gen growth_rate = (val - val[_n-1]) / val[_n-1] * 100 if _n > 1
    drop if growth_rate == .
    collapse (mean) mean_growth_rate = growth_rate, by(country)
    rename mean_growth_rate mean_`perc_name'_inc_shr_2020_2022
    tempfile f`fnum'
    save `f`fnum''
    local ++fnum
}

* Merge all temporary files
use `f1', clear
forvalues i = 2/`=`fnum'-1' {
    merge 1:1 country using `f`i'', nogen
}

* Merge with the top1 single year values
merge 1:1 country using `top1_levels', nogen

rename country WID_code

merge 1:1 WID_code using "${path_input}/outcomes/inequality/wid_country.dta", keepusing(country_name)
keep if _merge == 3
drop _merge

rename country_name NAMES_STD

replace NAMES_STD = "Brunei" if NAMES_STD == "Brunei Darussalam"
replace NAMES_STD = "Cape Verde" if NAMES_STD == "Cabo Verde"
replace NAMES_STD = "Cote d'Ivoire" if WID_code == "CI"
replace NAMES_STD = "Democratic Republic of Congo" if NAMES_STD == "DR Congo"
replace NAMES_STD = "South Korea" if NAMES_STD == "Korea"
replace NAMES_STD = "Kyrgyz Republic" if NAMES_STD == "Kyrgyzstan"
replace NAMES_STD = "Laos" if NAMES_STD == "Lao PDR"
replace NAMES_STD = "Russia" if NAMES_STD == "Russian Federation"
replace NAMES_STD = "Slovak Republic" if NAMES_STD == "Slovakia"
replace NAMES_STD = "Syria" if NAMES_STD == "Syrian Arab Republic"
replace NAMES_STD = "Timor" if NAMES_STD == "Timor-Leste"
replace NAMES_STD = "United States" if NAMES_STD == "USA"
replace NAMES_STD = "Vietnam" if NAMES_STD == "Viet Nam"
replace NAMES_STD = "Macedonia" if NAMES_STD == "North Macedonia"

save ${path_data}/inequality.dta, replace



************************************ 
************************************ World Happiness Report
import delimited ${path_input}/outcomes/old_outcomes/happiness.csv, clear

rename country NAMES_STD

replace NAMES_STD = "Congo" if NAMES_STD == "Congo (Brazzaville)"
replace NAMES_STD = "Democratic Republic of Congo" if NAMES_STD == "Congo (Kinshasa)"
replace NAMES_STD = "Czech Republic" if NAMES_STD == "Czechia"
replace NAMES_STD = "Cote d'Ivoire" if NAMES_STD == "Ivory Coast"
replace NAMES_STD = "Kyrgyz Republic" if NAMES_STD == "Kyrgyzstan"
replace NAMES_STD = "Slovak Republic" if NAMES_STD == "Slovakia"
replace NAMES_STD = "Turkey" if NAMES_STD == "Turkiye"
replace NAMES_STD = "Macedonia" if NAMES_STD == "North Macedonia"

save ${path_data}/happiness.dta, replace

// ************************************ 
// ************************************ Financial Flows
// import delimited ${path_input}/outcomes/old_outcomes/financial_flows.csv, clear
//
// rename country NAMES_STD
//
// replace NAMES_STD = "Afghanistan" if NAMES_STD == "Afghanistan, I.R. of"
// replace NAMES_STD = "Bahamas" if NAMES_STD == "Bahamas, The"
// replace NAMES_STD = "Brunei" if NAMES_STD == "Brunei Darussalam"
// replace NAMES_STD = "Central African Republic" if NAMES_STD == "Central African Rep."
// replace NAMES_STD = "China" if NAMES_STD == "China,P.R.: Mainland"
// replace NAMES_STD = "Congo" if NAMES_STD == "Congo, Republic of"
// replace NAMES_STD = "Cote d'Ivoire" if NAMES_STD == "Côte d'Ivoire"
// replace NAMES_STD = "Democratic Republic of Congo" if NAMES_STD == "Congo, Dem. Rep. of"
// replace NAMES_STD = "Gambia" if NAMES_STD == "Gambia, The"
// replace NAMES_STD = "Iran" if NAMES_STD == "Iran, Islamic Republic of"
// replace NAMES_STD = "Laos" if NAMES_STD == "Lao People's Dem.Rep"
// replace NAMES_STD = "Macedonia" if NAMES_STD == "North Macedonia"
// replace NAMES_STD = "Saint Kitts and Nevis" if NAMES_STD == "St. Kitts and Nevis"
// replace NAMES_STD = "Saint Lucia" if NAMES_STD == "St. Lucia"
// replace NAMES_STD = "Saint Vincent and the Grenadines" if NAMES_STD == "St. Vincent & Grens."
// replace NAMES_STD = "Sao Tome and Principe" if NAMES_STD == "São Tomé & Príncipe"
// replace NAMES_STD = "South Korea" if NAMES_STD == "Korea"
// replace NAMES_STD = "Swaziland" if NAMES_STD == "Eswatini"
// replace NAMES_STD = "Syria" if NAMES_STD == "Syrian Arab Republic"
// replace NAMES_STD = "Timor" if NAMES_STD == "Timor-Leste"
// replace NAMES_STD = "Venezuela" if NAMES_STD == "Venezuela, Rep. Bol."
// replace NAMES_STD = "Yemen" if NAMES_STD == "Yemen, Republic of"
//
// save ${path_data}/financial_flows.dta, replace

************************************ 
************************************ Night Light

use ${path_input}/outcomes/night_light/20190733data/Data/master/Estimations.dta, replace

encode countrycode,gen(countrycode1)
xtset countrycode1 year
rename lndn13 night_light
rename countryname NAMES_STD
gen g_night_light = (exp(D.night_light) -1)*100
keep year g_night_light night_light NAMES_STD dn13_growth
replace dn13_growth = dn13_growth*100

reshape wide g_night_light night_light dn13_growth, i(NAMES_STD) j(year)

replace NAMES_STD = "North Korea" if _n == 102
replace NAMES_STD = "Venezuela" if NAMES_STD == "Venezuela, RB"
replace NAMES_STD = "Bahamas" if NAMES_STD == "Bahamas, The"
replace NAMES_STD = "Brunei" if NAMES_STD == "Brunei Darussalam"
replace NAMES_STD = "Cape Verde" if NAMES_STD == "Cabo Verde"
replace NAMES_STD = "Congo" if NAMES_STD == "Congo, Rep"
replace NAMES_STD = "Democratic Republic of Congo" if NAMES_STD == "Congo, Dem Rep"
replace NAMES_STD = "Egypt" if NAMES_STD == "Egypt, Arab Rep"
replace NAMES_STD = "Gambia" if NAMES_STD == "Gambia, The"
replace NAMES_STD = "Iran" if NAMES_STD == "Iran, Islamic Rep"
replace NAMES_STD = "Laos" if NAMES_STD == "Lao PDR"
replace NAMES_STD = "Macedonia" if NAMES_STD == "North Macedonia"
replace NAMES_STD = "Micronesia" if NAMES_STD == "Micronesia, Fed Sts"
replace NAMES_STD = "South Korea" if NAMES_STD == "Korea, Rep"
replace NAMES_STD = "Swaziland" if NAMES_STD == "Eswatini"
replace NAMES_STD = "Syria" if NAMES_STD == "Syrian Arab Republic"
replace NAMES_STD = "Timor" if NAMES_STD == "Timor-Leste"
replace NAMES_STD = "Venezuela" if NAMES_STD == "Venezuela, RB"
replace NAMES_STD = "Yemen" if NAMES_STD == "Yemen, Rep"
replace NAMES_STD = "Russia" if NAMES_STD == "Russian Federation"
replace NAMES_STD = "Saint Kitts and Nevis" if NAMES_STD == "St Kitts and Nevis" 
replace NAMES_STD = "Saint Lucia" if NAMES_STD == "St Lucia"
replace NAMES_STD = "Saint Vincent and the Grenadines" if NAMES_STD == "St Vincent and the Grenadines"

save ${path_data}/night_light.dta, replace


// ************************************ 
// ************************************ Hours Worked
//
// use ${path_input}/outcomes/hours_worked/Data/Cleaned_data/repl_master_stats.dta, replace
//
// rename hwe_a_all hours_worked_core
// rename refyear hours_worked_core_year
// rename countryname NAMES_STD
// keep if coreDummy == 1
// keep year hours_worked_core hours_worked_core_year NAMES_STD
//
// replace NAMES_STD = "Timor" if NAMES_STD == "Timor-Leste"
//
// save ${path_data}/hours_worked.dta, replace

// ************************************ 
// ************************************ Effective Retirement Age
//
// import delimited ${path_input}/outcomes/old_outcomes/retirement_age.csv, clear
//
// rename country NAMES_STD
//
// replace NAMES_STD = "China" if NAMES_STD == "China (People's Republic of)"
// replace NAMES_STD = "Czech Republic" if NAMES_STD == "Czechia"
// replace NAMES_STD = "South Korea" if NAMES_STD == "Korea"
// replace NAMES_STD = "Turkey" if NAMES_STD == "Türkiye"
//
// save ${path_data}/effective_retirement_age.dta, replace

************************************ 
************************************ Affective Polarization

import delimited ${path_input}/outcomes/cross-polar-replication/analysis/release/descriptive/data.csv, encoding(UTF-8) clear

rename country NAMES_STD
keep NAMES_STD year partisan_affect_polarization

preserve
	keep if (year == 1996 & NAMES_STD == "australia") | (year == 1997 & NAMES_STD == "britain") | ///
			(year == 1997 & NAMES_STD == "canada") | (year == 1994 & NAMES_STD == "denmark") | ///
			(year == 1996 & NAMES_STD == "germany") | (year == 1996 & NAMES_STD == "japan") | ///
			(year == 1996 & NAMES_STD == "new_zealand") | (year == 1997 & NAMES_STD == "norway") | ///
			(year == 1994 & NAMES_STD == "sweden") | (year == 1995 & NAMES_STD == "switzerland") | ///
			(year == 1996 & NAMES_STD == "united_states")
	rename partisan_affect_polarization affect_polarization_near_1996
	keep NAMES_STD affect_polarization_near_1996
	tempfile f1
	save `f1'
restore
keep if (year == 2013 & NAMES_STD == "australia") | (year == 2010 & NAMES_STD == "britain") | ///
		(year == 2011 & NAMES_STD == "canada") | (year == 2011 & NAMES_STD == "denmark") | ///
		(year == 2012 & NAMES_STD == "france") | (year == 2012 & NAMES_STD == "germany") | ///
		(year == 2013 & NAMES_STD == "japan") | (year == 2011 & NAMES_STD == "new_zealand") | ///
		(year == 2013 & NAMES_STD == "norway") | (year == 2010 & NAMES_STD == "sweden") | ///
		(year == 2011 & NAMES_STD == "switzerland") | (year == 2012 & NAMES_STD == "united_states")
rename partisan_affect_polarization affect_polarization_near_2012
keep NAMES_STD affect_polarization_near_2012

merge m:m NAMES_STD using `f1', nogen

replace NAMES_STD = "Australia" if NAMES_STD == "australia"
replace NAMES_STD = "United Kingdom" if NAMES_STD == "britain"
replace NAMES_STD = "Canada" if NAMES_STD == "canada"
replace NAMES_STD = "Denmark" if NAMES_STD == "denmark"
replace NAMES_STD = "France" if NAMES_STD == "france"
replace NAMES_STD = "Germany" if NAMES_STD == "germany"
replace NAMES_STD = "Japan" if NAMES_STD == "japan"
replace NAMES_STD = "New Zealand" if NAMES_STD == "new_zealand"
replace NAMES_STD = "Norway" if NAMES_STD == "norway"
replace NAMES_STD = "Sweden" if NAMES_STD == "sweden"
replace NAMES_STD = "Switzerland" if NAMES_STD == "switzerland"
replace NAMES_STD = "United States" if NAMES_STD == "united_states"

save ${path_data}/affect_polarization.dta, replace


*********************************** 
************************************ Merge all outcomes data 

*** load gdp.dta and merge with covid_deaths.dta
use ${path_data}/gdp.dta, clear

merge 1:m NAMES_STD using ${path_data}/gdp2.dta
drop if _merge==2
drop _merge country iso

merge 1:m NAMES_STD using ${path_data}/gdppc.dta
drop if _merge==2
drop _merge country iso

merge 1:1 NAMES_STD using ${path_data}/gdp_growth.dta
drop if _merge==2
drop _merge

// merge 1:1 NAMES_STD using ${path_data}/covid_deaths.dta
// drop if _merge==2
// drop _merge

merge 1:1 NAMES_STD using ${path_data}/covid_cases.dta
drop if _merge!=3
drop _merge

merge 1:1 NAMES_STD using ${path_data}/excess_deaths_who.dta
drop if _merge==2
drop _merge

merge 1:1 NAMES_STD using ${path_data}/population_growth.dta
drop if _merge==2
drop _merge

merge 1:1 NAMES_STD using ${path_data}/median_age.dta
drop if _merge==2
drop _merge

merge 1:1 NAMES_STD using ${path_data}/co2_emissions.dta
drop if _merge==2
drop _merge

merge 1:1 NAMES_STD using ${path_data}/energy.dta
drop if _merge==2 
drop _merge

merge 1:1 NAMES_STD using ${path_data}/taxes_gdp.dta
drop if _merge==2
drop _merge

// merge 1:1 NAMES_STD using ${path_data}/complete_age_standardized_deaths.dta
// drop if _merge==2
// drop _merge

merge 1:1 NAMES_STD using ${path_data}/inequality.dta
drop if _merge==2
drop _merge

merge 1:1 NAMES_STD using ${path_data}/happiness.dta
drop if _merge==2
drop _merge

// merge 1:1 NAMES_STD using ${path_data}/life_expectancy.dta
// drop if _merge==2
// drop _merge
//
// merge 1:1 NAMES_STD using ${path_data}/life_expectancy_hale.dta
// drop if _merge==2
// drop _merge

merge 1:1 NAMES_STD using ${path_data}/child_mortality.dta
drop if _merge==2
drop _merge

// merge 1:1 NAMES_STD using ${path_data}/financial_flows.dta
// drop if _merge==2
// drop _merge

merge 1:1 NAMES_STD using ${path_data}/night_light.dta
drop if _merge==2
drop _merge

// merge 1:1 NAMES_STD using ${path_data}/income.dta
// drop if _merge==2
// drop _merge

// merge 1:1 NAMES_STD using ${path_data}/hours_worked.dta
// drop if _merge==2
// drop _merge


// merge 1:1 NAMES_STD using ${path_data}/effective_retirement_age.dta
// drop if _merge==2
// drop _merge

merge 1:1 NAMES_STD using ${path_data}/affect_polarization.dta
drop if _merge==2
drop _merge

save ${path_data}/outcomes.dta, replace
