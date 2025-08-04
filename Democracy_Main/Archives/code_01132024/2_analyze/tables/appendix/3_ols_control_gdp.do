
*************************************************************************************************
* Table : 2SLS Regression Estimates of Democracy's Effect By Decade with Control for Baseline GDP 
*************************************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use ${path_data}/total.dta, replace
drop if gdppc2019==. | gdppc2000==.

eststo clear

eststo: reg ${outcome1} ${dem2000} ${weight2000}, vce(robust)
eststo: reg ${outcome1} ${base_covariates2000} ${dem2000} ${weight2000}, vce(robust)

eststo: reg ${outcome1} gdppc2000 ${dem2000} ${weight2000}, vce(robust)
eststo: reg ${outcome1} gdppc2000 ${base_covariates2000} ${dem2000} ${weight2000}, vce(robust)

eststo: reg ${outcome1} total_gdp2000 ${dem2000} ${weight2000}, vce(robust)
eststo: reg ${outcome1} total_gdp2000 ${base_covariates2000} ${dem2000} ${weight2000}, vce(robust)


eststo: reg ${outcome1} gdppc2000 total_gdp2000 ${dem2000} ${weight2000}, vce(robust)
eststo: reg ${outcome1} gdppc2000 total_gdp2000 ${base_covariates2000} ${dem2000} ${weight2000}, vce(robust)


esttab using ${path_dropbox}/tables/appendix/3_ols_control_gdp_panel1.tex, ///
keep(${dem2000}) ///
replace label b(a1) se(a1) noobs nodepvars nogaps nonotes mlabels(none) nostar
	
********************************************************************************

eststo clear

eststo: reg ${outcome2} ${dem2019} ${weight2019}, vce(robust)
eststo: reg ${outcome2} ${base_covariates2019} ${dem2019} ${weight2019}, vce(robust)

eststo: reg ${outcome2} gdppc2019 ${dem2019} ${weight2019}, vce(robust)
eststo: reg ${outcome2} gdppc2019 ${base_covariates2019} ${dem2019} ${weight2019}, vce(robust)

eststo: reg ${outcome2} total_gdp2019 ${dem2019} ${weight2019}, vce(robust)
eststo: reg ${outcome2} total_gdp2019 ${base_covariates2019} ${dem2019} ${weight2019}, vce(robust)

eststo: reg ${outcome2} gdppc2019 total_gdp2019 ${dem2019} ${weight2019}, vce(robust)
eststo: reg ${outcome2} gdppc2019 total_gdp2019 ${base_covariates2019} ${dem2019} ${weight2019}, vce(robust)

esttab using ${path_appendix}/3_ols_control_gdp_panel2.tex, ///
keep(${dem2019}) ///
append label b(a1) se(a1) nodepvars nogaps nonotes mlabels(none) nostar stats(N, labels("N")) prefoot(`"\hline \\[-1.8ex] Baseline Controls Other Than Baseline GDP &  & \cmark &  & \cmark &  & \cmark &  & \cmark \\ Baseline GDP Per Capita Control &  &  & \cmark & \cmark &  &  & \cmark & \cmark \\ Baseline Total GDP Control & &  &  &  & \cmark & \cmark & \cmark & \cmark \\"') 

********************************************************************************

include "${path_code}/2_analyze/tables/PanelCombine.do"
panelcombine, use(${path_appendix}/3_ols_control_gdp_panel1.tex ${path_appendix}/3_ols_control_gdp_panel2.tex) paneltitles("`: var label ${outcome1}'" "`: var label ${outcome2}'") columncount(9) save(${path_appendix}/3_ols_control_gdp.tex) cleanup


