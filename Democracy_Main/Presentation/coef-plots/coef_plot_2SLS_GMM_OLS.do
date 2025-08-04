clear 

*** Change to appropriate directory
cd "/Users/leonardofancello/Desktop/Yale/Democracy/MainAnalysisRep/Presentation New/new_figures/main3"

*** Load data 
use ${path_data}/total.dta, replace

**************************** GDP GROWTH IN 2020-2022 *******************************
local var mean_growth_rate_2020_2022
local x_title "Mean GDP Growth Rate in 2020-2022"
local var_name "economic growth in 2020-2022"

eststo clear
forv i = 1/6{
	
	if `i' == 6{
		eststo s`i': reg `var' ${dem2019} if logem != . & lpd1500s !=. & legor_uk !=. & EurFrac !=. & bananas!=. & copper !=. ${weight2019}, vce(robust)
	}
	else {
		eststo s`i': reg `var' ${dem2019} if `:word 1 of ${iv`i'}' !=. ${weight2019}, vce(robust)
	}

	eststo m`i': ivregress 2sls `var' (${dem2019}=${iv`i'})${weight2019}, vce(robust)
	eststo r`i': ivregress gmm `var' (${dem2019}=${iv`i'})${weight2019}, vce(robust)

}

coefplot ///
(m1,  keep(${dem2019}) rename(${dem2019} = "Settler Mortality IV") ///
     mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(r1,  keep(${dem2019}) rename(${dem2019} = "Settler Mortality IV") ///
     offset(-0.2) mcolor(green) ciopts(lcolor(green))) ///
(s1,  keep(${dem2019}) rename(${dem2019} = "Settler Mortality IV") ///
     offset(-0.4) mcolor(gs10) ciopts(lcolor(gs10))) ///
(m2,  keep(${dem2019}) rename(${dem2019} = "Population Density IV") ///
     mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(r2,  keep(${dem2019}) rename(${dem2019} = "Population Density IV") ///
     offset(-0.2) mcolor(green) ciopts(lcolor(green))) ///
(s2,  keep(${dem2019}) rename(${dem2019} = "Population Density IV") ///
     offset(-0.4) mcolor(gs10) ciopts(lcolor(gs10))) ///
(m3,  keep(${dem2019}) rename(${dem2019} = "Legal Origin IV") ///
     mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(r3,  keep(${dem2019}) rename(${dem2019} = "Legal Origin IV") ///
     offset(-0.2) mcolor(green) ciopts(lcolor(green))) ///
(s3,  keep(${dem2019}) rename(${dem2019} = "Legal Origin IV") ///
     offset(-0.4) mcolor(gs10) ciopts(lcolor(gs10))) ///
(m4,  keep(${dem2019}) rename(${dem2019} = "Language IVs") ///
     mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(r4,  keep(${dem2019}) rename(${dem2019} = "Language IVs") ///
     offset(-0.2) mcolor(green) ciopts(lcolor(green))) ///
(s4,  keep(${dem2019}) rename(${dem2019} = "Language IVs") ///
     offset(-0.4) mcolor(gs10) ciopts(lcolor(gs10))) ///
(m5,  keep(${dem2019}) rename(${dem2019} = "Crops & Minerals IVs") ///
     mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(r5,  keep(${dem2019}) rename(${dem2019} = "Crops & Minerals IVs") ///
     offset(-0.2) mcolor(green) ciopts(lcolor(green))) ///
(s5,  keep(${dem2019}) rename(${dem2019} = "Crops & Minerals IVs") ///
     offset(-0.4) mcolor(gs10) ciopts(lcolor(gs10))) ///
(m6,  keep(${dem2019}) rename(${dem2019} = "All IVs") ///
     mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(r6,  keep(${dem2019}) rename(${dem2019} = "All IVs") ///
     offset(-0.2) mcolor(green) ciopts(lcolor(green))) ///
(s6,  keep(${dem2019}) rename(${dem2019} = "All IVs") ///
     offset(-0.4) mcolor(gs10) ciopts(lcolor(gs10))), xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) xtitle("`x_title'") xscale(range(-5 5)) xlabel(-5(1)5) legend(order(2 "2SLS" 4 "GMM" 6 "OLS" 1 "95% CI") row(1) position(6)) ysize(5)

graph export gdp_coef_plot_notitle_3models.png, as(png) name("Graph") replace

**************************** GDP GROWTH IN 2001-2019 *******************************

local var mean_growth_rate_2001_2019
eststo clear
forv i = 1/6{
	
	if `i' == 6{
		eststo s`i': reg `var' ${dem2000} if logem != . & lpd1500s !=. & legor_uk !=. & EurFrac !=. & bananas!=. & copper !=. ${weight2000}, vce(robust)
	}
	else {
		eststo s`i': reg `var' ${dem2000} if `:word 1 of ${iv`i'}' !=. ${weight2000}, vce(robust)
	}
	
	eststo m`i': ivregress 2sls `var' (${dem2000}=${iv`i'})${weight2000}, vce(robust)
	eststo r`i': ivregress gmm `var' (${dem2000}=${iv`i'})${weight2000}, vce(robust)
}

