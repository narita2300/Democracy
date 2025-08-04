
clear 

*** Change to appropriate directory
cd ${path_dropbox}/figures

*** Load data 
use ${path_data}/total.dta, replace

*******************************
* This script looks at the societal mechanisms behind democracy's negative effect. 
* The relevant variables are: 
codebook change_ftti_2001_2019 change_seatw_illib_2001_2019 change_seatw_popul_2001_2019 change_v2smpolhate_2001_2019 change_v2smpolsoc_2001_2019

replace change_ftti_2001_2019 = -1*change_ftti_2001_2019 
replace change_v2smpolhate_2001_2019 = -1*change_v2smpolhate_2001_2019
replace change_v2smpolsoc_2001_2019 = -1*change_v2smpolsoc_2001_2019

local vars change_ftti_2001_2019 change_seatw_illib_2001_2019 change_seatw_popul_2001_2019 change_v2smpolhate_2001_2019 change_v2smpolsoc_2001_2019

local titles "Change in protectionist trade policies" "Change in illiberal rhetoric by political parties" "Change in populist rhetoric by political parties" "Change in hate speech by political parties" "Change in political polarization of society"

*******************************
******************************* Mechanism: protectionism

local title "Change in protectionist trade policies"
local var change_ftti_2001_2019
local baseline 2000

eststo clear
	forv i = 1/6{
		if `i' == 6{
			eststo r`i': reg `var' ${dem2000} if logem != . & lpd1500s !=. & legor_uk !=. & EurFrac !=. & bananas!=. & copper !=. ${weight2000}, vce(robust)
		}
		else {
			eststo r`i': reg `var' ${dem2000} if `:word 1 of ${iv`i'}' !=. ${weight2000}, vce(robust)
		}
		eststo m`i': ivregress 2sls `var' (${dem`baseline'}=${iv`i'}) ${weight`baseline'}, vce(robust)
}

coefplot (m1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m2, keep(${dem2000}) rename(${dem2000} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r2,  keep(${dem2000}) rename(${dem2000} = "Population Density IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m3, keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r3,  keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m4, keep(${dem2000}) rename(${dem2000} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r4,  keep(${dem2000}) rename(${dem2000} = "Language IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m5, keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r5,  keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m6, keep(${dem2000}) rename(${dem2000} = "All IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r6,  keep(${dem2000}) rename(${dem2000} = "All IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-2 2)) xlabel(-2(0.5)2) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1))

graph export `var'_coef_plot_notitle.png, as(png) name("Graph") replace

*******************************
******************************* Mechanism: illiberalism

local title "Change in illiberal rhetoric"
local var change_seatw_illib_2001_2019 
local baseline 2000

eststo clear
	forv i = 1/6{
		if `i' == 6{
			eststo r`i': reg `var' ${dem2000} if logem != . & lpd1500s !=. & legor_uk !=. & EurFrac !=. & bananas!=. & copper !=. ${weight2000}, vce(robust)
		}
		else {
			eststo r`i': reg `var' ${dem2000} if `:word 1 of ${iv`i'}' !=. ${weight2000}, vce(robust)
		}
		eststo m`i': ivregress 2sls `var' (${dem`baseline'}=${iv`i'}) ${weight`baseline'}, vce(robust)
}

coefplot (m1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m2, keep(${dem2000}) rename(${dem2000} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r2,  keep(${dem2000}) rename(${dem2000} = "Population Density IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m3, keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r3,  keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m4, keep(${dem2000}) rename(${dem2000} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r4,  keep(${dem2000}) rename(${dem2000} = "Language IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m5, keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r5,  keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m6, keep(${dem2000}) rename(${dem2000} = "All IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r6,  keep(${dem2000}) rename(${dem2000} = "All IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-2 2)) xlabel(-2(0.5)2) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1))

graph export `var'_coef_plot_notitle.png, as(png) name("Graph") replace

*******************************
******************************* Mechanism: populism

local title "Change in hate speech"
local var change_v2smpolhate_2001_2019
local baseline 2000

eststo clear
	forv i = 1/6{
		if `i' == 6{
			eststo r`i': reg `var' ${dem2000} if logem != . & lpd1500s !=. & legor_uk !=. & EurFrac !=. & bananas!=. & copper !=. ${weight2000}, vce(robust)
		}
		else {
			eststo r`i': reg `var' ${dem2000} if `:word 1 of ${iv`i'}' !=. ${weight2000}, vce(robust)
		}
		eststo m`i': ivregress 2sls `var' (${dem`baseline'}=${iv`i'}) ${weight`baseline'}, vce(robust)
}

coefplot (m1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m2, keep(${dem2000}) rename(${dem2000} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r2,  keep(${dem2000}) rename(${dem2000} = "Population Density IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m3, keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r3,  keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m4, keep(${dem2000}) rename(${dem2000} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r4,  keep(${dem2000}) rename(${dem2000} = "Language IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m5, keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r5,  keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m6, keep(${dem2000}) rename(${dem2000} = "All IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r6,  keep(${dem2000}) rename(${dem2000} = "All IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-2 2)) xlabel(-2(0.5)2) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1))

graph export `var'_coef_plot_notitle.png, as(png) name("Graph") replace

*******************************
******************************* Mechanism: 

local title "Change in social polarization"
local var  change_v2smpolsoc_2001_2019
local baseline 2000

eststo clear
	forv i = 1/6{
		if `i' == 6{
			eststo r`i': reg `var' ${dem2000} if logem != . & lpd1500s !=. & legor_uk !=. & EurFrac !=. & bananas!=. & copper !=. ${weight2000}, vce(robust)
		}
		else {
			eststo r`i': reg `var' ${dem2000} if `:word 1 of ${iv`i'}' !=. ${weight2000}, vce(robust)
		}
		eststo m`i': ivregress 2sls `var' (${dem`baseline'}=${iv`i'}) ${weight`baseline'}, vce(robust)
}

coefplot (m1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m2, keep(${dem2000}) rename(${dem2000} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r2,  keep(${dem2000}) rename(${dem2000} = "Population Density IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m3, keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r3,  keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m4, keep(${dem2000}) rename(${dem2000} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r4,  keep(${dem2000}) rename(${dem2000} = "Language IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m5, keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r5,  keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m6, keep(${dem2000}) rename(${dem2000} = "All IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r6,  keep(${dem2000}) rename(${dem2000} = "All IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-2 2)) xlabel(-2(0.5)2) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1))

graph export `var'_coef_plot_notitle.png, as(png) name("Graph") replace


