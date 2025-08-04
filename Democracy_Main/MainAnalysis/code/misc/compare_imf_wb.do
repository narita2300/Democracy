cd "C:/Documents/RA/Democracy/MainAnalysis/"
import delimited "input/outcomes/gdp/API_NY.GDP.MKTP.KD.ZG_DS2_en_csv_v2_6508481.csv", varnames(5) clear 

local y = 1960
forvalues i = 5/68 {
	rename v`i' var`y'
	local y = `y' + 1
}

*Reshape the data from wide to long to merge with GDP deflator
reshape long var, i(countryname countrycode) j(year)
ren var gdp_growth

tempfile gdpgrowth
save `gdpgrowth', replace

*Merge with GDP deflator
import delimited "input\outcomes\gdp\WDI_gdp_deflator_03042024.csv", varnames(1) clear 
keep if seriescode == "NY.GDP.DEFL.ZS"
reshape long yr, i(countryname countrycode) j(year)
ren yr gdp_deflator
merge 1:1 countrycode year using `gdpgrowth'
drop if _merge != 3 //remove years - 2023
drop _merge

destring gdp_deflator, force replace

encode countrycode, gen(countrycode_num)
xtset countrycode_num year
gen real_gdp_growth = 1- L.gdp_deflator/gdp_deflator * (1-gdp_growth)
tempfile wb_gdp
save `wb_gdp', replace


*Commpare with IMF's
import excel "input\outcomes\gdp\imf-dm-export-20240129.xls", sheet("NGDP_RPCH") firstrow clear

ren RealGDPgrowthAnnualpercent country
local y = 1980
foreach var of varlist B-AX {
	rename `var' yr`y'
	local y = `y' + 1
}

kountry country, from (other) stuck
ren _ISO3N_ iso3n
kountry iso3n, from (iso3n) to (iso3c)
drop if missing(_ISO3C_)
reshape long yr, i(_ISO3C_) j(year)
destring yr, force replace
ren yr real_growth_imf
ren _ISO3C_ countrycode
merge 1:1 year countrycode using `wb_gdp'


