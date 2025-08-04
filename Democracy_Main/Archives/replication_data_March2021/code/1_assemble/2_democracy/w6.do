
*** import
import excel ${path_input}/democracy/center_for_systemic_peace/p5v2018.xls, sheet("p5v2018") firstrow clear

keep if year==2018
keep country polity2
kountry country, from(other)

*** save
save ${path_output}/data/systemic_peace.dta, replace

*** merge with countries data
use ${path_output}/data/countries.dta, replace
merge 1:1 NAMES_STD using ${path_output}/data/systemic_peace.dta
drop if _merge==2
drop country _merge
egen sd = sd(polity2)
gen democracy_csp = polity2/sd
drop sd polity2

*** save
save ${path_output}/data/systemic_peace.dta, replace

