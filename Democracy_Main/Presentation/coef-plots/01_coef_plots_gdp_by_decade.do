
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data
cd ${path_dropbox}/figures

*** Load data 
use ${path_data}/total.dta, replace

**************************** GDP GROWTH IN 1980s *******************************

local var mean_growth_rate_1981_1990
eststo clear
forv i = 1/6{
	if `i' == 6{
		eststo r`i': reg `var' democracy_vdem1980 if logem != . & lpd1500s !=. & legor_uk !=. & EurFrac !=. & bananas!=. & copper !=. [w=total_gdp1980] , vce(robust)
	}
	else {
		eststo r`i': reg `var' democracy_vdem1980 if `:word 1 of ${iv`i'}' !=. [w=total_gdp1980], vce(robust)
	}
	eststo m`i': ivregress 2sls `var' (democracy_vdem1980=${iv`i'}) [w=total_gdp1980], vce(robust)
}
local var mean_growth_rate_1981_1990
eststo m1: ivreg2 `var' (democracy_vdem1980=${iv1}) [w=total_gdp1980],robust
eststo m2: ivreg2 `var' (democracy_vdem1980=${iv2}) [w=total_gdp1980],robust
eststo m3: ivreg2 `var' (democracy_vdem1980=${iv3}) [w=total_gdp1980],robust
eststo m4: ivreg2 `var' (democracy_vdem1980=${iv4}) [w=total_gdp1980],robust
eststo m5: ivreg2 `var' (democracy_vdem1980=${iv5}) [w=total_gdp1980],robust
eststo m6: ivreg2 `var' (democracy_vdem1980=${iv6}) [w=total_gdp1980],robust

