
*** import data
import excel ${path_input}/IVs/legal_origin/EconomicCon_data.xls, sheet("Table 1") firstrow clear

drop if anti_sd =="" //drop first row
keep country code legor_uk legor_fr legor_ge legor_sc legor_so
kountry code, from(iso3c) m
drop if MARKER==0
drop MARKER
save ${path_output}/data/legal_origin.dta, replace


*** merge with countries data 
use ${path_output}/data/countries.dta, replace
merge 1:1 NAMES_STD using ${path_output}/data/legal_origin.dta
drop if _merge==2
keep countries iso3 NAMES_STD legor_uk legor_fr legor_ge legor_sc legor_so

*** save
save ${path_output}/data/legal_origin.dta, replace
