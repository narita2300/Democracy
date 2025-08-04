
/****************************************/
/* Merge the tables */
/****************************************/

*** import countries data 
use ${path_data}/countries.dta, replace

*** merge with outcomes.dta
merge 1:1 NAMES_STD using ${path_data}/outcomes.dta, nogenerate

*** merge with democracy.dta
merge 1:1 NAMES_STD using ${path_data}/democracy.dta, nogenerate

*** merge with controls.dta
merge 1:1 NAMES_STD using ${path_data}/controls.dta, nogenerate

*** merge with IVs.dta
merge 1:1 NAMES_STD using ${path_data}/IVs.dta, nogenerate

*** merge with IVs.dta
merge 1:1 NAMES_STD using ${path_data}/channels.dta, nogenerate



/****************************************/
/*Generate Variables for Analysis*/
/****************************************/
egen mean_gdppc_growth_2001_2019 = rowmean(gdppc_growth2001-gdppc_growth2019)

// generate number of days between policy introduction and 10th confirmed case ***
gen days_betw_10th_case_and_policy = introduce_policy - cases_over10
drop introduce_policy cases_over10 

// generate excess deaths per million 
gen excess_deaths_per_million = excess_deaths2020/population2020
drop excess_deaths2020

// generate total cases per million
gen total_cases_per_million = total_cases/population2020
drop total_cases

// generate mean of mechanism variables in the periods of interest
local start_year = 1961
local end_year = 1970
forv num = 1/5{
	foreach var in rtfpna logrtfpna trade logtrade tax logtax primary logprimary secondary logsecondary mortality logmortality{
		egen mean_`var'_`start_year'_`end_year' = rowmean(`var'`start_year'-`var'`end_year')
	}
	local start_year = `start_year'+10
	local end_year = `end_year'+10
}

local start_year = 1981
local end_year = 1990
forv num = 1/3{
	foreach var in investment loginvestment{
		egen mean_`var'_`start_year'_`end_year' = rowmean(`var'`start_year'-`var'`end_year')
	}
	local start_year = `start_year'+10
	local end_year = `end_year'+10
}

foreach var in investment loginvestment rtfpna logrtfpna trade logtrade tax logtax primary logprimary secondary logsecondary mortality logmortality import_value logimport_value export_value logexport_value manu_va_growth logmanu_va_growth serv_va_growth logserv_va_growth import_gdp logimport_gdp logexport_gdp{
		egen mean_`var'_2011_2019 = rowmean(`var'2011-`var'2019)
		egen mean_`var'_2001_2019 = rowmean(`var'2001-`var'2019)
// 		gen mean_`var'_2001_2019_pc = 100*mean_`var'_2001_2019
}

egen mean_growth_rate_2001_2019 = rowmean(gdp_growth2001-gdp_growth2019)
egen mean_total_gdp_2001_2019 = rowmean(total_gdp2001-total_gdp2019)
egen mean_growth_rate_1981_1990 = rowmean(gdp_growth1981-gdp_growth1990)
egen mean_growth_rate_1991_2000 = rowmean(gdp_growth1991-gdp_growth2000)
egen mean_growth_rate_2001_2010 = rowmean(gdp_growth2001-gdp_growth2010)
egen mean_growth_rate_2011_2020 = rowmean(gdp_growth2011-gdp_growth2020)



forv year = 2001/2019{
	gen china_import_gdp`year' = china_import`year'/(total_gdp`year'*1000000000)
	gen china_export_gdp`year' = china_export`year'/(total_gdp`year'*1000000000)
}
egen mean_china_import = rowmean(china_import2001-china_import2019)
egen mean_china_export = rowmean(china_export2001-china_export2019)

egen mean_china_import_gdp = rowmean(china_import_gdp2001-china_import_gdp2019)
egen mean_china_export_gdp = rowmean(china_export_gdp2001-china_export_gdp2019)

************************************ 
************************************ drop observations to make sample consistent across regressions in main analysis

// drop if gdp_growth2020 ==. | mean_growth_rate_2001_2019 ==. | total_deaths_per_million==. | democracy_csp2000==. | total_gdp2000==.
 drop if gdp_growth2020 ==. | mean_growth_rate_2001_2019 ==. | total_deaths_per_million==. | democracy_vdem2000==. | total_gdp2000==. | democracy_vdem2019==. | total_gdp2019==. | abs_lat==. | mean_temp_1991_2016 == . | mean_precip_1991_2016==. | pop_density2019==. | median_age2020 ==. | diabetes_prevalence2019 == . | mean_temp_1991_2000 == . | mean_precip_1991_2000==. | pop_density2000 ==. | median_age2000==.


// *** make sample consistent with original paper
replace legor_uk = . if ex2col!=1
replace legor_fr = . if ex2col!=1
replace legor_ge = . if ex2col!=1
replace legor_sc = . if ex2col!=1

// replace legor_uk=. if legor_uk==0 & legor_fr == 0 & legor_so == 0 & legor_sc == 0

