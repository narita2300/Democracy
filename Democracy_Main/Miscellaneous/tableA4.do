

************************************
************************************ base specification with updated GDP growth rate 

eststo clear
	forv i = 1/5{
		eststo: ivregress 2sls gdp_growth2020 (democracy_fh2020=${iv`i'})[w=total_gdp], vce(robust)
		eststo: ivregress 2sls gdp_growth2020 ${base_covariates} (democracy_fh2020=${iv`i'})[w=total_gdp], vce(robust)
		}
		esttab using ./output/tables/other/updated_gdp.tex, ///
keep(democracy_fh2020) ///
replace label b(a1) se(a1) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) ///
title(`"2SLS Regression Estimates of Democracy's Effects'"') ///
posthead(`"  & \multicolumn{10}{c}{ Dependent Variable is the GDP Growth Rate in 2020} \\ \cline{2-11}  \\[-1.8ex]"') ///
prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language, trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops, minerals} &  \multicolumn{2}{c}{pop. density} \\"' ///
`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') 



************************************
************************************ updated GDP growth rate in 2020, add control for 2019 growth rate

eststo clear
	forv i = 1/5{
		eststo: ivregress 2sls gdp_growth2020 gdp_growth2019 (democracy_fh2020=${iv`i'})[w=total_gdp], vce(robust)
		eststo: ivregress 2sls gdp_growth2020 gdp_growth2019 ${base_covariates} (democracy_fh2020=${iv`i'})[w=total_gdp], vce(robust)
		}
		esttab using ./output/tables/other/control_growth_rate_2019.tex, ///
keep(democracy_fh2020) ///
replace label b(a1) se(a1) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) ///
title(`"Democracy's Effect on GDP Growth Rate in 2020 with control for GDP Growth Rate in 2019"') ///
posthead(`"  & \multicolumn{10}{c}{ Dependent Variable is the GDP Growth Rate in 2020} \\ \cline{2-11}  \\[-1.8ex]"') ///
prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language, trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops, minerals} &  \multicolumn{2}{c}{pop. density} \\"' ///
`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') 


************************************
************************************ 

eststo clear
	forv i = 1/5{
		eststo: ivregress 2sls growth_rate2020 (democracy_fh2020=${iv`i'})[w=total_gdp], vce(robust)
		eststo: ivregress 2sls growth_rate2020 ${base_covariates} (democracy_fh2020=${iv`i'})[w=total_gdp], vce(robust)
		}
		esttab using ./output/tables/other/rem_growth_rate_2019.tex, ///
keep(democracy_fh2020) ///
replace label b(a1) se(a1) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) ///
title(`"Democracy's Effect on the Difference in Annual GDP Growth Rate between 2019 and 2020"') ///
posthead(`" \textbf{ Panel B:} & \multicolumn{10}{c}{ Dependent Variable is the Difference in  the Annual GDP Growth Rate Between 2019 and 2020} \\ \cline{2-11}  \\[-1.8ex]"') ///
prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language, trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops, minerals} &  \multicolumn{2}{c}{pop. density} \\"' ///
`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') 


************************************
************************************ Y is the difference in the GDP growth rate in 2020 and the GDP growth rate in 2019 (Table 1)

// Control for previous trends in the GDP growth rates by taking the average growth rate across 20 years as a dummy variable. 
// Subtract the growth rate in 2019 from the growth rate in 2020 and make that the outcome variable. 
gen growth_rate_diff = gdp_growth2020 - gdp_growth2019
eststo clear 
forv i = 1/5{
		eststo: ivregress 2sls growth_rate_diff (democracy_fh2020=${iv`i'})[w=total_gdp], vce(robust)
		eststo: ivregress 2sls growth_rate_diff ${base_covariates} (democracy_fh2020=${iv`i'})[w=total_gdp], vce(robust)
	}

esttab using ./output/tables/other/rem_growth_rate_2019.tex, ///
keep(democracy_fh2020) ///
replace label b(a1) se(a1) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) ///
title(`"Democracy's Effect on the Difference in Annual GDP Growth Rate between 2019 and 2020"') ///
posthead(`" \textbf{ Panel B:} & \multicolumn{10}{c}{ Dependent Variable is the Difference in  the Annual GDP Growth Rate Between 2019 and 2020} \\ \cline{2-11}  \\[-1.8ex]"') ///
prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language, trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops, minerals} &  \multicolumn{2}{c}{pop. density} \\"' ///
`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') 


************************************
************************************ Y is the percentage deviation of the GDP growth rate in 2020 from the GDP growth rate in 2019 (Table 2)

// Control for previous trends in the GDP growth rates by taking the average growth rate across 20 years as a dummy variable. 
// Subtract the growth rate in 2019 from the growth rate in 2020 and divide it by the growth rate in 2019. 
gen growth_rate_diff = gdp_growth2020 - gdp_growth2019
gen growth_rate_diff_rate = (growth_rate_diff/gdp_growth2019)*100
eststo clear 
forv i = 1/5{
		eststo: ivregress 2sls growth_rate_diff_rate (democracy_fh2020=${iv`i'})[w=total_gdp], vce(robust)
		eststo: ivregress 2sls growth_rate_diff_rate ${base_covariates} (democracy_fh2020=${iv`i'})[w=total_gdp], vce(robust)
	}

esttab using ./output/tables/other/growth_rate_diff_rate.tex, ///
keep(democracy_fh2020) ///
replace label b(a1) se(a1) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) ///
title(`"Democracy's Effect on \% Deviation from GDP Growth Rate in 2019"') ///
posthead(`" \textbf{ Panel B:} & \multicolumn{10}{c}{ Dependent Variable is \% Deviation of GDP Growth Rate in 2020 from GDP Growth Rate in 2019} \\ \cline{2-11}  \\[-1.8ex]"') ///
prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language, trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops, minerals} &  \multicolumn{2}{c}{pop. density} \\"' ///
`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') 



************************************
************************************ Y is the difference in the GDP growth rate in 2020 and the GDP growth rate in 2010-19 (Table 3)

egen sum_growth_rate10 = rowtotal(gdp_growth201*)
gen mean_growth_rate10 = sum_growth_rate10/10
gen growth_rate_rem_trend_10 = gdp_growth2020 - mean_growth_rate10
eststo clear 
forv i = 1/5{
		eststo: ivregress 2sls growth_rate_rem_trend_10 (democracy_fh2020=${iv`i'})[w=total_gdp], vce(robust)
		eststo: ivregress 2sls growth_rate_rem_trend_10 ${base_covariates} (democracy_fh2020=${iv`i'})[w=total_gdp], vce(robust)
		}

esttab using ./output/tables/all/rem_growth_trend_10.tex, ///
keep(democracy_fh2020) ///
replace label b(a1) se(a1) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) ///
title(`"Democracy's Effect on the Difference Between the Average Growth Rate in 2010-2019 and the Growth Rate in 2020"') ///
posthead(`" \textbf{ Panel B:} & \multicolumn{10}{c}{ Dependent Variable is the Difference Between the Average Growth Rate in 2010-2019 and the Growth Rate in 2020} \\ \cline{2-11}  \\[-1.8ex]"') ///
prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language, trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops, minerals} &  \multicolumn{2}{c}{pop. density} \\"' ///
`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') 

		
		
esttab using ./output/tables/all/rem_growth_trend_10.csv, keep(democracy_fh2020) replace label b(a1) se(a1) nolines nogaps compress nonotes depvars mlabels("settler mortality IV" "settler mortality IV" "language and trade IVs" "language and trade IVs" "legal origin IV" "legal origin IV" "crops and minerals IVs" "crops and minerals IVs" "pop. density IV" "pop density IV")

