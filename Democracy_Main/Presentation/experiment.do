
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data
cd ${path_dropbox}/figures


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

coefplot (m1, keep(democracy_vdem2000) coeflabels(democracy_vdem2000="Settler Mortality IV", wrap(20)) mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12)) /// 
(r1,  keep(democracy_vdem2000) coeflabels(democracy_vdem2000="Settler Mortality IV", wrap(20)) offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10))


//  ///
// (r1,  keep(${dem2000}) rename(${dem2000} = `""Settler || nMortality IV""') offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
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
// , xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-5 5)) xlabel(-5(1)5) title("Effect of 1 s.d. democracy increase on value added, agriculture", span size(medium)) subtitle("Base specification, no controls", span margin(b=5)) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1))

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
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-5 5)) xlabel(-5(1)5) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1))

graph export `var'_coef_plot_notitle.png, as(png) name("Graph") replace

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
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-5 5)) xlabel(-5(1)5) title("Effect of 1 s.d. democracy increase on value added, manufacturing", span size(medium)) subtitle("Base specification, no controls", span margin(b=5)) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1))

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
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-5 5)) xlabel(-5(1)5) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1))

graph export `var'_coef_plot_notitle.png, as(png) name("Graph") replace

*******************************
******************************* Mechanisms: Value Added, Services

local title "Services Value Added (Annual % Growth)"
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
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-5 5)) xlabel(-5(1)5) title("Effect of 1 s.d. democracy increase on value added, services", span size(medium)) subtitle("Base specification, no controls", span margin(b=5)) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1))

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
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-5 5)) xlabel(-5(1)5) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1))

graph export `var'_coef_plot_notitle.png, as(png) name("Graph") replace


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
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-15 5)) xlabel(-15(5)5) title("Effect of 1 s.d. democracy increase on capital formation", span size(medium)) subtitle("Base specification, no controls", span margin(b=5)) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1))
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
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-15 5)) xlabel(-15(5)5) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1))
graph export `var'_coef_plot_notitle.png, as(png) name("Graph") replace

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
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-15 5)) xlabel(-15(5)5) title("Effect of 1 s.d. democracy increase on capital formation", span size(medium)) subtitle("Base specification, no controls", span margin(b=5)) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1))
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
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-15 5)) xlabel(-15(5)5) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1))
graph export `var'_coef_plot_notitle.png, as(png) name("Graph") replace

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
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'")  title("Effect of 1 s.d. democracy increase on labor force", span size(medium)) subtitle("Base specification, no controls", span margin(b=5)) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1))
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
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1))
graph export `var'_coef_plot_notitle.png, as(png) name("Graph") replace

*******************************
******************************* Mechanisms: TFP

local title "TFP (Annual % Growth)"
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
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") title("Effect of 1 s.d. democracy increase on productivity", span size(medium)) subtitle("Base specification, no controls", span margin(b=5)) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1))
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
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'")  legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1))
graph export `var'_coef_plot_notitle.png, as(png) name("Graph") replace

*******************************
******************************* Mechanisms: Import Value Index

local title "Import Value Index (2000=100)"
local var mean_import_value_2001_2019
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
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") title("Effect of 1 s.d. democracy increase on imports", span size(medium)) subtitle("Base specification, no controls", span margin(b=5)) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1)) xscale(range(-200 100)) xlabel(-200(100)100) 
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
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") xscale(range(-200 100)) xlabel(-200(100)100) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1)) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1))
graph export `var'_coef_plot_notitle.png, as(png) name("Graph") replace


*******************************
******************************* Mechanisms: Export Value Index

local title "Export Value Index (2000=100)"
local var mean_export_value_2001_2019
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
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") title("Effect of 1 s.d. democracy increase on exports", span size(medium)) subtitle("Base specification, no controls", span margin(b=5)) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1)) xscale(range(-200 100)) xlabel(-200(100)100)
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
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("`title'") legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1)) xscale(range(-200 100)) xlabel(-200(100)100)
graph export `var'_coef_plot_notitle.png, as(png) name("Graph") replace



