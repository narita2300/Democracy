import excel "$path_input\channels21st\debt\Debt Database Fall 2013 Vintage.xlsx", sheet("Public debt (in percent of GDP)") firstrow clear

local year = 1692
foreach var of varlist D-LL{
	destring `var', force replace
	label variable `var' "Debt as percent of GDP `year'"
	ren `var' debt`year'
	local year = `year' + 1 
}

drop B 
keep country ifscode debt1970- debt2012
kountry ifscode, from (imfn) to (iso3n)
replace _ISO3N_ = 158 if ifscode == 528
replace _ISO3N_ = 688 if ifscode == 942
replace _ISO3N_ = 499 if ifscode == 943
drop if missing(ifscode)
tempfile vintage
save `vintage', replace


import excel "$path_input\channels21st\debt\imf-dm-export-20240528.xls", sheet("GGXWDG_NGDP") clear

ren A country

local year = 1980
foreach var of varlist B-AY{
	destring `var', force replace
	label variable `var' "Debt as percent of GDP `year'"
	ren `var' debt`year'
	local year = `year' + 1 
}
drop debt1980-debt2012
drop if _n == 1 & _n == 2
kountry country, from (other) stuck
drop if missing(_ISO3N_) 
merge 1:1 _ISO3N_ using `vintage' 
drop _merge

save "$path_data/debt.dta", replace
