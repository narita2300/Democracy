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
cd /Users/richardgong/Dropbox/Democracy/MainAnalysis

************************************
************************************ set folders for results and data

**** CHANGE:

global path_code /Users/richardgong/Dropbox/Democracy/MainAnalysis/code

global path_analyze ${path_code}/2_analyze

global path_tables ${path_analyze}/tables

global path_input /Users/richardgong/Dropbox/Democracy/MainAnalysis/input

global path_data /Users/richardgong/Dropbox/Democracy/MainAnalysis/output/data

global path_output /Users/richardgong/Dropbox/Democracy/MainAnalysis/output/tables

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
local main_index "vdem"

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
	global outcome2 "gdp_growth2020"
	global outcome3 "total_deaths_per_million"
}

if "`main_outcome'" == "capita"{
	global outcome1 "mean_gdppc_growth_2001_2019"
	global outcome2 "gdppc_growth2020"
	global outcome3 "total_deaths_per_million"
}

************************************
************************************ Assemble data

do ${path_code}/1_assemble/0_prelim.do
do ${path_code}/1_assemble/1_outcomes.do
do ${path_code}/1_assemble/3_controls.do
do ${path_code}/1_assemble/4_IVs.do
do ${path_code}/1_assemble/5_channels.do
do ${path_code}/1_assemble/6_all.do

**
************************************
************************************ Generate main results

do ${path_tables}/main/table2.do
do ${path_tables}/main/table3.do

************************************
************************************ Generate appendix results



