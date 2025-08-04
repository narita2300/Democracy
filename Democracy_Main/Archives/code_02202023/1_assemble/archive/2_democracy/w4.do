************************************
************************************ data for 2006-2020
*** import freedom house data
import excel ${path_input}/democracy/freedom_house/Aggregate_Category_and_Subcategory_Scores_FIW_2003-2021.xlsx, sheet("FIW06-21") firstrow clear

keep CountryTerritory Edition Total
reshape wide Total, i(CountryTerritory) j(Edition)
rename Total* democracy_fh*

kountry CountryTerritory, from(other) 

*** save
save ${path_data}/freedom_house.dta, replace

*** merge with countries data
use ${path_output}/data/countries.dta, replace
merge 1:m NAMES_STD using ${path_output}/data/freedom_house.dta
drop if _merge==2
drop CountryTerritory _merge

foreach var of varlist democracy_fh2006-democracy_fh2021{
	egen sd`var' = sd(`var')
	replace `var' = `var'/sd`var'
	
	egen mean`var' = mean(`var')
	replace `var' = `var' - mean`var'
}

drop sd* mean*
sort NAMES_STD
quietly by NAMES_STD:  gen dup = cond(_N==1,0,_n)

drop if dup==2 & NAMES_STD=="Swaziland"
drop if dup==1 & NAMES_STD=="Yugoslavia"
drop if dup==2 & NAMES_STD=="Cape Verde"
drop if dup==1 & NAMES_STD=="Macedonia"
drop dup

*** save
save ${path_data}/freedom_house.dta, replace

************************************
************************************ data for 2003-2005 

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
	egen sd`var' = sd(`var')
	replace `var' = `var'/sd`var'
	
	egen mean`var' = mean(`var')
	replace `var' = `var' - mean`var'
}

drop sd* mean*

replace democracy_fh2004 = 73 if CountryTerritory=="Yugoslavia"
replace democracy_fh2005 = 76 if CountryTerritory=="Yugoslavia"
drop if dup!=0
drop dup CountryTerritory

merge 1:1 NAMES_STD using ${path_output}/data/freedom_house.dta
drop if _merge==1 | _merge==2
drop _merge 

*** save
save ${path_data}/freedom_house.dta, replace

