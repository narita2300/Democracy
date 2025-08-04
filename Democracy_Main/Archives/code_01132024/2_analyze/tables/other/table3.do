********************************************************************************
* Table 3: 2SLS Regression on Potential Channels Behind Democracy's Effect
********************************************************************************
clear

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use ${path_output}/total.dta, replace

*** Make sample consistent across mechanism variables
drop if containmenthealth10==. | coverage10 ==. | days_betw_10th_case_and_policy ==.

* index: Freedom House's democracy index
* weight: GDP (total_gdp)
local count =1
local mediators containmenthealth10 coverage10 days_betw_10th_case_and_policy

foreach var of local mediators {
	eststo clear
	forv i = 1/5{
		eststo: ivreg2 `var' (${dem2019}=${iv`i'}) ${weight2019}, robust
		eststo: ivreg2 `var' ${base_covariates2019} (${dem2019}=${iv`i'})${weight2019}, robust
	}
	
	if `count'==1{
		local replace_append "replace"
	}
	
	else {
		local replace_append "append"
	}
	
	esttab using ${path_output}/tables/table3_panel`count'.tex, keep(${dem2019}) `replace_append' label b(a1) se(a1) nodepvars mlabels(none)
	
	local count = `count'+1
}

include "${path_code}/2_analyze/tables/PanelCombine.do"
panelcombine, use(table3_panel1.tex table3_panel2.tex table3_panel3.tex) paneltitles("`: var label `:word 1 of `mediators'''" "`: var label `:word 2 of `mediators'''" "`: var label `:word 3 of `mediators'''") columncount(11) save(table3.tex) cleanup