coefplot (m1,  keep(democracy_vdem1980) rename(democracy_vdem1980 = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r1,  keep(democracy_vdem1980) rename(democracy_vdem1980 = "Settler Mortality IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m2, keep(democracy_vdem1980) rename(democracy_vdem1980 = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r2,  keep(democracy_vdem1980) rename(democracy_vdem1980 = "Population Density IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m3, keep(democracy_vdem1980) rename(democracy_vdem1980 = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r3,  keep(democracy_vdem1980) rename(democracy_vdem1980 = "Legal Origin IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m4, keep(democracy_vdem1980) rename(democracy_vdem1980 = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r4,  keep(democracy_vdem1980) rename(democracy_vdem1980 = "Language IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m5, keep(democracy_vdem1980) rename(democracy_vdem1980 = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r5,  keep(democracy_vdem1980) rename(democracy_vdem1980 = "Crops & Minerals IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m6, keep(democracy_vdem1980) rename(democracy_vdem1980 = "All IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r6,  keep(democracy_vdem1980) rename(democracy_vdem1980 = "All IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Mean GDP Growth Rate in 1981-1990") xscale(range(-5 5)) xlabel(-5(1)5) title("Effect of 1 s.d. democracy increase on economic growth in 21st century", span size(medium)) subtitle("Base specification, no controls", span margin(b=5)) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1))

graph export `var'_coef_plot_hastitle.png, as(png) name("Graph") replace

coefplot (m1,  keep(democracy_vdem1980) rename(democracy_vdem1980 = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r1,  keep(democracy_vdem1980) rename(democracy_vdem1980 = "Settler Mortality IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m2, keep(democracy_vdem1980) rename(democracy_vdem1980 = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r2,  keep(democracy_vdem1980) rename(democracy_vdem1980 = "Population Density IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m3, keep(democracy_vdem1980) rename(democracy_vdem1980 = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r3,  keep(democracy_vdem1980) rename(democracy_vdem1980 = "Legal Origin IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m4, keep(democracy_vdem1980) rename(democracy_vdem1980 = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r4,  keep(democracy_vdem1980) rename(democracy_vdem1980 = "Language IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m5, keep(democracy_vdem1980) rename(democracy_vdem1980 = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r5,  keep(democracy_vdem1980) rename(democracy_vdem1980 = "Crops & Minerals IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m6, keep(democracy_vdem1980) rename(democracy_vdem1980 = "All IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r6,  keep(democracy_vdem1980) rename(democracy_vdem1980 = "All IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Mean GDP Growth Rate in 1981-1990") xscale(range(-5 5)) xlabel(-5(1)5) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1))

graph export `var'_coef_plot_notitle.png, as(png) name("Graph") replace

**************************** GDP GROWTH IN 1980s *******************************

local var mean_growth_rate_1991_2000
eststo clear
forv i = 1/6{
	if `i' == 6{
		eststo r`i': reg `var' democracy_vdem1990 if logem != . & lpd1500s !=. & legor_uk !=. & EurFrac !=. & bananas!=. & copper !=. [w=total_gdp1990], vce(robust)
	}
	else {
		eststo r`i': reg `var' democracy_vdem1990 if `:word 1 of ${iv`i'}' !=. [w=total_gdp1990], vce(robust)
	}
	eststo m`i': ivregress 2sls `var' (democracy_vdem1990=${iv`i'})[w=total_gdp1990], vce(robust)
}

coefplot (m1,  keep(democracy_vdem1990) rename(democracy_vdem1990 = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r1,  keep(democracy_vdem1990) rename(democracy_vdem1990 = "Settler Mortality IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m2, keep(democracy_vdem1990) rename(democracy_vdem1990 = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r2,  keep(democracy_vdem1990) rename(democracy_vdem1990 = "Population Density IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m3, keep(democracy_vdem1990) rename(democracy_vdem1990 = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r3,  keep(democracy_vdem1990) rename(democracy_vdem1990 = "Legal Origin IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m4, keep(democracy_vdem1990) rename(democracy_vdem1990 = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r4,  keep(democracy_vdem1990) rename(democracy_vdem1990 = "Language IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m5, keep(democracy_vdem1990) rename(democracy_vdem1990 = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r5,  keep(democracy_vdem1990) rename(democracy_vdem1990 = "Crops & Minerals IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m6, keep(democracy_vdem1990) rename(democracy_vdem1990 = "All IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r6,  keep(democracy_vdem1990) rename(democracy_vdem1990 = "All IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Mean GDP Growth Rate in 1991-2000") xscale(range(-5 5)) xlabel(-5(1)5) title("Effect of 1 s.d. democracy increase on economic growth in 21st century", span size(medium)) subtitle("Base specification, no controls", span margin(b=5)) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1))

graph export `var'_coef_plot_hastitle.png, as(png) name("Graph") replace

coefplot (m1,  keep(democracy_vdem1990) rename(democracy_vdem1990 = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r1,  keep(democracy_vdem1990) rename(democracy_vdem1990 = "Settler Mortality IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m2, keep(democracy_vdem1990) rename(democracy_vdem1990 = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r2,  keep(democracy_vdem1990) rename(democracy_vdem1990 = "Population Density IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m3, keep(democracy_vdem1990) rename(democracy_vdem1990 = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r3,  keep(democracy_vdem1990) rename(democracy_vdem1990 = "Legal Origin IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m4, keep(democracy_vdem1990) rename(democracy_vdem1990 = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r4,  keep(democracy_vdem1990) rename(democracy_vdem1990 = "Language IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m5, keep(democracy_vdem1990) rename(democracy_vdem1990 = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r5,  keep(democracy_vdem1990) rename(democracy_vdem1990 = "Crops & Minerals IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m6, keep(democracy_vdem1990) rename(democracy_vdem1990 = "All IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r6,  keep(democracy_vdem1990) rename(democracy_vdem1990 = "All IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Mean GDP Growth Rate in 1991-2000") xscale(range(-5 5)) xlabel(-5(1)5) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1))

graph export `var'_coef_plot_notitle.png, as(png) name("Graph") replace

**************************** GDP GROWTH IN 1981-2000 *******************************

local var mean_growth_rate_1981_2000
eststo clear
forv i = 1/6{
	if `i' == 6{
		eststo r`i': reg `var' democracy_vdem1980 if logem != . & lpd1500s !=. & legor_uk !=. & EurFrac !=. & bananas!=. & copper !=. ${weight2000}, vce(robust)
	}
	else {
		eststo r`i': reg `var' democracy_vdem1980 if `:word 1 of ${iv`i'}' !=. ${weight2000}, vce(robust)
	}
	eststo m`i': ivregress 2sls `var' (democracy_vdem1980=${iv`i'})${weight2000}, vce(robust)
}

coefplot (m1,  keep(democracy_vdem1980) rename(democracy_vdem1980 = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r1,  keep(democracy_vdem1980) rename(democracy_vdem1980 = "Settler Mortality IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m2, keep(democracy_vdem1980) rename(democracy_vdem1980 = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r2,  keep(democracy_vdem1980) rename(democracy_vdem1980 = "Population Density IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m3, keep(democracy_vdem1980) rename(democracy_vdem1980 = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r3,  keep(democracy_vdem1980) rename(democracy_vdem1980 = "Legal Origin IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m4, keep(democracy_vdem1980) rename(democracy_vdem1980 = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r4,  keep(democracy_vdem1980) rename(democracy_vdem1980 = "Language IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m5, keep(democracy_vdem1980) rename(democracy_vdem1980 = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r5,  keep(democracy_vdem1980) rename(democracy_vdem1980 = "Crops & Minerals IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m6, keep(democracy_vdem1980) rename(democracy_vdem1980 = "All IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r6,  keep(democracy_vdem1980) rename(democracy_vdem1980 = "All IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Mean GDP Growth Rate in 1981-2000") xscale(range(-5 5)) xlabel(-5(1)5) title("Effect of 1 s.d. democracy increase on economic growth in 1981-2000", span size(medium)) subtitle("Base specification, no controls", span margin(b=5)) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1))

graph export `var'_coef_plot_hastitle.png, as(png) name("Graph") replace

coefplot (m1,  keep(democracy_vdem1980) rename(democracy_vdem1980 = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r1,  keep(democracy_vdem1980) rename(democracy_vdem1980 = "Settler Mortality IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m2, keep(democracy_vdem1980) rename(democracy_vdem1980 = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r2,  keep(democracy_vdem1980) rename(democracy_vdem1980 = "Population Density IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m3, keep(democracy_vdem1980) rename(democracy_vdem1980 = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r3,  keep(democracy_vdem1980) rename(democracy_vdem1980 = "Legal Origin IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m4, keep(democracy_vdem1980) rename(democracy_vdem1980 = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r4,  keep(democracy_vdem1980) rename(democracy_vdem1980 = "Language IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m5, keep(democracy_vdem1980) rename(democracy_vdem1980 = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r5,  keep(democracy_vdem1980) rename(democracy_vdem1980 = "Crops & Minerals IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m6, keep(democracy_vdem1980) rename(democracy_vdem1980 = "All IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r6,  keep(democracy_vdem1980) rename(democracy_vdem1980 = "All IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Mean GDP Growth Rate in 1981-2000") xscale(range(-5 5)) xlabel(-5(1)5) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI") row(1))

graph export `var'_coef_plot_notitle.png, as(png) name("Graph") replace

