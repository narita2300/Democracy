************************************
************************************ Freedom House data for 2006-2020
*** import freedom house data
import excel ${path_input}/democracy/freedom_house/Aggregate_Category_and_Subcategory_Scores_FIW_2003-2021.xlsx, sheet("FIW06-21") firstrow clear

keep CountryTerritory Edition Total
reshape wide Total, i(CountryTerritory) j(Edition)
rename Total* democracy_fh*

kountry CountryTerritory, from(other) 
sort NAMES_STD
quietly by NAMES_STD:  gen dup = cond(_N==1,0,_n)

sort dup
drop if dup==2 & NAMES_STD=="Swaziland"
drop if dup==1 & NAMES_STD=="Yugoslavia"
drop if dup==2 & NAMES_STD=="Cape Verde"
drop if dup==2 & NAMES_STD=="Macedonia"
drop dup

*** save
save ${path_data}/freedom_house.dta, replace

*** merge with countries data
use ${path_data}/countries.dta, replace
sort NAMES_STD
quietly by NAMES_STD:  gen dup = cond(_N==1,0,_n)
drop if dup==2
drop dup

merge 1:m NAMES_STD using ${path_data}/freedom_house.dta
drop if _merge==2
drop CountryTerritory _merge

*** save
save ${path_data}/freedom_house.dta, replace

************************************
************************************ Freedom House data for 2003-2005 

import excel ${path_input}/democracy/freedom_house/Aggregate_Category_and_Subcategory_Scores_FIW_2003-2021.xlsx, sheet("FIW03-05") firstrow clear

keep CountryTerritory FIW03Total FIW04Total FIW05Total
rename FIW03Total democracy_fh2003
rename FIW04Total democracy_fh2004
rename FIW05Total democracy_fh2005

kountry CountryTerritory, from(other)

sort NAMES_STD
quietly by NAMES_STD:  gen dup = cond(_N==1,0,_n)
// destring demcracy_fh*, replace force

foreach var of varlist democracy_fh2003-democracy_fh2005{
	destring `var', replace force
// 	egen sd`var' = sd(`var')
// 	replace `var' = `var'/sd`var'
	
// 	egen mean`var' = mean(`var')
// 	replace `var' = `var' - mean`var'
}

// drop sd* mean*
// destring democracy_fh2004, replace force
// destring democracy_fh2005, replace force
// replace democracy_fh2004 = 73 if CountryTerritory=="Yugoslavia"
// replace democracy_fh2005 = 76 if CountryTerritory=="Yugoslavia"
drop if dup!=0
drop dup CountryTerritory

merge 1:1 NAMES_STD using ${path_data}/freedom_house.dta
drop if _merge==1 | _merge==2
drop _merge 

*** save
save ${path_data}/freedom_house.dta, replace

************************************
************************************ Economist Intelligence Unit's Democracy index data 

*** import data 
import excel "${path_input}/democracy/economist_intelligence_unit/_EIU-Democracy Indices - Dataset - v4.xlsx", sheet("data-for-countries-etc-by-year") firstrow clear
 
keep name time DemocracyindexEIU
rename DemocracyindexEIU democracy_eiu
drop if time==.

reshape wide democracy_eiu, i(name) j(time)

// // normalize the index in each year to have standard deviation one. 
// local year=2006
// foreach var of varlist democracy_eiu2006-democracy_eiu2020{
// 	egen sd`var' = sd(`var')
// 	replace `var' = `var'/sd`var'
// 	label variable `var' "Democracy Index (Economist Intelligence Unit, `year')"
	
// 	egen mean`var' = mean(`var')
// 	replace `var' = `var' - mean`var'
// 	local year = `year' + 1
// }
// drop sd* mean*

kountry name, from(other)
drop name

save ${path_data}/economist.dta, replace

************************************
************************************ Center for Systemic Peace's polity index data

*** import
import excel ${path_input}/democracy/center_for_systemic_peace/p5v2018.xls, sheet("p5v2018") firstrow clear

