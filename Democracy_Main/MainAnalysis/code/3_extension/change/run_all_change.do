************************************
************************************
// ssc install kountry, replace
// ssc inst _gwtmean, replace

clear all
macro drop _all
set more off 
pause on

set maxvar 10000

************************************
************************************ set directory

**** CHANGE:
cd /Users/richardgong/Downloads/MainAnalysis

************************************
************************************ set folders for results and data

**** CHANGE:

global path_code /Users/richardgong/Downloads/MainAnalysis/code

global path_analyze ${path_code}/2_analyze

global path_tables ${path_analyze}/tables

global path_input /Users/richardgong/Downloads/MainAnalysis/input

global path_data /Users/richardgong/Downloads/MainAnalysis/output/data

global path_output /Users/richardgong/Downloads/MainAnalysis/output/tables

global path_coefs ${path_output}/coefs

************************************
************************************ useful definitions

**** DO NOT CHANGE
global base_covariates2019 "abs_lat mean_temp_1991_2016 mean_precip_1991_2016 pop_density2019 median_age2020 diabetes_prevalence2019"
global base_covariates2000 "abs_lat mean_temp_1991_2000 mean_precip_1991_2000 pop_density2000 median_age2000"

global lang_trade_iv "EngFrac EurFrac"
global legor_iv "legor_uk"
global crops_minerals_iv "bananas coffee copper maize millet rice rubber silver sugarcane wheat"

global iv1 "logem"
global iv2 "lpd1500s"
global iv3 "legor_uk"
global iv4 "$lang_trade_iv"
global iv5 "$crops_minerals_iv"
global iv6 "logem lpd1500s $legor_iv $lang_trade_iv $crops_minerals_iv"

************************************
************************************ set the index that we want to use
local main_index "vdem_change"

if "`main_index'" == "csp" {
	global dem2019 "democracy_csp2018"
	global dem2000 "democracy_csp2000"
}

if "`main_index'" == "fh" {
	global dem2019 "democracy_fh2019"
	global dem2000 "democracy_fh2003"
}

if "`main_index'"== "vdem"{
	global dem2019 "democracy_vdem2019"
	global dem2000 "democracy_vdem2000"
}

if "`main_index'" == "eiu"{
	global dem2019 "democracy_eiu2019"
	global dem2000 "democracy_eiu2006"
}

if "`main_index'"== "vdem_change"{
	global dem2019 "democracy_vdem2019_change"
	global dem2000 "democracy_vdem2000_change"
}


************************************
************************************ set the weight that we want to use
local main_weight "gdp"

if "`main_weight'" == "gdp" {
	global weight2019 "[w=total_gdp2019]"
	global weight2000 "[w=total_gdp2000]"
}

if "`main_weight'" == "population" {
	global weight2019 "[w=population2019]"
	global weight2000 "[w=population2000]"
}

if "`main_weight'"== "none"{
	global weight2019 " "
	global weight2000 " "
}

************************************
************************************ set the main outcome 
local main_outcome "total"

if "`main_outcome'" == "total"{
	global outcome1 "mean_growth_rate_2001_2019"
	global outcome2 "mean_growth_rate_2020_2022"
	global outcome3 "mean_g_night_light_2001_2013"
	global outcome4 "mean_death_per_million_20_22"
	
	
}

if "`main_outcome'" == "capita"{
	global outcome1 "mean_gdppc_growth_2001_2019"
	global outcome2 "mean_gdppc_growth_2020_2022"
	global outcome3 "mean_g_night_light_2001_2013"
	global outcome4 "mean_death_per_million_20_22"
	
}

**
************************************
************************************ Generate tables


global path_output ${path_output}/extensions
global path_coefs ${path_output}/coefs

cd ${path_output}

do ${path_code}/3_extension/change/03_dem_ranking_change.do
// in R run figure1_change.R
// in R run figure2_change.R
do ${path_code}/3_extension/change/table2_change.do
// in R run 01_corr_auto_notitle_change.R
do ${path_code}/3_extension/change/30_2sls_by_decade_change.do


