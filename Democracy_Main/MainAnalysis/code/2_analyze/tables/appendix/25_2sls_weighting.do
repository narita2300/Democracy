********************************************************************************
* Table: 2SLS Regression with Alternative Weightings
********************************************************************************
clear 

*** Load data 
use ${path_data}/total.dta, replace

*** Make the sample size consistent across different weightings
drop if total_gdp2019==. | total_gdp2000==.
drop if population2019==. | population2000==.

local y = 1

local outcomes ${outcome1} ${outcome2} ${outcome3} 

foreach var of local outcomes{
	
		if "`var'" == "${outcome2}" {
		local weight "total_gdp2019 population2019"
		local covariates "${base_covariates2019}"
		local index "democracy_vdem2019"
	}
	
	else if "`var'" == "${outcome1}"| "`var'"== "${outcome3}" {
		local weight "total_gdp2000 population2000"
		local covariates "${base_covariates2000}"
		local index "democracy_vdem2000"
	}
	
	local n = 1
	
	// loop through GDP weighting and population weighting 
	foreach w in `weight' {
		eststo clear
		forv i = 1/6{
		eststo: ivregress 2sls `var' (`index'=${iv`i'}) [w=`w'], vce(robust)
		eststo: ivregress 2sls `var' `covariates' (`index'=${iv`i'}) [w=`w'], vce(robust)
		}
		
		if strpos("`w'","total_gdp")>0 {
			local weighting "GDP"
		}
		else {
			local weighting "Population"
		}
		
		esttab using 11_2sls_weighting_`var'_panel`n'.tex, keep(`index') replace label b(a1) se(a1) nodepvars nostar noobs coeflabels(`index' "Democracy Index (Weighting: `weighting')")
		
		local n = `n' + 1
	}
	
	// no weighting
	eststo clear
	forv i = 1/6{
		eststo: ivregress 2sls `var' (`index'=${iv`i'}) , vce(robust)
		eststo: ivregress 2sls `var' `covariates' (`index'=${iv`i'}), vce(robust)
	}
	
	if "`var'" == "${outcome3}"{
		local last `" stats(N, fmt(0) labels("N")) prefoot(`" \hline \\[-1.8ex] IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals}  & \multicolumn{2}{c}{all IVs} \\ Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') "'
	}
	
	else {
		local last "noobs"
	}
	
	
	esttab using 11_2sls_weighting_`var'_panel`n'.tex, keep(`index') replace label b(a1) se(a1) nodepvars nostar `last' coeflabels(`index' "Democracy Index (Weighting: None)")
	
	local y = `y'+1
	
	include "${path_code}/2_analyze/tables/PanelCombine_simplest.do"
panelcombine, use(11_2sls_weighting_`var'_panel1.tex 11_2sls_weighting_`var'_panel2.tex 11_2sls_weighting_`var'_panel3.tex) paneltitles(" ") columncount(13) save(11_2sls_weighting_`var'.tex) cleanup

}

