
clear 

// *** Change to appropriate directory
cd /Users/leonardofancello/Desktop/Yale/Democracy/MainAnalysisRep/Presentation/new_figures/economic/


*** Load data 
use ${path_data}/total.dta, replace

*******************************
******************************* Mechanisms: Value Added, Agriculture

local title "Value Added, Agriculture (Annual % Growth)"
local var mean_agr_va_growth_2001_2019
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
/*
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
, xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-5 5)) xlabel(-5(1)5) title("Effect of 1 s.d. democracy increase on value added, agriculture", span size(medium)) subtitle("Base specification, no controls", span margin(b=5)) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") position(6) row(1))

graph export `var'_coef_plot_hastitle.png, as(png) name("Graph") replace
*/
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
, xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-5 5)) xlabel(-5(1)5) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") position(6) row(1)) name(g1, replace)

graph export `var'_coef_plot_notitle.png, as(png) replace

*******************************
******************************* Mechanisms: Value Added, Manufacturing

local title "Value Added, Manufacturing (Annual % Growth)"
local var mean_manu_va_growth_2001_2019
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
/*
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
, xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-5 5)) xlabel(-5(1)5) title("Effect of 1 s.d. democracy increase on value added, manufacturing", span size(medium)) subtitle("Base specification, no controls", span margin(b=5)) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") position(6) row(1))

graph export `var'_coef_plot_hastitle.png, as(png) name("Graph") replace
*/
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
, xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-5 5)) xlabel(-5(1)5) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") position(6) row(1)) name(g2, replace)

graph export `var'_coef_plot_notitle.png, as(png) replace

*******************************
******************************* Mechanisms: Value Added, Services

local title "Value Added, Services (Annual % Growth)"
local var mean_serv_va_growth_2001_2019
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
/*
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
, xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-5 5)) xlabel(-5(1)5) title("Effect of 1 s.d. democracy increase on value added, services", span size(medium)) subtitle("Base specification, no controls", span margin(b=5)) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") position(6) row(1))

graph export `var'_coef_plot_hastitle.png, as(png) name("Graph") replace
*/
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
, xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-5 5)) xlabel(-5(1)5) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") position(6) row(1)) name(g3, replace)

graph export `var'_coef_plot_notitle.png, as(png) replace


graph combine g1 g2 g3, ycommon col(3)
*******************************
******************************* Mechanisms: Capital Formation (Annual % Growth)

local title "Capital Formation (Annual % Growth)"
local var mean_capital_growth_2001_2019
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
, xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-15 5)) xlabel(-15(5)5) title("Effect of 1 s.d. democracy increase on capital formation", span size(medium)) subtitle("Base specification, no controls", span margin(b=5)) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") position(6) row(1))
graph export `var'_coef_plot_hastitle.png, as(png) name("Graph") replace

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
, xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-5 5)) xlabel(-5(1)5) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") position(6) row(1))
graph export `var'_coef_plot_notitle.png, as(png) name("Graph") replace

// *******************************
// ******************************* Mechanisms: Capital Formation (Annual % Growth)

// local title "Capital Formation (Annual % Growth)"
// local var mean_capital_growth_2001_2019
// local baseline 2000

// eststo clear
// 	forv i = 1/6{
// 		if `i' == 6{
// 			eststo r`i': reg `var' ${dem2000} if logem != . & lpd1500s !=. & legor_uk !=. & EurFrac !=. & bananas!=. & copper !=. ${weight2000}, vce(robust)
// 		}
// 		else {
// 			eststo r`i': reg `var' ${dem2000} if `:word 1 of ${iv`i'}' !=. ${weight2000}, vce(robust)
// 		}
// 		eststo m`i': ivregress 2sls `var' (${dem`baseline'}=${iv`i'}) ${weight`baseline'}, vce(robust)
// }

// coefplot (m1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
// (r1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
// (m2, keep(${dem2000}) rename(${dem2000} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
// (r2,  keep(${dem2000}) rename(${dem2000} = "Population Density IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
// (m3, keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
// (r3,  keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
// (m4, keep(${dem2000}) rename(${dem2000} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
// (r4,  keep(${dem2000}) rename(${dem2000} = "Language IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
// (m5, keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
// (r5,  keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
// (m6, keep(${dem2000}) rename(${dem2000} = "All IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
// (r6,  keep(${dem2000}) rename(${dem2000} = "All IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
// , xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-15 5)) xlabel(-15(5)5) title("Effect of 1 s.d. democracy increase on capital formation", span size(medium)) subtitle("Base specification, no controls", span margin(b=5)) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") position(6) row(1))
// graph export `var'_coef_plot_hastitle.png, as(png) name("Graph") replace

// coefplot (m1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
// (r1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
// (m2, keep(${dem2000}) rename(${dem2000} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
// (r2,  keep(${dem2000}) rename(${dem2000} = "Population Density IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
// (m3, keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
// (r3,  keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
// (m4, keep(${dem2000}) rename(${dem2000} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
// (r4,  keep(${dem2000}) rename(${dem2000} = "Language IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
// (m5, keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
// (r5,  keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
// (m6, keep(${dem2000}) rename(${dem2000} = "All IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
// (r6,  keep(${dem2000}) rename(${dem2000} = "All IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
// , xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-5 5)) xlabel(-5(1)5) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") position(6) row(1))
// graph export `var'_coef_plot_notitle.png, as(png) name("Graph") replace

*******************************
******************************* Mechanisms: Labor Force (Annual % Growth)

