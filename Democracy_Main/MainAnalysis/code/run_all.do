************************************
************************************
// ssc install kountry, replace
// ssc inst _gwtmean, replace

clear all
macro drop _all
set more off 
pause on

set maxvar 10000

// ssc install kountry, replace
// ssc inst _gwtmean, replace
// ssc install ivreg2, replace
// ssc install ranktest, replace
// ssc install labutil, replace
ssc install estout, replace

************************************
************************************ set main path

**** CHANGE THIS PATH FOR YOUR SYSTEM:
global main_path "/Users/masaoishihara"

************************************
************************************ set directory

cd ${main_path}/Democracy/Democracy_Main/MainAnalysis

************************************
************************************ set folders for results and data

global path_code ${main_path}/Democracy/Democracy_Main/MainAnalysis/code

global path_analyze ${path_code}/2_analyze

global path_tables ${path_analyze}/tables

global path_input ${main_path}/Democracy/Democracy_Main/MainAnalysis/input

global path_data ${main_path}/Democracy/Democracy_Main/MainAnalysis/output/data

global path_output ${main_path}/Democracy/Democracy_Main/MainAnalysis/output/tables

global path_coefs ${path_output}/coefs

************************************
************************************ useful definitions

**** DO NOT CHANGE
global base_covariates2019 "abs_lat mean_temp_1991_2016 mean_precip_1991_2016 pop_density2019 median_age2020 diabetes_prevalence2019"
global base_covariates2000 "abs_lat mean_temp_1991_2000 mean_precip_1991_2000 pop_density2000 median_age2000"
// global base_covariates2018 "abs_lat mean_temp_1991_2016 mean_precip_1991_2016 pop_density2018 median_age2015 diabetes_prevalence2019"

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
	// global dem2018 "democracy_vdem2018"
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
	// global weight2018 "[w=total_gdp2018]"
}

if "`main_weight'" == "population" {
	global weight2019 "[w=population2019]"
	global weight2000 "[w=population2000]"
	// global weight2018 "[w=population2018]"
}

if "`main_weight'"== "none"{
	global weight2019 " "
	global weight2000 " "
	// global weight2018 " "
}

************************************
************************************ set the main outcome 
local main_outcome "total"

if "`main_outcome'" == "total"{
	global outcome1 "mean_growth_rate_2001_2019"
	global outcome2 "mean_growth_rate_2020_2022"
	global outcome3 "mean_g_night_light_2001_2013"
	// global outcome4 "excess_mortality_rate_100k"
	
	
}

if "`main_outcome'" == "capita"{
	global outcome1 "mean_gdppc_growth_2001_2019"
	global outcome2 "mean_gdppc_growth_2020_2022"
	global outcome3 "mean_g_night_light_2001_2013"
	// global outcome4 "excess_mortality_rate_100k"
	
}

************************************
************************************ Assemble data

do ${path_code}/1_assemble/0_prelim.do
do ${path_code}/1_assemble/1_outcomes.do
do ${path_code}/1_assemble/2_democracy.do
do ${path_code}/1_assemble/3_controls.do
do ${path_code}/1_assemble/4_IVs.do
do ${path_code}/1_assemble/5_channels.do
do ${path_code}/1_assemble/6_all.do

**
************************************
************************************ Generate main tables

cd ${path_output}

do ${path_tables}/main/table2.do
do ${path_tables}/main/final_table_mech.do

// in R run ${path_analyze}/figures/main/figure1.R
// in R run ${path_analyze}/figures/main/figure2.R

************************************
************************************ Generate appendix tables

cd ${path_output}/appendix

// in R run ${path_tables}/appendix/table1.R
// in R run ${path_tables}/appendix/02_descriptive_stats.R
do ${path_tables}/appendix/03_dem_ranking.do
do ${path_tables}/appendix/05_corr_dem_indices.do
do ${path_tables}/appendix/06_ols_control_gdp.do
do ${path_tables}/appendix/15_first_stage.do
do ${path_tables}/appendix/08_monotonicity_check.do
do ${path_tables}/appendix/09_ivs_corr.do
do ${path_tables}/appendix/mechanism_appendix.do
// do ${path_tables}/appendix/additional_outcomes.do // run separately 
do ${path_tables}/appendix/19_table2_pc.do
do ${path_tables}/appendix/24_2sls_indices.do
do ${path_tables}/appendix/20_2sls_recession.do
do ${path_tables}/appendix/27_2sls_exclude_US_China.do
do ${path_tables}/appendix/28_2sls_outliers.do
do ${path_tables}/appendix/29_2sls_remove_g7.do
do ${path_tables}/appendix/25_2sls_weighting.do
do ${path_tables}/appendix/21_2sls_control_gdp.do
do ${path_tables}/appendix/23_2sls_control_continent.do
do ${path_tables}/appendix/30_2sls_by_decade.do
do ${path_tables}/appendix/table2_change.do
// do ${path_tables}/appendix/26_dem_effect_nonlinear.do


do ${path_tables}/appendix/32_2sls_policy_mechanisms.do


// in R run ${path_analyze}/figures/appendix/rf_figure.R
// in R run ${path_analyze}/figures/appendix/figure_co2_emissions.R
// in R run ${path_analyze}/figures/appendix/figure_deaths.R
// in R run ${path_analyze}/figures/appendix/figure_energy.R
// in R run ${path_analyze}/figures/appendix/figure_happiness.R
// in R run ${path_analyze}/figures/appendix/figure_top_income.R

// in R run ${path_analyze}/figures/appendix/figure1_change.R
// in R run ${path_analyze}/figures/appendix/01_corr_auto_notitle.R
// in R run ${path_analyze}/figures/appendix/01_corr_auto_notitle_quad.R


