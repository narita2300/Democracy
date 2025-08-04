
************************************ 
************************************ GDP Growth Rates 

import excel ${path_input}/outcomes/gdp/imf-dm-export-20210421.xls, sheet("NGDP_RPCH") clear

// drop B C D E F G H I J K L M N O P Q R S T U AQ AR AS AT AU
rename A country

local year=1980
foreach var of varlist B-AV{
	rename `var' gdp_growth`year'
	local year = `year'+1
}

drop in 1/2
drop in 196/229
kountry country, from(other) m
tabulate country if MARKER==0
drop MARKER
destring gdp_growth*, replace force

//prevent some NAs in merging
// replace NAMES_STD="Democratic Republic of Congo" if country=="Congo, Dem. Rep. of the"
save ${path_data}/gdp_growth.dta, replace

*** MERGE COUNTRIES LIST DATA WITH GDP DATA 
use ${path_data}/countries.dta, replace
merge 1:1 NAMES_STD using ${path_output}/data/gdp_growth.dta
drop if _merge==2
drop _merge country 

save ${path_data}/gdp.dta, replace






