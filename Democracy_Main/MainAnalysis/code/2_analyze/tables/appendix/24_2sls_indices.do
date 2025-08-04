********************************************************************************
* Table: 2SLS Regression with Alternative Democracy Indices
********************************************************************************
clear 

*** Load data 
use ${path_data}/total.dta, replace

*** Make the sample size consistent across different weightings
drop if democracy_fh2019==. | democracy_fh2003==. 
drop if democracy_csp2018==. | democracy_csp2000==.
drop if democracy_vdem2019==. | democracy_vdem2000==.
drop if democracy_eiu2019==. | democracy_eiu2006==.

* weight = GDP (total_gdp)

local outcomes ${outcome1} ${outcome2} ${outcome3}

foreach var of local outcomes {
    
    if "`var'" == "${outcome2}" {
        local weight "total_gdp2019"
        local covariates "${base_covariates2019}"
        local index "democracy_vdem2019 democracy_csp2018 democracy_fh2019 democracy_eiu2019"
    }
    else if "`var'" == "${outcome1}" | "`var'" == "${outcome3}" {
        local weight "total_gdp2000"
        local covariates "${base_covariates2000}"
        local index "democracy_vdem2000 democracy_csp2000 democracy_fh2003 democracy_eiu2006"
    }
    
    local num = 1
    foreach i in `index' {
        
        eststo clear
        forvalues j = 1/6 {
            eststo: ivregress 2sls `var' (`i' = ${iv`j'}) [w = `weight'], vce(robust)
            eststo: ivregress 2sls `var' `covariates' (`i' = ${iv`j'}) [w = `weight'], vce(robust)
        }
        
        if "`i'" == "democracy_eiu2006" & "`var'" == "${outcome3}" {
            local last `"stats(N, labels("N")) prefoot(`" \hline \\[-1.8ex] IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\ Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') "'
        }
        else {
            local last "noobs"
        }
        
        esttab using 10_2sls_index_panel`num'.tex, keep(`i') append label b(a1) se(a1) nodepvars nostar `last'
        
        local num = `num' + 1
    }
    
    include "${path_code}/2_analyze/tables/PanelCombine_simplest.do"
    panelcombine, use(10_2sls_index_panel1.tex 10_2sls_index_panel2.tex 10_2sls_index_panel3.tex 10_2sls_index_panel4.tex) paneltitles("") columncount(13) save(10_2sls_index_`var'.tex) cleanup
}

* Combine panels for all outcomes (optional if needed)
* include "${path_code}/2_analyze/tables/PanelCombine.do"
* panelcombine, use(table2_panelA1.tex table2_panelA2.tex table2_panelA3.tex) paneltitles("`: var label `:word 1 of `outcomes'''" "`: var label `:word 2 of `outcomes'''" "`: var label `:word 3 of `outcomes'''") columncount(11) save(table2_panelA.tex) cleanup
