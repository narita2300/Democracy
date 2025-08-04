 
/****************************************/
/* Merge the tables */
/****************************************/
clear all
set maxvar 10000

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

egen mean_growth_rate_1961_1970 = rowmean(gdp_growth1961-gdp_growth1970)
label variable mean_growth_rate_1961_1970 "Mean GDP Growth Rate in 1961-1970"
egen mean_growth_rate_1971_1980 = rowmean(gdp_growth1971-gdp_growth1980)
label variable mean_growth_rate_1971_1980 "Mean GDP Growth Rate in 1971-1980"
// egen mean_growth_rate_1981_1990 = rowmean(gdp_growth1981-gdp_growth1990)
// label variable mean_growth_rate_1971_1980 "Mean GDP Growth Rate in 1981-1990"
egen mean_growth_rate_1981_2000 = rowmean(gdp_growth1981-gdp_growth2000)
label variable mean_growth_rate_1971_1980 "Mean GDP Growth Rate in 1981-2000"

egen mean_gdppc_growth_1961_1970 = rowmean(gdppc_growth1961-gdppc_growth1970)
label variable mean_gdppc_growth_1961_1970 "Mean GDP Per Capita Growth Rate in 1961-1970"
egen mean_gdppc_growth_1971_1980 = rowmean(gdppc_growth1971-gdppc_growth1980)
label variable mean_gdppc_growth_1971_1980 "Mean GDP Per Capita Growth Rate in 1971-1980"
egen mean_gdppc_growth_1981_1990 = rowmean(gdppc_growth1981-gdppc_growth1990)
label variable mean_gdppc_growth_1981_1990 "Mean GDP Per Capita Growth Rate in 1981-1990"
egen mean_gdppc_growth_1991_2000 = rowmean(gdppc_growth1991-gdppc_growth2000)
label variable mean_gdppc_growth_1991_2000 "Mean GDP Per Capita Growth Rate in 1991-2000"
egen mean_gdppc_growth_1981_2000 = rowmean(gdppc_growth1981-gdppc_growth2000)
label variable mean_gdppc_growth_1981_2000 "Mean GDP Per Capita Growth Rate in 1981-2000"

egen mean_gdppc_growth_2001_2010 = rowmean(gdppc_growth2001-gdppc_growth2010)
label variable mean_gdppc_growth_2001_2010 "Mean GDP Per Capita Growth Rate in 2001-2010"
egen mean_gdppc_growth_2011_2019 = rowmean(gdppc_growth2011-gdppc_growth2019)
label variable mean_gdppc_growth_2011_2019 "Mean GDP Per Capita Growth Rate in 2011-2019"
egen mean_gdppc_growth_2001_2019 = rowmean(gdppc_growth2001-gdppc_growth2019)
label variable mean_gdppc_growth_2001_2019 "Mean GDP Per Capita Growth Rate in 2001-2019"

// generate number of days between policy introduction and 10th confirmed case ***
// gen days_betw_10th_case_and_policy = introduce_policy - cases_over10
// drop introduce_policy cases_over10 

// generate excess deaths per million 
gen excess_deaths_per_million = excess_deaths2020/population2020
drop excess_deaths2020

gen excess_deaths_million_who2020 = excess_deaths_who2020/population2020
drop excess_deaths_who2020
gen excess_deaths_million_who2021 = excess_deaths_who2021/population2020 // update population
drop excess_deaths_who2021

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

// foreach var in investment loginvestment rtfpna logrtfpna trade logtrade tax logtax primary logprimary secondary logsecondary mortality logmortality import_value logimport_value export_value logexport_value manu_va_growth logmanu_va_growth serv_va_growth logserv_va_growth import_gdp logimport_gdp logexport_gdp agr_va_growth logagr_va_growth capital_growth logcapital_growth labor_growth loglabor_growth import_growth export_growth{
// 		egen mean_`var'_2011_2019 = rowmean(`var'2011-`var'2019)
// 		egen mean_`var'_2001_2019 = rowmean(`var'2001-`var'2019)
// // 		gen mean_`var'_2001_2019_pc = 100*mean_`var'_2001_2019
// }

foreach var in investment loginvestment rtfpna logrtfpna trade logtrade tax logtax primary logprimary secondary logsecondary mortality logmortality import_value logimport_value export_value logexport_value manu_va_growth logmanu_va_growth serv_va_growth logserv_va_growth import_gdp export_gdp agr_va_growth logagr_va_growth capital_growth logcapital_growth labor_growth loglabor_growth import_growth export_growth{
		egen mean_`var'_2001_2019 = rowmean(`var'2001-`var'2019)
}

egen mean_growth_rate_2001_2019 = rowmean(gdp_growth2001-gdp_growth2019)
egen mean_total_gdp_2001_2019 = rowmean(total_gdp2001-total_gdp2019)
egen mean_growth_rate_1981_1990 = rowmean(gdp_growth1981-gdp_growth1990)
egen mean_growth_rate_1991_2000 = rowmean(gdp_growth1991-gdp_growth2000)
egen mean_growth_rate_2001_2010 = rowmean(gdp_growth2001-gdp_growth2010)
egen mean_growth_rate_2011_2020 = rowmean(gdp_growth2011-gdp_growth2020)
egen mean_growth_rate_2011_2019 = rowmean(gdp_growth2011-gdp_growth2019)

