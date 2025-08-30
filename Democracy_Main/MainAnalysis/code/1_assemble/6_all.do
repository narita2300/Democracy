 
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
egen mean_growth_rate_2020_2022 = rowmean(gdp_growth2020-gdp_growth2022)
label variable mean_growth_rate_2020_2022 "Mean GDP Growth Rate in 2020-2022"

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
egen mean_gdppc_growth_2020_2022 = rowmean(gdppc_growth2020-gdppc_growth2022)
label variable mean_gdppc_growth_2020_2022 "Mean GDP Per Capita Growth Rate in 2020-2022"
// generate number of days between policy introduction and 10th confirmed case ***
gen days_betw_10th_case_and_policy = introduce_policy - cases_over10
drop introduce_policy cases_over10 


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

foreach var in investment loginvestment rtfpna logrtfpna trade logtrade tax logtax primary logprimary secondary logsecondary mortality logmortality{

	local varlist
	forval year = 2001(1)2019 {
		local varlist `varlist' `var'`year'
	}
	egen mean_`var'_2001_2019 = rowmean(`varlist')
}


// rename mean_labor_growth_2001_2019 mean_labor_2001_2019 
// rename labor2000 mean_labor_2000
// rename import_value2 mean_import_value2_2001_2019
// rename export_value2 mean_export_value2_2001_2019
//rename fdi_2001_2019 mean_fdi_2001_2019 


/////////////////////////////////////////////////////////  
//avg_seatw_illib_2001_2019 avg_votew_illib_2001_2019 avg_seatw_popul_2001_2019 avg_votew_popul_2001_2019

foreach var of varlist change_ftti_2001_2019 change_v2smpolhate_2001_2019 change_v2smpolsoc_2001_2019 mean_seatw_illib_2001_2019 change_seatw_illib_2001_2019 mean_seatw_popul_2001_2019 change_seatw_popul_2001_2019 {
	local lab: variable label `var'
	di "`lab'"
	egen `var'_sd = std(`var')
	drop `var'
	rename `var'_sd `var'
	label variable `var' "`lab'"
}

// avg_seatw_illib_2001_2019 avg_votew_illib_2001_2019 avg_seatw_popul_2001_2019 avg_votew_popul_2001_2019  avg_v2smpolhate_2001_2019 avg_v2smpolsoc_2001_2019 avg_ftti_2001_2019
// energy water co2_emissions pop_growth
rename change_v2smpolhate_2001_2019 new_v2smpolhate_2001_2019
rename change_v2smpolsoc_2001_2019 new_v2smpolsoc_2001_2019
rename change_seatw_illib_2001_2019 new_seatw_illib_2001_2019 
rename change_seatw_popul_2001_2019 new_seatw_popul_2001_2019
rename change_ftti_2001_2019 new_ftti_2001_2019
// rename avg_water_2001_2019 new_water_2001_2019 
// rename avg_energy_2001_2019 new_energy_2001_2019 
// rename avg_co2_emissions_2001_2019 new_co2_emissions_2001_2019 
rename avg_pop_growth_2001_2019 new_pop_growth_2001_2019 


///////////////////////////////////


// ren mean_china_import_2001_2019 mean_china_import
// ren mean_china_export_2001_2019 mean_china_export

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
//
// foreach var in china_import_gdp china_export_gdp {
// 	local varlist
// 	forval year = 2001(1)2019 {
// 		local varlist `varlist' `var'`year'
// 	}
// 	egen mean_`var' = rowmean(`varlist')
// }
//
//
// label variable mean_china_import_gdp "Mean Total Value of Imports from China in 2001-2019 (% of GDP)"
// label variable mean_china_export_gdp "Mean Total Value of Exports to China in 2001-2019 (% of GDP)"

forvalues year = 2001/2019{
	local last_year = `year' - 1
	// gen investment_change_`year' = (investment`year' - investment`last_year')/investment
	gen rtfpna_change_`year' = (rtfpna`year' - rtfpna`last_year')/rtfpna`last_year'
	gen log_rtfpna`year' = log(rtfpna`year')
}

