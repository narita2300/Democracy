********************************************************************************
* Table: Reduced Form Regressions
********************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use ${path_data}/total.dta, replace


******************************************
*** RF on Outcomes *** 
******************************************

egen mean_growth_rate_1981_2000 = rowmean(gdp_growth1981-gdp_growth2000)

cd ${path_dropbox}/tables

local count = 1
// local outcomes mean_growth_rate_2001_2019 gdp_growth2020 total_deaths_per_million mean_growth_rate_1981_2000
local outcomes mean_growth_rate_1981_2000
// local outcomes mean_growth_rate_2001_2019

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
				eststo: reg `outcome' ${iv`i'} `weight', robust
				eststo: reg `outcome' `covariates' ${iv`i'} `weight', robust
	}

	esttab using rf_`outcome'.tex, ///
	replace label cells("b(fmt(1))" "se(par fmt(1))" "p(fmt(2))") ///
	nodepvars nogaps nonotes nostar mlabels(none) drop(`covariates' _cons) stats(N, labels("N") fmt(0))
	
	local count = `count' + 1
}

include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use(table2_panelA1.tex table2_panelA2.tex table2_panelA3.tex) paneltitles("`: var label `:word 1 of `outcomes'''" "`: var label `:word 2 of `outcomes'''" "`: var label `:word 3 of `outcomes'''") columncount(11) save(table2_panelA.tex) cleanup

