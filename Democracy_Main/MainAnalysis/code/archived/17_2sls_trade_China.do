

********************************************************************************
* Table: 2SLS Regression Estimates of Democracy's Effects on Trade w/ China
********************************************************************************
clear 

*** Load data 
use ${path_data}/total.dta, replace


local count = 1
local outcomes mean_china_import_gdp mean_china_export_gdp

forv i = 0/6{
	
	eststo clear
		
	foreach outcome of local outcomes{
		
		if `i' == 0{
			eststo: reg `outcome' ${dem2000} ${weight2000}, vce(robust)
			eststo: reg `outcome' ${base_covariates2000} ${dem2000} ${weight2000}, vce(robust)
		}

		else {
			eststo: ivregress 2sls `outcome' (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)
			eststo: ivregress 2sls `outcome' ${base_covariates2000} (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)	
		}
		
		}
	
		if `count' == 6{
			// local last "`postfoot(Baseline Controls &  & \cmark &  & \cmark &  & \cmark &  & \cmark   &  & \cmark \\\hline \hline\\[-1.8ex]\end{tabular})'"
		}
		else {
			local last "noobs"
		}
		
		esttab using 20_2sls_china_trade_panel`count'.tex, ///
		replace label b(a1) se(a1) `last' ///
		nodepvars nogaps nonotes nostar mlabels(none) stats(N, fmt(0) labels("N")) keep(${dem2000})
		local count = `count' + 1
	
}

include "${path_code}/2_analyze/tables/PanelCombine_simple2.do"
panelcombine, use(20_2sls_china_trade_panel1.tex 20_2sls_china_trade_panel2.tex 20_2sls_china_trade_panel3.tex 20_2sls_china_trade_panel4.tex 20_2sls_china_trade_panel5.tex 20_2sls_china_trade_panel6.tex 20_2sls_china_trade_panel7.tex) paneltitles("A: OLS" "B: Instrument for Democracy by Settler Mortality" "C: Instrument for Democracy by Population Density in 1500s" "D: Instrument for Democracy by Legal Origin" "E: Instrument for Democracy by Language" "F: Instrument for Democracy by Crops and Minerals" "G: Use all IVs") columncount(5) save(20_2sls_china_trade.tex) cleanup
