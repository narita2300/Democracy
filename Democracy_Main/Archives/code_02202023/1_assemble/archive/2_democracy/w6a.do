
import delimited "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/democracy/Country_Year_V-Dem_Core_CSV_v11.1/V-Dem-CY-Core-v11.1.csv", clear 
 
keep if year >= 1980
keep country_name country_text_id year v2x_polyarchy 
rename v2x_polyarchy democracy_vdem
// v2x_libdem v2x_partipdem v2x_delibdem v2x_egaldem 
reshape wide democracy_vdem, i(country_text_id) j(year)
kountry country_text_id, from(iso3c) m

// replace NAMES_STD = "Kosovo" if country_text_id=="XKX"
// replace NAMES_STD = ""

drop if MARKER==0
drop MARKER

local year = 1980
foreach var of varlist democracy_vdem1980-democracy_vdem2020{
	label variable `var' "Democracy Index (V-Dem, `year')"
	egen sd`var' = sd(`var')
	replace `var' = `var'/sd`var'
	
	egen mean`var' = mean(`var')
	replace `var' = `var' - mean`var'
	
	local year = `year' +1
}

drop sd* country_text_id mean*

save ${path_data}/vdem.dta, replace

