			cap ssc install ivreg2, replace
cap ssc install ranktest, replace

global main_path "/Users/leonardofancello/Dropbox"
global path_code "${main_path}/Democracy/Democracy_Main/MainAnalysis/code"
global path_data "${main_path}/Democracy/Democracy_Main/MainAnalysis/output/data"
global path_output "${main_path}/Democracy/Democracy_Main/MainAnalysis/output/tables"
global path_coefs "${path_output}/coefs"

global base_covariates2019 "abs_lat mean_temp_1991_2016 mean_precip_1991_2016 pop_density2019 median_age2020 diabetes_prevalence2019"
global base_covariates2010 "abs_lat mean_temp_2001_2010 mean_precip_2001_2010 pop_density2010 median_age2010"

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
global dem2010 "democracy_vdem2010"

global weight2019 "[w=total_gdp2019]"
global weight2010 "[w=total_gdp2010]"

********************************************************************************
* Table: 2SLS Regression Estimates of Democracy's Effects
********************************************************************************

*** Change to appropriate directory
cd "${path_output}"
cap mkdir "old"
cap mkdir "old/coefs"

*** Load data
use "${path_data}/total.dta", replace

*********************************
*** Panel A: 2SLS on Outcomes *** 
*********************************

local count = 1

// local outcomes mean_LifeLadder_2010_2019 mean_Positiveaffect_2010_2019 LifeLadder2020 LifeLadder2021 LifeLadder2022 Positiveaffect2020 Positiveaffect2021 Positiveaffect2022
local outcomes life_ladder_2011_2020 positive_affect_2011_2020 life_ladder_2020_2022 positive_affect_2020_2022

foreach outcome of local outcomes{
	
	if "`outcome'" == "life_ladder_2011_2020" | "`outcome'" == "positive_affect_2011_2020" {
		local weight "${weight2010}"
		local covariates "${base_covariates2010}"
		local index "${dem2010}"
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
				file open f10 using "old/coefs/fstats_iv`i'_nocontrols.tex", replace write
				file open f11 using "old/coefs/`outcome'_iv`i'_nocontrols_coef.tex", replace write
				file open f12 using "old/coefs/`outcome'_iv`i'_nocontrols_se.tex", replace write
				file open f13 using "old/coefs/`outcome'_iv`i'_nocontrols_coef_abs.tex", replace write
				
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
				file open f20 using "old/coefs/fstats_iv`i'_withcontrols.tex", replace write
				file open f21 using "old/coefs/`outcome'_iv`i'_withcontrols_coef.tex", replace write
				file open f22 using "old/coefs/`outcome'_iv`i'_withcontrols_se.tex", replace write
				file open f23 using "old/coefs/`outcome'_iv`i'_withcontrols_coef_abs.tex", replace write
				
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
	
	if `count' == 4{
		local last "stats(fs, fmt(1 1) labels("F-Statistic (First stage)")) prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"')"

	}
	else {
		local last "noobs"
	}
	
	esttab using "old/table_happiness_panelA`count'.tex", ///
	replace label cells("b(fmt(1))" "se(par fmt(1))" "p(fmt(2))")  `last' ///
	nodepvars nogaps nonotes nostar mlabels(none) keep(`index') ///
	
	local count = `count' + 1
}

include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use("old/table_happiness_panelA1.tex" "old/table_happiness_panelA2.tex" "old/table_happiness_panelA3.tex" "old/table_happiness_panelA4.tex") paneltitles("Mean Growth Rate Life Ladder 2011-2020" "Mean Growth Rate Positive Affect 2011-2020" "Mean Growth Rate Life Ladder 2020-2022" "Mean Growth Rate Positive Affect 2020-2022") columncount(13) save("old/table_happiness_panelA.tex") cleanup

********************************
*** Panel B: OLS on Outcomes *** 
********************************

local count = 1

foreach outcome of local outcomes{
	
	if "`outcome'" ==  "life_ladder_2011_2020" | "`outcome'" == "positive_affect_2011_2020" {
		local weight "${weight2010}"
		local covariates "${base_covariates2010}"
		local index "${dem2010}"
	}
	else {
		local weight "${weight2019}"
		local covariates "${base_covariates2019}"
		local index "${dem2019}"
	}
	
	eststo clear
	forv i = 1/6{
		
		
				local colnum = (`i'-1)*2 + 1
		
				file open f11 using "old/coefs/`outcome'_col`colnum'_ols_coef.tex", replace write
				file open f12 using "old/coefs/`outcome'_col`colnum'_ols_se.tex", replace write
				file open f13 using "old/coefs/`outcome'_col`colnum'_ols_coef_abs.tex", replace write
				
				if `i' == 6{
					eststo: reg `outcome' `index' if logem != . & lpd1500s !=.
				}
				else {
					eststo: reg `outcome' `index' if `:word 1 of ${iv`i'}' !=.
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
				
				file open f21 using "old/coefs/`outcome'_col`colnum'_ols_coef.tex", replace write
				file open f22 using "old/coefs/`outcome'_col`colnum'_ols_se.tex", replace write
				file open f23 using "old/coefs/`outcome'_col`colnum'_ols_coef_abs.tex", replace write

				if `i' == 6{
					eststo: reg `outcome' `index' `covariates' if logem != . & lpd1500s !=.
				}
				else {
					eststo: reg `outcome' `index' `covariates' if `:word 1 of ${iv`i'}' !=.
				
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
	
	if `count' == 4{
		local last "stats(N, labels("N")) prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')"

	}
	else {
		local last "noobs"
	}
	
	esttab using "old/table_happiness_panelB`count'.tex", ///
	replace label b(a1) se(a1) `last' ///
	nodepvars nogaps nonotes nostar mlabels(none) keep(`index') ///
	
	local count = `count' + 1
}

include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use("old/table_happiness_panelB1.tex" "old/table_happiness_panelB2.tex" "old/table_happiness_panelB3.tex" "old/table_happiness_panelB4.tex") paneltitles("Mean Growth Rate Life Ladder 2011-2020" "Mean Growth Rate Positive Affect 2011-2020" "Mean Growth Rate Life Ladder 2020-2022" "Mean Growth Rate Positive Affect 2020-2022") columncount(13) save("old/table_happiness_panelB.tex") cleanup
