********************************************************************************
* Robustness Check
********************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data


*** Load data 
use ${path_data}/total.dta, replace

*** we re-estimate our preferred specification without countries with a standarized residual above 1.96 or below -1.96. ***

local count = 1
local outcomes mean_growth_rate_2001_2019 gdp_growth2020 total_deaths_per_million

foreach outcome of local outcomes{
	
	if "`outcome'" == "gdp_growth2020" | "`outcome'"== "total_deaths_per_million" {
		local weight "${weight2019}"
		local covariates "${base_covariates2019}"
		local index "${dem2019}"
	}
	
	else if "`outcome'" == "mean_growth_rate_2001_2019" {
		local weight "${weight2000}"
		local covariates "${base_covariates2000}"
		local index "${dem2000}"
	}
	
	eststo clear
	forv i = 1/5{
				ivreg2 `outcome' (`index'=${iv`i'}) `weight', robust
				predict yhat
				gen resid = `outcome' - yhat
				egen resid_std = std(resid)
				eststo: ivreg2 `outcome' (`index'=${iv`i'}) `weight' if resid_std<=1.96 & resid_std>=-1.96, robust
				drop yhat resid resid_std
				
				ivreg2 `outcome' `covariates' (`index'=${iv`i'}) `weight', robust
				predict yhat
				gen resid = `outcome' - yhat
				egen resid_std = std(resid)
				eststo: ivreg2 `outcome' (`index'=${iv`i'}) `weight' if resid_std<=1.96 & resid_std>=-1.96, robust
				drop yhat resid resid_std
	}
	
	if `count' == 3{
		local last "postfoot(`" \hline \\[-1.8ex] IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals}  \\ Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')"

	}
	else {
		local last ""
	}
	
	esttab using ${path_appendix}/robust_panel`count'.tex, ///
	replace label b(a1) se(a1) stats(N, labels("N"))  `last' ///
	nodepvars nogaps nonotes nostar mlabels(none) keep(`index') ///
	
	local count = `count' + 1
}

include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use(${path_appendix}/robust_panel1.tex ${path_appendix}/robust_panel2.tex ${path_appendix}/robust_panel3.tex) paneltitles("`: var label `:word 1 of `outcomes'''" "`: var label `:word 2 of `outcomes'''" "`: var label `:word 3 of `outcomes'''") columncount(11) save(${path_appendix}/13_2sls_outliers.tex) cleanup


// forv i = 1/5{
	
// 	use ${path_appendix}/total.dta, replace

// 	ivreg2 gdp_growth2020 (${dem2019}=${iv`i'}) ${weight2019}, robust
// 	predict yhat
// 	gen resid = gdp_growth2020 - yhat
// 	egen resid_std = std(resid)
// 	keep if resid_std<=1.96 & resid_std>=-1.96
// 	drop yhat resid resid_std
// 	ivreg2 gdp_growth2020 (${dem2019}=${iv`i'}) ${weight2019}, robust

// 	use ${path_appendix}/total.dta, replace
	
// 	ivreg2 gdp_growth2020 ${base_covariates2019} (${dem2019}=${iv`i'}) ${weight2019}, robust
// 	predict yhat
// 	gen resid = gdp_growth2020 - yhat
// 	egen resid_std = std(resid)
// 	keep if resid_std<=1.96 & resid_std>=-1.96
// 	drop yhat resid resid_std
// 	ivreg2 gdp_growth2020 ${base_covariates2019} (${dem2019}=${iv`i'}) ${weight2019}, robust

// }

// forv i = 1/5{
// 	use ${path_appendix}/total.dta, replace

// 	ivreg2 mean_growth_rate_2001_2019 (${dem2000}=${iv`i'}) ${weight2000}, robust
// 	predict yhat
// 	gen resid = gdp_growth2020 - yhat
// 	egen resid_std = std(resid)
// 	keep if resid_std<=1.96 & resid_std>=-1.96
// 	drop yhat resid resid_std
// 	ivreg2 gdp_growth2020 (${dem2000}=${iv`i'}) ${weight2000}, robust

// 	use ${path_appendix}/total.dta, replace
	
// 	ivreg2 mean_growth_rate_2001_2019 ${base_covariates2000} (${dem2000}=${iv`i'}) ${weight2000}, robust
// 	predict yhat
// 	gen resid = gdp_growth2020 - yhat
// 	egen resid_std = std(resid)
// 	keep if resid_std<=1.96 & resid_std>=-1.96
// 	drop yhat resid resid_std
// 	ivreg2 gdp_growth2020 ${base_covariates2000} (${dem2000}=${iv`i'}) ${weight2000}, robust

// }

// ivreg2 gdp_growth2020 (${dem2019}=${iv2}) ${weight2019}, robust
// predict yhat
// gen resid = gdp_growth2020 - yhat
// egen resid_std = std(resid)
// keep if resid_std<=1.96 & resid_std>=-1.96
// drop yhat resid resid_std
// ivreg2 gdp_growth2020 (${dem2019}=${iv2}) ${weight2019}, robust

// ivreg2 gdp_growth2020 ${base_covariates2019} (${dem2019}=${iv2}) ${weight2019}, robust
// predict yhat
// gen resid = gdp_growth2020 - yhat
// egen resid_std = std(resid)
// keep if resid_std<=1.96 & resid_std>=-1.96
// drop yhat resid resid_std
// ivreg2 gdp_growth2020 ${base_covariates2019} (${dem2019}=${iv2}) ${weight2019}, robust

// ivreg2 gdp_growth2020 (${dem2019}=${iv3}) ${weight2019}, robust
// predict yhat
// gen resid = gdp_growth2020 - yhat
// egen resid_std = std(resid)
// keep if resid_std<=1.96 & resid_std>=-1.96
// drop yhat resid resid_std
// ivreg2 gdp_growth2020 (${dem2019}=${iv3}) ${weight2019}, robust

// ivreg2 gdp_growth2020 ${base_covariates2019} (${dem2019}=${iv3}) ${weight2019}, robust
// predict yhat
// gen resid = gdp_growth2020 - yhat
// egen resid_std = std(resid)
// keep if resid_std<=1.96 & resid_std>=-1.96
// drop yhat resid resid_std
// ivreg2 gdp_growth2020 ${base_covariates2019} (${dem2019}=${iv3}) ${weight2019}, robust


