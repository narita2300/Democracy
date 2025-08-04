
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data
cd ${path_dropbox}/tables

*** Load data 
use ${path_data}/total.dta, replace

// relevant variables are
codebook change_ftti_2001_2019 change_seatw_illib_2001_2019 change_seatw_popul_2001_2019 change_v2smpolhate_2001_2019 change_v2smpolsoc_2001_2019

replace change_ftti_2001_2019 = -1*change_ftti_2001_2019 
replace change_v2smpolhate_2001_2019 = -1*change_v2smpolhate_2001_2019
replace change_v2smpolsoc_2001_2019 = -1*change_v2smpolsoc_2001_2019


********************************************************************************
***** OLS AND 2SLS TABLE 
local count = 1
local outcomes ftti seatw_illib seatw_popul v2smpolhate v2smpolsoc 

foreach outcome of local outcomes{
	mean(change_`outcome'_2001_2019)
	matrix list e(b)
	local mean`count' = string(round(e(b)[1,1], 0.01), "%03.2f")
	di `mean`count''
	local count = `count' + 1
}
di `mean1'

local count = 1
forv i = 0/6{
	
	eststo clear
		
	foreach outcome of local outcomes{
		
		if `i' == 0{
			
// 			file open f11 using ${path_coefs}/`outcome'_ols_nocontrols_coef.tex, replace write
// 			file open f12 using ${path_coefs}/`outcome'_ols_nocontrols_se.tex, replace write
// 			file open f13 using ${path_coefs}/`outcome'_ols_nocontrols_coef_abs.tex, replace write
				
			eststo: reg change_`outcome'_2001_2019 ${dem2000} ${weight2000}, vce(robust)
			// estadd ysumm
			
			local coef = string(round(_b[${dem2000}], 0.1), "%03.1f")
			local se = string(round(_se[${dem2000}], 0.1), "%03.1f")
			local coef_abs = abs(`coef')

// 			file write f11 "`coef'" "\unskip"
// 			file close f11

// 			file write f12 "`se'" "\unskip"
// 			file close f12
			
// 			file write f13 "`coef_abs'" "\unskip"
// 			file close f13
			
// 			file open f21 using ${path_coefs}/`outcome'_ols_withcontrols_coef.tex, replace write
// 			file open f22 using ${path_coefs}/`outcome'_ols_withcontrols_se.tex, replace write
// 			file open f23 using ${path_coefs}/`outcome'_ols_withcontrols_coef_abs.tex, replace write
			
			eststo: reg change_`outcome'_2001_2019 gdppc2000 ${base_covariates2000} ${dem2000} ${weight2000}, vce(robust)
			// estadd ysumm
			
			local coef = string(round(_b[${dem2000}], 0.1), "%03.1f")
			local se = string(round(_se[${dem2000}], 0.1), "%03.1f")
			local coef_abs = abs(`coef')

// 			file write f21 "`coef'" "\unskip"
// 			file close f21

// 			file write f22 "`se'" "\unskip"
// 			file close f22
			
// 			file write f23 "`coef_abs'" "\unskip"
// 			file close f23
		
			//eststo: reg change_`outcome'_2001_2019 total_gdp2000 ${base_covariates2000} ${dem2000} 
		}

		else {
			
// 			file open f11 using ${path_coefs}/`outcome'_iv`i'_nocontrols_coef.tex, replace write
// 			file open f12 using ${path_coefs}/`outcome'_iv`i'_nocontrols_se.tex, replace write
// 			file open f13 using ${path_coefs}/`outcome'_iv`i'_nocontrols_coef_abs.tex, replace write
			
			eststo: ivreg2 change_`outcome'_2001_2019 (${dem2000}=${iv`i'}) ${weight2000}, robust
			// estadd ysumm
			
			local coef = string(round(_b[${dem2000}], 0.1), "%03.1f")
			local se = string(round(_se[${dem2000}], 0.1), "%03.1f")
			local coef_abs = abs(`coef')
			
// 			file write f11 "`coef'" "\unskip"
// 			file close f11

// 			file write f12 "`se'" "\unskip"
// 			file close f12
			
// 			file write f13 "`coef_abs'" "\unskip"
// 			file close f13
			
// 			file open f21 using ${path_coefs}/`outcome'_iv`i'_withcontrols_coef.tex, replace write
// 			file open f22 using ${path_coefs}/`outcome'_iv`i'_withcontrols_se.tex, replace write
// 			file open f23 using ${path_coefs}/`outcome'_iv`i'_withcontrols_coef_abs.tex, replace write
			
			eststo: ivreg2 change_`outcome'_2001_2019 gdppc2000 ${base_covariates2000} (${dem2000}=${iv`i'}) ${weight2000}, robust

			local coef = string(round(_b[${dem2000}], 0.1), "%03.1f")
			local se = string(round(_se[${dem2000}], 0.1), "%03.1f")
			local coef_abs = abs(`coef')
			
// 			file write f21 "`coef'" "\unskip"
// 			file close f21

// 			file write f22 "`se'" "\unskip"
// 			file close f22
			
// 			file write f23 "`coef_abs'" "\unskip"
// 			file close f23
			// eststo: ivregress 2sls change_`outcome'_2001_2019 total_gdp2000 ${base_covariates2000} (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)	
		}
		
		}
	
		if `count' == 7{
			local last `"stats(N, fmt(0) labels("N")) postfoot(`" \\ Baseline Controls (include GDP Per Capita) & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark \\"')"'
		}
		else {
			local last `"stats(N, fmt(0) labels("N"))"'
		}
		
		esttab using table4_panel`count'.tex, ///
		replace label b(a1) se(a1) `last' ///
		nodepvars nogaps nonotes nostar mlabels(none) keep(${dem2000})
		local count = `count' + 1
	
}

include "${path_code}/2_analyze/tables/PanelCombine_simple2.do"
panelcombine, use(table4_panel1.tex table4_panel2.tex table4_panel3.tex table4_panel4.tex table4_panel5.tex table4_panel6.tex table4_panel7.tex) paneltitles("A: OLS" "B: Instrument for Democracy by Settler Mortality" "C: Instrument for Democracy by Population Density in 1500s" "D: Instrument for Democracy by Legal Origin" "E: Instrument for Democracy by Language" "F: Instrument for Democracy by Crops and Minerals" "G: Use all IVs") columncount(9) save(table4_addgdppccontrol.tex) cleanup

