********************************************************************************
* Table A5: Causal Mediaton Analysis on Potential Mechanisms
********************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use "./output/total.dta", replace

*** Note: ivmediate can only take one instrument and cannot weight countries. 

*** Make the results consistent across rows
keep if logem!=.
keep if containmenthealth10!=.
keep if coverage10!=.
keep if days_betw_10th_case_and_policy!=.

************************************************
*** Panel A: 2SLS on Covid-19 deaths ***
************************************************
eststo clear

eststo: ivmediate gdp_growth, mediator(containmenthealth10) treatment(democracy_fh) instrument(logem) vce(robust) 
eststo: ivmediate gdp_growth, mediator(coverage10) treatment(democracy_fh) instrument(logem) vce(robust) 
eststo: ivmediate gdp_growth, mediator(days_betw_10th_case_and_policy) treatment(democracy_fh) instrument(logem) vce(robust) 

// Produce output
esttab using ./output/tables/tableA5/panelA.tex, replace label b(a1) se(a1) compress nogaps nodepvars

****************************************
*** Panel B: 2SLS on Covid-19 deaths ***
****************************************
eststo clear

eststo: ivmediate total_deaths_per_million, mediator(containmenthealth10) treatment(democracy_fh) instrument(logem) vce(robust) full
eststo: ivmediate total_deaths_per_million, mediator(coverage10) treatment(democracy_fh) instrument(logem) vce(robust) full
eststo: ivmediate total_deaths_per_million, mediator(days_betw_10th_case_and_policy) treatment(democracy_fh) instrument(logem) vce(robust) full

// Produce output
esttab using ./output/tables/tableA5/panelB.tex, replace label b(a1) se(a1) compress nogaps nodepvars
