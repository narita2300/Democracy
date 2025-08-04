********************************************************************************
* Table : 2SLS on difference in growth rates between 2019 and 2020
********************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use ${path_data}/total.dta, replace


************************************ 
************************************ Y: Difference in GDP growth rates between 2019 and 2020

gen growth_rate_diff = gdp_growth2020 - gdp_growth2019
eststo clear 
forv i = 1/5{
		eststo: ivreg2 growth_rate_diff (${dem2019}=${iv`i'}) ${weight2019}, robust
		eststo: ivreg2 growth_rate_diff ${base_covariates2019} (${dem2019}=${iv`i'}) ${weight2019}, robust
}

esttab using ${path_appendix}/7_2sls_growth_change.tex, ///
keep(${dem2019}) ///
replace label b(a1) se(a1) stats(N, labels("N")) nostar nodepvars nogaps nonotes mlabels(none) ///
posthead(`" \hline & \multicolumn{10}{c}{ Dependent Variable is the Difference in the Annual GDP Growth Rate Between 2019 and 2020} \\ \cline{2-11}  \\[-1.8ex]"') ///
prefoot(`" \hline \\[-1.8ex] IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals}  \\ Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')

