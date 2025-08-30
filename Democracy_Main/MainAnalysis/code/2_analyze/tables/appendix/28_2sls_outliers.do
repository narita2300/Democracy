********************************************************************************
* Robustness Check
********************************************************************************
clear 


*** Load data 
use ${path_data}/total.dta, replace

*** we re-estimate our preferred specification without countries with a standarized residual above 1.96 or below -1.96. ***

local count = 1
local outcomes ${outcome1} ${outcome2} ${outcome3}


foreach outcome of local outcomes{
	
	if "`outcome'" == "${outcome2}" {
		local weight "${weight2019}"
		local covariates "${base_covariates2019}"
		local index "${dem2019}"
	}
	
	else if "`outcome'" == "${outcome1}" | "`outcome'" == "${outcome3}" {
		local weight "${weight2000}"
		local covariates "${base_covariates2000}"
		local index "${dem2000}"
	}
	
	eststo clear
	forv i = 1/6{
				ivreg2 `outcome' (`index'=${iv`i'}) `weight', robust
				predict yhat
				gen resid = `outcome' - yhat
				egen resid_std = std(resid)
				eststo: ivreg2 `outcome' (`index'=${iv`i'}) `weight' if resid_std<=1.96 & resid_std>=-1.96, robust
				drop yhat resid resid_std
				
				ivreg2 `outcome' `covariates' (`index'=${iv`i'}) `weight', robust
				predict yhat
				gen resid = `outcome' - yhat
				egen resid_std = std(resid)
				eststo: ivreg2 `outcome' (`index'=${iv`i'}) `weight' if resid_std<=1.96 & resid_std>=-1.96, robust
				drop yhat resid resid_std
	}
	
	if `count' == 3{
		local last "postfoot(`" \hline \\[-1.8ex] IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs}  \\ Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')"

	}
	else {
		local last ""
	}
	
	esttab using robust_panel`count'.tex, ///
	replace label b(a1) se(a1) stats(N, labels("N"))  `last' ///
	nodepvars nogaps nonotes nostar mlabels(none) keep(`index') ///
	
	local count = `count' + 1
}

include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use(robust_panel1.tex robust_panel2.tex robust_panel3.tex) paneltitles("`: var label `:word 1 of `outcomes'''" "`: var label `:word 2 of `outcomes'''" "`: var label `:word 3 of `outcomes'''") columncount(13) save(${path_output}/appendix/13_2sls_outliers.tex) cleanup