gen mean_growth_rate_1961_2000 = (mean_growth_rate_1961_1970 + mean_growth_rate_1971_1980 + mean_growth_rate_1981_1990 + mean_growth_rate_1991_2000)/4


// forv year = 2001/2019{
// 	gen china_import_gdp`year' = china_import`year'/(total_gdp`year'*1000000000)
// 	gen china_export_gdp`year' = china_export`year'/(total_gdp`year'*1000000000)
// }
// egen mean_china_import = rowmean(china_import2001-china_import2019)
// egen mean_china_export = rowmean(china_export2001-china_export2019)

// egen mean_china_import_gdp = rowmean(china_import_gdp2001-china_import_gdp2019)
// egen mean_china_export_gdp = rowmean(china_export_gdp2001-china_export_gdp2019)

forvalues year = 2001/2019{
	local last_year = `year' - 1
	// gen investment_change_`year' = (investment`year' - investment`last_year')/investment
	gen rtfpna_change_`year' = (rtfpna`year' - rtfpna`last_year')/rtfpna`last_year'
	gen log_rtfpna`year' = log(rtfpna`year')
}

egen mean_logtfp_2001_2019 = rowmean(log_rtfpna2001-log_rtfpna2019)
egen mean_tfpgrowth_2001_2019 = rowmean(rtfpna_change_2001-rtfpna_change_2019)
replace mean_tfpgrowth_2001_2019 = mean_tfpgrowth_2001_2019*100
label variable mean_tfpgrowth_2001_2019 "Mean TFP Growth Rate in 2001-2019"


// egen mean_conflict_2001_2019 = rowmean(conflict2001-conflict2019)
// label variable mean_conflict_2001_2019 "Mean Conflict Index in 2001-2019"
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

