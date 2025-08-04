
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use ${path_data}/total.dta, replace

*******************************
******************************* Baseline results: GDP Growth Rate in 2020

local title "GDP Growth Rate in 2020"
local var gdp_growth2020
local baseline 2019
eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (${dem`baseline'}=${iv`i'})${weight`baseline'}, vce(robust)
	}
	coefplot (m1,  keep(${dem`baseline'}) rename(${dem`baseline'} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
	(m2, keep(${dem`baseline'}) rename(${dem`baseline'} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m3, keep(${dem`baseline'}) rename(${dem`baseline'} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m3, keep(${dem`baseline'}) rename(${dem`baseline'} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m4, keep(${dem`baseline'}) rename(${dem`baseline'} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m5, keep(${dem`baseline'}) rename(${dem`baseline'} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	,xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on `title'")  xscale(range(-5 5)) xlabel(-5(1)5)
graph export ${path_presentation}/`var'_coef_plot_no_controls.png, as(png) name("Graph") replace

local title "GDP Growth Rate in 2020"
local var gdp_growth2020
local baseline 2019

eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (${dem`baseline'}=${iv`i'}) ${base_covariates`baseline'}${weight`baseline'}, vce(robust)
	}
	coefplot (m1,  keep(${dem`baseline'}) rename(${dem`baseline'} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
	(m2, keep(${dem`baseline'}) rename(${dem`baseline'} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m3, keep(${dem`baseline'}) rename(${dem`baseline'} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m3, keep(${dem`baseline'}) rename(${dem`baseline'} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m4, keep(${dem`baseline'}) rename(${dem`baseline'} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m5, keep(${dem`baseline'}) rename(${dem`baseline'} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	,xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on `title'")  xscale(range(-5 5)) xlabel(-5(1)5)
graph export ${path_presentation}/`var'_coef_plot_baseline_controls.png, as(png) name("Graph") replace

*******************************
******************************* Baseline results: Mean GDP Growth Rate in 2001-2019
local title "Mean GDP Growth Rate in 2001-2019"
local var mean_growth_rate_2001_2019
local baseline 2000

eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (${dem`baseline'}=${iv`i'}) ${weight`baseline'}, vce(robust)
	}
	coefplot (m1,  keep(${dem`baseline'}) rename(${dem`baseline'} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
	(m2, keep(${dem`baseline'}) rename(${dem`baseline'} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m3, keep(${dem`baseline'}) rename(${dem`baseline'} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m3, keep(${dem`baseline'}) rename(${dem`baseline'} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m4, keep(${dem`baseline'}) rename(${dem`baseline'} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m5, keep(${dem`baseline'}) rename(${dem`baseline'} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	,xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on `title'")  
graph export ${path_presentation}/`var'_coef_plot_no_controls.png, as(png) name("Graph") replace


local title "Mean GDP Growth Rate in 2001-2019"
local var mean_growth_rate_2001_2019
local baseline 2000

eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (${dem`baseline'}=${iv`i'}) ${base_covariates`baseline'}${weight`baseline'}, vce(robust)
	}
	coefplot (m1,  keep(${dem`baseline'}) rename(${dem`baseline'} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
	(m2, keep(${dem`baseline'}) rename(${dem`baseline'} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m3, keep(${dem`baseline'}) rename(${dem`baseline'} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m3, keep(${dem`baseline'}) rename(${dem`baseline'} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m4, keep(${dem`baseline'}) rename(${dem`baseline'} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m5, keep(${dem`baseline'}) rename(${dem`baseline'} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	,xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on `title'")  
graph export ${path_presentation}/`var'_coef_plot_baseline_controls.png, as(png) name("Graph") replace

*******************************
******************************* Baseline results: Total Deaths Per Million in 2020

local title "Covid-19 Deaths Per Million in 2020"
local var total_deaths_per_million
local baseline 2019

eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (${dem`baseline'}=${iv`i'}) ${weight`baseline'}, vce(robust)
	}
	coefplot (m1,  keep(${dem`baseline'}) rename(${dem`baseline'} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
	(m2, keep(${dem`baseline'}) rename(${dem`baseline'} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m3, keep(${dem`baseline'}) rename(${dem`baseline'} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m3, keep(${dem`baseline'}) rename(${dem`baseline'} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m4, keep(${dem`baseline'}) rename(${dem`baseline'} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m5, keep(${dem`baseline'}) rename(${dem`baseline'} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	,xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on `title'") xscale(range(-100 700))   xlabel(-100(100)700)
graph export ${path_presentation}/`var'_coef_plot_no_controls.png, as(png) name("Graph") replace

local title "Covid-19 Deaths Per Million in 2020"
local var total_deaths_per_million
local baseline 2019

eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (${dem`baseline'}=${iv`i'}) ${base_covariates`baseline'}${weight`baseline'}, vce(robust)
	}
	coefplot (m1,  keep(${dem`baseline'}) rename(${dem`baseline'} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
	(m2, keep(${dem`baseline'}) rename(${dem`baseline'} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m3, keep(${dem`baseline'}) rename(${dem`baseline'} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m3, keep(${dem`baseline'}) rename(${dem`baseline'} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m4, keep(${dem`baseline'}) rename(${dem`baseline'} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m5, keep(${dem`baseline'}) rename(${dem`baseline'} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	,xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on `title'") xscale(range(-100 700))   xlabel(-100(100)700)
graph export ${path_presentation}/`var'_coef_plot_baseline_controls.png, as(png) name("Graph") replace

// local titles "GDP Growth Rate in 2020" "Mean GDP Growth Rate in 2001-2019" "Covid-19 Deaths Per Million in 2020"
// local vars gdp_growth2020 mean_growth_rate_2001_2019 total_deaths_per_million
// local baselines 2019 2000 2019
// local n:word count "`titles'"

// forvalues i = 1/`n' {
	
// 	local title "`: word `i' of "`titles'"'"
// 	local var "`:word `i' of `vars''"
// 	local baseline "`:word `i' of `baselines''"
	
// 	eststo clear
// 	forv i = 1/5{
// 		eststo m`i': ivregress 2sls `var' (${dem`baseline'}=${iv`i'}) ${base_covariates`baseline'}${weight`baseline'}, vce(robust)
// 	}
// 	coefplot (m1,  keep(${dem`baseline'}) rename(${dem`baseline'} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
// 	(m2, keep(${dem`baseline'}) rename(${dem`baseline'} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
// 	(m3, keep(${dem`baseline'}) rename(${dem`baseline'} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
// 	(m3, keep(${dem`baseline'}) rename(${dem`baseline'} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m4, keep(${dem`baseline'}) rename(${dem`baseline'} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
// 	(m5, keep(${dem`baseline'}) rename(${dem`baseline'} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
// 	,legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on `title'") 

// 	graph export ${path_presentation}/`var'_coef_plot.png, as(png) name("Graph") replace
// }


*******************************
******************************* Add control for baseline GDP per capita

local title "GDP Growth Rate in 2020"
local var gdp_growth2020
local baseline 2019

eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' gdppc`baseline' (${dem`baseline'}=${iv`i'}) ${weight`baseline'}, vce(robust)
	}
	coefplot (m1,  keep(${dem`baseline'}) rename(${dem`baseline'} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
	(m2, keep(${dem`baseline'}) rename(${dem`baseline'} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m3, keep(${dem`baseline'}) rename(${dem`baseline'} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m4, keep(${dem`baseline'}) rename(${dem`baseline'} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m5, keep(${dem`baseline'}) rename(${dem`baseline'} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	,xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on `title'")  xscale(range(-10 5)) xlabel(-10(5)5)
graph export ${path_presentation}/`var'_coef_plot_control_gdppc.png, as(png) name("Graph") replace
// 	(m3, keep(${dem`baseline'}) rename(${dem`baseline'} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///

local title "Mean GDP Growth Rate in 2001-2019"
local var mean_growth_rate_2001_2019
local baseline 2000

eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' gdppc`baseline' (${dem`baseline'}=${iv`i'}) ${weight`baseline'}, vce(robust)
	}
	coefplot (m1,  keep(${dem`baseline'}) rename(${dem`baseline'} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
	(m2, keep(${dem`baseline'}) rename(${dem`baseline'} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m3, keep(${dem`baseline'}) rename(${dem`baseline'} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m4, keep(${dem`baseline'}) rename(${dem`baseline'} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m5, keep(${dem`baseline'}) rename(${dem`baseline'} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	,xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on `title'")  xscale(range(-10 5)) xlabel(-10(5)5)
graph export ${path_presentation}/`var'_coef_plot_control_gdppc.png, as(png) name("Graph") replace
// 	(m3, keep(${dem`baseline'}) rename(${dem`baseline'} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///



// local titles "GDP Growth Rate in 2020" "Mean GDP Growth Rate in 2001-2019" 
// local vars gdp_growth2020 mean_growth_rate_2001_2019
// local baselines 2019 2000
// local n:word count "`titles'"

// forvalues i = 1/`n' {
	
// 	local title "`: word `i' of "`titles'"'"
// 	local var "`:word `i' of `vars''"
// 	local baseline "`:word `i' of `baselines''"
	
// 	eststo clear
// 	forv i = 1/5{
// 		eststo m`i': ivregress 2sls `var' gdppc`baseline' (${dem`baseline'}=${iv`i'}) ${weight`baseline'}, vce(robust)
// 	}
// 	coefplot (m1,  keep(${dem`baseline'}) rename(${dem`baseline'} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
// 	(m2, keep(${dem`baseline'}) rename(${dem`baseline'} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
// 	(m3, keep(${dem`baseline'}) rename(${dem`baseline'} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m4, keep(${dem`baseline'}) rename(${dem`baseline'} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
// 	(m5, keep(${dem`baseline'}) rename(${dem`baseline'} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
// 	, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on `title'") 

// 	graph export ${path_presentation}/`var'_coef_plot_control_gdp.png, as(png) name("Graph") replace
// }
// // 	(m3, keep(${dem`baseline'}) rename(${dem`baseline'} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///


*******************************
******************************* Placebo checks for 1980s and 1990s

local titles "Mean GDP Growth Rate in 1981-1990" "Mean GDP Growth Rate in 1991-2000"
local vars mean_growth_rate_1981_1990 mean_growth_rate_1991_2000
local baselines 1980 1990
local n:word count "`titles'"

forvalues i = 1/`n' {
	local title "`: word `i' of "`titles'"'"
	local var "`:word `i' of `vars''"
	local baseline "`:word `i' of `baselines''"
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (democracy_vdem`baseline'=${iv`i'}) [w=total_gdp`baseline'], vce(robust)
	}
		coefplot (m1,  keep(democracy_vdem`baseline') rename(democracy_vdem`baseline' = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
	(m2, keep(democracy_vdem`baseline') rename(democracy_vdem`baseline' = "Language & Trade IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m4, keep(democracy_vdem`baseline') rename(democracy_vdem`baseline' = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m5, keep(democracy_vdem`baseline') rename(democracy_vdem`baseline' = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on `title'") 

	graph export ${path_presentation}/`var'_coef_plot.png, as(png) name("Graph") replace
}

// 	(m3, keep(democracy_vdem`baseline') rename(democracy_vdem`baseline' = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///



*******************************
******************************* Mechanisms: Investment Share

local title "Investment Share of GDP"
local var mean_investment_2001_2019
local baseline 2000

eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (${dem`baseline'}=${iv`i'}) ${weight`baseline'}, vce(robust)
	}
	coefplot (m1,  keep(${dem`baseline'}) rename(${dem`baseline'} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
	(m2, keep(${dem`baseline'}) rename(${dem`baseline'} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m3, keep(${dem`baseline'}) rename(${dem`baseline'} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m4, keep(${dem`baseline'}) rename(${dem`baseline'} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m5, keep(${dem`baseline'}) rename(${dem`baseline'} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	,xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on `title'") xscale(range(-15 5)) xlabel(-15(5)5)
graph export ${path_presentation}/`var'_coef_plot.png, as(png) name("Graph") replace

// ${base_covariates`baseline'} 


*******************************
******************************* Mechanisms: Import Value Index

local title "Import Value Index (2000=100)"
local var mean_import_value_2001_2019
local baseline 2000

eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (${dem`baseline'}=${iv`i'}) ${weight`baseline'}, vce(robust)
	}
	coefplot (m1,  keep(${dem`baseline'}) rename(${dem`baseline'} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
	(m2, keep(${dem`baseline'}) rename(${dem`baseline'} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m3, keep(${dem`baseline'}) rename(${dem`baseline'} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m4, keep(${dem`baseline'}) rename(${dem`baseline'} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m5, keep(${dem`baseline'}) rename(${dem`baseline'} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	,xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on `title'") xscale(range(-200 100)) xlabel(-200(100)100)
graph export ${path_presentation}/`var'_coef_plot.png, as(png) name("Graph") replace


*******************************
******************************* Mechanisms: Export Value Index

local title "Export Value Index (2000=100)"
local var mean_export_value_2001_2019
local baseline 2000

eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (${dem`baseline'}=${iv`i'}) ${weight`baseline'}, vce(robust)
	}
	coefplot (m1,  keep(${dem`baseline'}) rename(${dem`baseline'} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
	(m2, keep(${dem`baseline'}) rename(${dem`baseline'} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m3, keep(${dem`baseline'}) rename(${dem`baseline'} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m4, keep(${dem`baseline'}) rename(${dem`baseline'} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m5, keep(${dem`baseline'}) rename(${dem`baseline'} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	,xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on `title'") xscale(range(-200 100)) xlabel(-200(100)100)
graph export ${path_presentation}/`var'_coef_plot.png, as(png) name("Graph") replace


*******************************
******************************* Mechanisms: Value Added, Manufcaturing

local title "Manufacturing Value Added (Annual % Growth)"
local var mean_manu_va_growth_2001_2019
local baseline 2000

eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (${dem`baseline'}=${iv`i'}) ${weight`baseline'}, vce(robust)
	}
	coefplot (m1,  keep(${dem`baseline'}) rename(${dem`baseline'} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
	(m2, keep(${dem`baseline'}) rename(${dem`baseline'} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m3, keep(${dem`baseline'}) rename(${dem`baseline'} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m4, keep(${dem`baseline'}) rename(${dem`baseline'} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m5, keep(${dem`baseline'}) rename(${dem`baseline'} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	,xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on `title'") xscale(range(-5 5)) xlabel(-5(0)5)
graph export ${path_presentation}/`var'_coef_plot.png, as(png) name("Graph") replace

*******************************
******************************* Mechanisms: Value Added, Manufcaturing

local title "Services Value Added (Annual % Growth)"
local var mean_serv_va_growth_2001_2019
local baseline 2000

eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (${dem`baseline'}=${iv`i'}) ${weight`baseline'}, vce(robust)
	}
	coefplot (m1,  keep(${dem`baseline'}) rename(${dem`baseline'} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
	(m2, keep(${dem`baseline'}) rename(${dem`baseline'} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m3, keep(${dem`baseline'}) rename(${dem`baseline'} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m4, keep(${dem`baseline'}) rename(${dem`baseline'} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	(m5, keep(${dem`baseline'}) rename(${dem`baseline'} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
	,xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on `title'") xscale(range(-5 5)) xlabel(-5(0)5)
graph export ${path_presentation}/`var'_coef_plot.png, as(png) name("Graph") replace




