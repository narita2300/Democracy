
********************************************************************************
* Table 12: 2SLS Regression excluding the US and China
********************************************************************************
clear 

*** Load data 
use ${path_data}/total.dta, replace
	
***********************************************************************************
*** Panel A row 1 & Panel B row 2 : 2SLS with sample including the US and China ***
***********************************************************************************
local outcomes ${outcome1} ${outcome2} ${outcome3} ${outcome4}
foreach var of local outcomes{
	
	use ${path_data}/total.dta, replace
	
		if "`var'" == "${outcome2}" {
		local weight "total_gdp2019"
		local covariates "${base_covariates2019}"
		local index "democracy_vdem2019"
		local last "noobs"
	}
	
	else if "`var'"== "${outcome4}"{
		local weight "total_gdp2019"
		local covariates "${base_covariates2019}"
		local index "democracy_vdem2019"
		local last `" postfoot(`"\hline \\[-1.8ex] IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals}  & \multicolumn{2}{c}{all IVs}  \\ Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')"'
		
	}
	
	else if "`var'" == "${outcome1}"| "`var'"== "${outcome3}" {
		local weight "total_gdp2000"
		local covariates "${base_covariates2000}"
		local index "democracy_vdem2000"
		local last ""
	}
	
	eststo clear
		forv i = 1/6{
			eststo: ivregress 2sls `var' (`index'=${iv`i'}) [w=`weight'], vce(robust)
			eststo: ivregress 2sls `var' `covariates' (`index'=${iv`i'}) [w=`weight'], vce(robust)
	}
	
	esttab using 12_2sls_exclude_US_China_`var'_panel1.tex, keep(`index') replace label b(a1) se(a1) nodepvars nostar nogaps nonotes obslast mlabels(none) stats(N, fmt(0) labels("N")) prefoot("Include US \& China? & \cmark & \cmark  & \cmark & \cmark & \cmark & \cmark  & \cmark & \cmark & \cmark & \cmark & \cmark & \cmark\\")
	
	include "${path_code}/2_analyze/tables/PanelCombine_simplest.do"
panelcombine, use(12_2sls_exclude_US_China_`var'_panel1.tex) paneltitles(" ") columncount(13) save(12_2sls_exclude_US_China_`var'_panelA1.tex) cleanup
	

	drop if countries=="United States"
	drop if countries=="China"

	eststo clear
		forv i = 1/6{
			eststo: ivregress 2sls `var' (`index'=${iv`i'}) [w=`weight'], vce(robust)
			eststo: ivregress 2sls `var' `covariates' (`index'=${iv`i'}) [w=`weight'], vce(robust)
	}
	
	esttab using 12_2sls_exclude_US_China_`var'_panel2.tex, keep(`index') replace label b(a1) se(a1) nodepvars nostar nogaps nonotes mlabels(none) stats(N, fmt(0) labels("N")) prefoot("Include US \& China? & \xmark & \xmark  & \xmark & \xmark   & \xmark & \xmark  & \xmark & \xmark  & \xmark & \xmark  & \xmark & \xmark \\") `last'
	
	include "${path_code}/2_analyze/tables/PanelCombine_simplest.do"
panelcombine, use(12_2sls_exclude_US_China_`var'_panel2.tex) paneltitles(" ") columncount(13) save(12_2sls_exclude_US_China_`var'_panelA2.tex) cleanup
	
}



