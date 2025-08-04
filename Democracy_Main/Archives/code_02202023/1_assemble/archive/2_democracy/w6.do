
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
save ${path_output}/data/systemic_peace.dta, replace

*** merge with countries data
use ${path_output}/data/countries.dta, replace
merge 1:1 NAMES_STD using ${path_output}/data/systemic_peace.dta
drop if _merge==2
drop _merge countries iso3

foreach var of varlist democracy_csp2000-democracy_csp2018{
	local year = substr("`var'", 14, .)
	egen sd`var' = sd(`var')
	replace `var' = `var'/sd`var'
	label variable `var' "Democracy Index (Polity, `year')"
	
	egen mean`var' = mean(`var')
	replace `var' = `var' - mean`var'
}

drop sd* mean*

*** save
save ${path_data}/systemic_peace.dta, replace