local varlist
forval year = 2001(1)2019 {
    local varlist `varlist' log_rtfpna`year'
}
egen mean_logtfp_2001_2019 = rowmean(`varlist')

local varlist
forval year = 2001(1)2019 {
    local varlist `varlist' rtfpna_change_`year'
}
egen mean_tfpgrowth_2001_2019 = rowmean(`varlist')
replace mean_tfpgrowth_2001_2019 = mean_tfpgrowth_2001_2019*100
label variable mean_tfpgrowth_2001_2019 "Mean TFP Growth Rate in 2001-2019"

egen mean_conflict_2001_2019 = rowmean(conflict2001-conflict2019)
label variable mean_conflict_2001_2019 "Mean Conflict Index in 2001-2019"

// egen mean_rd_expenditure_2001_2019 = rowmean(rd_expenditure2001-rd_expenditure2019)
// label variable mean_rd_expenditure_2001_2019 "Mean R&D Expenditure in 2001-2019 (% of GDP)"

// egen mean_rd_researchers_2001_2019 = rowmean(rd_researchers2001-rd_researchers2019)
// label variable mean_rd_researchers_2001_2019 "Mean R&D Researchers per Million People in 2001-2019"

// egen mean_new_business_2001_2019 = rowmean(new_business2001-new_business2019)
// label variable mean_new_business_2001_2019 "Mean No. of New Business Registrations per 1000 People in 2001-2019"

forval year = 1992 (1)2013 {
		
	gen night_lightpc`year' = exp(night_light`year')/(population`year'*1000000)
}

*calculate growth rate of nightlightpc
forval year = 1993 (1)2013 {
	local prev = `year' - 1	
	gen g_night_lightpc`year' =(night_lightpc`year' - night_lightpc`prev')*100/night_lightpc`prev' 
	
}

foreach var in g_night_light g_night_lightpc night_light {
	local varlist
	forval year = 1993(1)2000 {
		local varlist `varlist' `var'`year'
	}
	egen mean_`var'_1993_2000 = rowmean(`varlist')
}

foreach var in g_night_light g_night_lightpc night_light dn13_growth {
	local varlist
	forval year = 2001(1)2013 {
		local varlist `varlist' `var'`year'
	}
	egen mean_`var'_2001_2013 = rowmean(`varlist')
}

************************************ 
************************************ drop observations to make sample consistent across regressions in main analysis

// drop if gdp_growth2020 ==. | mean_growth_rate_2001_2019 ==. | total_deaths_per_million==. | democracy_csp2000==. | total_gdp2000==.
 drop if mean_growth_rate_2020_2022 == . | mean_growth_rate_2001_2019 ==. | democracy_vdem2000==. | total_gdp2000==. | democracy_vdem2019==. | total_gdp2019==. | abs_lat==. | mean_temp_1991_2016 == . | mean_precip_1991_2016==. | pop_density2019==. | median_age2020 ==. | diabetes_prevalence2019 == . | mean_temp_1991_2000 == . | mean_precip_1991_2000==. | pop_density2000 ==. | median_age2000==.


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
	gen nonstd_`var' = `var'
	label variable `var' "Democracy Index (V-Dem, `year')"
	egen std`var' = std(`var')
	replace `var' = std`var'
	local year = `year' +1
}
drop std* 

// foreach var of varlist change_ftti_2001_2019 change_v2smpolhate_2001_2019 change_v2smpolsoc_2001_2019 mean_seatw_illib_2001_2019 mean_votew_illib_2001_2019 change_seatw_illib_2001_2019 change_votew_illib_2001_2019 mean_seatw_popul_2001_2019 mean_votew_popul_2001_2019 change_seatw_popul_2001_2019 change_votew_popul_2001_2019 {
// 	local lab: variable label `var'
// 	di "`lab'"
// 	egen `var'_sd = std(`var')
// 	drop `var'
// 	rename `var'_sd `var'
// 	label variable `var' "`lab'"
//  }

// democracy change
forval i = 1981/2020 {
	loc prev = `i'-1
	gen democracy_vdem_change`i' = nonstd_democracy_vdem`i'-nonstd_democracy_vdem`prev'
	gen std_vdem_change`i' = democracy_vdem`i'-democracy_vdem`prev'
	egen std_democracy_vdem_change`i' = std(democracy_vdem_change`i')
	label variable std_democracy_vdem_change`i' "Democracy Annual Change (V-Dem, `i')"
	label variable democracy_vdem_change`i' "Democracy Annual Change in `i'"
}

gen tot_dem_vdem_change_2000_2019 = nonstd_democracy_vdem2000-nonstd_democracy_vdem2019
label variable tot_dem_vdem_change_2000_2019 "Total Democracy Change in 2000-2019"

