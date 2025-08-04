 
// Make a do-file that generates Table A8 using V-Dem 
 
// Make a do-file that outputs all the results using V-Dem into one csv format:

// Y (3): GDP growth rates in 2020, mean GDP growth rates in 2001-2019, Covid-19 deaths per million in 2020
// X (4): Center for Systemic Peace or V-Dem
// C (2): none or {absolute latitude, mean temperature, mean precipitation, population density, median age, diabetes prevalence}
// Z (5): the five IVs
// W (3): GDP, population, none
// Sample: include US & China, exclude US & China

************************************
************************************ set folders for results and data

**** CHANGE:
*path for code
// global path_code /YOUR_FOLDER/replication_data/code
global path_code /Users/ayumis/Dropbox/Democracy/MainAnalysis/code

* path for input
global path_input /Users/ayumis/Dropbox/Democracy/MainAnalysis/input
// global path_input /Users/ayumis/Desktop/replication_data/input

* path for ouput
global path_output /Users/ayumis/Dropbox/Democracy/MainAnalysis/output
// global path_output   /Users/ayumis/Desktop/replication_data/output

************************************
************************************ useful definitions

// **** DO NOT CHANGE
global base_covariates2019 "abs_lat"
global base_covariates2000 "abs_lat"

// global base_covariates2019 "abs_lat mean_temp_1991_2016 mean_precip_1991_2016"
// global base_covariates2000 "abs_lat mean_temp_1991_2000 mean_precip_1991_2000"
// global lang_trade_iv "EngFrac EurFrac logFrankRom"
// global legor_iv "civil_law"
// global legor_iv "uk_mom frsp_mom ger_mom "
// global legor_iv "legor_uk"
global legor_iv "legor_uk legor_fr legor_ge legor_sc"

// global legor_iv "sjlouk"
// global crops_minerals_iv "bananas coffee copper maize millet rice silver sugarcane rubber wheat"

global iv1 "logem"
global iv2 "$lang_trade_iv"
global iv3 "$legor_iv"
global iv4 "$crops_minerals_iv"
global iv5 "lpd1500s"
global iv6 "logem $lang_trade_iv $legor_iv $crops_minerals_iv lpd1500s"


************************************
************************************ 

*** Load data 
use ${path_output}/total.dta, replace

************************************
************************************ look at outliers in the outcomes

// GDP growth rates in 2020


// Covid-19 outcomes in 2020 


// egen p5 = pctile(gdp_growth2020), p(5)
// egen p95 = pctile(gdp_growth2020), p(95)
// generate pop = p5<=gdp_growth2020 & gdp_growth2020<p95
 
************************************
************************************ set the index that we want to use

local main_index "vdem"

if "`main_index'" == "csp" {
	local dem2020 "democracy_csp2018"
	local dem2000 "democracy_csp2000"
}

if "`main_index'" == "fh" {
	local dem2020 "democracy_fh2020"
	local dem2000 "democracy_fh2003"
}

if "`main_index'"== "vdem"{
	local dem2020 "democracy_vdem2019"
	local dem2000 "democracy_vdem2000"
}

if "`main_index'" == "eiu"{
	local dem2020 "democracy_eiu2020"
	local dem2000 "democracy_eiu2006"
}

di "`dem2020'"
di "`dem2000'"

************************************
************************************ calculate all the
// replace sjlouk=. if ex2col==1
replace legor_uk = . if ex2col!=1
// replace legor_uk = . if civil_law==.
replace legor_fr = . if ex2col!=1
replace legor_ge = . if ex2col!=1
replace legor_sc = . if ex2col!=1

local num = 1

foreach remove_us_china in 0 1 {
	
	if `remove_us_china' ==1{
	drop if countries=="United States"
	drop if countries=="China"
	}
	
	foreach var in gdp_growth2020 mean_growth_rate_2001_2019 total_deaths_per_million{
	
	if "`var'" == "gdp_growth2020" | "`var'"== "total_deaths_per_million" {
		// local weight `" "[w=total_gdp2019]" "[w=population2020]" " " "'
		
		if `remove_us_china' ==1{
			local weight "[w=total_gdp2019] "
		}
		else {
			local weight `" "[w=total_gdp2019]" " " "'
		}
		
		local covariates "${base_covariates2019}"
		local index "`dem2020'"
	}
	
	else if "`var'" == "mean_growth_rate_2001_2019" {
		// local weight `" "[w=total_gdp2000]" "[w=population2000]" " " "'
		if `remove_us_china' ==1{
			local weight "[w=total_gdp2000]"
		}
		else {
			local weight `" "[w=total_gdp2000]" " " "'
		}
		local covariates "${base_covariates2000}"
		local index "`dem2000'"
	}
	
	
	
	foreach w in `weight'{
		
		eststo clear
	
		 eststo: ivregress 2sls `var' (`index'=${iv3}) `w', vce(robust)
		// eststo: ivregress 2sls `var' (`index'=${iv`j'}) `w' `limit_sample', vce(robust)
		estat firststage
		mat fstat = r(singleresults)
		estadd scalar fs = fstat[1,4]
		
		eststo: ivregress 2sls `var' `covariates' (`index'=${iv3}) `w', vce(robust)
		// eststo: ivregress 2sls `var' `covariates' (`index'=${iv3}) `w' `limit_sample', vce(robust)
		estat firststage
		mat fstat = r(singleresults)
		estadd scalar fs = fstat[1,4]
		
		
	if `num' == 1 & `remove_us_china' == 0 {
		local replace_append "replace"
	} 
	else{
		local replace_append "append"
	}
	
	esttab using ${path_output}/tables/all/all_`main_index'_legal_origins_option1.csv, keep(`index') nocons `replace_append' label b(a1) t(a1) nodepvars stats(N fs, labels("N" "F-Statistic (First stage)")) plain collabels(none)
	local num = `num' + 1
		}
	}

}
	






