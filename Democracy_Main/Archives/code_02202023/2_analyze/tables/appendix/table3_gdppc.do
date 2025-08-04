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

cd ${path_dropbox}/tables/appendix

local count = 1
local outcomes mean_gdppc_growth_2001_2019 gdppc_growth2020 total_deaths_per_million
// local outcomes mean_growth_rate_2001_2019

foreach outcome of local outcomes{
	
	if "`outcome'" == "gdppc_growth2020" | "`outcome'"== "total_deaths_per_million" {
		local weight "${weight2019}"
		local covariates "${base_covariates2019}"
		local index "${dem2019}"
	}
	
	else if "`outcome'" == "mean_gdppc_growth_2001_2019" {
		local weight "${weight2000}"
		local covariates "${base_covariates2000}"
		local index "${dem2000}"
	}
	
	eststo clear
	forv i = 1/5{
		
// 				// without controls
// 				// file to store the relevant f-statistics, coefs, and se
// 				file open f10 using ${path_coefs}/fstats_iv`i'_nocontrols.tex, replace write
// 				file open f11 using ${path_coefs}/`outcome'_iv`i'_nocontrols_coef.tex, replace write
// 				file open f12 using ${path_coefs}/`outcome'_iv`i'_nocontrols_se.tex, replace write
// 				file open f13 using ${path_coefs}/`outcome'_iv`i'_nocontrols_coef_abs.tex, replace write
				
				eststo: ivreg2 `outcome' (`index'=${iv`i'}) `weight', robust
				scalar fstat = e(widstat)
				estadd scalar fs = fstat
				
// 				local fs1 = string(round(e(widstat), 0.1), "%03.1f")
// 				local coef = string(round(_b[`index'], 0.1), "%03.1f")
// 				local se = string(round(_se[`index'], 0.1), "%03.1f")
// 				local coef_abs = string(abs(round(_b[`index'], 0.1)), "%03.1f")
				
// 				file write f10 "`fs1'" "\unskip"
// 				file close f10

// 				file write f11 "`coef'" "\unskip"
// 				file close f11

// 				file write f12 "`se'" "\unskip"
// 				file close f12
				
// 				file write f13 "`coef_abs'" "\unskip"
// 				file close f13
				
