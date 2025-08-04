***************************************
*** Table A2: OLS on Democracy Index *** 
***************************************
clear

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data
cd ${path_dropbox}/tables


*** Load data 
use ${path_data}/total.dta, replace


* index: Freedom House's democracy index (democracy_fh)
* weight = GDP (total_gdp)

eststo clear


forv i=1/5{
	eststo: reg ${dem2019} ${iv`i'} ${weight2019}, vce(robust)
	
	ivreg2 gdp_growth2020 (${dem2019}=${iv`i'}) ${weight2019}, robust
	local fstat`i'1 = string(round(e(widstat), 0.1), "%03.1f")
	
	eststo: reg ${dem2019} ${iv`i'} ${base_covariates2019} ${weight2019}, vce(robust)
	
	ivreg2 gdp_growth2020 (${dem2019}=${iv`i'})${base_covariates2019} ${weight2019}, robust
	local fstat`i'2 = string(round(e(widstat), 0.1), "%03.1f")
	
}
esttab using ${path_appendix}/4_first_stage.tex, nocons replace label b(a1) se(a1) nostar nodepvars drop(${base_covariates2019} _cons) stats(N, labels("N")) obslast nogaps nonotes mlabels(none) posthead(`"\hline &\multicolumn{10}{c}{ Dependent Variable is Democracy Index (V-Dem, 2019)}\\\cline{2-11}\\[-1.8ex]"') prefoot(`"F-Statistic (First stage) & `fstat11' & `fstat12' & `fstat21' & `fstat22' & `fstat31' & `fstat32' & `fstat41' & `fstat42' & `fstat51' & `fstat52' \\ \hline \\[-1.8ex] Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\ "')
