
*** import data 
import excel "${path_input}/democracy/economist_intelligence_unit/_EIU-Democracy Indices - Dataset - v4.xlsx", sheet("data-for-countries-etc-by-year") firstrow clear
 
keep name time DemocracyindexEIU
rename DemocracyindexEIU democracy_eiu
drop if time==.

reshape wide democracy_eiu, i(name) j(time)

// normalize the index in each year to have standard deviation one. 
local year=2006
foreach var of varlist democracy_eiu2006-democracy_eiu2020{
	egen sd`var' = sd(`var')
	replace `var' = `var'/sd`var'
	label variable `var' "Democracy Index (Economist Intelligence Unit, `year')"
	
	egen mean`var' = mean(`var')
	replace `var' = `var' - mean`var'
	local year = `year' + 1
}
drop sd* mean*

kountry name, from(other)
drop name

save ${path_data}/economist.dta, replace

