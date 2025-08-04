
*** import freedom house data
import excel ${path_input}/democracy/freedom_house/2020_All_Data_FIW_2013-2020.xlsx, sheet("FIW13-20") cellrange(A2:AR1677) firstrow clear

keep if Edition==2020
keep CountryTerritory Total Status
rename Status fh_status
kountry CountryTerritory, from(other) 

*** save
save ${path_output}/data/freedom_house.dta, replace

*** merge with countries data
use ${path_output}/data/countries.dta, replace
merge 1:1 NAMES_STD using ${path_output}/data/freedom_house.dta
drop if _merge==2
drop CountryTerritory _merge
rename Total democracy_fh
egen sd = sd(democracy_fh)
replace democracy_fh = democracy_fh/sd
drop sd

*** save
save ${path_output}/data/freedom_house.dta, replace
