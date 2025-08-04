
*** import countries data 
use ${path_data}/countries.dta, replace

*** merge with outcomes.dta
merge 1:1 NAMES_STD using ${path_data}/outcomes.dta, nogenerate

*** merge with democracy.dta
merge 1:1 NAMES_STD using ${path_data}/democracy.dta, nogenerate

*** merge with controls.dta
merge 1:1 NAMES_STD using ${path_data}/controls.dta, nogenerate

*** merge with IVs.dta
merge 1:1 NAMES_STD using ${path_data}/IVs.dta, nogenerate

*** merge with containmenthealth10.dta
merge 1:1 NAMES_STD using ${path_data}/containmenthealth10.dta
drop if _merge==2
drop _merge

*** merge with coverage10.dta
merge 1:1 NAMES_STD using ${path_data}/coverage10.dta
drop if _merge==2
drop _merge

*** merge with introduce_policy.dta
merge 1:1 NAMES_STD using ${path_data}/introduce_policy.dta
drop if _merge==2
drop _merge

*** merge with wdi.dta
merge 1:1 NAMES_STD using ${path_data}/wdi.dta
drop if _merge==2
drop _merge

*** merge with pwt.dta
merge 1:1 NAMES_STD using ${path_data}/pwt.dta
drop if _merge==2
drop _merge

*** merge with pwt.dta
merge 1:1 NAMES_STD using ${path_data}/imf.dta
drop if _merge==2
drop _merge


/****************************************/
/*Generate Variables for Analysis*/
/****************************************/

// generate number of days between policy introduction and 10th confirmed case ***
gen days_betw_10th_case_and_policy = introduce_policy - cases_over10
drop introduce_policy cases_over10 

// generate excess deaths per million 
gen excess_deaths_per_million = excess_deaths_count/population2020
drop excess_deaths_count

// generate total cases per million
gen total_cases_per_million = total_cases/population2020
drop total_cases

// generate mean of mechanism variables in the periods of interest
local start_year = 1961
local end_year = 1970
forv num = 1/5{
	foreach var in investment loginvestment ctfp logctfp trade logtrade tax logtax primary logprimary secondary logsecondary mortality logmortality{
		egen mean_`var'_`start_year'_`end_year' = rowmean(`var'`start_year'-`var'`end_year')
	}
	local start_year = `start_year'+10
	local end_year = `end_year'+10
}
local start_year = 1981
local end_year = 1990
forv num = 1/3{
	foreach var in investmentpc loginvestmentpc{
		egen mean_`var'_`start_year'_`end_year' = rowmean(`var'`start_year'-`var'`end_year')
	}
	local start_year = `start_year'+10
	local end_year = `end_year'+10
}

foreach var in investment loginvestment investmentpc loginvestmentpc ctfp logctfp trade logtrade tax logtax primary logprimary secondary logsecondary mortality logmortality{
		egen mean_`var'_2011_2019 = rowmean(`var'2011-`var'2019)
		egen mean_`var'_2001_2019 = rowmean(`var'2001-`var'2019)
}

egen mean_growth_rate_2001_2019 = rowmean(gdp_growth2001-gdp_growth2019)
egen mean_total_gdp_2001_2019 = rowmean(total_gdp2001-total_gdp2019)
egen mean_growth_rate_1981_1990 = rowmean(gdp_growth1981-gdp_growth1990)
egen mean_growth_rate_1991_2000 = rowmean(gdp_growth1991-gdp_growth2000)
egen mean_growth_rate_2001_2010 = rowmean(gdp_growth2001-gdp_growth2010)
egen mean_growth_rate_2011_2020 = rowmean(gdp_growth2011-gdp_growth2020)

************************************ 
************************************ 
*** drop unnecessary columns
drop iso3

*** drop observations/columns for consistency in samples
drop if gdp_growth2020 ==. | mean_growth_rate_2001_2019 ==. | total_deaths_per_million==. | democracy_csp2000==. | total_gdp2000==.
// drop if gdp_growth2020 ==. | mean_growth_rate_2001_2019 ==. | total_deaths_per_million==. | total_gdp2000==. | democracy_vdem2000===. | democracy_vdem2019==.

*** make sample consistent with original paper
replace legor_uk = . if ex2col!=1
replace legor_fr = . if ex2col!=1
replace legor_ge = . if ex2col!=1
replace legor_sc = . if ex2col!=1


/****************************************/
/*Label Variables*/
/****************************************/

label variable countries "Country Name"
label variable gdp_growth2020 "GDP Growth Rate in 2020"
label variable total_deaths_per_million "Covid-19-related Deaths Per Million in 2020"
label variable abs_lat "Absolute Latitude"
label variable logem "Log European Settler Mortality"
label variable EngFrac "Fraction Speaking English"
label variable EurFrac "Fraction Speaking European"
label variable logFrankRom "Log Frankel-Romer Trade Share"
label variable uk_mom "British Legal Origin"
label variable frsp_mom "French Legal Origin"
label variable ger_mom "German Legal Origin"
label variable scan_mom "Scandinavian Legal Origin"
label variable civil_law "Civil Law Legal Origin"
label variable bananas "Bananas"
label variable legor_uk "British Legal Origin"
label variable legor_fr "French Legal Origin"
label variable legor_ge "German Legal Origin"
label variable legor_sc "Scandinavian Legal Origin"
label variable bananas "Bananas"
label variable coffee "Coffee"
label variable copper "Copper"
label variable maize "Maize"
label variable millet "Millet"
label variable rice "Rice"
label variable rubber "Rubber"
label variable silver "Silver"
label variable sugarcane "Sugarcane"
label variable wheat "Wheat"
label variable lpd1500s "Log Population Density in 1500s"
label variable containmenthealth10 "Containment Health Index at 10th Confirmed Case"
label variable coverage10 "Coverage of Containment Measure at 10th Confirmed Case"
label variable days_betw_10th_case_and_policy "Days between 10th Confirmed Case and Any Containment Measure"
label variable excess_deaths_per_million "Excess Deaths Per Million in 2020"
label variable total_cases_per_million "Total Covid-19 Cases Per Million in 2020"

foreach var of varlist democracy_fh2003-democracy_fh2021 {
	local year = substr("`var'", 13, .)
	label variable `var' "Democracy Index (Freedom House, `year')"
}

foreach var of varlist gdp_growth* {
	local year = substr("`var'", 11, .)
	label variable `var' "GDP Growth Rate in `year'"
}

label variable mean_growth_rate_2001_2019 "Mean GDP Growth Rate in 2001-2019"
label variable mean_total_gdp "Mean Total GDP in 2001-2019"
label variable mean_growth_rate_1981_1990 "Mean GDP Growth Rate in 1981-1990"
label variable mean_growth_rate_1991_2000 "Mean GDP Growth Rate in 1991-2000"
label variable mean_growth_rate_2001_2010 "Mean GDP Growth Rate in 2001-2010"
label variable mean_growth_rate_2011_2020 "Mean GDP Growth Rate in 2011-2020"

*** Save dataset ***
save ${path_output}/total.dta, replace
