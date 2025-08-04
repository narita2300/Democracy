********************************************************************************
* 2SLS: Mechanisms Behind Democracy's Effect in 21st Century 
********************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use ${path_data}/total.dta, replace
drop if gdppc2000==.

//"The variables we investigate are (log) investment share in GDP, (log) TFP, a measure of economic reforms (corresponding to the mean index of the reforms considered in Giuliano et al., 2013, normalized between 0 and 100), (log) trade share in GDP, (log) taxes share in GDP, primary school enrollment, secondary school enrollment, log child mortality, and the social unrest variable already used above."

// To make the units correspond to the summary stats table, use the following:
// GDP per capita: gdppc[year]
// Investment share of GDP: investment[year]/100
// TFP: rtfpna[year]
// Trade Share of GDP: trade[year]/1000
// Primary Enrollment Rate: primary[year]
// Secondary Enrollment Rate: secondary[year]
// Child Mortality Rate Per 1000 Births: mortality[year]

// Use the following variables for the regressions: 
// Investment share of GDP: mean_loginvestment_2001_2019
// TFP: mean_logrtfpna_2001_2019*100
// Trade Share of GDP: mean_logtrade_2001_2019*100
// Primary Enrollment Rate: mean_logprimary_2001_2019*100
// Secondary Enrollment Rate: mean_logsecondary_2001_2019*100
// Child Mortality Rate Per 1000 Births: mean_logmortality_2001_2019*100

***************************************************
*** Panel A: OLS on Mechanisms against Democracy *** 
***************************************************

eststo clear
foreach var in logtax logprimary logsecondary logmortality{
	gen mean_`var'_2001_2019_pc = 100*mean_`var'_2001_2019
	eststo: reg mean_`var'_2001_2019_pc ${dem2000} ${weight2000}, vce(robust)
	eststo: reg mean_`var'_2001_2019_pc ${base_covariates2000} ${dem2000} ${weight2000}, vce(robust)
	eststo: reg mean_`var'_2001_2019_pc gdppc2000 total_gdp2000 ${base_covariates2000} ${dem2000} ${weight2000}, vce(robust)
}
esttab using ${path_output}/2sls_mechanisms_21st_a.tex, ///
keep(${dem2000}) replace label b(a1) se(a1) stats(N, labels("N")) nogaps nonotes mlabels(none) 

///
// prehead(`" \begin{landscape} \begin{table} \begin{threeparttable} \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi} \caption{Correlation Between Democracy and Potential Mechanisms in 2001-2019}\label{tab:ols-mechanisms-21st} \begin{tabular}{l*{14}{c}} \hline\hline & \multicolumn{2}{c}{Investment} &\multicolumn{2}{c}{TFP} &\multicolumn{2}{c}{Trade Share} &\multicolumn{2}{c}{Tax Share} &\multicolumn{2}{c}{Primary School} &\multicolumn{2}{c}{Secondary School} &\multicolumn{2}{c}{Infant Mortality} \\ "') ///
// postfoot(`"\hline\hline \end{tabular} \end{threeparttable} \end{table} \end{landscape}"')

***************************************************
*** Panel B-F: 2SLS on Mechanism against Democracy *** 
***************************************************

eststo clear
forvalues i = 1/5{
	eststo clear
	foreach var in logtax logprimary logsecondary logmortality{
		eststo: ivregress 2sls mean_`var'_2001_2019_pc (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)
		eststo: ivregress 2sls mean_`var'_2001_2019_pc ${base_covariates2000} (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)
		eststo: ivregress 2sls mean_`var'_2001_2019_pc gdppc2000 total_gdp2000 ${base_covariates2000} (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)	
}
esttab using ${path_output}/2sls_mechanisms_21st_a.tex, ///
keep(${dem2000}) append label b(a1) se(a1) stats(N, fmt(0) labels("N")) nogaps nonotes mlabels(none) 

// ///
// prehead(`" \begin{landscape} \begin{table} \begin{threeparttable} \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi} \caption{Correlation Between Democracy and Potential Mechanisms in 2001-2019}\label{tab:ols-mechanisms-21st} \begin{tabular}{l*{21}{c}} \hline\hline & \multicolumn{3}{c}{Investment} &\multicolumn{3}{c}{TFP} &\multicolumn{3}{c}{Trade Share} &\multicolumn{3}{c}{Tax Share} &\multicolumn{3}{c}{Primary School} &\multicolumn{3}{c}{Secondary School} &\multicolumn{3}{c}{Infant Mortality} \\ "') ///
// postfoot(`"\hline\hline \end{tabular} \end{threeparttable} \end{table} \end{landscape}"')
}


