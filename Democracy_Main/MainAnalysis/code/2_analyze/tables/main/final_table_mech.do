********************************************************************************
* Table 3: 2SLS Regression Estimates of Democracy's Effects on Mechanisms
********************************************************************************
clear

*** Load data 
use ${path_data}/total.dta, replace

// file close f11
// file close f12
// file close f13


replace new_ftti_2001_2019 = -1*new_ftti_2001_2019 
replace new_v2smpolhate_2001_2019 = -1*new_v2smpolhate_2001_2019
replace new_v2smpolsoc_2001_2019 = -1*new_v2smpolsoc_2001_2019

rename mean_capital_g_2001_2019 new_capital_g_2001_2019
rename mean_labor_2001_2019 new_labor_2001_2019
rename mean_tfpgrowth_2001_2019 new_tfpgrowth_2001_2019
rename mean_fdi_2001_2019 new_fdi_2001_2019
rename mean_imp_2001_2019 new_imp_2001_2019
rename mean_exp_2001_2019 new_exp_2001_2019
rename median_age_2001_2019 new_median_age_2001_2019
rename rd_expenditure_g new_rd_expenditure_g_2001_2019
rename primary_school1 new_primary_school1_2001_2019
rename secondary_school1 new_secondary_school1_2001_2019


local count = 1
local outcomes ftti seatw_popul v2smpolhate v2smpolsoc capital_g rd_expenditure_g labor tfpgrowth imp exp primary_school1 secondary_school1 pop_growth median_age

foreach outcome of local outcomes{
	mean(new_`outcome'_2001_2019)
	matrix list e(b)
	local mean`count' = string(round(e(b)[1,1], 0.1), "%03.1f")
	di `mean`count''
	local count = `count' + 1
}
di `mean1'

* Override mean1 through mean4 with "N/A"
local mean1 = "N/A"
local mean2 = "N/A"
local mean3 = "N/A"
local mean4 = "N/A"

local count = 1

forv i = 0/6{
	
	eststo clear
		
	foreach outcome of local outcomes{
		
		
		if `i' == 0{
			
			file open f11 using ${path_coefs}/`outcome'_ols_nocontrols_coef.tex, replace write
			file open f12 using ${path_coefs}/`outcome'_ols_nocontrols_se.tex, replace write
			file open f13 using ${path_coefs}/`outcome'_ols_nocontrols_coef_abs.tex, replace write
				
			eststo: reg new_`outcome'_2001_2019 ${dem2000} ${weight2000}, vce(robust)
			// estadd ysumm
			
			local coef = string(round(_b[${dem2000}], 0.1), "%03.1f")
			local se = string(round(_se[${dem2000}], 0.1), "%03.1f")
			local coef_abs = abs(`coef')

			file write f11 "`coef'" "\unskip"
			file close f11

			file write f12 "`se'" "\unskip"
			file close f12
			
			file write f13 "`coef_abs'" "\unskip"
			file close f13
			
	
			//eststo: reg new_`outcome'_2001_2019 total_gdp2000 ${base_covariates2000} ${dem2000} 
		}

		else {
			
			file open f11 using ${path_coefs}/`outcome'_iv`i'_nocontrols_coef.tex, replace write
			file open f12 using ${path_coefs}/`outcome'_iv`i'_nocontrols_se.tex, replace write
			file open f13 using ${path_coefs}/`outcome'_iv`i'_nocontrols_coef_abs.tex, replace write
			
			eststo: ivregress 2sls new_`outcome'_2001_2019 (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)
			// estadd ysumm
			
			local coef = string(round(_b[${dem2000}], 0.1), "%03.1f")
			local se = string(round(_se[${dem2000}], 0.1), "%03.1f")
			local coef_abs = abs(`coef')
			
			file write f11 "`coef'" "\unskip"
			file close f11

			file write f12 "`se'" "\unskip"
			file close f12
			
			file write f13 "`coef_abs'" "\unskip"
			file close f13
			
			
			// eststo: ivregress 2sls new_`outcome'_2001_2019 total_gdp2000 ${base_covariates2000} (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)	
		}
		
		}
	
		if `count' == 7{
			local last `"stats(N, fmt(0) labels("N")) postfoot(`" \\ Outcome Mean & `mean1' & `mean2' & `mean3' & `mean4' & `mean5' & `mean6' & `mean7' & `mean8' & `mean9' & `mean10' & `mean11' & `mean12' & `mean13' & `mean14'\\"')"'

		}
		else {
			local last `"stats(N, fmt(0) labels("N"))"'
		}
		
		esttab using table3f_panelA`count'.tex, ///
		replace label b(a1) se(a1) `last' ///
		nodepvars nogaps nonotes nostar mlabels(none) keep(${dem2000})
		local count = `count' + 1
	
}

include "${path_code}/2_analyze/tables/PanelCombine_simple2.do"
panelcombine, use(table3f_panelA1.tex table3f_panelA2.tex table3f_panelA3.tex table3f_panelA4.tex table3f_panelA5.tex table3f_panelA6.tex table3f_panelA7.tex) paneltitles("A: OLS" "B: Instrument for Democracy by Settler Mortality" "C: Instrument for Democracy by Population Density in 1500s" "D: Instrument for Democracy by Legal Origin" "E: Instrument for Democracy by Language" "F: Instrument for Democracy by Crops and Minerals" "G: Use all IVs") columncount(14) save(${path_output}/fitable3fA.tex) cleanup

