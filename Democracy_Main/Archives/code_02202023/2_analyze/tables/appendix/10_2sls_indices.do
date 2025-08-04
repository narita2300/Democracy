********************************************************************************
* Table: 2SLS Regression with Alternative Democracy Indices
********************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use ${path_data}/total.dta, replace

*** Make the sample size consistent across different weightings
drop if democracy_fh2019==. | democracy_fh2003==. 
drop if democracy_csp2018==. | democracy_csp2000==.
drop if democracy_vdem2019==. | democracy_vdem2000==.
drop if democracy_eiu2019==. | democracy_eiu2006==.


* weight = GDP (total_gdp)

// local num=1

foreach var in mean_growth_rate_2001_2019 gdp_growth2020 total_deaths_per_million {
	
	if "`var'" == "gdp_growth2020" | "`var'"== "total_deaths_per_million"{
		local weight "total_gdp2019"
		local covariates "${base_covariates2019}"
		local index "democracy_vdem2019 democracy_csp2018 democracy_fh2019 democracy_eiu2019"
	}
	
	else if "`var'" == "mean_growth_rate_2001_2019" {
		di "Second if!"
		local weight "total_gdp2000"
		local covariates "${base_covariates2000}"
		local index "democracy_vdem2000 democracy_csp2000 democracy_fh2003 democracy_eiu2006"
		
	}
	
	local num = 1
	foreach i in `index'{
		
		eststo clear
		forv j = 1/5{
			eststo: ivregress 2sls `var' (`i'=${iv`j'})[w=`weight'], vce(robust)
			eststo: ivregress 2sls `var' `covariates' (`i'=${iv`j'})[w=`weight'], vce(robust)
		}
			
		if "`i'" == "democracy_eiu2019" & "`var'" == "total_deaths_per_million"{
			local last `"stats(N, labels("N")) prefoot(`" \hline \\[-1.8ex] IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals}  \\ Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') "'
		} 
		
		else {
			local last "noobs"
		}
		
		esttab using ${path_appendix}/10_2sls_index_panel`num'.tex, keep(`i') append label b(a1) se(a1) nodepvars nostar `last'
		
		local num = `num' + 1
	
	}
	
	include "${path_code}/2_analyze/tables/PanelCombine_simplest.do"
panelcombine, use(${path_appendix}/10_2sls_index_panel1.tex ${path_appendix}/10_2sls_index_panel2.tex ${path_appendix}/10_2sls_index_panel3.tex ${path_appendix}/10_2sls_index_panel4.tex) paneltitles("") columncount(11) save(10_2sls_index_`var'.tex) cleanup

}

// include "${path_code}/2_analyze/tables/PanelCombine.do"
// panelcombine, use(table2_panelA1.tex table2_panelA2.tex table2_panelA3.tex) paneltitles("`: var label `:word 1 of `outcomes'''" "`: var label `:word 2 of `outcomes'''" "`: var label `:word 3 of `outcomes'''") columncount(11) save(table2_panelA.tex) cleanup


