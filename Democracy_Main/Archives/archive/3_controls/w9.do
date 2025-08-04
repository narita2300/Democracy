

*** import GDP data ***
import excel "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/controls/total_gdp/imf-dm-export-20210423.xls", sheet("NGDPD") cellrange(A3:AV231) clear

local y 1980
foreach var of varlist B-AV {
	label variable `var' "GDP in `y' (billion USD, current prices)"
	destring `var', replace force
	rename `var' total_gdp`y'
	local y = `y' + 1
}

rename A countryname
kountry countryname, from(other)
keep NAMES_STD total_gdp1980-total_gdp2020

save ${path_data}/total_gdp.dta, replace

*** merge with countries data 
use ${path_data}/countries.dta, replace
merge 1:m NAMES_STD using ${path_output}/data/total_gdp.dta
drop if _merge==2
keep countries iso3 NAMES_STD total_gdp* 

*** save
save ${path_data}/total_gdp.dta, replace



*** import GDP per capita data ***
import excel "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/controls/total_gdp/imf-dm-export-20210515-2.xls", sheet("NGDPDPC") cellrange(A3:AV231) clear

local y 1980
foreach var of varlist B-AV {
	label variable `var' "GDP per capita in `y' (USD, current prices)"
	destring `var', replace force
	rename `var' gdppc`y'
	local y = `y' + 1
}

rename A countryname
kountry countryname, from(other)
keep NAMES_STD gdppc1980-gdppc2020

merge 1:1 NAMES_STD using ${path_data}/total_gdp.dta
drop if _merge==2
drop if _merge==1
keep countries iso3 NAMES_STD total_gdp* gdppc*

*** save
save ${path_data}/total_gdp.dta, replace
