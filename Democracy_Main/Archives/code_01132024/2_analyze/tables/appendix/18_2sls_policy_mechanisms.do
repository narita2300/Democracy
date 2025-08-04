
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use ${path_data}/total.dta, replace

drop if containmenthealth10==. | coverage10 ==. | days_betw_10th_case_and_policy ==.

******************************************
*** Panel A: 2SLS on Covid-19 Outcomes *** 
******************************************
local outcomes containmenthealth10 coverage10 days_betw_10th_case_and_policy

************************************ First row
************************************ Y: Mean GDP growth rate in 2001-2019
//democracy's effect on mean GDP growth rate in 2001-2019
eststo clear
forv i = 1/6{
		eststo: ivregress 2sls containmenthealth10 (${dem2019}=${iv`i'})${weight2019}, vce(robust)
		eststo: ivregress 2sls containmenthealth10 ${base_covariates2019} (${dem2019}=${iv`i'})${weight2019}, vce(robust)
}
esttab using ${path_appendix}/18_policy_mechanisms_panel1.tex, ///
	append label b(a1) se(a1) noobs nostar ///
	nodepvars nogaps nonotes mlabels(none) keep(${dem2019}) ///

include "${path_code}/2_analyze/tables/PanelCombine_simplest.do"
panelcombine, use(${path_appendix}/18_policy_mechanisms_panel1.tex) paneltitles(" ") columncount(13) save(${path_appendix}/18_policy_mechanisms_panelA.tex) cleanup

	
************************************ Second row
************************************ Y: GDP growth rates in 2020
eststo clear
forv i = 1/6{
			eststo: ivregress 2sls coverage10 (${dem2019}=${iv`i'}) ${weight2019}, vce(robust)
			eststo: ivregress 2sls coverage10 ${base_covariates2019} (${dem2019}=${iv`i'})${weight2019}, vce(robust)
}

esttab using ${path_appendix}/18_policy_mechanisms_panel2.tex, ///
	replace label b(a1) se(a1) noobs nostar ///
	nodepvars nogaps nonotes mlabels(none) keep(${dem2019}) ///

include "${path_code}/2_analyze/tables/PanelCombine_simplest.do"
panelcombine, use(${path_appendix}/18_policy_mechanisms_panel2.tex) paneltitles(" ") columncount(13) save(${path_appendix}/18_policy_mechanisms_panelB.tex) cleanup

************************************ Third row
************************************ Y: Covid-19 Deaths Per Million in 2020
// Third row: democracy's effect on Total Covid-19 Deaths Per Million in 2020		
eststo clear
forv i = 1/6{
		eststo: ivregress 2sls days_betw_10th_case_and_policy (${dem2019}=${iv`i'})${weight2019}, vce(robust)
		eststo: ivregress 2sls days_betw_10th_case_and_policy ${base_covariates2019} (${dem2019}=${iv`i'})${weight2019}, vce(robust)
}

esttab using ${path_appendix}/18_policy_mechanisms_panel3.tex, ///
	append label b(a1) se(a1) stats(N, fmt(0) labels("N")) nostar ///
	nodepvars nogaps nonotes mlabels(none) keep(${dem2019}) ///
	prefoot(`" \hline \\[-1.8ex] IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals}  & \multicolumn{2}{c}{all IVs} \\ Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark  & \xmark & \cmark\\"') 
	
include "${path_code}/2_analyze/tables/PanelCombine_simplest.do"
panelcombine, use(${path_appendix}/18_policy_mechanisms_panel3.tex) paneltitles(" ") columncount(13) save(${path_appendix}/18_policy_mechanisms_panelC.tex) cleanup
	
// include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
// panelcombine, use(${path_appendix}/18_policy_mechanisms_panel1.tex ${path_appendix}/18_policy_mechanisms_panel2.tex ${path_appendix}/18_policy_mechanisms_panel3.tex) paneltitles("`: var label `:word 1 of `outcomes'''" "`: var label `:word 2 of `outcomes'''" "`: var label `:word 3 of `outcomes'''") columncount(11) save(${path_appendix}/18_policy_mechanisms.tex) cleanup
