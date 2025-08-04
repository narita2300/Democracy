
/******************************/
/*World Development Indicators*/
/******************************/

import delimited ${path_input}/channels21st/wdi.csv, encoding(UTF-8) rowrange(2) clear 
rename v1 country_name
rename v2 iso3c 
rename v3 series_name 
rename v4 series_code

local series "GC.NFN.TOTL.GD.ZS" "SE.TER.ENRR" "SE.SEC.ENRR" "SP.DYN.IMRT.IN" "NE.TRD.GNFS.ZS"
local varname investment primary secondary mortality trade

local n_series : word count `series'
di `word count `varname''
assert `n_series'==`:word count `varname''

forval i = 1/`n_series' {
	import delimited ${path_input}/channels21st/wdi.csv, encoding(UTF-8) rowrange(2) clear 
	rename v1 country_name
	rename v2 iso3c 
	rename v3 series_name 
	rename v4 series_code
	keep if series_code ==  "`:word `i' of "`series'"'"

	local y = 5
	forvalues year = 1960/2020 {
		destring v`y', replace force
		rename v`y' `:word `i' of `varname''`year'
		local y = `y' + 1
		gen log`:word `i' of `varname''`year' = log(`:word `i' of `varname''`year')
	}
	drop series_name series_code
	save ${path_data}/`:word `i' of `varname''.dta, replace
}

// merge each of the individual .dta into one dataset
// use ${path_input}/channels21st/DDCGdata_final.dta, clear
use ${path_data}/investment.dta, clear
foreach var of local varname{
	merge 1:1 country_name using ${path_data}/`var'.dta, nogenerate
}
kountry iso3c, from(iso3c) marker
drop if MARKER==0
drop MARKER
save ${path_data}/wdi.dta, replace

import delimited ${path_input}/channels21st/tax.csv, encoding(UTF-8) rowrange(6) clear 
rename v2 iso3c 
drop v1 v3 v4
local y = 5
forvalues year = 1960/2020 {
	destring v`y', replace force
	rename v`y' tax`year'
	local y = `y' + 1
	gen logtax`year' = log(tax`year')
}
kountry iso3c, from(iso3c) marker
drop if MARKER==0
drop MARKER

merge 1:1 NAMES_STD using ${path_data}/wdi.dta
drop _merge
save ${path_data}/wdi.dta, replace

/*******************/
/*Penn World Tables*/
/*******************/

use ${path_input}/channels21st/pwt100.dta, clear
keep countrycode year ctfp
reshape wide ctfp, i(countrycode) j(year)
kountry countrycode, from(iso3c) marker
drop if MARKER==0
drop MARKER

foreach var of varlist ctfp1950-ctfp2019{
	gen log`var' = log(`var')
}
save ${path_data}/pwt.dta, replace

/******************************/
/*International Monetary Fund*/
/******************************/

import delimited ${path_input}/channels21st/imf.csv, rowrange(6) clear 

keep if indicatorid==345 
// | indicator==2777
local y = 6
forvalues year = 1980/2024{
	rename v`y' investmentpc`year'
	local y = `y'+1
	gen loginvestmentpc`year' = log(investmentpc`year')
}

kountry countryiso3, from(iso3c)
drop countryiso3 countryname indicatorid indicator subindicatortype

save ${path_data}/imf.dta, replace

/************************************************/
/* Democracy Does Cause Growth Replication Data */
/************************************************/

// relevant variables: country, loginvpc (log investment), ltfp (log TFP), marketref (market reforms), ltrade (trade share), lgov (government expenditure), lprienr (primary enrollment), lsecenr (secondary enrollment), lmort (child mortality), unrestn (riots and revolutions)

// load data from Acemoglu et al. (JPE, 2019)
use ${path_input}/channels21st/DDCGdata_final.dta, clear
	
foreach var of varlist loginvpc ltfp marketref ltrade2 lgov lprienr lsecenr lmort unrestn{
	use ${path_input}/channels21st/DDCGdata_final.dta, clear
	keep country_name year `var'
	reshape wide `var', i(country_name) j(year)
	save ${path_data}/`var'.dta, replace
}

// merge each of the individual .dta into one dataset
// use ${path_input}/channels21st/DDCGdata_final.dta, clear
use ${path_data}/loginvpc.dta, clear
foreach var in ltfp marketref ltrade2 lgov lprienr lsecenr lmort unrestn{
	merge 1:1 country_name using ${path_data}/`var'.dta, nogenerate
}
save ${path_data}/ddcg.dta, replace

