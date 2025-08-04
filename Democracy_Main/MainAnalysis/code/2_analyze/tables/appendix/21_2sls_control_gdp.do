*************************************************************************************************
* Table : 2SLS with additional control for GDP per capita at baseline 
*************************************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use ${path_data}/total.dta, replace

drop if ${outcome2}==. | ${outcome1}==.
drop if gdppc2019==. | gdppc2000==.

************************************ Panel A: No Control for Baseline GDP
************************************ Y: Mean GDP growth rate in 2001-2019

eststo clear 
forv i = 1/6{
		eststo: ivregress 2sls ${outcome1} (${dem2000}=${iv`i'})${weight2000}, vce(robust)
		eststo: ivregress 2sls ${outcome1} ${base_covariates2000} (${dem2000}=${iv`i'})${weight2000}, vce(robust)
}

esttab using ${path_output}/appendix/21_2sls_control_gdp_panel1.tex, ///
keep(${dem2000}) ///
replace label b(a1) se(a1) noobs nodepvars nogaps nonotes mlabels(none) nostar ///


// local count = 1
// local outcomes ${outcome1} ${outcome2}

// foreach outcome of local outcomes{
// 	eststo clear 
// 	forv i = 1/6{
// 			eststo: ivregress 2sls `outcome' (${dem2000}=${iv`i'})${weight2000}, vce(robust)
// 			eststo: ivregress 2sls `outcome' ${base_covariates2000} (${dem2000}=${iv`i'})${weight2000}, vce(robust)
// 	}	
// 	esttab using ${path_appendix}/6_2sls_control_gdp_panel`count'.tex, ///
// 	keep(${dem2000}) ///
// 	replace label b(a1) se(a1) noobs nodepvars nogaps nonotes mlabels(none) nostar
	
// 	local count = `count'+1
// }

// include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
// panelcombine, use(${path_appendix}/6_2sls_control_gdp_panel1.tex ${path_appendix}/6_2sls_control_gdp_panel2.tex) paneltitles("`: var label `:word 1 of `outcomes'''" "`: var label `:word 2 of `outcomes'''") columncount(13) save(${path_appendix}/6_2sls_control_gdp_panelA.tex) cleanup

************************************ Panel A: No Control for Baseline GDP
************************************ Y: GDP growth rate in 2020
eststo clear 
forv i = 1/6{
		eststo: ivregress 2sls ${outcome2} (${dem2019}=${iv`i'})${weight2019}, vce(robust)
		eststo: ivregress 2sls ${outcome2} ${base_covariates2019} (${dem2019}=${iv`i'})${weight2019}, vce(robust)
	}
	
esttab using ${path_output}/appendix/21_2sls_control_gdp_panel2.tex, ///
keep(${dem2019}) ///
replace label b(a1) se(a1) noobs nodepvars nogaps nonotes mlabels(none) nostar ///

include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use(${path_output}/appendix/21_2sls_control_gdp_panel1.tex ${path_output}/appendix/21_2sls_control_gdp_panel2.tex) paneltitles("Mean GDP Growth Rate in 2001-2019" "Mean GDP Growth Rate in 2020-2022") columncount(13) save(${path_output}/appendix/21_2sls_control_gdp_panelA.tex) cleanup


// local count = 1
// local outcomes ${outcome1} ${outcome2}

// foreach outcome of local outcomes{
// 	eststo clear 
// 	forv i = 1/6{
// 			eststo: ivregress 2sls `outcome' (${dem2000}=${iv`i'})${weight2000}, vce(robust)
// 			eststo: ivregress 2sls `outcome' ${base_covariates2000} (${dem2000}=${iv`i'})${weight2000}, vce(robust)
// 	}	
// 	esttab using ${path_appendix}/6_2sls_control_gdp_panel`count'.tex, ///
// 	keep(${dem2000}) ///
// 	replace label b(a1) se(a1) noobs nodepvars nogaps nonotes mlabels(none) nostar
	
// 	local count = `count'+1
// }

// include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
// panelcombine, use(${path_appendix}/6_2sls_control_gdp_panel1.tex ${path_appendix}/6_2sls_control_gdp_panel2.tex) paneltitles("`: var label `:word 1 of `outcomes'''" "`: var label `:word 2 of `outcomes'''") columncount(13) save(${path_appendix}/6_2sls_control_gdp_panelA.tex) cleanup

************************************ Panel B: Control for GDP Per Capita
************************************ Y: Mean GDP growth rate in 2001-2019
eststo clear 
forv i = 1/6{
		eststo: ivregress 2sls ${outcome1} gdppc2000 (${dem2000}=${iv`i'})${weight2000}, vce(robust)
		eststo: ivregress 2sls ${outcome1} gdppc2000 ${base_covariates2000} (${dem2000}=${iv`i'})${weight2000}, vce(robust)
}

esttab using ${path_output}/appendix/21_2sls_control_gdp_panel1.tex, ///
keep(${dem2000}) ///
replace label b(a1) se(a1) noobs nodepvars nogaps nonotes mlabels(none) nostar ///

************************************ Panel B: Control for GDP per Capita
************************************ Y: mean GDP growth rate in 2020-2022


eststo clear 
forv i = 1/6{
		eststo: ivregress 2sls ${outcome2} gdppc2019 (${dem2019}=${iv`i'})${weight2019}, vce(robust)
		eststo: ivregress 2sls ${outcome2} gdppc2019 ${base_covariates2019} (${dem2019}=${iv`i'})${weight2019}, vce(robust)
	}
	
esttab using ${path_output}/appendix/21_2sls_control_gdp_panel2.tex, ///
keep(${dem2019}) ///
replace label b(a1) se(a1) noobs nodepvars nogaps nonotes mlabels(none) nostar ///

include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use(${path_output}/appendix/21_2sls_control_gdp_panel1.tex ${path_output}/appendix/21_2sls_control_gdp_panel2.tex) paneltitles("Mean GDP Growth Rate in 2001-2019" "Mean GDP Growth Rate in 2020-2022") columncount(13) save(${path_output}/appendix/21_2sls_control_gdp_panelB.tex) cleanup


************************************ Panel C: Control for total GDP
************************************ Y: Mean GDP growth rate in 2001-2019

eststo clear 
forv i = 1/6{
		eststo: ivregress 2sls ${outcome1} total_gdp2000 (${dem2000}=${iv`i'})${weight2000}, vce(robust)
		eststo: ivregress 2sls ${outcome1} total_gdp2000 ${base_covariates2000} (${dem2000}=${iv`i'})${weight2000}, vce(robust)
	}
	
esttab using ${path_output}/appendix/21_2sls_control_gdp_panel1.tex, ///
keep(${dem2000}) ///
replace label b(a1) se(a1) noobs nodepvars nogaps nonotes mlabels(none) nostar ///

************************************ Panel C: Control for total GDP
************************************ Y: Mean GDP growth rate in 2020-2022


eststo clear 
forv i = 1/6{
		eststo: ivregress 2sls ${outcome2} total_gdp2019 (${dem2019}=${iv`i'})${weight2019}, vce(robust)
		eststo: ivregress 2sls ${outcome2} total_gdp2019 ${base_covariates2019} (${dem2019}=${iv`i'})${weight2019}, vce(robust)
	}
	
esttab using ${path_output}/appendix/21_2sls_control_gdp_panel2.tex, ///
keep(${dem2019}) ///
replace label b(a1) se(a1) obslast nodepvars nogaps nonotes mlabels(none) nostar ///
stats(N, labels("N") fmt(0)) prefoot(`" \hline \\[-1.8ex] IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals}  & \multicolumn{2}{c}{all IVs}\\ Baseline Controls Other Than Baseline GDP & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')


include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use(${path_output}/appendix/21_2sls_control_gdp_panel1.tex ${path_output}/appendix/21_2sls_control_gdp_panel2.tex) paneltitles("Mean GDP Growth Rate in 2001-2019" "Mean GDP Growth Rate in 2020-2022") columncount(13) save(${path_output}/appendix/21_2sls_control_gdp_panelC.tex) cleanup


	
