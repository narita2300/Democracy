********************************************************************************
* Table: 2SLS Regression Estimates of Democracy's Effects on Investment and Trade Share
********************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use ${path_data}/total.dta, clear

local start_year = 1961
local end_year = 1970
forv num = 1/5{
	foreach var in loginvpc ltfp marketref ltrade2 lgov lprienr lsecenr lmort unrestn{
		egen mean_`var'_`start_year'_`end_year' = rowmean(`var'`start_year'-`var'`end_year')
		// label variable mean_`var'_`start_year'_`end_year' "Mean "
	}
	local start_year = `start_year'+10
	local end_year = `end_year'+10
}

************************************ First row
************************************ Y: Investment as a Share of GDP in 1991-2000

eststo clear
forv i = 1/5{
			eststo: ivregress 2sls mean_loginvpc_1991_2000 (democracy_vdem1990=${iv`i'}) [w=total_gdp1990], vce(robust)
			eststo: ivregress 2sls mean_loginvpc_1991_2000 abs_lat mean_temp_1981_1990 mean_precip_1981_1990 median_age1990 pop_density1990 (democracy_vdem1990=${iv`i'})[w=total_gdp1990], vce(robust)
}

esttab using ./output/tables/mechanisms_potential1.tex, ///
	replace label b(a1) se(a1) stats(N, labels("N")) ///
	nodepvars nogaps nonotes mlabels(none) keep(democracy_vdem1990) ///
	posthead(`"&\multicolumn{10}{c}{ Dependent Variable is Mean of Log Investment Share in GDP in 1991-2000}\\\cline{2-11}\\[-1.8ex]"') ///
	prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language, trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops, minerals} &  \multicolumn{2}{c}{pop. density} \\"' /// 
	`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')


************************************ Second row
************************************ Y: Investment as a Share of GDP in 2001-2010

eststo clear
forv i = 1/5{
			eststo: ivregress 2sls mean_loginvpc_2001_2010 (democracy_vdem2000=${iv`i'}) [w=total_gdp2000], vce(robust)
			eststo: ivregress 2sls mean_loginvpc_2001_2010 ${base_covariates2000} (democracy_vdem2000=${iv`i'})[w=total_gdp2000], vce(robust)
}

esttab using ./output/tables/mechanisms_potential1.tex, ///
	append label b(a1) se(a1) stats(N, labels("N")) ///
	nodepvars nogaps nonotes mlabels(none) keep(democracy_vdem2000) ///
	posthead(`"&\multicolumn{10}{c}{ Dependent Variable is Mean of Log Investment Share in GDP in 2001-2010}\\\cline{2-11}\\[-1.8ex]"') ///
	prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language, trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops, minerals} &  \multicolumn{2}{c}{pop. density} \\"' /// 
	`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')


************************************ Third row
************************************ Y: Trade as a Share of GDP in 1991-2000

eststo clear
forv i = 1/5{
			eststo: ivregress 2sls mean_ltrade2_1991_2000 (democracy_vdem1990=${iv`i'}) [w=total_gdp1990], vce(robust)
			eststo: ivregress 2sls mean_ltrade2_1991_2000 abs_lat mean_temp_1981_1990 mean_precip_1981_1990 median_age1990 pop_density1990 (democracy_vdem1990=${iv`i'})[w=total_gdp1990], vce(robust)
}
esttab using ./output/tables/mechanisms_potential1.tex, ///
	append label b(a1) se(a1) stats(N, labels("N")) ///
	nodepvars nogaps nonotes mlabels(none) keep(democracy_vdem1990) ///
	posthead(`"&\multicolumn{10}{c}{ Dependent Variable is Mean of Log Trade Share in GDP in 1991-2000}\\\cline{2-11}\\[-1.8ex]"') ///
	prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language, trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops, minerals} &  \multicolumn{2}{c}{pop. density} \\"' /// 
	`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')


************************************ Fourth row
************************************ Y: Trade as a Share of GDP in 2001-2010

eststo clear
forv i = 1/5{
			eststo: ivregress 2sls mean_ltrade2_2001_2010 (democracy_vdem2000=${iv`i'}) [w=total_gdp2000], vce(robust)
			eststo: ivregress 2sls mean_ltrade2_2001_2010 ${base_covariates2000} (democracy_vdem2000=${iv`i'})[w=total_gdp2000], vce(robust)
}

esttab using ./output/tables/mechanisms_potential1.tex, ///
	append label b(a1) se(a1) stats(N, labels("N")) ///
	nodepvars nogaps nonotes mlabels(none) keep(democracy_vdem2000) ///
	posthead(`"&\multicolumn{10}{c}{ Dependent Variable is Mean of Log Trade Share in GDP in 2001-2010}\\\cline{2-11}\\[-1.8ex]"') ///
	prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language, trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops, minerals} &  \multicolumn{2}{c}{pop. density} \\"' /// 
	`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')