coefplot ///
(m1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") ///
     mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(r1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") ///
     offset(-0.2) mcolor(green) ciopts(lcolor(green))) ///
(s1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") ///
     offset(-0.4) mcolor(gs10) ciopts(lcolor(gs10))) ///
(m2,  keep(${dem2000}) rename(${dem2000} = "Population Density IV") ///
     mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(r2,  keep(${dem2000}) rename(${dem2000} = "Population Density IV") ///
     offset(-0.2) mcolor(green) ciopts(lcolor(green))) ///
(s2,  keep(${dem2000}) rename(${dem2000} = "Population Density IV") ///
     offset(-0.4) mcolor(gs10) ciopts(lcolor(gs10))) ///
(m3,  keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") ///
     mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(r3,  keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") ///
     offset(-0.2) mcolor(green) ciopts(lcolor(green))) ///
(s3,  keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") ///
     offset(-0.4) mcolor(gs10) ciopts(lcolor(gs10))) ///
(m4,  keep(${dem2000}) rename(${dem2000} = "Language IVs") ///
     mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(r4,  keep(${dem2000}) rename(${dem2000} = "Language IVs") ///
     offset(-0.2) mcolor(green) ciopts(lcolor(green))) ///
(s4,  keep(${dem2000}) rename(${dem2000} = "Language IVs") ///
     offset(-0.4) mcolor(gs10) ciopts(lcolor(gs10))) ///
(m5,  keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") ///
     mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(r5,  keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") ///
     offset(-0.2) mcolor(green) ciopts(lcolor(green))) ///
(s5,  keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") ///
     offset(-0.4) mcolor(gs10) ciopts(lcolor(gs10))) ///
(m6,  keep(${dem2000}) rename(${dem2000} = "All IVs") ///
     mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(r6,  keep(${dem2000}) rename(${dem2000} = "All IVs") ///
     offset(-0.2) mcolor(green) ciopts(lcolor(green))) ///
(s6,  keep(${dem2000}) rename(${dem2000} = "All IVs") ///
     offset(-0.4) mcolor(gs10) ciopts(lcolor(gs10))), xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) xtitle("Mean GDP Growth Rate in 2001-2019") xscale(range(-5 5)) xlabel(-5(1)5) legend(order(2 "2SLS" 4 "GMM" 6 "OLS" 1 "95% CI") row(1) position(6)) ysize(5)

graph export gdp_21st_coef_plot_notitle_3models.png, as(png) name("Graph") replace

***************************NIGHTLIGHTS**********************************************

local var mean_g_night_light_2001_2013
eststo clear
forv i = 1/6{
	
	if `i' == 6{
		eststo s`i': reg `var' ${dem2000} if logem != . & lpd1500s !=. & legor_uk !=. & EurFrac !=. & bananas!=. & copper !=. ${weight2000}, vce(robust)
	}
	else {
		eststo s`i': reg `var' ${dem2000} if `:word 1 of ${iv`i'}' !=. ${weight2000}, vce(robust)
	}
	
	eststo m`i': ivregress 2sls `var' (${dem2000}=${iv`i'})${weight2000}, vce(robust)
	eststo r`i': ivregress gmm `var' (${dem2000}=${iv`i'})${weight2000}, vce(robust)
}

coefplot ///
(m1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") ///
     mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(r1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") ///
     offset(-0.2) mcolor(green) ciopts(lcolor(green))) ///
(s1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") ///
     offset(-0.4) mcolor(gs10) ciopts(lcolor(gs10))) ///
(m2,  keep(${dem2000}) rename(${dem2000} = "Population Density IV") ///
     mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(r2,  keep(${dem2000}) rename(${dem2000} = "Population Density IV") ///
     offset(-0.2) mcolor(green) ciopts(lcolor(green))) ///
(s2,  keep(${dem2000}) rename(${dem2000} = "Population Density IV") ///
     offset(-0.4) mcolor(gs10) ciopts(lcolor(gs10))) ///
(m3,  keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") ///
     mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(r3,  keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") ///
     offset(-0.2) mcolor(green) ciopts(lcolor(green))) ///
(s3,  keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") ///
     offset(-0.4) mcolor(gs10) ciopts(lcolor(gs10))) ///
(m4,  keep(${dem2000}) rename(${dem2000} = "Language IVs") ///
     mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(r4,  keep(${dem2000}) rename(${dem2000} = "Language IVs") ///
     offset(-0.2) mcolor(green) ciopts(lcolor(green))) ///
(s4,  keep(${dem2000}) rename(${dem2000} = "Language IVs") ///
     offset(-0.4) mcolor(gs10) ciopts(lcolor(gs10))) ///
(m5,  keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") ///
     mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(r5,  keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") ///
     offset(-0.2) mcolor(green) ciopts(lcolor(green))) ///
(s5,  keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") ///
     offset(-0.4) mcolor(gs10) ciopts(lcolor(gs10))) ///
(m6,  keep(${dem2000}) rename(${dem2000} = "All IVs") ///
     mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(r6,  keep(${dem2000}) rename(${dem2000} = "All IVs") ///
     offset(-0.2) mcolor(green) ciopts(lcolor(green))) ///
(s6,  keep(${dem2000}) rename(${dem2000} = "All IVs") ///
     offset(-0.4) mcolor(gs10) ciopts(lcolor(gs10))), xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) xtitle("Mean Night-time Light Intensity Growth Rate in 2001-2013") xscale(range(-5 5)) xlabel(-5(1)5) legend(order(2 "2SLS" 4 "GMM" 6 "OLS" 1 "95% CI") row(1) position(6)) ysize(5)

graph export nightlight_21st_coef_plot_notitle_3models.png, as(png) name("Graph") replace