keep if year>=2000
keep country year polity2
kountry country, from(other)
drop country
rename polity2 democracy_csp

sort NAMES_STD year
quietly by NAMES_STD year:  gen dup = cond(_N==1,0,_n)
replace democracy_csp = -3 if NAMES_STD=="Sudan"
replace democracy_csp = 7 if NAMES_STD=="Yugoslavia"
drop if dup==1
drop dup
reshape wide democracy_csp, i(NAMES_STD) j(year)

*** save
save ${path_data}/systemic_peace.dta, replace

*** merge with countries data
use ${path_data}/countries.dta, replace

sort NAMES_STD
quietly by NAMES_STD:  gen dup = cond(_N==1,0,_n)
drop if dup==2
drop dup

merge 1:1 NAMES_STD using ${path_data}/systemic_peace.dta
drop if _merge==2
drop _merge iso3

// foreach var of varlist democracy_csp2000-democracy_csp2018{
// 	local year = substr("`var'", 14, .)
// 	egen sd`var' = sd(`var')
// 	replace `var' = `var'/sd`var'
// 	label variable `var' "Democracy Index (Polity, `year')"
	
// 	egen mean`var' = mean(`var')
// 	replace `var' = `var' - mean`var'
// }

// drop sd* mean*

*** save
save ${path_data}/systemic_peace.dta, replace

************************************
************************************ V-Dem's electoral democracy index data

import delimited "${path_input}/democracy/Country_Year_V-Dem_Core_CSV_v11.1/V-Dem-CY-Core-v11.1.csv", clear 
 
keep if year >= 1980
keep country_name country_text_id year v2x_polyarchy 
rename v2x_polyarchy democracy_vdem
// v2x_libdem v2x_partipdem v2x_delibdem v2x_egaldem 
reshape wide democracy_vdem, i(country_text_id) j(year)
kountry country_text_id, from(iso3c) m

// replace NAMES_STD = "Kosovo" if country_text_id=="XKX"
// replace NAMES_STD = ""

drop if MARKER==0
drop MARKER

// local year = 1980
// foreach var of varlist democracy_vdem1980-democracy_vdem2020{
// 	label variable `var' "Democracy Index (V-Dem, `year')"
// 	egen sd`var' = sd(`var')
// 	replace `var' = `var'/sd`var'
	
// 	egen mean`var' = mean(`var')
// 	replace `var' = `var' - mean`var'
	
// 	local year = `year' +1
// }

// drop sd* country_text_id mean*

save ${path_data}/vdem.dta, replace

************************************
************************************ V-Dem's deliberative component index 

import delimited "${path_input}/democracy/Country_Year_V-Dem_Core_CSV_v11.1/V-Dem-CY-Core-v11.1.csv", clear 
 
keep if year >= 1980
keep country_name country_text_id year v2xdl_delib
reshape wide v2xdl_delib, i(country_text_id) j(year)
kountry country_text_id, from(iso3c) m

drop if MARKER==0
drop MARKER

save ${path_data}/v2xdl_delib.dta, replace

************************************
************************************ V-Dem's deliberative component index: reasoned justification

import delimited "${path_input}/democracy/Country_Year_V-Dem_Core_CSV_v11.1/V-Dem-CY-Core-v11.1.csv", clear 
 
keep if year >= 1980
keep country_name country_text_id year v2dlreason
reshape wide v2dlreason, i(country_text_id) j(year)
kountry country_text_id, from(iso3c) m

drop if MARKER==0
drop MARKER

save ${path_data}/v2dlreason.dta, replace

************************************
************************************ V-Dem's deliberative component index: common good justification

import delimited "${path_input}/democracy/Country_Year_V-Dem_Core_CSV_v11.1/V-Dem-CY-Core-v11.1.csv", clear 
 
keep if year >= 1980
keep country_name country_text_id year v2dlcommon
reshape wide v2dlcommon, i(country_text_id) j(year)
kountry country_text_id, from(iso3c) m

drop if MARKER==0
drop MARKER

