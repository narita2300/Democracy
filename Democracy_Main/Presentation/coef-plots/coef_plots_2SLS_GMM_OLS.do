clear 

*** Change to appropriate directory
cd "/Users/leonardofancello/Desktop/Yale/Democracy/MainAnalysisRep/Presentation New/new_figures/additional"

*** Load data 
use ${path_data}/total.dta, replace


**************************** EXCESS MORTALITY *******************************

local var excess_mortality_rate_100k
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
     offset(-0.4) mcolor(gs10) ciopts(lcolor(gs10))), xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) xtitle("Mean Excess Deaths per 100k People in 2020-2022") xscale(range(-15 50)) xlabel(-15(5)50) legend(order(2 "2SLS" 4 "GMM" 6 "OLS" 1 "95% CI") row(1) position(6)) ysize(5)

graph export excess_mortality_coef_plot_notitle_3models.png, as(png) name("Graph") replace

**************************** LIFE SATISFACTION 2010-2019 *******************************

local var life_ladder_2010_2019
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
     offset(-0.4) mcolor(gs10) ciopts(lcolor(gs10))), xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) xtitle("Mean Life Satisfaction Growth Rate in 2010-2019") xscale(range(-5 5)) xlabel(-5(1)5) legend(order(2 "2SLS" 4 "GMM" 6 "OLS" 1 "95% CI") row(1) position(6)) ysize(5)

graph export life_ladder_2010_2019_coef_plot_notitle_3models.png, as(png) name("Graph") replace

**************************** LIFE SATISFACTION 2020-2022 *******************************

local var life_ladder_2020_2022
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
     offset(-0.4) mcolor(gs10) ciopts(lcolor(gs10))), xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) xtitle("Mean Life Satisfaction Growth Rate in 2020-2022") xscale(range(-5 5)) xlabel(-5(1)5) legend(order(2 "2SLS" 4 "GMM" 6 "OLS" 1 "95% CI") row(1) position(6)) ysize(5)

graph export life_ladder_2020_2022_coef_plot_notitle_3models.png, as(png) name("Graph") replace

**************************** TOP 1% INCOME SHARE 2001-2019 *******************************

local var mean_top1_inc_shr_2001_2019
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
     offset(-0.4) mcolor(gs10) ciopts(lcolor(gs10))), xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) xtitle("Mean Top 1% Income Share Growth Rate in 2001-2019") xscale(range(-5 5)) xlabel(-5(1)5) legend(order(2 "2SLS" 4 "GMM" 6 "OLS" 1 "95% CI") row(1) position(6)) ysize(5)

graph export top1_inc_shr_2001_2019_coef_plot_notitle_3models.png, as(png) name("Graph") replace

**************************** TOP 1% INCOME SHARE 2020-2022 *******************************

local var mean_top1_inc_shr_2020_2022
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
     offset(-0.4) mcolor(gs10) ciopts(lcolor(gs10))), xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) xtitle("Mean Top 1% Income Share Growth Rate in 2020-2022") xscale(range(-5 5)) xlabel(-5(1)5) legend(order(2 "2SLS" 4 "GMM" 6 "OLS" 1 "95% CI") row(1) position(6)) ysize(5)

graph export top1_inc_shr_2020_2022_coef_plot_notitle_3models.png, as(png) name("Graph") replace

**************************** CO2 EMISSIONS 2001-2019 *******************************

local var avg_co2_emissions_2001_2019
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
     offset(-0.4) mcolor(gs10) ciopts(lcolor(gs10))), xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) xtitle("Mean CO2 Emissions per Capita Growth Rate in 2001-2019") xscale(range(-5 5)) xlabel(-5(1)5) legend(order(2 "2SLS" 4 "GMM" 6 "OLS" 1 "95% CI") row(1) position(6)) ysize(5)

graph export co2_emissions_2001_2019_coef_plot_notitle_3models.png, as(png) name("Graph") replace

**************************** CO2 EMISSIONS 2020-2022 *******************************

local var avg_co2_emissions_2020_2022
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
     offset(-0.4) mcolor(gs10) ciopts(lcolor(gs10))), xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) xtitle("Mean CO2 Emissions per Capita Growth Rate in 2020-2022") xscale(range(-5 5)) xlabel(-5(1)5) legend(order(2 "2SLS" 4 "GMM" 6 "OLS" 1 "95% CI") row(1) position(6)) ysize(5)

graph export co2_emissions_2020_2022_coef_plot_notitle_3models.png, as(png) name("Graph") replace

**************************** ENERGY CONSUMPTION 2001-2019 *******************************

local var avg_energy_2001_2019
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
     offset(-0.4) mcolor(gs10) ciopts(lcolor(gs10))), xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) xtitle("Mean Energy Consumption per Capita Growth Rate in 2001-2019") xscale(range(-5 5)) xlabel(-5(1)5) legend(order(2 "2SLS" 4 "GMM" 6 "OLS" 1 "95% CI") row(1) position(6)) ysize(5)

graph export energy_2001_2019_coef_plot_notitle_3models.png, as(png) name("Graph") replace

**************************** ENERGY CONSUMPTION 2020-2022 *******************************

local var avg_energy_2020_2022
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
     offset(-0.4) mcolor(gs10) ciopts(lcolor(gs10))), xline(0, lcolor(red) lpattern(solid)) graphregion(color(white)) xtitle("Mean Energy Consumption per Capita Growth Rate in 2020-2022") xscale(range(-5 5)) xlabel(-5(1)5) legend(order(2 "2SLS" 4 "GMM" 6 "OLS" 1 "95% CI") row(1) position(6)) ysize(5)

graph export energy_2020_2022_coef_plot_notitle_3models.png, as(png) name("Graph") replace
