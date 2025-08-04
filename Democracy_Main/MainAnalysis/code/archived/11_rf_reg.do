********************************************************************************
* Table: Reduced Form Regressions
********************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use ${path_data}/total.dta, replace

******************************************
*** RF on Outcomes *** 
******************************************

local count = 1
local outcomes mean_growth_rate_1981_2000 ${outcome1} ${outcome2} ${outcome3} ${outcome4}

foreach outcome of local outcomes{
	
	if "`outcome'" == "${outcome2}" | "`outcome'"== "${outcome4}" {
		local weight "${weight2019}"
		local covariates "${base_covariates2019}"
		local index "${dem2019}"
	}
	
	else if "`outcome'" == "${outcome1}" |  "`outcome'"== "${outcome3}" {
		local weight "${weight2000}"
		local covariates "${base_covariates2000}"
		local index "${dem2000}"
	}
	
	else if "`outcome'" == "mean_growth_rate_1981_2000"{
		local weight "[w=total_gdp1980]"
		local covariates "abs_lat mean_temp_1971_1980 mean_precip_1971_1980 median_age1980 pop_density1980"
		local index "democracy_vdem1980"
	}
	
	eststo clear
	forv i = 1/6{
				eststo: reg `outcome' ${iv`i'} `weight', robust
				eststo: reg `outcome' `covariates' ${iv`i'} `weight', robust
	}

	esttab using rf_`outcome'.tex, ///
	replace label b(a1) se(a1) ///
	nodepvars nogaps nonotes nostar mlabels(none) drop(`covariates' _cons) prefoot(`" \hline \\[-1.8ex]Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark  & \xmark & \cmark  \\"') stats(N, labels("N") fmt(0))

	
	local count = `count' + 1
}


//cells("b(fmt(1))" "se(par fmt(1))" "p(fmt(2))")

// include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
// panelcombine, use(table2_panelA1.tex table2_panelA2.tex table2_panelA3.tex) paneltitles("`: var label `:word 1 of `outcomes'''" "`: var label `:word 2 of `outcomes'''" "`: var label `:word 3 of `outcomes'''") columncount(11) save(table2_panelA.tex) cleanup

