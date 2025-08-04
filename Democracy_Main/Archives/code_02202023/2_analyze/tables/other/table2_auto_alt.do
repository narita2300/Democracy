********************************************************************************
* Table 2: 2SLS Regression Estimates of Democracy's Effects
********************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data


*** Load data 
use ${path_data}/total.dta, replace

******************************************
*** Panel A: 2SLS on Covid-19 Outcomes *** 
******************************************

cd ${path_dropbox}/tables

local count = 0
local outcomes mean_growth_rate_2001_2019 gdp_growth2020 total_deaths_per_million
// local outcomes mean_growth_rate_2001_2019

forv i = 0/5{
	
	eststo clear
		
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
		
		if `i' == 0{
			eststo: reg `outcome' `index' `weight', vce(robust)		
			eststo: reg `outcome' `index' `covariates' `weight', vce(robust)
		}

		else {
			eststo: ivreg2 `outcome' (`index'=${iv`i'}) `weight', robust
			scalar fstat = e(widstat)
			estadd scalar fs = fstat
			
			eststo: ivreg2 `outcome' `covariates' (`index'=${iv`i'}) `weight', robust
			scalar fstat = e(widstat)
			estadd scalar fs = fstat
		}
		
	}
		
		if `count' == 5{
			local last "stats(fs, labels("F-Statistic (First stage)")) prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language \& trade} & \multicolumn{2}{c}{crops \& minerals}  \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 3 & 3 & 10 & 10 \\"')"
		}
		else {
			local last "noobs"
		}
		
		esttab using table2_panelA`count'.tex, ///
		replace label b(a1) se(a1) `last' ///
		nodepvars nogaps nonotes nostar mlabels(none) keep(${dem2000} ${dem2019}) ///
		
		local count = `count' + 1
	
}

include "${path_code}/2_analyze/tables/PanelCombine_new.do"
panelcombine, use(table2_panelA0.tex table2_panelA1.tex table2_panelA2.tex table2_panelA3.tex table2_panelA4.tex table2_panelA5.tex) paneltitles("A: " "B: " "C:" "D:" "E:" "F:") columncount(11) save(table2_panelA.tex) cleanup
	
******************************************
*** Panel B: OLS on Covid-19 Outcomes *** 
******************************************

local outcomes mean_growth_rate_2001_2019 gdp_growth2020 total_deaths_per_million
local count = 1

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
				eststo: reg `outcome' `index' if `:word 1 of ${iv`i'}' !=. `weight', vce(robust)		
				eststo: reg `outcome' `index' `covariates' if `:word 1 of ${iv`i'}' !=. `weight', vce(robust)
	}
	
	if `count' == 3{
		local last "stats(N, labels("N")) prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')"

	}
	else {
		local last "noobs"
	}
	
	esttab using table2_panelB`count'.tex, ///
	replace label b(a1) se(a1) `last' ///
	nodepvars nogaps nonotes nostar mlabels(none) keep(`index') ///
	
	local count = `count' + 1
}

include "${path_code}/2_analyze/tables/PanelCombine.do"
panelcombine, use(table2_panelB1.tex table2_panelB2.tex table2_panelB3.tex) paneltitles("`: var label `:word 1 of `outcomes'''" "`: var label `:word 2 of `outcomes'''" "`: var label `:word 3 of `outcomes'''") columncount(11) save(table2_panelB.tex) cleanup

// include "${path_code}/2_analyze/tables/PanelCombine2.do"
// panelcombine, use(${path_output}/tables/table2_panelA.tex ${path_output}/tables/table2_panelB.tex) paneltitles("Two-Stage Least Squares" "Ordinary Least Squares") columncount(11) save(table2.tex) cleanup