local title "Labor Force (Annual % Growth)"
local var mean_labor_growth_2001_2019
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
, xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'")  title("Effect of 1 s.d. democracy increase on labor force", span size(medium)) subtitle("Base specification, no controls", span margin(b=5)) xscale(range(-5 5)) xlabel(-5(1)5) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") position(6) row(1))
graph export `var'_coef_plot_hastitle.png, as(png) name("Graph") replace

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
, xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-5 5)) xlabel(-5(1)5) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") position(6) row(1))
graph export `var'_coef_plot_notitle.png, as(png) name("Graph") replace

*******************************
******************************* Mechanisms: TFP

local title "TFP (Annual Growth Rate)"
local var mean_tfpgrowth_2001_2019
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
, xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") title("Effect of 1 s.d. democracy increase on productivity", span size(medium)) subtitle("Base specification, no controls", span margin(b=5)) xscale(range(-5 5)) xlabel(-5(1)5) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") position(6) row(1))
graph export `var'_coef_plot_hastitle.png, as(png) name("Graph") replace

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
, xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-5 5)) xlabel(-5(1)5) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") position(6) row(1))
graph export `var'_coef_plot_notitle.png, as(png) name("Graph") replace

*******************************
******************************* Mechanisms: FDI

local title "FDI Outflow (Annual % Growth)"
local var mean_fdi_2001_2019
local baseline 2000

eststo clear
forv i = 1/6 {
    if `i' == 6 {
        eststo r`i': reg `var' ${dem2000} if logem != . & lpd1500s !=. & legor_uk !=. & EurFrac !=. & bananas !=. & copper !=. ${weight2000}, vce(robust)
    }
    else {
        eststo r`i': reg `var' ${dem2000} if `:word 1 of ${iv`i'}' !=. ${weight2000}, vce(robust)
    }
    eststo m`i': ivregress 2sls `var' (${dem`baseline'}=${iv`i'}) ${weight`baseline'}, vce(robust)
}

coefplot (m1, keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12)) ///
(r1, keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") offset(-0.2) mlabposition(7) mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m2, keep(${dem2000}) rename(${dem2000} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12)) ///
(r2, keep(${dem2000}) rename(${dem2000} = "Population Density IV") offset(-0.2) mlabposition(7) mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m3, keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12)) ///
(r3, keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") offset(-0.2) mlabposition(7) mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m4, keep(${dem2000}) rename(${dem2000} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12)) ///
(r4, keep(${dem2000}) rename(${dem2000} = "Language IVs") offset(-0.2) mlabposition(7) mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m5, keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12)) ///
(r5, keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") offset(-0.2) mlabposition(7) mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m6, keep(${dem2000}) rename(${dem2000} = "All IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12)) ///
(r6, keep(${dem2000}) rename(${dem2000} = "All IVs") offset(-0.2) mlabposition(7) mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
, xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") title("Effect of 1 s.d. democracy increase on productivity", span size(medium)) subtitle("Base specification, no controls", span margin(b=5)) ///
xscale(range(-200 60)) xlabel(-200(20)60) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") position(6) row(1))
graph export `var'_coef_plot_hastitle.png, as(png) name("Graph") replace

coefplot (m1, keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12)) ///
(r1, keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") offset(-0.2) mlabposition(7) mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m2, keep(${dem2000}) rename(${dem2000} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12)) ///
(r2, keep(${dem2000}) rename(${dem2000} = "Population Density IV") offset(-0.2) mlabposition(7) mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m3, keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12)) ///
(r3, keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") offset(-0.2) mlabposition(7) mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m4, keep(${dem2000}) rename(${dem2000} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12)) ///
(r4, keep(${dem2000}) rename(${dem2000} = "Language IVs") offset(-0.2) mlabposition(7) mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m5, keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12)) ///
(r5, keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") offset(-0.2) mlabposition(7) mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m6, keep(${dem2000}) rename(${dem2000} = "All IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12)) ///
(r6, keep(${dem2000}) rename(${dem2000} = "All IVs") offset(-0.2) mlabposition(7) mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
, xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-200 60)) xlabel(-200(20)60) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") position(6) row(1))
graph export `var'_coef_plot_notitle.png, as(png) name("Graph") replace


*******************************
******************************* Mechanisms: Import Value Index

local title "Import Value Index (Annual % Growth)"
local var mean_import_value2_2001_2019
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
, xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") title("Effect of 1 s.d. democracy increase on imports", span size(medium)) subtitle("Base specification, no controls", span margin(b=5)) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") position(6) row(1)) xscale(range(-6 1)) xlabel(-6(1)1)
graph export `var'_coef_plot_hastitle.png, as(png) name("Graph") replace

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
, xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-6 1)) xlabel(-6(1)1) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") position(6) row(1))
graph export `var'_coef_plot_notitle.png, as(png) name("Graph") replace



*******************************
******************************* Mechanisms: Export Value Index

local title "Export Value Index (Annual % Growth)"
local var mean_export_value2_2001_2019
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
, xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") title("Effect of 1 s.d. democracy increase on exports", span size(medium)) subtitle("Base specification, no controls", span margin(b=5)) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") position(6) row(1)) xscale(range(-6 1)) xlabel(-6(1)1)
graph export `var'_coef_plot_hastitle.png, as(png) name("Graph") replace

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
, xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-6 1)) xlabel(-6(1)1) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") position(6) row(1))
graph export `var'_coef_plot_notitle.png, as(png) name("Graph") replace




