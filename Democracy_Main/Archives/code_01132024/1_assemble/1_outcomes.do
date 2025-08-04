
************************************ 
************************************ GDP Growth Rates 

import excel ${path_input}/outcomes/gdp/imf-dm-export-20210421.xls, sheet("NGDP_RPCH") clear

// drop B C D E F G H I J K L M N O P Q R S T U AQ AR AS AT AU
rename A country

local year=1981
foreach var of varlist C-AV{
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

drop B

save ${path_data}/gdp.dta, replace


************************************ 
************************************ GDP Growth Rates: 1961-1980

import delimited ${path_input}/outcomes/gdp/API_NY.GDP.MKTP.KD.ZG_DS2_en_csv_v2_2916869.csv, encoding(UTF-8) rowrange(6) clear 

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

keep v1 v2 v349 v714 v1076
rename v1 province_state
rename v2 country_region
rename v349 deaths
rename v714 deaths21
rename v1076 deaths22
drop if deaths=="12/31/20"
drop if deaths21=="12/31/21"
drop if deaths22=="12/31/22"
destring deaths, replace
destring deaths21, replace
destring deaths22, replace
egen total_deaths = sum(deaths), by(country_region)
egen total_deaths21 = sum(deaths21), by(country_region)
egen total_deaths22 = sum(deaths22), by(country_region)

//drop duplicates
bysort country_region total_deaths: gen dup = cond(_N==1, 0,_n) 
drop if dup > 1
drop province_state deaths dup

bysort country_region total_deaths21: gen dup = cond(_N==1, 0,_n) 
drop if dup > 1
drop deaths21 dup

bysort country_region total_deaths22: gen dup = cond(_N==1, 0,_n) 
drop if dup > 1
drop deaths22 dup

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
gen total_deaths_per_million21 = (total_deaths21/population)*1000000
gen total_deaths_per_million22 = (total_deaths22/population)*1000000
keep country_region iso3 total_deaths_per_million total_deaths_per_million21 total_deaths_per_million22
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

************************************ 
************************************ World Inequality Database

cap ssc install wid

wid, indicators(shweal) perc(p90p100) ages(992) pop(j) year(2020) clear
rename val top10_income_share2020
keep country top10_income_share2020

tempfile f1
save `f1'

wid, indicators(shweal) perc(p90p100) ages(992) pop(j) year(2021) clear
rename val top10_income_share2021
keep country top10_income_share2021

tempfile f2
save `f2'

wid, indicators(shweal) perc(p99p100) ages(992) pop(j) year(2020) clear
rename val top1_income_share2020
keep country top1_income_share2020

tempfile f3
save `f3'

wid, indicators(shweal) perc(p99p100) ages(992) pop(j) year(2021) clear
rename val top1_income_share2021
keep country top1_income_share2021

tempfile f4
save `f4'

wid, indicators(shweal) perc(p0p50) ages(992) pop(j) year(2020) clear
rename val bot50_income_share2020
keep country bot50_income_share2020

tempfile f5
save `f5'

loc lst = ""
forval i = 2001/2019 {
	loc lst = "`lst' `i'"
}

