cap ssc install ivreg2, replace
cap ssc install ranktest, replace

clear all
set maxvar 10000

global path_code /Users/richardgong/MainAnalysis/code
global path_data /Users/richardgong/MainAnalysis/output/data
global path_output /Users/richardgong/MainAnalysis/output/tables/extensions
global path_coefs ${path_output}/coefs

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

global dem2019 "democracy_vdem2019"
global dem2000 "democracy_vdem2000"

global weight2019 "[w=total_gdp2019]"
global weight2000 "[w=total_gdp2000]"

********************************************************************************
* Table: 2SLS Regression Estimates of Democracy's Effects
********************************************************************************

*** Change to appropriate directory
cd ${path_output}

*** Load data
use ${path_data}/total.dta, replace

*********************************
*** Panel A: 2SLS on Outcomes *** 
*********************************

local count = 1
local outcomes mean_bot50_inc_shr_2001_2019 bot50_income_share2020 bot50_income_share2020 bot50_income_share2020

foreach outcome of local outcomes{
	
	if "`outcome'" == "mean_bot50_inc_shr_2001_2019" {
		local weight "${weight2000}"
		local covariates "${base_covariates2000}"
		local index "${dem2000}"
	}
	else {
		local weight "${weight2019}"
		local covariates "${base_covariates2019}"
		local index "${dem2019}"
	}
	
	eststo clear
	forv i = 1/6{
		
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
		local last "stats(fs, fmt(1 1) labels("F-Statistic (First stage)")) prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"')"

	}
	else {
		local last "noobs"
	}
	
	esttab using table_bot_income_panelA`count'.tex, ///
	replace label cells("b(fmt(1))" "se(par fmt(1))" "p(fmt(2))")  `last' ///
	nodepvars nogaps nonotes nostar mlabels(none) keep(`index') ///
	
	local count = `count' + 1
}

include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use(table_bot_income_panelA1.tex table_bot_income_panelA2.tex table_bot_income_panelA3.tex table_bot_income_panelA4.tex) paneltitles("`: var label `:word 1 of `outcomes'''" "`: var label `:word 2 of `outcomes'''" "`: var label `:word 3 of `outcomes'''") columncount(13) save(table_bot_income_panelA.tex) cleanup

********************************
*** Panel B: OLS on Outcomes *** 
********************************

local count = 1

foreach outcome of local outcomes{
	
	if "`outcome'" == "mean_bot50_inc_shr_2001_2019" {
		local weight "${weight2000}"
		local covariates "${base_covariates2000}"
		local index "${dem2000}"
	}
	else {
		local weight "${weight2019}"
		local covariates "${base_covariates2019}"
		local index "${dem2019}"
	}
	
	eststo clear
	forv i = 1/6{
		
		
				local colnum = (`i'-1)*2 + 1
		
				file open f11 using ${path_coefs}/`outcome'_col`colnum'_ols_coef.tex, replace write
				file open f12 using ${path_coefs}/`outcome'_col`colnum'_ols_se.tex, replace write
				file open f13 using ${path_coefs}/`outcome'_col`colnum'_ols_coef_abs.tex, replace write
				
				if `i' == 6{
					eststo: reg `outcome' `index' if logem != . & lpd1500s !=. & legor_uk !=. & EurFrac !=. & bananas!=. & copper !=. `weight', vce(robust)
				}
				else {
					eststo: reg `outcome' `index' if `:word 1 of ${iv`i'}' !=. `weight', vce(robust)
				}

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

				if `i' == 6{
					eststo: reg `outcome' `index' `covariates' if logem != . & lpd1500s !=. & legor_uk !=. & EurFrac !=. & bananas!=. & copper !=. `weight', vce(robust)
				}
				else {
					eststo: reg `outcome' `index' `covariates' if `:word 1 of ${iv`i'}' !=. `weight', vce(robust)
				
				}
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
		local last "stats(N, labels("N")) prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')"

	}
	else {
		local last "noobs"
	}
	
	esttab using table_bot_income_panelB`count'.tex, ///
	replace label b(a1) se(a1) `last' ///
	nodepvars nogaps nonotes nostar mlabels(none) keep(`index') ///
	
	local count = `count' + 1
}

include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use(table_bot_income_panelB1.tex table_bot_income_panelB2.tex table_bot_income_panelB3.tex table_bot_income_panelB4.tex) paneltitles("`: var label `:word 1 of `outcomes'''" "`: var label `:word 2 of `outcomes'''" "`: var label `:word 3 of `outcomes'''") columncount(13) save(table_bot_income_panelB.tex) cleanup
