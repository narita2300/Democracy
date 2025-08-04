
************************************
************************************ population

*** import population data 
import excel ${path_input}/controls/population/WPP2019_POP_F01_1_TOTAL_POPULATION_BOTH_SEXES.xlsx, sheet("ESTIMATES") cellrange(A17:BZ306) firstrow clear

local y = 1950
foreach var of varlist H-BZ{
	destring `var', replace force
	replace `var' = `var'/1000
	label variable `var' "Population in `y' (100k)"
	rename `var' population`y'
	local y = `y' + 1
}

keep if Type =="Country/Area"
keep Regionsubregioncountryorar population*
kountry Regionsubregioncountryorar, from(other)

save ${path_data}/population.dta, replace

*** merge with countries.dta
use ${path_data}/countries.dta, replace
merge 1:1 NAMES_STD using ${path_data}/population.dta
drop if _merge==2

keep countries iso3 NAMES_STD population*

*** save
save ${path_data}/population.dta, replace

************************************
************************************ total GDP

*** import GDP data ***
import excel "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/controls/total_gdp/imf-dm-export-20210423.xls", sheet("NGDPD") cellrange(A3:AV231) clear

local y 1980
foreach var of varlist B-AV {
	label variable `var' "GDP in `y' (billion USD, current prices)"
	destring `var', replace force
	rename `var' total_gdp`y'
	local y = `y' + 1
}

rename A countryname
kountry countryname, from(other)
keep NAMES_STD total_gdp1980-total_gdp2020

save ${path_data}/total_gdp.dta, replace

*** merge with countries data 
use ${path_data}/countries.dta, replace
merge 1:m NAMES_STD using ${path_data}/total_gdp.dta
drop if _merge==2
keep countries iso3 NAMES_STD total_gdp* 

*** save
save ${path_data}/total_gdp.dta, replace

************************************
************************************ GDP per capita

*** import GDP per capita data ***
import excel "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/controls/total_gdp/imf-dm-export-20210515-2.xls", sheet("NGDPDPC") cellrange(A3:AV231) clear

local y 1980
foreach var of varlist B-AV {
	label variable `var' "GDP per capita in `y' (USD, current prices)"
	destring `var', replace force
	rename `var' gdppc`y'
	gen loggdppc`y' = log(gdppc`y')
	local y = `y' + 1
}

rename A countryname
kountry countryname, from(other)
keep NAMES_STD gdppc1980-gdppc2020 loggdppc*

merge 1:1 NAMES_STD using ${path_data}/total_gdp.dta
drop if _merge==2
drop if _merge==1
keep countries iso3 NAMES_STD total_gdp* gdppc* loggdppc*

*** save
save ${path_data}/total_gdp.dta, replace

************************************
************************************ latitude

*** import latitude data
import delimited ${path_input}/controls/latitude/average-latitude-longitude-countries.csv, clear 

rename iso3166countrycode iso2
keep iso2 country latitude
gen abs_lat = abs(latitude)
drop latitude

kountry country, from(other)

save ${path_data}/latitude.dta, replace

*** merge with countries data 
use ${path_data}/countries.dta, replace
merge 1:1 NAMES_STD using ${path_data}/latitude.dta
drop if _merge==2
keep countries iso3 NAMES_STD abs_lat

*** save
save ${path_data}/latitude.dta, replace

************************************
************************************ temperature

*** import temperature data
// the periods for which we want mean temperature: 1991-2000, 2001-2010, 2011-2016, 2001-2016, 1971-1980, 1981-1990
local start_year 1991 2001 2011 2001 1991 1971 1981
local end_year 2000 2010 2016 2016 2016 1980 1990
local n_periods : word count `start_year'

forval i = 1/`n_periods' {
	if `:word `i' of `start_year'' >= 1991{
		import delimited ${path_input}/controls/temperature/tas_1991_2016.csv, clear 
	}
	else {
		import delimited ${path_input}/controls/temperature/tas_1961_1990.csv, clear 
	}
		
	keep if year >= `:word `i' of `start_year'' & year <= `:word `i' of `end_year''
	
	bysort country: egen mean_temp_`:word `i' of `start_year''_`:word `i' of `end_year'' = mean(temperaturecelsius)
	bysort country: gen dup = cond(_N==1, 0,_n) 
	drop if dup > 1
	
	label variable mean_temp_`:word `i' of `start_year''_`:word `i' of `end_year'' "Mean Temperature in `:word `i' of `start_year''-:word `i' of `end_year''"
	
	keep country iso3 mean_temp
	kountry country, from(other)
	
	save ${path_data}/temperature_`:word `i' of `start_year''_`:word `i' of `end_year''.dta, replace
}

*** merge with countries data 
use ${path_data}/countries.dta, replace

forval i = 1/`n_periods' {
	merge 1:1 NAMES_STD using ${path_data}/temperature_`:word `i' of `start_year''_`:word `i' of `end_year''.dta
	drop if _merge==2
	drop _merge
	// keep countries iso3 NAMES_STD mean_temp

}

keep countries iso3 NAMES_STD mean_temp*
*** save
save ${path_data}/temperature.dta, replace

************************************
************************************ precipitation

// the periods for which we want mean temperature: 1991-2000, 2001-2010, 2011-2016, 2001-2016, 1971-1980, 1981-1990
local start_year 1991 2001 2011 2001 1991 1971 1981
local end_year 2000 2010 2016 2016 2016 1980 1990
local n_periods : word count `start_year'

forval i = 1/`n_periods' {
	if `:word `i' of `start_year'' >= 1991{
		import delimited ${path_input}/controls/precipitation/pr_1991_2016.csv, clear
	}
	else {
		import delimited ${path_input}/controls/precipitation/pr_1961_1990.csv, clear 
	}
		
	keep if year >= `:word `i' of `start_year'' & year <= `:word `i' of `end_year''
	
	bysort country: egen mean_precip_`:word `i' of `start_year''_`:word `i' of `end_year'' = mean(rainfallmm)
	bysort country: gen dup = cond(_N==1, 0,_n) 
	drop if dup > 1
	
	label variable mean_precip_`:word `i' of `start_year''_`:word `i' of `end_year'' "Mean Precipitation in `:word `i' of `start_year''-:word `i' of `end_year''"
	
	keep country iso3 mean_precip
	kountry country, from(other)
	
	save ${path_data}/precipitation_`:word `i' of `start_year''_`:word `i' of `end_year''.dta, replace
}

*** merge with countries data 
use ${path_data}/countries.dta, replace

forval i = 1/`n_periods' {
	merge 1:1 NAMES_STD using ${path_data}/precipitation_`:word `i' of `start_year''_`:word `i' of `end_year''.dta
	drop if _merge==2
	drop _merge
	// keep countries iso3 NAMES_STD mean_temp

}

keep countries iso3 NAMES_STD mean_precip*
*** save
save ${path_data}/precipitation.dta, replace

************************************
************************************ population density

*** import population density data
import excel ${path_input}/controls/population_density/WPP2019_POP_F06_POPULATION_DENSITY.xlsx, sheet("ESTIMATES") cellrange(A17:BZ306) firstrow clear

local y 1950
foreach v of varlist H-BZ {
rename `v' pop_density`y'
label variable pop_density`y' "Population Density in `y'"
local y = `y'+1
}

keep if Type=="Country/Area"
// keep Regionsubregioncountryorar pop_density2000 pop_density2020
kountry Regionsubregioncountryorar, from(other)
destring pop_density*, replace
drop Regionsubregioncountryorar

save ${path_data}/population_density.dta, replace

*** merge with countries data 
use ${path_data}/countries.dta, replace

merge 1:1 NAMES_STD using ${path_data}/population_density.dta
drop if _merge==2
keep countries iso3 NAMES_STD pop_density*

*** save
save ${path_data}/population_density.dta, replace

************************************
************************************ median age

*** import median age data
import excel ${path_input}/controls/median_age/MedianAgeTotalPop-20210520040839.xlsx,sheet("Data") cellrange(A3:AH257) clear

local y 1950
foreach v of varlist D-R {
	rename `v' median_age`y'
	label variable median_age`y' "Median Age in `y'"
	local y = `y'+5
}

kountry B, from(other) m
drop if MARKER==0
keep B NAMES_STD  median_age*

drop if median_age2020==26.8 //drop Micronesia observation because it refers to a region, not a country
save ${path_data}/median_age.dta, replace

*** merge with countries data 
use ${path_data}/countries.dta, replace
merge 1:m NAMES_STD using ${path_data}/median_age.dta
drop if _merge==2
keep countries iso3 NAMES_STD median_age*

*** save
save ${path_data}/median_age.dta, replace

************************************
************************************ diabetes prevalence

*** import diabetes data
import excel "$path_input/controls/diabetes/IDF (age-adjusted-comparative-prevalence-of-diabetes---).xlsx", sheet("Sheet1") cellrange(A2:H230) firstrow clear
keep CountryTerritory D E
rename D diabetes_prevalence2010
rename E diabetes_prevalence2019

label variable diabetes_prevalence2010 "Prevalence of Diabetes in 2010"
label variable diabetes_prevalence2019 "Prevalence of Diabetes in 2019"

kountry CountryTerritory, from(other)
destring diabetes_prevalence*, replace force

save ${path_data}/diabetes.dta, replace

*** merge with countries data 
use ${path_data}/countries.dta, replace
merge 1:m NAMES_STD using ${path_data}/diabetes.dta
drop if _merge==2
keep countries iso3 NAMES_STD diabetes_prevalence*

*** save
save ${path_data}/diabetes.dta, replace

************************************
************************************ healthcare security index

// load healthcare data
import excel "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/controls/healthcare/GlobalHealthSecurityIndex2019.xlsx", sheet("Sheet2") cellrange(N9:O204) firstrow clear

kountry Country, from(other)
replace NAMES_STD = "Democratic Republic of Congo" if Country=="Congo (Democratic Republic)"
replace NAMES_STD = "Swaziland" if Country=="eSwatini (Swaziland)"
merge 1:1 NAMES_STD using ${path_data}/countries.dta
drop if _merge==1
rename Score100 health_security_index 
label variable health_security_index "Global Health Security Index in 2019"
keep health_security_index NAMES_STD

*** save
save ${path_data}/healthcare.dta, replace


************************************
************************************ Solow fundamentals: capital formation

import delimited "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/controls/solow_fudamentals/API_NE.GDI.TOTL.ZS_DS2_en_csv_v2_2767210.csv", encoding(UTF-8) rowrange(5) clear 

drop if v1 == "Country Name"

local n = 5
forvalues year = 1960/2020 {
	destring v`n', replace force
	rename v`n' capital`year'
	gen logcapital`year' = log(capital`year')
	local n = `n' + 1
}

kountry v2, from(iso3c) m
drop if MARKER ==0
drop v1 v2 v3 v4 MARKER

save  ${path_data}/capital.dta, replace

************************************
************************************ Solow fundamentals: population growth 

import delimited "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/controls/solow_fudamentals/API_SP.POP.GROW_DS2_en_csv_v2_2763938.csv", encoding(UTF-8) rowrange(5) clear 

drop if v1 == "Country Name"

local n = 6
forvalues year = 1961/2020 {
	destring v`n', replace force
	rename v`n' popgrowth`year'
	gen logpopgrowth`year' = log(popgrowth`year')
	local n = `n' + 1
}

kountry v2, from(iso3c) m
drop if MARKER ==0
drop v1 v2 v3 v4 v5 MARKER

save ${path_data}/popgrowth.dta, replace

************************************
************************************ Solow fundamentals: population growth 

import delimited "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/controls/solow_fudamentals/API_SP.POP.GROW_DS2_en_csv_v2_2763938.csv", encoding(UTF-8) rowrange(5) clear 

drop if v1 == "Country Name"

local n = 6
forvalues year = 1961/2020 {
	destring v`n', replace force
	rename v`n' popgrowth`year'
	gen logpopgrowth`year' = log(popgrowth`year')
	local n = `n' + 1
}

kountry v2, from(iso3c) m
drop if MARKER ==0
drop v1 v2 v3 v4 v5 MARKER

save ${path_data}/popgrowth.dta, replace

************************************
************************************ Solow fundamentals: human capital proxy --  

 use "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/controls/solow_fudamentals/BL2013_MF2599_v2.2.dta", clear
 
keep WBcode year yr_sch
reshape wide yr_sch, i(WBcode) j(year)

kountry WBcode, from(iso3c) m
drop if MARKER==0
drop MARKER WBcode

drop if NAMES_STD == "Romania"

foreach var of varlist yr_sch*{
	gen log`var' = log(`var')
}