foreach var of varlist v2xdl_delib1980-v2xdl_delib2020{
	egen std`var' = std(`var')
	gen `var'_nostd = `var'
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

foreach var of varlist change_ftti_2001_2019 change_v2smpolhate_2001_2019 change_v2smpolsoc_2001_2019 mean_seatw_illib_2001_2019 mean_votew_illib_2001_2019 change_seatw_illib_2001_2019 change_votew_illib_2001_2019 mean_seatw_popul_2001_2019 mean_votew_popul_2001_2019 change_seatw_popul_2001_2019 change_votew_popul_2001_2019 {
	local lab: variable label `var'
	di "`lab'"
	egen `var'_sd = std(`var')
	drop `var'
	rename `var'_sd `var'
	label variable `var' "`lab'"
}


/****************************************/
/*Label Variables*/
/****************************************/

label variable countries "Country Name"
label variable gdp_growth2020 "GDP Growth Rate in 2020"
label variable total_deaths_per_million "Covid-19-related Deaths Per Million in 2020"
label variable gdppc_growth2020 "GDP Per Capita Growth Rate in 2020"
label variable mean_gdppc_growth_2001_2019 "Mean GDP Per Capita Growth Rate in 2001-2019"
label variable abs_lat "Absolute Latitude"
label variable longitude "Longitude"
label variable logem "Log European Settler Mortality"
label variable EngFrac "Fraction Speaking English"
label variable EurFrac "Fraction Speaking European"
label variable logFrankRom "Log Frankel-Romer Trade Share"
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
// label variable containmenthealth10 "Containment Health Index at 10th Confirmed Case"
// label variable coverage10 "Coverage of Containment Measure at 10th Confirmed Case"
// label variable days_betw_10th_case_and_policy "Days between 10th Confirmed Case and Any Containment Measure"
label variable excess_deaths_per_million "Excess Deaths Per Million in 2020"
label variable excess_deaths_million_who2020 "Excess Deaths Per Million in 2020"
label variable excess_deaths_million_who2021 "Excess Deaths Per Million in 2021"
label variable total_cases_per_million "Total Covid-19 Cases Per Million in 2020"
label variable total_deaths_per_million21 "Covid-19-related Deaths Per Million in 2021"
label variable total_deaths_per_million22 "Covid-19-related Deaths Per Million in 2022"
label variable financial_flows2020 "Financial Flows in 2020"
label variable financial_flows2021 "Financial Flows in 2021"
label variable LifeLadder2020 "Life Ladder Rating 2020"
label variable LifeLadder2021 "Life Ladder Rating 2021"
label variable LifeLadder2022 "Life Ladder Rating 2022"
label variable Positiveaffect2020 "Positive Affect Rating 2020"
label variable Positiveaffect2021 "Positive Affect Rating 2021"
label variable Positiveaffect2022 "Positive Affect Rating 2022"
label variable top1_income_share2020 "Top 1% Income Share in 2020"
label variable top1_income_share2021 "Top 1% Income Share in 2021"
label variable top10_income_share2020 "Top 10% Income Share in 2020"
label variable top10_income_share2021 "Top 10% Income Share in 2021"
label variable bot50_income_share2020 "Bot 50% Income Share in 2020"
label variable med_income_2020 "Log Median Income in 2020"
label variable med_income_2021 "Log Median Income in 2021"
label variable hours_worked_core "Weekly Hours Worked per Employed"
label variable effective_ret_age_men_1970 "Effective Retirement Age Men in 1970"
label variable effective_ret_age_women_1970 "Effective Retirement Age Women in 1970"
label variable effective_ret_age_men_1980 "Effective Retirement Age Men in 1980"
label variable effective_ret_age_women_1980 "Effective Retirement Age Women in 1980"
label variable effective_ret_age_men_1990 "Effective Retirement Age Men in 1990"
label variable effective_ret_age_women_1990 "Effective Retirement Age Women in 1990"
label variable effective_ret_age_men_2000 "Effective Retirement Age Men in 2000"
label variable effective_ret_age_women_2000 "Effective Retirement Age Women in 2000"
label variable effective_ret_age_men_2010 "Effective Retirement Age Men in 2010"
label variable effective_ret_age_women_2010 "Effective Retirement Age Women in 2010"
label variable effective_ret_age_men_2020 "Effective Retirement Age Men in 2020"
label variable effective_ret_age_women_2020 "Effective Retirement Age Women in 2020"
label variable affect_polarization_near_1996 "Affective Polarization near 1996"
label variable affect_polarization_near_2012 "Affective Polarization near 2012"

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
label variable mean_top10_inc_shr_2001_2019 "Mean Top 10% Income Share in 2001-2019"
label variable mean_top1_inc_shr_2001_2019 "Mean Top 1% Income Share in 2001-2019"
label variable mean_bot50_inc_shr_2001_2019 "Mean Bot 50% Income Share in 2001-2019"
label variable mean_top10_inc_shr_1981_1990 "Mean Top 10% Income Share in 1981-1990"
label variable mean_top1_inc_shr_1981_1990 "Mean Top 1% Income Share in 1981-1990"
label variable mean_bot50_inc_shr_1981_1990 "Mean Bot 50% Income Share in 1981-1990"
label variable mean_top10_inc_shr_1991_2000 "Mean Top 10% Income Share in 1991-2000"
label variable mean_top1_inc_shr_1991_2000 "Mean Top 1% Income Share in 1991-2000"
label variable mean_bot50_inc_shr_1991_2000 "Mean Bot 50% Income Share in 1991-2000"
label variable mean_top10_inc_shr_2001_2010 "Mean Top 10% Income Share in 2001-2010"
label variable mean_top1_inc_shr_2001_2010 "Mean Top 1% Income Share in 2001-2010"
label variable mean_bot50_inc_shr_2001_2010 "Mean Bot 50% Income Share in 2001-2010"
label variable mean_top10_inc_shr_2011_2020 "Mean Top 10% Income Share in 2011-2020"
label variable mean_top1_inc_shr_2011_2020 "Mean Top 1% Income Share in 2011-2020"
label variable mean_bot50_inc_shr_2011_2020 "Mean Bot 50% Income Share in 2011-2020"
label variable mean_Positiveaffect_2010_2019 "Mean Positive Affect Rating in 2010-2019"
label variable mean_LifeLadder_2010_2019 "Mean Life Ladder Rating in 2010-2019"
label variable mean_financial_flows_2001_2019 "Mean Financial Flows in 2001-2019"
label variable mean_financial_flows_1981_1990 "Mean Financial Flows in 1981-1990"
label variable mean_financial_flows_1991_2000 "Mean Financial Flows in 1991-2000"
label variable mean_financial_flows_2001_2010 "Mean Financial Flows in 2001-2010"
label variable mean_financial_flows_2011_2020 "Mean Financial Flows in 2011-2020"
label variable mean_night_light_1992_2000 "Mean Log Nighttime Light in 1992-2000"
label variable mean_night_light_2001_2013 "Mean Log Nighttime Light in 2001-2013"
label variable mean_g_night_light_1992_2000 "Mean Growth Rate Nighttime Light in 1992-2000"
label variable mean_g_night_light_2001_2013 "Mean Growth Rate Nighttime Light in 2001-2013"
label variable mean_med_income_1981_1990 "Mean Log Median Income in 1981-1990"
label variable mean_med_income_1991_2000 "Mean Log Median Income in 1991-2000"
label variable mean_med_income_2001_2010 "Mean Log Median Income in 2001-2010"
label variable mean_med_income_2011_2020 "Mean Log Median Income in 2011-2020"
label variable mean_med_income_2001_2019 "Mean Log Median Income in 2001-2019"
label variable mean_g_med_income_1981_1990 "Mean Growth Rate Median Income in 1981-1990"
label variable mean_g_med_income_1991_2000 "Mean Growth Rate Median Income in 1991-2000"
label variable mean_g_med_income_2001_2010 "Mean Growth Rate Median Income in 2001-2010"
label variable mean_g_med_income_2011_2020 "Mean Growth Rate Median Income in 2011-2020"

*** Save dataset ***
save ${path_data}/total.dta, replace