/****************************************/
/*Normalize the Democracy Indices*/
/****************************************/

// foreach var of varlist democracy_fh2006-democracy_fh2021{
// 	egen sd`var' = sd(`var')
// 	replace `var' = `var'/sd`var'
	
// 	egen mean`var' = mean(`var')
// 	replace `var' = `var' - mean`var'
// }
// drop sd* meandemocracy*

// // normalize the index in each year to have standard deviation one. 
// local year=2006
// foreach var of varlist democracy_eiu2006-democracy_eiu2020{
// 	egen sd`var' = sd(`var')
// 	replace `var' = `var'/sd`var'
// 	label variable `var' "Democracy Index (Economist Intelligence Unit, `year')"
	
// 	egen mean`var' = mean(`var')
// 	replace `var' = `var' - mean`var'
// 	local year = `year' + 1
// }
// drop sd* meandemocracy*

// foreach var of varlist democracy_csp2000-democracy_csp2018{
// 	local year = substr("`var'", 14, .)
// 	egen sd`var' = sd(`var')
// 	replace `var' = `var'/sd`var'
// 	label variable `var' "Democracy Index (Polity, `year')"
	
// 	egen mean`var' = mean(`var')
// 	replace `var' = `var' - mean`var'
// }

// drop sd* meandemocracy*

// local year = 1980
// foreach var of varlist democracy_vdem1980-democracy_vdem2020{
// 	label variable `var' "Democracy Index (V-Dem, `year')"
// 	egen sd`var' = sd(`var')
// 	replace `var' = `var'/sd`var'
	
// 	egen mean`var' = mean(`var')
// 	replace `var' = `var' - mean`var'
	
// 	local year = `year' +1
// }

// drop sd* meandemocracy*


foreach var of varlist democracy_fh2003-democracy_fh2021{
	egen std`var' = std(`var')
	replace `var' = std`var'
}
drop std*

// normalize the index in each year to have standard deviation one. 
local year=2006
foreach var of varlist democracy_eiu2006-democracy_eiu2020{
	egen std`var' = std(`var')
	label variable `var' "Democracy Index (Economist Intelligence Unit, `year')"
	replace `var' = std`var'
	local year = `year' + 1
}
drop std*

foreach var of varlist democracy_csp2000-democracy_csp2018{
	local year = substr("`var'", 14, .)
	egen std`var' = std(`var')
	replace `var' = std`var'
	label variable `var' "Democracy Index (Polity, `year')"
}
drop std*

local year = 1980
foreach var of varlist democracy_vdem1980-democracy_vdem2020{
	label variable `var' "Democracy Index (V-Dem, `year')"
	egen std`var' = std(`var')
	replace `var' = std`var'
	local year = `year' +1
}
drop std* 

/****************************************/
/*Label Variables*/
/****************************************/

label variable countries "Country Name"
label variable gdp_growth2020 "GDP Growth Rate in 2020"
label variable total_deaths_per_million "Covid-19-related Deaths Per Million in 2020"
label variable gdppc_growth2020 "GDP Per Capita Growth Rate in 2020"
label variable mean_gdppc_growth_2001_2019 "Mean GDP Per Capita Growth Rate in 2001-2019"
label variable abs_lat "Absolute Latitude"
label variable logem "Log European Settler Mortality"
label variable EngFrac "Fraction Speaking English"
label variable EurFrac "Fraction Speaking European"
label variable logFrankRom "Log Frankel-Romer Trade Share"
// label variable uk_mom "British Legal Origin"
// label variable frsp_mom "French Legal Origin"
// label variable ger_mom "German Legal Origin"
// label variable scan_mom "Scandinavian Legal Origin"
// label variable civil_law "Civil Law Legal Origin"
label variable bananas "Bananas"
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
label variable excess_deaths_per_million "Excess Deaths Per Million in 2020"
label variable total_cases_per_million "Total Covid-19 Cases Per Million in 2020"

foreach var of varlist democracy_fh2003-democracy_fh2021 {
	local year = substr("`var'", 13, .)
	label variable `var' "Democracy Index (Freedom House, `year')"
}

foreach var of varlist gdp_growth* {
	local year = substr("`var'", 11, .)
	label variable `var' "GDP Growth Rate in `year'"
}

label variable mean_growth_rate_2001_2019 "Mean GDP Growth Rate in 2001-2019"
label variable mean_total_gdp "Mean Total GDP in 2001-2019"
label variable mean_growth_rate_1981_1990 "Mean GDP Growth Rate in 1981-1990"
label variable mean_growth_rate_1991_2000 "Mean GDP Growth Rate in 1991-2000"
label variable mean_growth_rate_2001_2010 "Mean GDP Growth Rate in 2001-2010"
label variable mean_growth_rate_2011_2020 "Mean GDP Growth Rate in 2011-2020"

*** Save dataset ***
save ${path_data}/total.dta, replace