wid, indicators(shweal) perc(p90p100) ages(992) pop(j) year(`lst') clear
collapse value, by(country)
rename val mean_top10_inc_shr_2001_2019
keep country mean_top10_inc_shr_2001_2019

tempfile f6
save `f6'

wid, indicators(shweal) perc(p99p100) ages(992) pop(j) year(`lst') clear
collapse value, by(country)
rename val mean_top1_inc_shr_2001_2019
keep country mean_top1_inc_shr_2001_2019

tempfile f7
save `f7'

wid, indicators(shweal) perc(p0p50) ages(992) pop(j) year(`lst') clear
collapse value, by(country)
rename val mean_bot50_inc_shr_2001_2019
keep country mean_bot50_inc_shr_2001_2019

tempfile f8
save `f8'

loc lst = ""
forval i = 1981/1990 {
	loc lst = "`lst' `i'"
}

wid, indicators(shweal) perc(p90p100) ages(992) pop(j) year(`lst') clear
collapse value, by(country)
rename val mean_top10_inc_shr_1981_1990
keep country mean_top10_inc_shr_1981_1990

tempfile f9
save `f9'

wid, indicators(shweal) perc(p99p100) ages(992) pop(j) year(`lst') clear
collapse value, by(country)
rename val mean_top1_inc_shr_1981_1990
keep country mean_top1_inc_shr_1981_1990

tempfile f10
save `f10'

wid, indicators(shweal) perc(p0p50) ages(992) pop(j) year(`lst') clear
collapse value, by(country)
rename val mean_bot50_inc_shr_1981_1990
keep country mean_bot50_inc_shr_1981_1990

tempfile f11
save `f11'

loc lst = ""
forval i = 1991/2000 {
	loc lst = "`lst' `i'"
}

wid, indicators(shweal) perc(p90p100) ages(992) pop(j) year(`lst') clear
collapse value, by(country)
rename val mean_top10_inc_shr_1991_2000
keep country mean_top10_inc_shr_1991_2000

tempfile f12
save `f12'

wid, indicators(shweal) perc(p99p100) ages(992) pop(j) year(`lst') clear
collapse value, by(country)
rename val mean_top1_inc_shr_1991_2000
keep country mean_top1_inc_shr_1991_2000

tempfile f13
save `f13'

wid, indicators(shweal) perc(p0p50) ages(992) pop(j) year(`lst') clear
collapse value, by(country)
rename val mean_bot50_inc_shr_1991_2000
keep country mean_bot50_inc_shr_1991_2000

tempfile f14
save `f14'

loc lst = ""
forval i = 2001/2010 {
	loc lst = "`lst' `i'"
}

wid, indicators(shweal) perc(p90p100) ages(992) pop(j) year(`lst') clear
collapse value, by(country)
rename val mean_top10_inc_shr_2001_2010
keep country mean_top10_inc_shr_2001_2010

tempfile f15
save `f15'

wid, indicators(shweal) perc(p99p100) ages(992) pop(j) year(`lst') clear
collapse value, by(country)
rename val mean_top1_inc_shr_2001_2010
keep country mean_top1_inc_shr_2001_2010

tempfile f16
save `f16'

wid, indicators(shweal) perc(p0p50) ages(992) pop(j) year(`lst') clear
collapse value, by(country)
rename val mean_bot50_inc_shr_2001_2010
keep country mean_bot50_inc_shr_2001_2010

tempfile f17
save `f17'

loc lst = ""
forval i = 2011/2020 {
	loc lst = "`lst' `i'"
}

wid, indicators(shweal) perc(p90p100) ages(992) pop(j) year(`lst') clear
collapse value, by(country)
rename val mean_top10_inc_shr_2011_2020
keep country mean_top10_inc_shr_2011_2020

tempfile f18
save `f18'

wid, indicators(shweal) perc(p99p100) ages(992) pop(j) year(`lst') clear
collapse value, by(country)
rename val mean_top1_inc_shr_2011_2020
keep country mean_top1_inc_shr_2011_2020

tempfile f19
save `f19'

wid, indicators(shweal) perc(p0p50) ages(992) pop(j) year(`lst') clear
collapse value, by(country)
rename val mean_bot50_inc_shr_2011_2020
keep country mean_bot50_inc_shr_2011_2020

merge 1:1 country using `f1', nogen
merge 1:1 country using `f2', nogen
merge 1:1 country using `f3', nogen
merge 1:1 country using `f4', nogen
merge 1:1 country using `f5', nogen
merge 1:1 country using `f6', nogen
merge 1:1 country using `f7', nogen
merge 1:1 country using `f8', nogen
merge 1:1 country using `f9', nogen
merge 1:1 country using `f10', nogen
merge 1:1 country using `f11', nogen
merge 1:1 country using `f12', nogen
merge 1:1 country using `f13', nogen
merge 1:1 country using `f14', nogen
merge 1:1 country using `f15', nogen
merge 1:1 country using `f16', nogen
merge 1:1 country using `f17', nogen
merge 1:1 country using `f18', nogen
merge 1:1 country using `f19', nogen

replace top1_income_share2020 = top1_income_share2020 * 100
replace top1_income_share2021 = top1_income_share2021 * 100
replace top10_income_share2020 = top10_income_share2020 * 100
replace top10_income_share2021 = top10_income_share2021 * 100
replace bot50_income_share2020 = bot50_income_share2020 * 100
replace mean_top10_inc_shr_2001_2019 = mean_top10_inc_shr_2001_2019 * 100
replace mean_top1_inc_shr_2001_2019 = mean_top1_inc_shr_2001_2019 * 100
replace mean_bot50_inc_shr_2001_2019 = mean_bot50_inc_shr_2001_2019 * 100
replace mean_top10_inc_shr_1981_1990 = mean_top10_inc_shr_1981_1990 * 100
replace mean_top1_inc_shr_1981_1990 = mean_top1_inc_shr_1981_1990 * 100
replace mean_bot50_inc_shr_1981_1990 = mean_bot50_inc_shr_1981_1990 * 100
replace mean_top10_inc_shr_1991_2000 = mean_top10_inc_shr_1991_2000 * 100
replace mean_top1_inc_shr_1991_2000 = mean_top1_inc_shr_1991_2000 * 100
replace mean_bot50_inc_shr_1991_2000 = mean_bot50_inc_shr_1991_2000 * 100
replace mean_top10_inc_shr_2001_2010 = mean_top10_inc_shr_2001_2010 * 100
replace mean_top1_inc_shr_2001_2010 = mean_top1_inc_shr_2001_2010 * 100
replace mean_bot50_inc_shr_2001_2010 = mean_bot50_inc_shr_2001_2010 * 100
replace mean_top10_inc_shr_2011_2020 = mean_top10_inc_shr_2011_2020 * 100
replace mean_top1_inc_shr_2011_2020 = mean_top1_inc_shr_2011_2020 * 100
replace mean_bot50_inc_shr_2011_2020 = mean_bot50_inc_shr_2011_2020 * 100

rename country WID_code

merge 1:1 WID_code using "${path_input}/outcomes/inequality/wid_country.dta", keepusing(country_name)
keep if _merge==3
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

import excel ${path_input}/outcomes/happiness/DataForTable2.1WHR2023.xls, sheet("Sheet1") firstrow clear

preserve
	keep if year == 2020
	rename Positiveaffect Positiveaffect2020
	rename LifeLadder LifeLadder2020
	keep Countryname Positiveaffect2020 LifeLadder2020
	tempfile f1
	save `f1'
restore
preserve
	keep if year == 2021
	rename Positiveaffect Positiveaffect2021
	rename LifeLadder LifeLadder2021
	keep Countryname Positiveaffect2021 LifeLadder2021
	tempfile f2
	save `f2'
restore
preserve
	keep if year == 2022
	rename Positiveaffect Positiveaffect2022
	rename LifeLadder LifeLadder2022
	keep Countryname Positiveaffect2022 LifeLadder2022
	tempfile f3
	save `f3'
restore
keep if (year >= 2010) & (year <= 2019)
// keep when all years observed, data avaibility pre 2010
egen t = count(year), by(Countryname)
keep if t == 2019-2010 + 1
collapse Positiveaffect LifeLadder, by(Countryname)
rename Positiveaffect mean_Positiveaffect_2010_2019
rename LifeLadder mean_LifeLadder_2010_2019

merge 1:1 Countryname using `f1', nogen
merge 1:1 Countryname using `f2', nogen
merge 1:1 Countryname using `f3', nogen

replace Positiveaffect2020 = Positiveaffect2020 * 100
replace Positiveaffect2021 = Positiveaffect2021 * 100
replace Positiveaffect2022 = Positiveaffect2022 * 100
replace mean_Positiveaffect_2010_2019 = mean_Positiveaffect_2010_2019 * 100

rename Countryname NAMES_STD
replace NAMES_STD = "Congo" if NAMES_STD == "Congo (Brazzaville)"
replace NAMES_STD = "Democratic Republic of Congo" if NAMES_STD == "Congo (Kinshasa)"
replace NAMES_STD = "Czech Republic" if NAMES_STD == "Czechia"
replace NAMES_STD = "Cote d'Ivoire" if NAMES_STD == "Ivory Coast"
replace NAMES_STD = "Kyrgyz Republic" if NAMES_STD == "Kyrgyzstan"
replace NAMES_STD = "Slovak Republic" if NAMES_STD == "Slovakia"
replace NAMES_STD = "Turkey" if NAMES_STD == "Turkiye"
replace NAMES_STD = "Macedonia" if NAMES_STD == "North Macedonia"

save ${path_data}/happiness.dta, replace

************************************ 
************************************ Financial Flows
import excel ${path_input}/outcomes/financial_flows/EWN-dataset_12-2022.xlsx, sheet("Dataset") firstrow clear

rename netIIPexclgoldGDPdomestic financial_flows
rename Year year
keep year financial_flows Country

preserve
	keep if year == 2020
	rename financial_flows financial_flows2020
	keep Country financial_flows2020
	tempfile f1
	save `f1'
restore
preserve
	keep if year == 2021
	rename financial_flows financial_flows2021
	keep Country financial_flows2021
	tempfile f2
	save `f2'
restore
preserve
	keep if (year >= 2001) & (year <= 2019)
	egen t = count(year), by(Country)
	keep if t == 2019-2001 + 1
	collapse financial_flows, by(Country)
	rename financial_flows mean_financial_flows_2001_2019
	tempfile f3
	save `f3'
restore
preserve
	keep if (year >= 1981) & (year <= 1990)
	egen t = count(year), by(Country)
	keep if t == 1990-1981 + 1
	collapse financial_flows, by(Country)
	rename financial_flows mean_financial_flows_1981_1990
	tempfile f4
	save `f4'
restore
preserve
	keep if (year >= 1991) & (year <= 2000)
	egen t = count(year), by(Country)
	keep if t == 2000-1991 + 1
	collapse financial_flows, by(Country)
	rename financial_flows mean_financial_flows_1991_2000
	tempfile f5
	save `f5'
restore
preserve
	keep if (year >= 2001) & (year <= 2010)
	egen t = count(year), by(Country)
	keep if t == 2010-2001 + 1
	collapse financial_flows, by(Country)
	rename financial_flows mean_financial_flows_2001_2010
	tempfile f6
	save `f6'
restore
keep if (year >= 2011) & (year <= 2020)
egen t = count(year), by(Country)
keep if t == 2020-2011 + 1
collapse financial_flows, by(Country)
rename financial_flows mean_financial_flows_2011_2020

merge 1:1 Country using `f1', nogen
merge 1:1 Country using `f2', nogen
merge 1:1 Country using `f3', nogen
merge 1:1 Country using `f4', nogen
merge 1:1 Country using `f5', nogen
merge 1:1 Country using `f6', nogen

replace financial_flows2020 = financial_flows2020 * 100
replace financial_flows2021 = financial_flows2021 * 100
replace mean_financial_flows_2001_2019 = mean_financial_flows_2001_2019 * 100
replace mean_financial_flows_1981_1990 = mean_financial_flows_1981_1990 * 100
replace mean_financial_flows_1991_2000 = mean_financial_flows_1991_2000 * 100
replace mean_financial_flows_2001_2010 = mean_financial_flows_2001_2010 * 100
replace mean_financial_flows_2011_2020 = mean_financial_flows_2011_2020 * 100

rename Country NAMES_STD

replace NAMES_STD = "Afghanistan" if NAMES_STD == "Afghanistan, I.R. of"
replace NAMES_STD = "Bahamas" if NAMES_STD == "Bahamas, The"
replace NAMES_STD = "Brunei" if NAMES_STD == "Brunei Darussalam"
replace NAMES_STD = "Central African Republic" if NAMES_STD == "Central African Rep."
replace NAMES_STD = "China" if NAMES_STD == "China,P.R.: Mainland"
replace NAMES_STD = "Congo" if NAMES_STD == "Congo, Republic of"
replace NAMES_STD = "Cote d'Ivoire" if NAMES_STD == "Côte d'Ivoire"
replace NAMES_STD = "Democratic Republic of Congo" if NAMES_STD == "Congo, Dem. Rep. of"
replace NAMES_STD = "Gambia" if NAMES_STD == "Gambia, The"
replace NAMES_STD = "Iran" if NAMES_STD == "Iran, Islamic Republic of"
replace NAMES_STD = "Laos" if NAMES_STD == "Lao People's Dem.Rep"
replace NAMES_STD = "Macedonia" if NAMES_STD == "North Macedonia"
replace NAMES_STD = "Saint Kitts and Nevis" if NAMES_STD == "St. Kitts and Nevis"
replace NAMES_STD = "Saint Lucia" if NAMES_STD == "St. Lucia"
replace NAMES_STD = "Saint Vincent and the Grenadines" if NAMES_STD == "St. Vincent & Grens."
replace NAMES_STD = "Sao Tome and Principe" if NAMES_STD == "São Tomé & Príncipe"
replace NAMES_STD = "South Korea" if NAMES_STD == "Korea"
replace NAMES_STD = "Swaziland" if NAMES_STD == "Eswatini"
replace NAMES_STD = "Syria" if NAMES_STD == "Syrian Arab Republic"
replace NAMES_STD = "Timor" if NAMES_STD == "Timor-Leste"
replace NAMES_STD = "Venezuela" if NAMES_STD == "Venezuela, Rep. Bol."
replace NAMES_STD = "Yemen" if NAMES_STD == "Yemen, Republic of"

save ${path_data}/financial_flows.dta, replace

************************************ 
************************************ Night Light

use ${path_input}/outcomes/night_light/20190733data/Data/master/Estimations.dta, replace

encode countrycode,gen(countrycode1)
xtset countrycode1 year
rename lndn13 night_light
rename countryname NAMES_STD
gen g_night_light = D.night_light
replace g_night_light = g_night_light*100
keep year g_night_light night_light NAMES_STD

preserve
	keep if (year >= 1992) & (year <= 2000)
	egen t = count(year), by(NAMES_STD)
	keep if t == 2000-1992 + 1
	collapse g_night_light night_light, by(NAMES_STD)
	rename night_light mean_night_light_1992_2000
	rename g_night_light mean_g_night_light_1992_2000
	tempfile f1
	save `f1'
restore
keep if (year >= 2001) & (year <= 2013)
egen t = count(year), by(NAMES_STD)
keep if t == 2013-2001 + 1
collapse g_night_light night_light, by(NAMES_STD)
rename night_light mean_night_light_2001_2013
rename g_night_light mean_g_night_light_2001_2013

merge 1:1 NAMES_STD using `f1', nogen

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

************************************ 
************************************ World Inequality Database: Median Income

wid, indicators(tptinc) perc(p50p51) ages(992) pop(j) year(2020) clear
rename val med_income_2020
keep country med_income_2020

tempfile f1
save `f1'

wid, indicators(tptinc) perc(p50p51) ages(992) pop(j) year(2021) clear
rename val med_income_2021
keep country med_income_2021

tempfile f2
save `f2'

loc lst = ""
forval i = 2001/2019 {
	loc lst = "`lst' `i'"
}

wid, indicators(tptinc) perc(p50p51) ages(992) pop(j) year(`lst') clear
collapse value, by(country)
rename val mean_med_income_2001_2019
keep country mean_med_income_2001_2019

tempfile f3
save `f3'

loc lst = ""
forval i = 1981/1990 {
	loc lst = "`lst' `i'"
}

wid, indicators(tptinc) perc(p50p51) ages(992) pop(j) year(`lst') clear
collapse value, by(country)
rename val mean_med_income_1981_1990
keep country mean_med_income_1981_1990

tempfile f4
save `f4'

loc lst = ""
forval i = 1991/2000 {
	loc lst = "`lst' `i'"
}

wid, indicators(tptinc) perc(p50p51) ages(992) pop(j) year(`lst') clear
collapse value, by(country)
rename val mean_med_income_1991_2000
keep country mean_med_income_1991_2000

tempfile f5
save `f5'

loc lst = ""
forval i = 2001/2010 {
	loc lst = "`lst' `i'"
}

wid, indicators(tptinc) perc(p50p51) ages(992) pop(j) year(`lst') clear
collapse value, by(country)
rename val mean_med_income_2001_2010
keep country mean_med_income_2001_2010

tempfile f6
save `f6'

loc lst = ""
forval i = 2011/2020 {
	loc lst = "`lst' `i'"
}

wid, indicators(tptinc) perc(p50p51) ages(992) pop(j) year(`lst') clear
collapse value, by(country)
rename val mean_med_income_2011_2020
keep country mean_med_income_2011_2020

tempfile f7
save `f7'

loc lst = ""
forval i = 1980/1990 {
	loc lst = "`lst' `i'"
}

wid, indicators(tptinc) perc(p50p51) ages(992) pop(j) year(`lst') clear
encode country,gen(country1)
xtset country1 year
gen growth_value = 100*(value[_n]-value[_n-1])/value[_n-1]
drop if year == 1980
collapse growth_value, by(country)
rename growth_value mean_g_med_income_1981_1990
keep country mean_g_med_income_1981_1990

tempfile f8
save `f8'

loc lst = ""
forval i = 1990/2000 {
	loc lst = "`lst' `i'"
}

wid, indicators(tptinc) perc(p50p51) ages(992) pop(j) year(`lst') clear
encode country,gen(country1)
xtset country1 year
gen growth_value = 100*(value[_n]-value[_n-1])/value[_n-1]
drop if year == 1990
collapse growth_value, by(country)
rename growth_value mean_g_med_income_1991_2000
keep country mean_g_med_income_1991_2000

tempfile f9
save `f9'

loc lst = ""
forval i = 2000/2010 {
	loc lst = "`lst' `i'"
}

wid, indicators(tptinc) perc(p50p51) ages(992) pop(j) year(`lst') clear
encode country,gen(country1)
xtset country1 year
gen growth_value = 100*(value[_n]-value[_n-1])/value[_n-1]
drop if year == 2000
collapse growth_value, by(country)
rename growth_value mean_g_med_income_2001_2010
keep country mean_g_med_income_2001_2010

tempfile f10
save `f10'

loc lst = ""
forval i = 2010/2020 {
	loc lst = "`lst' `i'"
}

wid, indicators(tptinc) perc(p50p51) ages(992) pop(j) year(`lst') clear
encode country,gen(country1)
xtset country1 year
gen growth_value = 100*(value[_n]-value[_n-1])/value[_n-1]
drop if year == 2010
collapse growth_value, by(country)
rename growth_value mean_g_med_income_2011_2020
keep country mean_g_med_income_2011_2020

merge 1:1 country using `f1', nogen
merge 1:1 country using `f2', nogen
merge 1:1 country using `f3', nogen
merge 1:1 country using `f4', nogen
merge 1:1 country using `f5', nogen
merge 1:1 country using `f6', nogen
merge 1:1 country using `f7', nogen
merge 1:1 country using `f8', nogen
merge 1:1 country using `f9', nogen
merge 1:1 country using `f10', nogen

replace med_income_2020 = log(med_income_2020)
replace med_income_2021 = log(med_income_2021)
replace mean_med_income_1981_1990 = log(mean_med_income_1981_1990)
replace mean_med_income_1991_2000 = log(mean_med_income_1991_2000)
replace mean_med_income_2001_2010 = log(mean_med_income_2001_2010)
replace mean_med_income_2011_2020 = log(mean_med_income_2011_2020)
replace mean_med_income_2001_2019 = log(mean_med_income_2001_2019)

rename country WID_code

merge 1:1 WID_code using "${path_input}/outcomes/inequality/wid_country.dta", keepusing(country_name)
keep if _merge==3
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

save ${path_data}/income.dta, replace

************************************ 
************************************ Hours Worked

use ${path_input}/outcomes/hours_worked/Data/Cleaned_data/repl_master_stats.dta, replace

rename hwe_a_all hours_worked_core
rename refyear hours_worked_core_year
rename countryname NAMES_STD
keep if coreDummy == 1
keep year hours_worked_core hours_worked_core_year NAMES_STD

replace NAMES_STD = "Timor" if NAMES_STD == "Timor-Leste"

save ${path_data}/hours_worked.dta, replace

************************************ 
************************************ Effective Retirement Age

import delimited ${path_input}/outcomes/retirement_age/PAG_30122023023144784.csv, encoding(UTF-8) rowrange(6) clear 

rename country NAMES_STD
keep NAMES_STD year indicator value

preserve
	keep if year == 1970 & indicator == "Effective labour market exit age, men"
	rename value effective_ret_age_men_1970
	keep NAMES_STD effective_ret_age_men_1970
	tempfile f1
	save `f1'
restore
preserve
	keep if year == 1970 & indicator == "Effective labour market exit age, women"
	rename value effective_ret_age_women_1970
	keep NAMES_STD effective_ret_age_women_1970
	tempfile f2
	save `f2'
restore
preserve
	keep if year == 1980 & indicator == "Effective labour market exit age, men"
	rename value effective_ret_age_men_1980
	keep NAMES_STD effective_ret_age_men_1980
	tempfile f3
	save `f3'
restore
preserve
	keep if year == 1980 & indicator == "Effective labour market exit age, women"
	rename value effective_ret_age_women_1980
	keep NAMES_STD effective_ret_age_women_1980
	tempfile f4
	save `f4'
restore
preserve
	keep if year == 1990 & indicator == "Effective labour market exit age, men"
	rename value effective_ret_age_men_1990
	keep NAMES_STD effective_ret_age_men_1990
	tempfile f5
	save `f5'
restore
preserve
	keep if year == 1990 & indicator == "Effective labour market exit age, women"
	rename value effective_ret_age_women_1990
	keep NAMES_STD effective_ret_age_women_1990
	tempfile f6
	save `f6'
restore
preserve
	keep if year == 2000 & indicator == "Effective labour market exit age, men"
	rename value effective_ret_age_men_2000
	keep NAMES_STD effective_ret_age_men_2000
	tempfile f7
	save `f7'
restore
preserve
	keep if year == 2000 & indicator == "Effective labour market exit age, women"
	rename value effective_ret_age_women_2000
	keep NAMES_STD effective_ret_age_women_2000
	tempfile f8
	save `f8'
restore
preserve
	keep if year == 2010 & indicator == "Effective labour market exit age, men"
	rename value effective_ret_age_men_2010
	keep NAMES_STD effective_ret_age_men_2010
	tempfile f9
	save `f9'
restore
preserve
	keep if year == 2010 & indicator == "Effective labour market exit age, women"
	rename value effective_ret_age_women_2010
	keep NAMES_STD effective_ret_age_women_2010
	tempfile f10
	save `f10'
restore
preserve
	keep if year == 2020 & indicator == "Effective labour market exit age, men"
	rename value effective_ret_age_men_2020
	keep NAMES_STD effective_ret_age_men_2020
	tempfile f11
	save `f11'
restore
keep if year == 2020 & indicator == "Effective labour market exit age, women"
rename value effective_ret_age_women_2020
keep NAMES_STD effective_ret_age_women_2020

merge m:m NAMES_STD using `f1', nogen
merge m:m NAMES_STD using `f2', nogen
merge m:m NAMES_STD using `f3', nogen
merge m:m NAMES_STD using `f4', nogen
merge m:m NAMES_STD using `f5', nogen
merge m:m NAMES_STD using `f6', nogen
merge m:m NAMES_STD using `f7', nogen
merge m:m NAMES_STD using `f8', nogen
merge m:m NAMES_STD using `f9', nogen
merge m:m NAMES_STD using `f10', nogen
merge m:m NAMES_STD using `f11', nogen

replace NAMES_STD = "China" if NAMES_STD == "China (People's Republic of)"
replace NAMES_STD = "Czech Republic" if NAMES_STD == "Czechia"
replace NAMES_STD = "South Korea" if NAMES_STD == "Korea"
replace NAMES_STD = "Turkey" if NAMES_STD == "Türkiye"

save ${path_data}/effective_retirement_age.dta, replace

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

merge 1:m iso3 using ${path_data}/covid_deaths.dta
drop if _merge==2
drop country_region _merge

merge 1:1 NAMES_STD using ${path_data}/covid_cases.dta
drop if _merge!=3
drop _merge

merge 1:m NAMES_STD using ${path_data}/excess_deaths.dta
drop if _merge==2
drop _merge

merge 1:1 NAMES_STD using ${path_data}/excess_deaths_who.dta
drop if _merge==2
drop _merge

merge 1:1 NAMES_STD using ${path_data}/inequality.dta
drop if _merge==2
drop _merge

merge 1:1 NAMES_STD using ${path_data}/happiness.dta
drop if _merge==2
drop _merge

merge 1:1 NAMES_STD using ${path_data}/financial_flows.dta
drop if _merge==2
drop _merge

merge 1:1 NAMES_STD using ${path_data}/night_light.dta
drop if _merge==2
drop _merge

merge 1:1 NAMES_STD using ${path_data}/income.dta
drop if _merge==2
drop _merge

merge 1:1 NAMES_STD using ${path_data}/hours_worked.dta
drop if _merge==2
drop _merge

merge 1:1 NAMES_STD using ${path_data}/effective_retirement_age.dta
drop if _merge==2
drop _merge

merge 1:1 NAMES_STD using ${path_data}/affect_polarization.dta
drop if _merge==2
drop _merge

save ${path_data}/outcomes.dta, replace