local varlist
forval year = 2000(1)2019 {
	local varlist `varlist' democracy_vdem_change`year'
}
egen mean_dem_vdem_change_2000_2019 = rowmean(`varlist')
label variable mean_dem_vdem_change_2000_2019 "Mean Democracy Annual Change in 2000-2019"

local varlist
forval year = 2001(1)2019 {
	local varlist `varlist' democracy_vdem_change`year'
}
egen mean_dem_vdem_change_2001_2019 = rowmean(`varlist')
egen std_mean_vdem_change_2001_2019 = std(mean_dem_vdem_change_2001_2019)
label variable std_mean_vdem_change_2001_2019 "Mean Democracy Annual Change in 2001-2019"
label variable mean_dem_vdem_change_2001_2019 "Mean Democracy Annual Change in 2001-2019"

local varlist
forval year = 2001(1)2019 {
	local varlist `varlist' std_vdem_change`year'
}
egen mean_std_vdem_change_2001_2019 = rowmean(`varlist')
label variable mean_std_vdem_change_2001_2019 "Mean Standardized Democracy Annual Change in 2001-2019"

local varlist
forval year = 1993(1)2000 {
	local varlist `varlist' democracy_vdem_change`year'
}
egen mean_dem_vdem_change_1993_2000 = rowmean(`varlist')
egen std_mean_vdem_change_1993_2000 = std(mean_dem_vdem_change_1993_2000)
label variable std_mean_vdem_change_1993_2000 "Mean Democracy Annual Change in 1993-2000"
label variable mean_dem_vdem_change_1993_2000 "Mean Democracy Annual Change in 1993-2000"

local varlist
forval year = 2001(1)2013 {
	local varlist `varlist' democracy_vdem_change`year'
}
egen mean_dem_vdem_change_2001_2013 = rowmean(`varlist')
label variable mean_dem_vdem_change_2001_2013 "Mean Democracy Annual Change in 2001-2013"
egen std_mean_vdem_change_2001_2013 = std(mean_dem_vdem_change_2001_2013)
label variable std_mean_vdem_change_2001_2013 "Mean Democracy Annual Change in 2001-2013"

local varlist
forval year = 2001(1)2013 {
	local varlist `varlist' std_vdem_change`year'
}
egen mean_std_vdem_change_2001_2013 = rowmean(`varlist')
label variable mean_std_vdem_change_2001_2013 "Mean Standardized Democracy Annual Change in 2001-2013"

local varlist
forval year = 1981(1)1990 {
	local varlist `varlist' democracy_vdem_change`year'
}
egen mean_dem_vdem_change_1981_1990 = rowmean(`varlist')
egen std_mean_vdem_change_1981_1990 = std(mean_dem_vdem_change_1981_1990)
label variable std_mean_vdem_change_1981_1990 "Mean Democracy Annual Change in 1981-1990"
label variable mean_dem_vdem_change_1981_1990 "Mean Democracy Annual Change in 1981-1990"

local varlist
forval year = 1991(1)2000 {
	local varlist `varlist' democracy_vdem_change`year'
}
egen mean_dem_vdem_change_1991_2000 = rowmean(`varlist')
egen std_mean_vdem_change_1991_2000 = std(mean_dem_vdem_change_1991_2000)
label variable std_mean_vdem_change_1991_2000 "Mean Democracy Annual Change in 1991-2000"
label variable mean_dem_vdem_change_1991_2000 "Mean Democracy Annual Change in 1991-2000"

local varlist
forval year = 2001(1)2010 {
	local varlist `varlist' democracy_vdem_change`year'
}
egen mean_dem_vdem_change_2001_2010 = rowmean(`varlist')
egen std_mean_vdem_change_2001_2010 = std(mean_dem_vdem_change_2001_2010)
label variable std_mean_vdem_change_2001_2010 "Mean Democracy Annual Change in 2001-2010"
label variable mean_dem_vdem_change_2001_2010 "Mean Democracy Annual Change in 2001-2010"

local varlist
forval year = 2011(1)2019 {
	local varlist `varlist' democracy_vdem_change`year'
}
egen mean_dem_vdem_change_2011_2019 = rowmean(`varlist')
egen std_mean_vdem_change_2011_2019 = std(mean_dem_vdem_change_2011_2019)
label variable std_mean_vdem_change_2011_2019 "Mean Democracy Annual Change in 2011-2019"
label variable mean_dem_vdem_change_2011_2019 "Mean Democracy Annual Change in 2011-2019"


/****************************************/
/*Label Variables*/
/****************************************/

label variable countries "Country Name"
label variable gdp_growth2020 "GDP Growth Rate in 2020"
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
label variable containmenthealth10 "Containment Health Index at 10th Confirmed Case"
label variable coverage10 "Coverage of Containment Measure at 10th Confirmed Case"
label variable days_betw_10th_case_and_policy "Days between 10th Confirmed Case and Any Containment Measure"
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

// label variable mean_growth_rate_2001_2019 "Mean GDP Growth Rate in 2001-2019"
// label variable mean_total_gdp "Mean Total GDP in 2001-2019"
// label variable mean_growth_rate_1981_1990 "Mean GDP Growth Rate in 1981-1990"
// label variable mean_growth_rate_1991_2000 "Mean GDP Growth Rate in 1991-2000"
// label variable mean_growth_rate_2001_2010 "Mean GDP Growth Rate in 2001-2010"
// label variable mean_growth_rate_2011_2020 "Mean GDP Growth Rate in 2011-2020"
// label variable mean_top10_inc_shr_2001_2019 "Mean Top 10% Income Share in 2001-2019"
// label variable mean_top1_inc_shr_2001_2019 "Mean Top 1% Income Share in 2001-2019"
// label variable mean_bot50_inc_shr_2001_2019 "Mean Bot 50% Income Share in 2001-2019"
// label variable mean_top10_inc_shr_1981_1990 "Mean Top 10% Income Share in 1981-1990"
// label variable mean_top1_inc_shr_1981_1990 "Mean Top 1% Income Share in 1981-1990"
// label variable mean_bot50_inc_shr_1981_1990 "Mean Bot 50% Income Share in 1981-1990"
// label variable mean_top10_inc_shr_1991_2000 "Mean Top 10% Income Share in 1991-2000"
// label variable mean_top1_inc_shr_1991_2000 "Mean Top 1% Income Share in 1991-2000"
// label variable mean_bot50_inc_shr_1991_2000 "Mean Bot 50% Income Share in 1991-2000"
// label variable mean_top10_inc_shr_2001_2010 "Mean Top 10% Income Share in 2001-2010"
// label variable mean_top1_inc_shr_2001_2010 "Mean Top 1% Income Share in 2001-2010"
// label variable mean_bot50_inc_shr_2001_2010 "Mean Bot 50% Income Share in 2001-2010"
// label variable mean_top10_inc_shr_2011_2020 "Mean Top 10% Income Share in 2011-2020"
// label variable mean_top1_inc_shr_2011_2020 "Mean Top 1% Income Share in 2011-2020"
// label variable mean_bot50_inc_shr_2011_2020 "Mean Bot 50% Income Share in 2011-2020"
// label variable mean_Positiveaffect_2010_2019 "Mean Positive Affect Rating in 2010-2019"
// label variable mean_LifeLadder_2010_2019 "Mean Life Ladder Rating in 2010-2019"
// label variable mean_financial_flows_2001_2019 "Mean Financial Flows in 2001-2019"
// label variable mean_financial_flows_1981_1990 "Mean Financial Flows in 1981-1990"
// label variable mean_financial_flows_1991_2000 "Mean Financial Flows in 1991-2000"
// label variable mean_financial_flows_2001_2010 "Mean Financial Flows in 2001-2010"
// label variable mean_financial_flows_2011_2020 "Mean Financial Flows in 2011-2020"
// label variable mean_night_light_1993_2000 "Mean Log Nighttime Light in 1993-2000"
// label variable mean_night_light_2001_2013 "Mean Log Nighttime Light in 2001-2013"
// label variable mean_g_night_light_1993_2000 "Mean Nighttime Light Intensity Growth Rate in 1993-2000"
// label variable mean_g_night_light_2001_2013 "Mean Nighttime Light Intensity Growth Rate in 2001-2013"
// label variable mean_g_night_lightpc_1993_2000 "Mean Nighttime Light Intensity per Capita Growth Rate in 1993-2000"
// label variable mean_g_night_lightpc_2001_2013 "Mean Nighttime Light Intensity per Capita Growth Rate in 2001-2013"
//
// label variable mean_med_income_1981_1990 "Mean Log Median Income in 1981-1990"
// label variable mean_med_income_1991_2000 "Mean Log Median Income in 1991-2000"
// label variable mean_med_income_2001_2010 "Mean Log Median Income in 2001-2010"
// label variable mean_med_income_2011_2020 "Mean Log Median Income in 2011-2020"
// label variable mean_med_income_2001_2019 "Mean Log Median Income in 2001-2019"
// label variable mean_g_med_income_1981_1990 "Mean Growth Rate Median Income in 1981-1990"
// label variable mean_g_med_income_1991_2000 "Mean Growth Rate Median Income in 1991-2000"
// label variable mean_g_med_income_2001_2010 "Mean Growth Rate Median Income in 2001-2010"
// label variable mean_g_med_income_2011_2020 "Mean Growth Rate Median Income in 2011-2020"

*** Save dataset ***
save ${path_data}/total.dta, replace