// 				// with controls 
// 				// file to store the relevant f-statistics, coefs, and se
// 				file open f20 using ${path_coefs}/fstats_iv`i'_withcontrols.tex, replace write
// 				file open f21 using ${path_coefs}/`outcome'_iv`i'_withcontrols_coef.tex, replace write
// 				file open f22 using ${path_coefs}/`outcome'_iv`i'_withcontrols_se.tex, replace write
// 				file open f23 using ${path_coefs}/`outcome'_iv`i'_withcontrols_coef_abs.tex, replace write
				
				eststo: ivreg2 `outcome' `covariates' (`index'=${iv`i'}) `weight', robust
				scalar fstat = e(widstat)
				estadd scalar fs = fstat
				
// 				local fs2 = string(round(e(widstat), 0.1), "%03.1f")
// 				local coef = string(round(_b[`index'], 0.1), "%03.1f")
// 				local se = string(round(_se[`index'], 0.1), "%03.1f")
// 				local coef_abs = string(abs(round(_b[`index'], 0.1)), "%03.1f")
				
// 				file write f20 "`fs2'" "\unskip"
// 				file close f20

// 				file write f21 "`coef'" "\unskip"
// 				file close f21

// 				file write f22 "`se'" "\unskip"
// 				file close f22
				
// 				file write f23 "`coef_abs'" "\unskip"
// 				file close f23
	}
	
	if `count' == 3{
		local last "stats(fs, fmt(1 1) labels("F-Statistic (First stage)")) prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals}  \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 \\"')"

	}
	else {
		local last "noobs"
	}
	
	esttab using gdppc_panelA`count'.tex, ///
	replace label cells("b(fmt(1))" "se(par fmt(1))" "p(fmt(2))")  `last' ///
	nodepvars nogaps nonotes nostar mlabels(none) keep(`index') ///
	
	local count = `count' + 1
}

include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use(gdppc_panelA1.tex gdppc_panelA2.tex gdppc_panelA3.tex) paneltitles("`: var label `:word 1 of `outcomes'''" "`: var label `:word 2 of `outcomes'''" "`: var label `:word 3 of `outcomes'''") columncount(11) save(gdppc_panelA.tex) cleanup

******************************************
*** Panel B: OLS on Covid-19 Outcomes *** 
******************************************

local outcomes mean_gdppc_growth_2001_2019 gdppc_growth2020 total_deaths_per_million
local count = 1

foreach outcome of local outcomes{
	
	if "`outcome'" == "gdppc_growth2020" | "`outcome'"== "total_deaths_per_million" {
		local weight "${weight2019}"
		local covariates "${base_covariates2019}"
		local index "${dem2019}"
	}
	
	else if "`outcome'" == "mean_gdppc_growth_2001_2019" {
		local weight "${weight2000}"
		local covariates "${base_covariates2000}"
		local index "${dem2000}"
	}
	
	eststo clear
	forv i = 1/5{
		
// 				local colnum = (`i'-1)*2 + 1
		
// 				file open f11 using ${path_coefs}/`outcome'_col`colnum'_ols_coef.tex, replace write
// 				file open f12 using ${path_coefs}/`outcome'_col`colnum'_ols_se.tex, replace write
// 				file open f13 using ${path_coefs}/`outcome'_col`colnum'_ols_coef_abs.tex, replace write

				eststo: reg `outcome' `index' if `:word 1 of ${iv`i'}' !=. `weight', vce(robust)
				
// 				local coef = string(round(_b[`index'], 0.1), "%03.1f")
// 				local se = string(round(_se[`index'], 0.1), "%03.1f")
// 				local coef_abs = string(abs(round(_b[`index'], 0.1)), "%03.1f")
				
// 				file write f11 "`coef'" "\unskip"
// 				file close f11
				
// 				file write f12 "`se'" "\unskip"
// 				file close f12
				
// 				file write f13 "`coef_abs'" "\unskip"
// 				file close f13
				
// 				local colnum = (`i'-1)*2 + 2
				
// 				file open f21 using ${path_coefs}/`outcome'_col`colnum'_ols_coef.tex, replace write
// 				file open f22 using ${path_coefs}/`outcome'_col`colnum'_ols_se.tex, replace write
// 				file open f23 using ${path_coefs}/`outcome'_col`colnum'_ols_coef_abs.tex, replace write

				eststo: reg `outcome' `index' `covariates' if `:word 1 of ${iv`i'}' !=. `weight', vce(robust)
// 				local coef = string(round(_b[`index'], 0.1), "%03.1f")
// 				local se = string(round(_se[`index'], 0.1), "%03.1f")
				
// 				file write f21 "`coef'" "\unskip"
// 				file close f21

// 				file write f22 "`se'" "\unskip"
// 				file close f22
				
// 				file write f23 "`coef_abs'" "\unskip"
// 				file close f23

	}
	
	if `count' == 3{
		local last "stats(N, labels("N")) prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')"

	}
	else {
		local last "noobs"
	}
	
	esttab using gdppc_panelB`count'.tex, ///
	replace label b(a1) se(a1) `last' ///
	nodepvars nogaps nonotes nostar mlabels(none) keep(`index') ///
	
	local count = `count' + 1
}

include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use(gdppc_panelB1.tex gdppc_panelB2.tex gdppc_panelB3.tex) paneltitles("`: var label `:word 1 of `outcomes'''" "`: var label `:word 2 of `outcomes'''" "`: var label `:word 3 of `outcomes'''") columncount(11) save(gdppc_panelB.tex) cleanup
