cap ssc install ivreg2, replace
cap ssc install ranktest, replace

global main_path "/Users/leonardofancello/Dropbox"
global path_code "${main_path}/Democracy/Democracy_Main/MainAnalysis/code"
global path_data "${main_path}/Democracy/Democracy_Main/MainAnalysis/output/data"
global path_output "${main_path}/Democracy/Democracy_Main/MainAnalysis/output/tables"
global path_coefs "${path_output}/coefs"

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

********************************************************************************
* Table: 2SLS Regression Estimates of Democracy's Effects
********************************************************************************

*** Change to appropriate directory
cd "${path_output}"
cap mkdir "old"

*** Load data
use "${path_data}/total.dta", replace

*********************************
*** Panel A: 2SLS on Outcomes *** 
*********************************

local count = 1
local outcomes mean_bot50_inc_shr_2001_2019 mean_bot50_inc_shr_2020_2021

foreach outcome of local outcomes{
	
	if "`outcome'" == "mean_bot50_inc_shr_2001_2019" {
		local weight "[w=total_gdp2000]"
		local covariates "${base_covariates2000}"
		local index "democracy_vdem2000"
	}
	else {
		local weight "[w=total_gdp2019]"
		local covariates "${base_covariates2019}"
		local index "democracy_vdem2019"
	}
	
	eststo clear
	forv i = 1/6{
		
				// without controls
				eststo: ivreg2 `outcome' (`index'=${iv`i'}) `weight', robust
				scalar fstat = e(widstat)
				estadd scalar fs = fstat

				// with controls 
				eststo: ivreg2 `outcome' `covariates' (`index'=${iv`i'}) `weight', robust
				scalar fstat = e(widstat)
				estadd scalar fs = fstat
	}
	
	if `count' == 2{
		local last "stats(fs, fmt(1 1) labels("F-Statistic (First stage)")) prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"')"

	}
	else {
		local last "noobs"
	}
	
	esttab using "old/table_bot_income_panelA`count'.tex", ///
	replace label cells("b(fmt(1))" "se(par fmt(1))" "p(fmt(2))")  `last' ///
	nodepvars nogaps nonotes nostar mlabels(none) keep(`index') ///
	
	local count = `count' + 1
}

include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use("old/table_bot_income_panelA1.tex" "old/table_bot_income_panelA2.tex") paneltitles("Growth Rate Mean Bot 50\% Income Share in 2001-2019" "Growth Rate Mean Bot 50\% Income Share in 2020-2021") columncount(13) save("old/table_bot_income_panelA.tex") cleanup

********************************
*** Panel B: OLS on Outcomes *** 
********************************

local count = 1

foreach outcome of local outcomes{
	
	if "`outcome'" == "mean_bot50_inc_shr_2001_2019" {
		local weight "[w=total_gdp2000]"
		local covariates "${base_covariates2000}"
		local index "democracy_vdem2000"
	}
	else {
		local weight "[w=total_gdp2019]"
		local covariates "${base_covariates2019}"
		local index "democracy_vdem2019"
	}
	
	eststo clear
	forv i = 1/6{

				if `i' == 6{
					eststo: reg `outcome' `index' if logem != . & lpd1500s !=. & legor_uk !=. & EurFrac !=. & bananas!=. & copper !=. `weight', vce(robust)
				}
				else {
					eststo: reg `outcome' `index' if `:word 1 of ${iv`i'}' !=. `weight', vce(robust)
				}

				if `i' == 6{
					eststo: reg `outcome' `index' `covariates' if logem != . & lpd1500s !=. & legor_uk !=. & EurFrac !=. & bananas!=. & copper !=. `weight', vce(robust)
				}
				else {
					eststo: reg `outcome' `index' `covariates' if `:word 1 of ${iv`i'}' !=. `weight', vce(robust)
				
				}
	}
	
	if `count' == 2{
		local last "stats(N, labels("N")) prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')"

	}
	else {
		local last "noobs"
	}
	
	esttab using "old/table_bot_income_panelB`count'.tex", ///
	replace label b(a1) se(a1) `last' ///
	nodepvars nogaps nonotes nostar mlabels(none) keep(`index') ///
	
	local count = `count' + 1
}

include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use("old/table_bot_income_panelB1.tex" "old/table_bot_income_panelB2.tex") paneltitles("Growth Rate Mean Bot 50\% Income Share in 2001-2019" "Growth Rate Mean Bot 50\% Income Share in 2020-2021") columncount(13) save("old/table_bot_income_panelB.tex") cleanup
