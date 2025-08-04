************************************
************************************

clear all
macro drop _all
set more off 
pause on

************************************
************************************ set directory


**** CHANGE:
cd /YOUR_FOLDER/replication_data
// cd /Users/ayumis/Desktop/replication_data

************************************
************************************ set folders for results and data

**** CHANGE:
*path for code
global path_code /YOUR_FOLDER/replication_data/code
//global path_code /Users/ayumis/Desktop/replication_data/code

* path for input
global path_input /YOUR_FOLDER/replication_data/input
// global path_input /Users/ayumis/Desktop/replication_data/input

* path for ouput
global path_output /YOUR_FOLDER/replication_data/output
// global path_output   /Users/ayumis/Desktop/replication_data/output

************************************
************************************ useful definitions

**** DO NOT CHANGE
global base_covariates "abs_lat mean_temp mean_precip pop_density median_age diabetes_prevalence"
global lang_trade_iv "EngFrac EurFrac logFrankRom"
global legor_iv "legor_uk legor_fr legor_ge"
global crops_minerals_iv "bananas coffee copper maize millet rice silver sugarcane rubber wheat"

global iv1 "logem"
global iv2 "$lang_trade_iv"
global iv3 "$legor_iv"
global iv4 "$crops_minerals_iv"
global iv5 "lpd1500s"

************************************
************************************ generate results

do ${path_code}/2_analyze/regressions/table2.do
do ${path_code}/2_analyze/regressions/table3.do
do ${path_code}/2_analyze/regressions/tableA2.do
do ${path_code}/2_analyze/regressions/tableA3.do
do ${path_code}/2_analyze/regressions/tableA4.do
do ${path_code}/2_analyze/regressions/tableA5.do





