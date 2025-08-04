********************************************************************************
* Table 2: 2SLS Regression Estimates of Democracy's Effects
********************************************************************************
clear 

*** Change to appropriate directory
cd ${path_appendix}

*** Load data 
use ${path_data}/total.dta, replace

******************************************
*** Panel A: 2SLS on Covid-19 Outcomes *** 
******************************************

egen mean_growth_rate_pre_recession = rowmean(gdp_growth2001-gdp_growth2007)
label var mean_growth_rate_pre_recession "Mean GDP Growth Rate in 2001-2007"
egen mean_growth_rate_recession = rowmean(gdp_growth2008-gdp_growth2009)
label var mean_growth_rate_recession "Mean GDP Growth Rate in 2008-2009"
egen mean_growth_rate_post_recession = rowmean(gdp_growth2010-gdp_growth2019)
label var mean_growth_rate_post_recession "Mean GDP Growth Rate in 2010-2019"

local count = 1
// local outcomes mean_gdppc_growth_2001_2019 gdppc_growth2020 total_deaths_per_million
local outcomes mean_growth_rate_pre_recession mean_growth_rate_recession mean_growth_rate_post_recession


foreach outcome of local outcomes{
	
	if "`outcome'" == "mean_growth_rate_pre_recession" {
		local weight "${weight2000}"
		local covariates "${base_covariates2000}"
		local index "${dem2000}"
	}
	
	else if "`outcome'" == "mean_growth_rate_recession" {
		local weight "[w=total_gdp2007]"
		local covariates abs_lat mean_temp_1991_2000 mean_precip_1991_2000 pop_density2007 median_age2005
		local index democracy_vdem2007
	}
	
	else if "`outcome'" == "mean_growth_rate_post_recession" {
		local weight "[w=total_gdp2009]"
		local covariates abs_lat mean_temp_1991_2000 mean_precip_1991_2000 pop_density2009 median_age2005
		local index democracy_vdem2009
	}
	
	eststo clear
	forv i = 1/6{
				
				eststo: ivreg2 `outcome' (`index'=${iv`i'}) `weight', robust
	
				eststo: ivreg2 `outcome' `covariates' (`index'=${iv`i'}) `weight', robust
	}
	
	if `count' == 3{
		local last "prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"')"
	}
	else {
		local last "noobs"
	}
	
	esttab using recession_panelA`count'.tex, ///
	replace label cells("b(fmt(1))" "se(par fmt(1))" "p(fmt(2))")  `last' ///
	nodepvars nogaps nonotes nostar mlabels(none) keep(`index') ///
	
	local count = `count' + 1
}

include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use(recession_panelA1.tex recession_panelA2.tex recession_panelA3.tex) paneltitles("`: var label `:word 1 of `outcomes'''" "`: var label `:word 2 of `outcomes'''" "`: var label `:word 3 of `outcomes'''") columncount(13) save(recession_panelA.tex) cleanup

******************************************
*** Panel B: OLS on Covid-19 Outcomes *** 
******************************************

// local outcomes mean_gdppc_growth_2001_2019 gdppc_growth2020 total_deaths_per_million
local count = 1

foreach outcome of local outcomes{
	
		if "`outcome'" == "mean_growth_rate_pre_recession" {
		local weight "${weight2000}"
		local covariates "${base_covariates2000}"
		local index "${dem2000}"
	}
	
	else if "`outcome'" == "mean_growth_rate_recession" {
		local weight "[w=total_gdp2007]"
		local covariates abs_lat mean_temp_1991_2000 mean_precip_1991_2000 pop_density2007 median_age2005
		local index democracy_vdem2007
	}
	
	else if "`outcome'" == "mean_growth_rate_post_recession" {
		local weight "[w=total_gdp2009]"
		local covariates abs_lat mean_temp_1991_2000 mean_precip_1991_2000 pop_density2009 median_age2005
		local index democracy_vdem2009
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
	
	esttab using recession_panelB`count'.tex, ///
	replace label b(a1) se(a1) `last' ///
	nodepvars nogaps nonotes nostar mlabels(none) keep(`index') ///
	
	local count = `count' + 1
}

include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use(recession_panelB1.tex recession_panelB2.tex recession_panelB3.tex) paneltitles("`: var label `:word 1 of `outcomes'''" "`: var label `:word 2 of `outcomes'''" "`: var label `:word 3 of `outcomes'''") columncount(13) save(recession_panelB.tex) cleanup
