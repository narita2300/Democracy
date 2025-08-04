
*** import data
import excel ${path_input}/democracy/economist_intelligence_unit/EIU_2020.xlsx, sheet("Sheet1") firstrow clear

rename Overallscore democracy_eiu
keep country_name democracy_eiu
kountry country_name, from(other)

*** save
save ${path_output}/data/economist.dta, replace

*** merge with countries data
use ${path_output}/data/countries.dta, replace
merge 1:1 NAMES_STD using ${path_output}/data/economist.dta
drop if _merge==2
drop country_name _merge
egen sd = sd(democracy_eiu)
replace democracy_eiu = democracy_eiu/sd
drop sd

*** save
save ${path_output}/data/economist.dta, replace

