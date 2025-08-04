********************************************************************************
* Table 2: 2SLS Regression Estimates of Democracy's Effects
********************************************************************************
clear 

*** Load data 
use ${path_data}/total.dta, replace

********************************************************
*** 2SLS on Covid-19 Outcomes: Control for Continent *** 
********************************************************

encode continent, generate(cont)

************************************ First row
************************************ Y: Mean GDP growth rate in 2001-2019

eststo clear
forv i = 1/6{
		eststo: ivregress 2sls ${outcome1} i.cont (${dem2000}=${iv`i'})${weight2000}, vce(robust)
		eststo: ivregress 2sls ${outcome1} i.cont ${base_covariates2000} (${dem2000}=${iv`i'})${weight2000}, vce(robust)
}
esttab using ${path_output}/appendix/control_continent_panel1.tex, ///
	append label b(a1) se(a1) ///
	nodepvars noobs nogaps nostar nonotes mlabels(none) keep(${dem2000}) ///

************************************ Second row
************************************ Y: GDP growth rates in 2020

eststo clear
forv i = 1/6{
			eststo: ivregress 2sls ${outcome2} i.cont (${dem2019}=${iv`i'}) ${weight2019}, vce(robust)
			eststo: ivregress 2sls ${outcome2} i.cont ${base_covariates2019} (${dem2019}=${iv`i'})${weight2019}, vce(robust)
}

esttab using ${path_output}/appendix/control_continent_panel2.tex, ///
	replace label b(a1) se(a1) ///
	nodepvars noobs nogaps nostar nonotes mlabels(none) keep(${dem2019}) ///
	
	
************************************ Third row
************************************ Y: Mean nighttime light intesnity growth 2001-2013	

eststo clear
forv i = 1/6{
		eststo: ivregress 2sls ${outcome3} i.cont (${dem2000}=${iv`i'})${weight2000}, vce(robust)
		eststo: ivregress 2sls ${outcome3} i.cont ${base_covariates2000} (${dem2000}=${iv`i'})${weight2000}, vce(robust)
}

esttab using ${path_output}/appendix/control_continent_panel3.tex, ///
	append label b(a1) se(a1) stats(N, labels("N") fmt(0)) ///
	nodepvars noobs nogaps nostar nonotes mlabels(none) keep(${dem2000}) ///
prefoot(`" \hline \\[-1.8ex] IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs}  \\ Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') 


include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use(${path_output}/appendix/control_continent_panel1.tex ${path_output}/appendix/control_continent_panel2.tex ${path_output}/appendix/control_continent_panel3.tex) paneltitles("Mean GDP Growth Rate in 2001-2019" "Mean GDP Growth Rate in 2020-2022" "Mean Nighttime Light Intensity Growth Rate in 2001-2013") columncount(13) save(${path_output}/appendix/23_2sls_control_continent.tex) cleanup

