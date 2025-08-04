
*** PREPARE GDP GROWTH RATES DATA FOR MERGE
clear
import excel ${path_input}/outcomes/gdp/imf-dm-export-20210104.xls, sheet("NGDP_RPCH") clear

keep A AP
rename A country
rename AP gdp_growth
drop in 1/2
drop in 196/229
kountry country, from(other) m
tabulate country if MARKER==0
drop MARKER
destring gdp_growth, replace force

//prevent some NAs in merging
replace NAMES_STD="Democratic Republic of Congo" if country=="Congo, Dem. Rep. of the"
save ${path_output}/data/gdp_growth.dta, replace

*** MERGE COUNTRIES LIST DATA WITH GDP DATA 
use ${path_output}/data/countries.dta, replace
merge 1:1 NAMES_STD using ${path_output}/data/gdp_growth.dta
drop if _merge==2
drop _merge country 

save ${path_output}/data/gdp.dta, replace





