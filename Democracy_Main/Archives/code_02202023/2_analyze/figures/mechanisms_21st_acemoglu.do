
***************************************************
*************************************************** Comparison between GDP-weighted and unweightedOLS


clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use ${path_data}/total.dta, replace
drop if gdppc2000==.

local depvars loginvestment logrtfpna logtrade logtax logprimary logsecondary logmortality
local titles "Log Investment Share of GDP" "Log TFP" "Log Trade Share of GDP" "Log Tax Revenue Share of GDP" "Log Primary School Enrollment Rate" "Log Secondary School Enrollment Rate" "Log Child Mortality Rate Per 1000 Births"
local n:word count `depvars'

forvalues i = 1/`n' {
	local var "`:word `i' of `depvars''"
	local title  "`: word `i' of "`titles'"'"
	di "`title'"
	gen mean_`var'_2001_2019_pc = mean_`var'_2001_2019*100
	scatter mean_`var'_2001_2019 democracy_vdem2000 [w=total_gdp2000], mlabel(iso3) || lfit mean_`var'_2001_2019 democracy_vdem2000 [w=total_gdp2000], title("`title'") ytitle("Mean of dependent variable in 2001-2019") legend(order(2 "GDP-Weighted OLS" 3 "Unweighted OLS")) || lfit mean_`var'_2001_2019 democracy_vdem2000
	graph export "/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/figures/mechanisms/`var'.png", as(png) name("Graph") replace 
}

***************************************************
*************************************************** GDP-weighted OLS with CI

*** Load data 
use ${path_data}/total.dta, replace
drop if gdppc2000==.

local depvars loginvestment logrtfpna logtrade logtax logprimary logsecondary logmortality
local titles "Log Investment Share of GDP" "Log TFP" "Log Trade Share of GDP" "Log Tax Revenue Share of GDP" "Log Primary School Enrollment Rate" "Log Secondary School Enrollment Rate" "Log Child Mortality Rate Per 1000 Births"
local n:word count `depvars'

forvalues i = 1/`n' {
	local var "`:word `i' of `depvars''"
	local title  "`: word `i' of "`titles'"'"
	di "`title'"
	gen mean_`var'_2001_2019_pc = mean_`var'_2001_2019*100
	graph twoway lfitci mean_`var'_2001_2019 democracy_vdem2000 [w=total_gdp2000], title("`title'") ytitle("Mean of dependent variable in 2001-2019") legend(order(2 "GDP-Weighted OLS" 1 "95% CI"))|| scatter mean_`var'_2001_2019 democracy_vdem2000 [w=total_gdp2000], mlabel(iso3) 
	graph export "/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/figures/mechanisms/`var'.png", as(png) name("Graph") replace 
}

// mlabcolor(gs10) mcolor(gs10)