save ${path_data}/v2dlcommon.dta, replace

************************************
************************************ V-Dem's deliberative component index: respect for counterarguments

import delimited "${path_input}/democracy/Country_Year_V-Dem_Core_CSV_v11.1/V-Dem-CY-Core-v11.1.csv", clear 
 
keep if year >= 1980
keep country_name country_text_id year v2dlcountr
reshape wide v2dlcountr, i(country_text_id) j(year)
kountry country_text_id, from(iso3c) m

drop if MARKER==0
drop MARKER

save ${path_data}/v2dlcountr.dta, replace

************************************
************************************ V-Dem's deliberative component index: range of consultation

import delimited "${path_input}/democracy/Country_Year_V-Dem_Core_CSV_v11.1/V-Dem-CY-Core-v11.1.csv", clear 
 
keep if year >= 1980
keep country_name country_text_id year v2dlconslt
reshape wide v2dlconslt, i(country_text_id) j(year)
kountry country_text_id, from(iso3c) m

drop if MARKER==0
drop MARKER

save ${path_data}/v2dlconslt.dta, replace

************************************
************************************ V-Dem's deliberative component index: engaged society

import delimited "${path_input}/democracy/Country_Year_V-Dem_Core_CSV_v11.1/V-Dem-CY-Core-v11.1.csv", clear 
 
keep if year >= 1980
keep country_name country_text_id year v2dlengage
reshape wide v2dlengage, i(country_text_id) j(year)
kountry country_text_id, from(iso3c) m

drop if MARKER==0
drop MARKER

save ${path_data}/v2dlengage.dta, replace

************************************
************************************ V-Dem's freedom of expression index 

import delimited "${path_input}/democracy/Country_Year_V-Dem_Core_CSV_v11.1/V-Dem-CY-Core-v11.1.csv", clear 
 
keep if year >= 1980
keep country_name country_text_id year v2x_freexp_altinf
reshape wide v2x_freexp_altinf, i(country_text_id) j(year)
kountry country_text_id, from(iso3c) m

drop if MARKER==0
drop MARKER

save ${path_data}/v2x_freexp_altinf.dta, replace

************************************
************************************ 

*** import countries data 
use ${path_data}/countries.dta, replace

*** merge with freedom_house.dta
merge 1:1 NAMES_STD using ${path_data}/freedom_house.dta, nogenerate

*** merge with systemic_peace.dta
merge 1:1 NAMES_STD using ${path_data}/systemic_peace.dta, nogenerate

*** merge with economist.dta
merge 1:1 NAMES_STD using ${path_data}/economist.dta
drop if _merge==2
drop _merge

*** merge with vdem.dta
merge 1:1 NAMES_STD using ${path_data}/vdem.dta
drop if _merge==2
drop _merge

*** merge with v2xdl_delib.dta
merge 1:1 NAMES_STD using ${path_data}/v2xdl_delib.dta
drop if _merge==2
drop _merge

*** merge with v2dlreason.dta
merge 1:1 NAMES_STD using ${path_data}/v2dlreason.dta
drop if _merge==2
drop _merge

*** merge with v2dlcommon.dta
merge 1:1 NAMES_STD using ${path_data}/v2dlcommon.dta
drop if _merge==2
drop _merge

*** merge with v2dlcountr.dta
merge 1:1 NAMES_STD using ${path_data}/v2dlcountr.dta
drop if _merge==2
drop _merge

*** merge with v2dlconslt.dta
merge 1:1 NAMES_STD using ${path_data}/v2dlconslt.dta
drop if _merge==2
drop _merge

*** merge with v2dlengage.dta
merge 1:1 NAMES_STD using ${path_data}/v2dlengage.dta
drop if _merge==2
drop _merge

*** merge with v2x_freexp_altinf.dta
merge 1:1 NAMES_STD using ${path_data}/v2x_freexp_altinf.dta
drop if _merge==2
drop _merge
*** save data
save ${path_data}/democracy.dta, replace
