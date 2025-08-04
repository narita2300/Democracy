********************************************************************************
* Table 2: 2SLS Regression Estimates of Democracy's Effects
********************************************************************************
clear 

*** Load data 
use ${path_data}/total.dta, replace

drop if countries == "France" | countries =="United States" | countries == "Germany" | countries == "Japan" | countries == "United Kingdom" | countries == "Canada" | countries == "Italy"

******************************************
*** Panel A: 2SLS on Covid-19 Outcomes *** 
local outcomes ${outcome1} ${outcome2} ${outcome3} 

************************************ First row
************************************ Y: Mean GDP growth rate in 2001-2019
//democracy's effect on mean GDP growth rate in 2001-2019
eststo clear
forv i = 1/6{
		eststo: ivregress 2sls ${outcome1}  (${dem2000}=${iv`i'})${weight2000}, vce(robust)
		eststo: ivregress 2sls ${outcome1}  ${base_covariates2000} (${dem2000}=${iv`i'})${weight2000}, vce(robust)
}
esttab using 14_2sls_remove_g7_panel1.tex, ///
	append label b(a1) se(a1) noobs nostar ///
	nodepvars nogaps nonotes mlabels(none) keep(${dem2000}) ///

************************************ Second row
************************************ Y: GDP growth rates in 2020
eststo clear
forv i = 1/6{
			eststo: ivregress 2sls  ${outcome2} (${dem2019}=${iv`i'}) ${weight2019}, vce(robust)
			eststo: ivregress 2sls  ${outcome2} ${base_covariates2019} (${dem2019}=${iv`i'})${weight2019}, vce(robust)
}

esttab using 14_2sls_remove_g7_panel2.tex, ///
	replace label b(a1) se(a1) noobs nostar ///
	nodepvars nogaps nonotes mlabels(none) keep(${dem2019}) ///
	
***************************************Third row 
************************************ Y: Nightime Light Intensity Growth Rate
// Third row: democracy's effect on Nightime Light Intensity Growth Rate 2001 - 2013	
	eststo clear
forv i = 1/6{
		eststo: ivregress 2sls  ${outcome3}  (${dem2000}=${iv`i'})${weight2000}, vce(robust)
		eststo: ivregress 2sls ${outcome3} ${base_covariates2000} (${dem2000}=${iv`i'})${weight2000}, vce(robust)
}
esttab using 14_2sls_remove_g7_panel3.tex, ///
	append label b(a1) se(a1) stats(N, fmt(0) labels("N")) nostar ///
	nodepvars nogaps nonotes mlabels(none) keep(${dem2000}) ///
	prefoot(`" \hline \\[-1.8ex] IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs}  \\ Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') 
	
	
include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use(14_2sls_remove_g7_panel1.tex 14_2sls_remove_g7_panel2.tex 14_2sls_remove_g7_panel3.tex) paneltitles("Dependent Variable is Mean GDP Growth Rate in 2001-2019" "Dependent Variable is Mean GDP Growth Rate in 2020-2022" "Dependent Variable is Mean Nighttime Light Intensity Growth Rate in 2001-2013") columncount(13) save(14_2sls_remove_g7.tex) cleanup
