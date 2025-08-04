********************************************************************************
* Table 2: 2SLS Regression Estimates of Democracy's Effects
********************************************************************************
clear 

*** Load data 
use ${path_data}/total.dta, replace

******************************************
*** Panel A: 2SLS on Covid-19 Outcomes *** 
******************************************


local count = 1
local outcomes mean_gdppc_growth_2001_2019 mean_gdppc_growth_2020_2022 mean_g_night_lightpc_2001_2013
 //local outcomes ${outcome1} ${outcome2} mean_g_night_lightpc_2001_2013


foreach outcome of local outcomes{
	
	if "`outcome'" == "mean_gdppc_growth_2020_2022" {
		local weight "${weight2019}"
		local covariates "${base_covariates2019}"
		local index "${dem2019}"
	}
	
	else if "`outcome'" == "mean_gdppc_growth_2001_2019"| "`outcome'" == "mean_g_night_lightpc_2001_2013" {
		local weight "${weight2000}"
		local covariates "${base_covariates2000}"
		local index "${dem2000}"
	}
	
	eststo clear
	forv i = 1/6{
				
				eststo: ivreg2 `outcome' (`index'=${iv`i'}) `weight', robust
				scalar fstat = e(widstat)
				estadd scalar fs = fstat
	
				eststo: ivreg2 `outcome' `covariates' (`index'=${iv`i'}) `weight', robust
				scalar fstat = e(widstat)
				estadd scalar fs = fstat
	}
	
	if `count' == 3{
		local last "prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"')"
	}
	else {
		local last "noobs"
	}
	
	esttab using table2_pc_panelA`count'.tex, ///
	replace label cells("b(fmt(1))" "se(par fmt(1))" "p(fmt(1))")  `last' ///
	nodepvars nogaps nonotes nostar mlabels(none) keep(`index') ///
	
	local count = `count' + 1
}

include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use(table2_pc_panelA1.tex table2_pc_panelA2.tex table2_pc_panelA3.tex ) paneltitles("Mean Per-Capita GDP Growth Rate in 2001-2019" "Mean Per-Capita GDP Growth Rate in 2020-2022" "Mean Per-Capita Nighttime Light Intensity Growth Rate in 2001-2013") columncount(13) save($path_output/appendix/table2_pc_panelA.tex) cleanup

******************************************
*** Panel B: OLS on Covid-19 Outcomes *** 
******************************************

// local outcomes mean_gdppc_growth_2001_2019 gdppc_growth2020 total_deaths_per_million
local count = 1

foreach outcome of local outcomes{
	
	if "`outcome'" == "mean_gdppc_growth_2020_2022" {
		local weight "${weight2019}"
		local covariates "${base_covariates2019}"
		local index "${dem2019}"
	}
	
	else if "`outcome'" == "mean_gdppc_growth_2001_2019"  |"`outcome'" == "mean_g_night_lightpc_2001_2013"  {
		local weight "${weight2000}"
		local covariates "${base_covariates2000}"
		local index "${dem2000}"
	}
	
	eststo clear
	forv i = 1/6{
		
				local colnum = (`i'-1)*2 + 1
				if `i' == 6{
					eststo: reg `outcome' `index' if logem != . & lpd1500s !=. & legor_uk !=. & EurFrac !=. & bananas!=. & copper !=. `weight', vce(robust)
				}
				else {
					eststo: reg `outcome' `index' if `:word 1 of ${iv`i'}' !=. `weight', vce(robust)
				}
				
				local colnum = (`i'-1)*2 + 2
				
				if `i' == 6{
					eststo: reg `outcome' `index' `covariates' if logem != . & lpd1500s !=. & legor_uk !=. & EurFrac !=. & bananas!=. & copper !=. `weight', vce(robust)
				}
				else {
					eststo: reg `outcome' `index' `covariates' if `:word 1 of ${iv`i'}' !=. `weight', vce(robust)
				
				}
	}
	
	if `count' == 3{
		local last "stats(N, labels("N")) prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')"

	}
	else {
		local last "noobs"
	}
	
	esttab using table2_pc_panelB`count'.tex, ///
	replace label b(a1) se(a1) `last' ///
	nodepvars nogaps nonotes nostar mlabels(none) keep(`index') ///
	
	local count = `count' + 1
}

include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use(table2_pc_panelB1.tex table2_pc_panelB2.tex table2_pc_panelB3.tex) paneltitles("Mean Per-Capita GDP Growth Rate in 2001-2019" "Mean Per-Capita GDP Growth Rate in 2020-2022" "Mean Per-Capita Nighttime Light Intensity Growth Rate in 2001-2013") columncount(13) save($path_output/appendix/table2_pc_panelB.tex) cleanup
