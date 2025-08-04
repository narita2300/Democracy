************************************
************************************

clear all
macro drop _all
set more off 
pause on

************************************
************************************ set directory


**** CHANGE:
cd /Users/ayumis/Dropbox/Democracy/MainAnalysis
// cd /Users/ayumis/Desktop/replication_data

************************************
************************************ set folders for results and data

**** CHANGE:
*path for code
// global path_code /YOUR_FOLDER/replication_data/code
global path_code /Users/ayumis/Dropbox/Democracy/MainAnalysis/code

global path_analyze ${path_code}/2_analyze

global path_tables ${path_analyze}/tables

* path for input
global path_input /Users/ayumis/Dropbox/Democracy/MainAnalysis/input
// global path_input /Users/ayumis/Desktop/replication_data/input

* path for output data 
global path_data /Users/ayumis/Dropbox/Democracy/MainAnalysis/output/data

* path for presentation output
global path_presentation /Users/ayumis/Dropbox/Democracy/Presentation

* path for paper output
global path_output /Users/ayumis/Dropbox/Democracy/MainAnalysis/output/tables
// global path_output   /Users/ayumis/Desktop/replication_data/output

global path_dropbox /Users/ayumis/Dropbox/アプリ/Overleaf/Curse_of_Democracy/supporting_files

global path_appendix ${path_dropbox}/tables/appendix

global path_coefs ${path_dropbox}/coefs
************************************
************************************ useful definitions

**** DO NOT CHANGE
// global base_covariates2019 "abs_lat mean_temp_1991_2016 mean_precip_1991_2016"
// global base_covariates2000 "abs_lat mean_temp_1991_2000 mean_precip_1991_2000"
// global base_covariates2019 "abs_lat mean_temp_1991_2016 mean_precip_1991_2016 pop_density2019 median_age2020"
global base_covariates2019 "abs_lat mean_temp_1991_2016 mean_precip_1991_2016 pop_density2019 median_age2020 diabetes_prevalence2019"
global base_covariates2000 "abs_lat mean_temp_1991_2000 mean_precip_1991_2000 pop_density2000 median_age2000"

global lang_trade_iv "EngFrac EurFrac"
// global lang_trade_iv "EngFrac EurFrac logFrankRom"
// // global legor_iv "civil_law"
// global legor_iv "legor_uk legor_fr legor_ge legor_sc legor_so"
global legor_iv "legor_uk"
global crops_minerals_iv "bananas coffee copper maize millet rice rubber silver sugarcane wheat"

global iv1 "logem4"
global iv2 "lpd1500s"
global iv3 "legor_uk"
global iv4 "$lang_trade_iv"
global iv5 "$crops_minerals_iv"
global iv6 "logem lpd1500s $legor_iv $lang_trade_iv $crops_minerals_iv"

// global iv1 "logem4"
// global iv2 "$lang_trade_iv"
// global iv3 "$legor_iv"
// global iv4 "$crops_minerals_iv"
// global iv5 "lpd1500s"
// global iv6 "logem $lang_trade_iv $legor_iv $crops_minerals_iv lpd1500s"

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
************************************ generate main results

// do ${path_tables}/main/table2.do
// do ${path_tables}/main/table3.do

// ************************************
// ************************************ generate appendixresults

// do ${path_tables}/appendix/3_ols_control_gdp.do
// do ${path_tables}/appendix/4_first_stage.do
// do ${path_tables}/appendix/5_subtract_democracy_effect.do
// do ${path_tables}/appendix/6_2sls_control_gdp.do
// // do ${path_tables}/appendix/
// // do ${path_tables}/appendix/
// // do ${path_tables}/appendix/
// // do ${path_tables}/appendix/
// // do ${path_tables}/appendix/
// // do ${path_tables}/appendix/
// // do ${path_tables}/appendix/
// // do ${path_tables}/appendix/
// // do ${path_tables}/appendix/
// // do ${path_tables}/appendix/





