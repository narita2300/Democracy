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

local count = 1
local outcomes mean_growth_rate_2001_2019 gdp_growth2020 total_deaths_per_million
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
	
	local coefs1 
	local coefs_abs1
	
	local coef2
	local coefs_abs2
	
	
	eststo clear
	forv i = 1/5{
		
				// without controls
				// file to store the relevant f-statistics, coefs, and se
				file open f10 using ${path_coefs}/fstats_iv`i'_nocontrols.tex, replace write
				file open f11 using ${path_coefs}/`outcome'_iv`i'_nocontrols_coef.tex, replace write
				file open f12 using ${path_coefs}/`outcome'_iv`i'_nocontrols_se.tex, replace write
				file open f13 using ${path_coefs}/`outcome'_iv`i'_nocontrols_coef_abs.tex, replace write
				
				eststo: ivreg2 `outcome' (`index'=${iv`i'}) `weight', robust
				scalar fstat = e(widstat)
				estadd scalar fs = fstat
				
				local fs1 = string(round(e(widstat), 0.1), "%03.1f")
				local coef = string(round(_b[`index'], 0.1), "%03.1f")
				local se = string(round(_se[`index'], 0.1), "%03.1f")
				local coef_abs = string(abs(round(_b[`index'], 0.1)), "%03.1f")
				
				local coef_num = round(_b[`index'], 0.1)
				local coef_num_abs = abs(`coef_num')
				
				local coefs1 `coefs1' `coef_num'
				di `coefs1'
				local coefs_abs1 `coefs_abs1' `coef_num_abs'
				di `coefs_abs1'
				
				file write f10 "`fs1'" "\unskip"
				file close f10

				file write f11 "`coef'" "\unskip"
				file close f11

				file write f12 "`se'" "\unskip"
				file close f12
				
				file write f13 "`coef_abs'" "\unskip"
				file close f13
				
				// with controls 
				// file to store the relevant f-statistics, coefs, and se
				file open f20 using ${path_coefs}/fstats_iv`i'_withcontrols.tex, replace write
				file open f21 using ${path_coefs}/`outcome'_iv`i'_withcontrols_coef.tex, replace write
				file open f22 using ${path_coefs}/`outcome'_iv`i'_withcontrols_se.tex, replace write
				file open f23 using ${path_coefs}/`outcome'_iv`i'_withcontrols_coef_abs.tex, replace write
				
				
				eststo: ivreg2 `outcome' `covariates' (`index'=${iv`i'}) `weight', robust
				scalar fstat = e(widstat)
				estadd scalar fs = fstat
				
				local fs2 = string(round(e(widstat), 0.1), "%03.1f")
				local coef = string(round(_b[`index'], 0.1), "%03.1f")
				local se = string(round(_se[`index'], 0.1), "%03.1f")
				local coef_abs = string(abs(round(_b[`index'], 0.1)), "%03.1f")
				
				
				local coef_num = round(_b[`index'], 0.1)
				local coef_num_abs = abs(`coef_num')
				
				local coefs2 `coefs2' `coef_num'
				local coefs_abs2 `coefs_abs2' `coef_num_abs'
				
				file write f20 "`fs2'" "\unskip"
				file close f20

				file write f21 "`coef'" "\unskip"
				file close f21

				file write f22 "`se'" "\unskip"
				file close f22
				
				file write f23 "`coef_abs'" "\unskip"
				file close f23
	}
	
	if `count' == 3{
		local last "stats(fs, fmt(1) labels("F-Statistic (First stage)")) prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals}  \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 \\"')"

	}
	else {
		local last "noobs"
	}
	
	
	esttab using table2_panelA`count'.tex, ///
	replace label b(a1) se(a1) `last' ///
	nodepvars nogaps nonotes nostar mlabels(none) keep(`index') ///
	
	local count = `count' + 1
	
// 	di "`coefs1'"
// 	listsort "`coefs1'"
// 	local coef1_sorted = s(list)
// 	local coefs1_median: `word 3 of `coefs1''
// 	di "`coef1_sorted'"
	
// 	listsort "`coefs_abs1'"
// 	local coefs_abs1_sorted = s(list)
	
// 	listsort "`coefs2'"
// 	local coefs2_sorted = s(list)
	
// 	listsort "`coefs_abs2'"
// 	local coefs_abs2_sorted = s(list)
	
// 	di "Here?"
// // 	local coefs1: list sort coefs1
// // 	local coefs1_median: `word 3 of `coefs1''
	
// // 	local coefs_abs1: list sort coefs_abs1
// // 	local coefs_abs1_median: `word 3 of `coefs_abs1''
	
// // 	local coefs2: list sort coefs2
// // 	local coefs2_median: `word 3 of `coefs2''
	
// // 	local coefs_abs2: list sort coefs_abs2
// // 	local coefs_abs2_median: `word 3 of `coefs_abs2''

// 	file open c11 using ${path_coefs}/`outcome'_median_nocontrols.tex, replace write
// 	file open c12 using ${path_coefs}/`outcome'_median_nocontrols_abs.tex, replace write
	
// 	file open c21 using ${path_coefs}/`outcome'_median_withcontrols.tex, replace write
// 	file open c22 using ${path_coefs}/`outcome'_median_withcontrols_abs.tex, replace write
	
// 	file write c11 "`coefs1_median'" "\unskip"
// 	file close c11
	
// 	file write c12 "`coefs_abs1_median'" "\unskip"
// 	file close c12
	
// 	file write c21 "`coefs2_median'" "\unskip"
// 	file close c21
	
// 	file write c22 "`coefs_abs2_median'" "\unskip"
// 	file close c22

}
// stats(p fs, fmt(2 1) labels("P-value" "F-Statistic (First stage)")) 
// stats(p, fmt(2) labels("P-value"))

include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use(table2_panelA1.tex table2_panelA2.tex table2_panelA3.tex) paneltitles("`: var label `:word 1 of `outcomes'''" "`: var label `:word 2 of `outcomes'''" "`: var label `:word 3 of `outcomes'''") columncount(11) save(table2_panelA.tex) cleanup
	
// listsort "1 5 4 2 3"
// local coef1_sorted = s(list)
// di `coef1_sorted'
// local coefs1_median: `word 3 of `coefs1_sorted''
// di `coefs1_median'
	
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
		
				local colnum = (`i'-1)*2 + 1
		
				file open f11 using ${path_coefs}/`outcome'_col`colnum'_ols_coef.tex, replace write
				file open f12 using ${path_coefs}/`outcome'_col`colnum'_ols_se.tex, replace write
				file open f13 using ${path_coefs}/`outcome'_col`colnum'_ols_coef_abs.tex, replace write

				eststo: reg `outcome' `index' if `:word 1 of ${iv`i'}' !=. `weight', vce(robust)
				
				local coef = string(round(_b[`index'], 0.1), "%03.1f")
				local se = string(round(_se[`index'], 0.1), "%03.1f")
				local coef_abs = string(abs(round(_b[`index'], 0.1)), "%03.1f")
				
				
				file write f11 "`coef'" "\unskip"
				file close f11
				
				file write f12 "`se'" "\unskip"
				file close f12
				
				file write f13 "`coef_abs'" "\unskip"
				file close f13
				
				local colnum = (`i'-1)*2 + 2
				
				file open f21 using ${path_coefs}/`outcome'_col`colnum'_ols_coef.tex, replace write
				file open f22 using ${path_coefs}/`outcome'_col`colnum'_ols_se.tex, replace write
				file open f23 using ${path_coefs}/`outcome'_col`colnum'_ols_coef_abs.tex, replace write

				eststo: reg `outcome' `index' `covariates' if `:word 1 of ${iv`i'}' !=. `weight', vce(robust)
				local coef = string(round(_b[`index'], 0.1), "%03.1f")
				local se = string(round(_se[`index'], 0.1), "%03.1f")
				
				file write f21 "`coef'" "\unskip"
				file close f21

				file write f22 "`se'" "\unskip"
				file close f22
				
				file write f23 "`coef_abs'" "\unskip"
				file close f23

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

include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use(table2_panelB1.tex table2_panelB2.tex table2_panelB3.tex) paneltitles("`: var label `:word 1 of `outcomes'''" "`: var label `:word 2 of `outcomes'''" "`: var label `:word 3 of `outcomes'''") columncount(11) save(table2_panelB.tex) cleanup

// include "${path_code}/2_analyze/tables/PanelCombine2.do"
// panelcombine, use(${path_output}/tables/table2_panelA.tex ${path_output}/tables/table2_panelB.tex) paneltitles("Two-Stage Least Squares" "Ordinary Least Squares") columncount(11) save(table2.tex) cleanup