save ${path_data}/yr_sch.dta, replace

************************************
************************************ merge all controls data

*** import countries data 
use ${path_data}/countries.dta, replace

*** merge with population.dta
merge 1:1 NAMES_STD using ${path_data}/population.dta, nogenerate

*** merge with total_gdp.dta
merge 1:1 NAMES_STD using ${path_data}/total_gdp.dta, nogenerate

*** merge with latitude.dta
merge 1:1 NAMES_STD using ${path_data}/latitude.dta, nogenerate

*** merge with temperature.dta
merge 1:1 NAMES_STD using ${path_data}/temperature.dta, nogenerate

*** merge with precipitation.dta
merge 1:1 NAMES_STD using ${path_data}/precipitation.dta, nogenerate

*** merge with population_density.dta
merge 1:1 NAMES_STD using ${path_data}/population_density.dta, nogenerate

*** merge with median_age.dta
merge 1:1 NAMES_STD using ${path_data}/median_age.dta, nogenerate

*** merge with diabetes.dta
merge 1:1 NAMES_STD using ${path_data}/diabetes.dta, nogenerate

*** merge with healthcare.dta
merge 1:1 NAMES_STD using ${path_data}/healthcare.dta, nogenerate


merge 1:1 NAMES_STD using ${path_data}/capital.dta, nogenerate
merge 1:1 NAMES_STD using ${path_data}/popgrowth.dta, nogenerate
merge 1:1 NAMES_STD using ${path_data}/yr_sch.dta, nogenerate

*** save data
save ${path_data}/controls.dta, replace
