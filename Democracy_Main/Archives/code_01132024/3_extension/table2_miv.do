set maxvar 10000

cap ssc install ivreg2, replace
cap ssc install ranktest, replace

global path_code /Users/richardgong/MainAnalysis/code
global path_data /Users/richardgong/MainAnalysis/output/data
global path_output /Users/richardgong/MainAnalysis/output/tables/extensions
global path_coefs ${path_output}/coefs

global base_covariates2019 "abs_lat mean_temp_1991_2016 mean_precip_1991_2016 pop_density2019 median_age2020 diabetes_prevalence2019"
global base_covariates2000 "abs_lat mean_temp_1991_2000 mean_precip_1991_2000 pop_density2000 median_age2000"

global lang_trade_iv "EngFrac EurFrac"
global legor_iv "legor_uk"
global crops_minerals_iv "bananas coffee copper maize millet rice rubber silver sugarcane wheat"

global iv1 "EngFrac"
global iv2 "EurFrac"
global iv3 "bananas"
global iv4 "coffee"
global iv5 "logem"
global iv6 "lpd1500s"

global covariates_iv1 "EurFrac"
global covariates_iv2 "EngFrac"
global covariates_iv3 "coffee copper maize millet rice rubber silver sugarcane wheat"
global covariates_iv4 "bananas copper maize millet rice rubber silver sugarcane wheat"
global covariates_iv5 "lpd1500s $legor_iv $lang_trade_iv $crops_minerals_iv"
global covariates_iv6 "logem $legor_iv $lang_trade_iv $crops_minerals_iv"

global dem2019 "democracy_vdem2019"
global dem2000 "democracy_vdem2000"

global weight2019 "[w=total_gdp2019]"
global weight2000 "[w=total_gdp2000]"

global outcome1 "mean_growth_rate_2001_2019"
global outcome2 "gdp_growth2020"
global outcome3 "total_deaths_per_million"

********************************************************************************
* Table: 2SLS Regression Estimates of Democracy's Effects (Multiple IVs)
********************************************************************************

*** Change to appropriate directory
cd ${path_output}

*** Load data
use ${path_data}/total.dta, replace

******************************************
*** Panel A: 2SLS on Outcomes *** 
******************************************

local count = 1
	
local outcomes ${outcome1} ${outcome2} ${outcome3}


foreach outcome of local outcomes{
	
	if "`outcome'" == "${outcome2}" | "`outcome'"== "${outcome3}" {
		local weight "${weight2019}"
		local index "${dem2019}"
	}
	
	else if "`outcome'" == "${outcome1}" {
		local weight "${weight2000}"
		local index "${dem2000}"
	}
	
	eststo clear
	forv i = 1/6{
				
				local covariates_iv "${covariates_iv`i'}"
			
				if "`outcome'" == "${outcome2}" | "`outcome'"== "${outcome3}" {
					local covariates_base "$base_covariates2019"
				}
				else if "`outcome'" == "${outcome1}" {
					local covariates_base "$base_covariates2000"
				}
				
				// without controls
				// file to store the relevant f-statistics, coefs, and se
				file open f10 using ${path_coefs}/fstats_iv`i'_nocontrols.tex, replace write
				file open f11 using ${path_coefs}/`outcome'_iv`i'_nocontrols_coef.tex, replace write
				file open f12 using ${path_coefs}/`outcome'_iv`i'_nocontrols_se.tex, replace write
				file open f13 using ${path_coefs}/`outcome'_iv`i'_nocontrols_coef_abs.tex, replace write
				
				eststo: ivreg2 `outcome' `covariates_iv' (`index'=${iv`i'}) `weight', robust
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
				
				eststo: ivreg2 `outcome' `covariates_iv' `covariates_base' (`index'=${iv`i'}) `weight', robust
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
		local last "stats(fs, fmt(1 1) labels("F-Statistic (First stage)")) prefoot(`" IVs & \multicolumn{2}{c}{english (lang.)} &  \multicolumn{2}{c}{european (lang.)} & \multicolumn{2}{c}{bananas (crops \& min.)} & \multicolumn{2}{c}{coffee (crops \& min.)} & \multicolumn{2}{c}{set. mort. (all IVs)} & \multicolumn{2}{c}{pop. den. (all IVs)} \\"' `"Number of IVs & 2 & 2 & 2 & 2 & 10 & 10 & 10 & 10 & 15 & 15 & 15 & 15 \\"')"

	}
	else {
		local last "noobs"
	}
	
	esttab using table2_miv_panelA`count'.tex, ///
	replace label cells("b(fmt(1))" "se(par fmt(1))" "p(fmt(2))")  `last' ///
	nodepvars nogaps nonotes nostar mlabels(none) keep(`index') ///
	
	local count = `count' + 1
}

include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use(table2_miv_panelA1.tex table2_miv_panelA2.tex table2_miv_panelA3.tex) paneltitles("`: var label `:word 1 of `outcomes'''" "`: var label `:word 2 of `outcomes'''" "`: var label `:word 3 of `outcomes'''") columncount(13) save(table2_miv_panelA.tex) cleanup
