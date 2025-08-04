********************************************************************************
* Table A9: Causal Mediaton Analysis on Potential Mechanisms
********************************************************************************

ssc install ivmediate
*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use ${path_data}/total.dta, replace

*** Note: ivmediate can only take one instrument and cannot weight countries. 

*** Make the results consistent across rows
keep if logem!=.
keep if containmenthealth10!=.
keep if coverage10!=.
keep if days_betw_10th_case_and_policy!=.

************************************************
*** Panel A: 2SLS on GDP Per Capita Growth Rate in 2020 ***
************************************************
* index: democracy_fh
* weight: none

eststo clear

eststo: ivmediate gdppc_growth2020, mediator(containmenthealth10) treatment(democracy_vdem2019) instrument(logem) vce(robust) 
eststo: ivmediate gdppc_growth2020, mediator(coverage10) treatment(democracy_vdem2019) instrument(logem) vce(robust) 
eststo: ivmediate gdppc_growth2020, mediator(days_betw_10th_case_and_policy) treatment(democracy_vdem2019) instrument(logem) vce(robust) 

// Produce output
esttab using ${path_output}/appendix/19_causal_mediation_analysis_panelA.tex, replace label b(a1) se(a1) compress nogaps nodepvars

****************************************
*** Panel B: 2SLS on Covid-19 Deaths Per Million in 2020 ***
****************************************
eststo clear

eststo: ivmediate total_death_per_million2020, mediator(containmenthealth10) treatment(democracy_vdem2019) instrument(logem) vce(robust) 
eststo: ivmediate total_death_per_million2020, mediator(coverage10) treatment(democracy_vdem2019) instrument(logem) vce(robust)
eststo: ivmediate total_death_per_million2020, mediator(days_betw_10th_case_and_policy) treatment(democracy_vdem2019) instrument(logem) vce(robust)

// Produce output
esttab using ${path_output}/appendix/19_causal_mediation_analysis_panelB.tex, replace label b(a1) se(a1) compress nogaps nodepvars
