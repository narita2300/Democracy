********************************************************************************
* Table 3: 2SLS Regression Estimates of Democracy's Mechanisms
********************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data


*** Load data 
use ${path_data}/total.dta, replace


******************************************
*** Panel A: 2SLS on Covid-19 Outcomes *** 
******************************************

cd ${path_dropbox}/tables

local count = 1
local outcomes mean_investment_2001_2019 mean_import_value_2001_2019 mean_export_value_2001_2019 mean_manu_va_growth_2001_2019 mean_serv_va_growth_2001_2019
// local outcomes mean_growth_rate_2001_2019

foreach outcome of local outcomes{
	
	local weight "${weight2000}"
	local covariates "${base_covariates2000}"
	local index "${dem2000}"
	
	eststo clear
	forv i = 1/5{
				eststo: ivreg2 `outcome' (`index'=${iv`i'}) `weight', robust
				eststo: ivreg2 `outcome' `covariates' (`index'=${iv`i'}) `weight', robust
	}
	
	if `count' == 5{
		local last "prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language \& trade} & \multicolumn{2}{c}{crops \& minerals} \\"')"

	}
	else {
		local last "noobs"
	}
	
	esttab using table3_panel`count'.tex, ///
	replace label b(a1) se(a1) `last' ///
	nodepvars nogaps nonotes nostar mlabels(none) keep(`index')
	
	local count = `count' + 1
}

include "${path_code}/2_analyze/tables/PanelCombine.do"
panelcombine, use(table3_panel1.tex table3_panel2.tex table3_panel3.tex table3_panel4.tex table3_panel5.tex) paneltitles("`: var label `:word 1 of `outcomes'''" "`: var label `:word 2 of `outcomes'''" "`: var label `:word 3 of `outcomes'''" "`: var label `:word 4 of `outcomes'''" "`: var label `:word 5 of `outcomes'''") columncount(11) save(table3.tex) cleanup
	
