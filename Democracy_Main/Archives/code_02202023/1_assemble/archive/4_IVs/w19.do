
*** import data
import excel ${path_input}/IVs/legal_origin/EconomicCon_data.xls, sheet("Table 1") firstrow clear

drop if anti_sd =="" //drop first row
keep country code legor_uk legor_fr legor_ge legor_sc legor_so
kountry code, from(iso3c) m
drop if MARKER==0
drop MARKER
save ${path_data}/legal_origin.dta, replace


*** merge with countries data 
use ${path_data}/countries.dta, replace
merge 1:1 NAMES_STD using ${path_data}/legal_origin.dta
drop if _merge==2
keep countries iso3 NAMES_STD legor_uk legor_fr legor_ge legor_sc legor_so

*** save
save ${path_data}/legal_origin.dta, replace


************************

*** import data
import excel ${path_input}/IVs/legal_origin/landfweb_0-2.xls, sheet("data") firstrow clear
keep name uk_mom frsp_mom scan_mom ger_mom civ_com
kountry name, from(other)
drop name
rename civ_com civil_law

merge 1:1 NAMES_STD using ${path_data}/legal_origin.dta
drop if _merge==1
drop _merge

replace uk_mom=0 if NAMES_STD =="China"
replace frsp_mom=0 if NAMES_STD =="China"
replace scan_mom=0 if NAMES_STD =="China"
replace ger_mom = 1 if NAMES_STD=="China"
replace civil_law=1 if NAMES_STD=="China"

*** save
save ${path_data}/legal_origin.dta, replace
