********************************************************************************
* Table: Reduced Form Regressions
********************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use ${path_data}/total.dta, replace

// covariates: alphabet_name, longitude, island, name_len, 
// create a dummy variable indicating whether the country's name starts with a A-M 
gen first_letter = substr(countries, 1, 1)
gen last_letter = substr(countries, -1, 1)
gen name_begins_a_m = (first_letter == "A" | first_letter == "B" | first_letter == "C" | first_letter == "D" | first_letter == "E" | first_letter == "F" | first_letter == "G" | first_letter == "H" | first_letter == "I" | first_letter == "J" | first_letter == "K"| first_letter == "L"| first_letter == "M")
gen name_ends_a_m = (last_letter == "a" | last_letter == "b" | last_letter == "c" | last_letter == "d" | last_letter == "e" | last_letter == "f" | last_letter == "g" | last_letter == "h" | last_letter == "i" | last_letter == "j" | last_letter == "k"| last_letter == "l"| last_letter == "m")
gen name_len = strlen(countries)
label variable name_begins_a_m "Name Begins With A-M"
label variable name_ends_a_m "Name Ends With A-M"
label variable name_len "Length of Name"

eststo clear
eststo: reg ${iv1} name_begins_a_m name_ends_a_m name_len, robust
scalar p = Ftail(e(df_m), e(df_r), e(F))
estadd scalar pval = p

eststo: reg ${iv2} name_begins_a_m name_ends_a_m name_len, robust
scalar p = Ftail(e(df_m), e(df_r), e(F))
estadd scalar pval = p

eststo: reg ${iv3} name_begins_a_m name_ends_a_m name_len, robust
scalar p = Ftail(e(df_m), e(df_r), e(F))
estadd scalar pval = p

eststo: reg EngFrac name_begins_a_m name_ends_a_m name_len, robust
scalar p = Ftail(e(df_m), e(df_r), e(F))
estadd scalar pval = p

eststo: reg EurFrac name_begins_a_m name_ends_a_m name_len, robust
scalar p = Ftail(e(df_m), e(df_r), e(F))
estadd scalar pval = p

eststo: reg bananas name_begins_a_m name_ends_a_m name_len, robust
scalar p = Ftail(e(df_m), e(df_r), e(F))
estadd scalar pval = p

eststo: reg coffee name_begins_a_m name_ends_a_m name_len, robust
scalar p = Ftail(e(df_m), e(df_r), e(F))
estadd scalar pval = p

eststo: reg copper name_begins_a_m name_ends_a_m name_len, robust
scalar p = Ftail(e(df_m), e(df_r), e(F))
estadd scalar pval = p

eststo: reg maize name_begins_a_m name_ends_a_m name_len, robust
scalar p = Ftail(e(df_m), e(df_r), e(F))
estadd scalar pval = p

eststo: reg millet name_begins_a_m name_ends_a_m name_len, robust
scalar p = Ftail(e(df_m), e(df_r), e(F))
estadd scalar pval = p

eststo: reg rice name_begins_a_m name_ends_a_m name_len, robust
scalar p = Ftail(e(df_m), e(df_r), e(F))
estadd scalar pval = p

eststo: reg rubber name_begins_a_m name_ends_a_m name_len, robust
scalar p = Ftail(e(df_m), e(df_r), e(F))
estadd scalar pval = p

eststo: reg silver name_begins_a_m name_ends_a_m name_len, robust
scalar p = Ftail(e(df_m), e(df_r), e(F))
estadd scalar pval = p

eststo: reg sugarcane name_begins_a_m name_ends_a_m name_len, robust
scalar p = Ftail(e(df_m), e(df_r), e(F))
estadd scalar pval = p

eststo: reg wheat name_begins_a_m name_ends_a_m name_len, robust
scalar p = Ftail(e(df_m), e(df_r), e(F))
estadd scalar pval = p

// esttab using ${path_appendix}/covariate_balance_regression2.tex, ///
// 	replace label cells("b" "se(par)" "p") ///
// 	nodepvars nogaps nonotes nostar mlabels(none) noconstant stats(N, labels("N") fmt(0))

esttab using ${path_appendix}/covariate_balance_regression2.tex, ///
	replace label b(a1) se(a1) ///
	nodepvars nogaps nonotes nostar mlabels(none) noconstant stats(pval N, labels("p-value" "N" ) fmt(2 0))
// esttab using covariate_balance_reg.tex, ///
// 	replace label b(a1) se(a1) ///
// 	nodepvars nogaps nonotes nostar mlabels(none) 
