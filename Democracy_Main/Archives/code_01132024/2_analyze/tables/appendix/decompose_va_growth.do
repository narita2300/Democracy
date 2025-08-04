
********************************************************************************
* Table 3: 2SLS Regression Estimates of Democracy's Effects on Mechanisms
********************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data
cd ${path_dropbox}/tables


*** Load data 
use ${path_data}/total.dta, replace


local count = 1
local outcomes agr_va_growth manu_va_growth serv_va_growth capital_growth labor_growth tfpgrowth
// local outcomes mean_growth_rate_2001_2019

forv i = 0/6{
	
	eststo clear
		
	foreach outcome of local outcomes{
		
		if `i' == 0{
			eststo: reg mean_`outcome'_2001_2019 total_gdp2000 ${dem2000} ${weight2000}, vce(robust)
			eststo: reg mean_`outcome'_2001_2019 total_gdp2000 ${base_covariates2000} ${dem2000} ${weight2000}, vce(robust)
		}

		else {
			eststo: ivregress 2sls mean_`outcome'_2001_2019 total_gdp2000 (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)
			eststo: ivregress 2sls mean_`outcome'_2001_2019 total_gdp2000 ${base_covariates2000} (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)		
		}
		
		}
	
		if `count' == 6{
			// local last "`postfoot(Baseline Controls &  & \cmark &  & \cmark &  & \cmark &  & \cmark   &  & \cmark \\\hline \hline\\[-1.8ex]\end{tabular})'"
		}
		else {
			local last "noobs"
		}
		
		esttab using table3_panel`count'.tex, ///
		replace label b(a1) se(a1) `last' ///
		nodepvars nogaps nonotes nostar mlabels(none) stats(N, fmt(0) labels("N")) keep(${dem2000})
		local count = `count' + 1
	
}

include "${path_code}/2_analyze/tables/PanelCombine_simple2.do"
panelcombine, use(table3_panel1.tex table3_panel2.tex table3_panel3.tex table3_panel4.tex table3_panel5.tex table3_panel6.tex table3_panel7.tex) paneltitles("A: OLS" "B: Instrument for Democracy by Settler Mortality" "C: Instrument for Democracy by Population Density in 1500s" "D: Instrument for Democracy by Legal Origin" "E: Instrument for Democracy by Language" "F: Instrument for Democracy by Crops and Minerals" "G: Use all IVs") columncount(11) save(${path_appendix}/va_growth_decomposition.tex) cleanup

