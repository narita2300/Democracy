
************************************
************************************ Containment Health Index (severity)

*** cases over 10
import delimited ${path_input}/channels2020/OxCGRT_latest.csv, clear

tostring date, replace
gen dates = date(date, "YMD")
format dates %td

keep if jurisdiction=="NAT_TOTAL"

gen cases_over10 = 1 if confirmedcases!=. & confirmedcases>10
replace cases_over10 = 0 if confirmedcases<=10 | confirmedcases==.
keep if cases_over10==1
sort countryname date
by countryname: gen cases_over10_date =_n==1
keep if cases_over10_date ==1 
drop cases_over10 cases_over10_date

kountry countrycode, from(iso3c)
rename dates cases_over10
gen containmenthealth10 = containmenthealthindex/19.9988
keep NAMES_STD cases_over10 containmenthealth10

save ${path_data}/containmenthealth10.dta, replace

************************************
************************************ Containment Health Index (coverage)

*** cases over 10
import delimited ${path_input}/channels2020/OxCGRT_latest.csv, clear

tostring date, replace
gen dates = date(date, "YMD")
format dates %td

gen cases_over10 = 1 if confirmedcases>10
replace cases_over10 = 0 if confirmedcases<=10 | confirmedcases==.
keep if cases_over10 ==1 

sort countryname date
by countryname: gen cases_over10_date =_n==1
keep if cases_over10_date ==1
drop cases_over10 cases_over10_date

kountry countrycode, from(iso3c)
rename dates cases_over10

***

gen d1 = 1==c1_schoolclosing>0
gen d2 = 1==c2_workplaceclosing>0
gen d3 = 1==c3_cancelpublicevents>0
gen d4 = 1==c4_restrictionsongatherings>0
gen d5 = 1==c5_closepublictransport>0
gen d6 = 1==c6_stayathomerequirements>0
gen d7 = 1==c7_restrictionsoninternalmovemen>0
gen d8 = 1==c8_internationaltravelcontrols>0
gen d9 = 1==h1_publicinformationcampaigns>0
gen d10 = 1==h2_testingpolicy>0
gen d11 = 1==h3_contacttracing>0
gen d12 = 1==h6_facialcoverings>0
gen d13 = 1==h7_vaccinationpolicy>0

gen coverage = d1 + d2 + d3 + d4+ d5 + d6 + d7 + d8 + d9 + d10 + d11 + d12 + d13
gen coverage10 = 100*coverage/13

keep NAMES_STD coverage10

save ${path_data}/coverage10.dta, replace

************************************
************************************ Containment Health Index (speed)

*** import data 
import delimited ${path_input}/channels2020/OxCGRT_latest.csv, clear

//convert date variable to date format
tostring date, replace
generate dates = date(date, "YMD")
format dates %td
drop date
rename dates date

keep if containmenthealthindex!=0
sort countryname date
by countryname: gen first=_n==1
keep if first==1
drop first

kountry countrycode, from(iso3c)
rename date introduce_policy
keep NAMES_STD introduce_policy

save ${path_data}/introduce_policy.dta, replace

************************************
************************************ World Development Indicators

import delimited ${path_input}/channels21st/wdi.csv, encoding(UTF-8) rowrange(2) clear 
rename v1 country_name
rename v2 iso3c 
rename v3 series_name 
rename v4 series_code

local series "SP.DYN.IMRT.IN" "NE.TRD.GNFS.ZS"
local varname mortality trade

local n_series : word count `series'
di `word count `varname''
assert `n_series'==`:word count `varname''

forval i = 1/`n_series' {
	import delimited ${path_input}/channels21st/wdi.csv, encoding(UTF-8) rowrange(2) clear 
	rename v1 country_name
	rename v2 iso3c 
	rename v3 series_name 
	rename v4 series_code
	keep if series_code ==  "`:word `i' of "`series'"'"

	local y = 5
	forvalues year = 1960/2020 {
		destring v`y', replace force
		rename v`y' `:word `i' of `varname''`year'
		local y = `y' + 1
		gen log`:word `i' of `varname''`year' = log(`:word `i' of `varname''`year')
	}
	drop series_name series_code
	save ${path_data}/`:word `i' of `varname''.dta, replace
}


 import delimited ${path_input}/channels21st/school2.csv, encoding(UTF-8) rowrange(2) clear 

rename v1 country_name
rename v2 iso3c 
rename v3 series_name 
rename v4 series_code
keep if series_code=="SE.PRM.NENR"
local y = 5
	forvalues year = 1960/2020 {
		destring v`y', replace force
		rename v`y' primary`year'
		local y = `y' + 1
		gen logprimary`year' = log(primary`year')
}
drop series_name series_code
save ${path_data}/primary.dta, replace

 import delimited ${path_input}/channels21st/school2.csv, encoding(UTF-8) rowrange(2) clear
rename v1 country_name
rename v2 iso3c 
rename v3 series_name 
rename v4 series_code
keep if series_code=="SE.SEC.NENR"
local y = 5
	forvalues year = 1960/2020 {
		destring v`y', replace force
		rename v`y' secondary`year'
		local y = `y' + 1
		gen logsecondary`year' = log(secondary`year')
}
drop series_name series_code
save ${path_data}/secondary.dta, replace

local varname primary secondary mortality trade

// merge each of the individual .dta into one dataset
// use ${path_input}/channels21st/DDCGdata_final.dta, clear
use ${path_data}/primary.dta, clear
foreach var of local varname{
	merge 1:1 country_name using ${path_data}/`var'.dta, nogenerate
}
kountry iso3c, from(iso3c) marker
drop if MARKER==0
drop MARKER
save ${path_data}/wdi.dta, replace

import delimited ${path_input}/channels21st/tax.csv, encoding(UTF-8) rowrange(6) clear 
rename v2 iso3c 
drop v1 v3 v4
local y = 5
forvalues year = 1960/2020 {
	destring v`y', replace force
	rename v`y' tax`year'
	local y = `y' + 1
	gen logtax`year' = log(tax`year')
}
kountry iso3c, from(iso3c) marker
drop if MARKER==0
drop MARKER

merge 1:1 NAMES_STD using ${path_data}/wdi.dta
drop _merge
save ${path_data}/wdi.dta, replace

************************************
************************************ Penn World Tables

use ${path_input}/channels21st/pwt100.dta, clear
keep countrycode year rtfpna
reshape wide rtfpna, i(countrycode) j(year)
kountry countrycode, from(iso3c) marker
drop if MARKER==0
drop MARKER

foreach var of varlist rtfpna1950-rtfpna2019{
	gen log`var' = log(`var')
}
save ${path_data}/pwt.dta, replace

************************************
************************************ International Monetary Fund

import delimited ${path_input}/channels21st/imf.csv, rowrange(6) clear 

keep if indicatorid==345 
// | indicator==2777
local y = 6
forvalues year = 1980/2024{
	rename v`y' investment`year'
	local y = `y'+1
	gen loginvestment`year' = log(investment`year')
}

kountry countryiso3, from(iso3c)
drop countryiso3 countryname indicatorid indicator subindicatortype

save ${path_data}/imf.dta, replace

************************************
************************************ Democracy Does Cause Growth Replication Data

// relevant variables: country, loginvpc (log investment), ltfp (log TFP), marketref (market reforms), ltrade (trade share), lgov (government expenditure), lprienr (primary enrollment), lsecenr (secondary enrollment), lmort (child mortality), unrestn (riots and revolutions)

// load data from Acemoglu et al. (JPE, 2019)
use ${path_input}/channels21st/DDCGdata_final.dta, clear
	
foreach var of varlist loginvpc ltfp marketref ltrade2 lgov lprienr lsecenr lmort unrestn{
	use ${path_input}/channels21st/DDCGdata_final.dta, clear
	keep country_name year `var'
	reshape wide `var', i(country_name) j(year)
	save ${path_data}/`var'.dta, replace
}

// merge each of the individual .dta into one dataset
// use ${path_input}/channels21st/DDCGdata_final.dta, clear
use ${path_input}/channels21st/DDCGdata_final.dta, clear
keep country_name wbcode 
duplicates drop
foreach var in loginvpc ltfp marketref ltrade2 lgov lprienr lsecenr lmort unrestn{
	merge 1:1 country_name using ${path_data}/`var'.dta, nogenerate
}

kountry wbcode, from(iso3c) m
replace NAMES_STD = "Singapore" if wbcode=="SIN"
replace NAMES_STD = "United Arab Emirates" if wbcode =="UAE"
replace NAMES_STD = "Yugoslavia" if wbcode =="SER"
replace NAMES_STD = "Nauru" if wbcode=="NAU"
replace NAMES_STD = "Taiwan" if wbcode=="TAW"

save ${path_data}/ddcg.dta, replace

************************************
************************************ Innovation Data 
// // variables which are correlated with democracy with high significance or are important 
// local indicators "Research and development expenditure (% of GDP)" "Researchers in R&D (per million people)" "ICT goods imports (% of total goods imports)" "ICT service imports (% of service imports, BoP)" "High-technology imports (% of manufactured imports)" "Patent applications, residents" "Investment in telecoms with private participation (current US$)" "import value index (2000 = 100)" "Gross national expenditure (% of GDP)" "import value index (2000 = 100)" "International tourism, expenditures for passenger transport items (current US$)" "Manufacturing, value added (annual % growth)" "Merchandise imports to low- and middle-income economies in Latin America & the Caribbean (% of total merchandise imports)" "Merchandise imports to low- and middle-income economies in South Asia (% of total merchandise imports)" "Net trade in goods (BoP, current US$)" "Net trade in goods and services (BoP, current US$)" "New business density (new registrations per 1,000 people ages 15-64)" "New businesses registered (number)" "Services, etc., value added (% of GDP)" "Services, etc., value added (annual % growth)" "Taxes on goods and services (% value added of industry and services)" "Taxes on income, profits and capital gains (% of total taxes)" "Technicians in R&D (per million people)" 

// local shortnames rd_expenditure rd_researchers ict_goods_imports ict_services_imports high_tech_imports patent_apps telecoms_investment import_value national_expenditure import_value tourism manufacturing_value_added merch_imports_latin merch_imports_south_asia net_trade_goods net_trade_goods_services new_business_density new_business_registered services_va services_va_growth tax_goods_services tax_income technicians_rd
// local n:word count "`indicators'"
// local m:word count `shortnames'
// di `n'
// di `m'
import delimited ${path_input}/channels21st/raw_data.csv, clear 
// Get data on: 1. trade 2. growth in manufacturing and service sector value added 

// local indicators "import value index (2000 = 100)" ///
// "imports of goods and services (% of GDP)" ///
// "imports of goods and services (% of GDP)" ///
// "Net trade in goods (BoP, current US$)" ///
// "Net trade in goods and services (BoP, current US$)" ///
// "Trade (% of GDP)" ///
// "Trade in services (% of GDP)" ///
// "Manufacturing, value added (annual % growth)" ///
// "Services, etc., value added (annual % growth)" ///
// "Merchandise imports to low- and middle-income economies in Latin America & the Caribbean (% of total merchandise imports)" ///
// "Merchandise imports to low- and middle-income economies in South Asia (% of total merchandise imports)" ///
// "Foreign direct investment, net inflows (% of GDP)" ///
// "Foreign direct investment, net outflows (% of GDP)"


local indicators "Import value index (2000 = 100)" "Export value index (2000 = 100)" "Manufacturing, value added (annual % growth)" "imports of goods and services (% of GDP)" "exports of goods and services (% of GDP)" "Manufacturing, value added (% of GDP)" "Services, etc., value added (% of GDP)"
local shortnames import_value export_value manu_va_growth import_gdp export_gdp manu_va_gdp serv_va_gdp
local n:word count "`indicators'"

forvalues i = 1/`n' {
	import delimited ${path_input}/channels21st/raw_data.csv, clear 
	local indicator "`: word `i' of "`indicators'"'"
	local shortname "`:word `i' of `shortnames''"
	
	keep if indicator=="`indicator'"
	local y = 6
	forvalues year = 1960/2020 {
			rename v`y' `shortname'`year'
			local y = `y' + 1
			gen log`shortname'`year' = log(`shortname'`year')
	}
	keep countryiso3 log* `shortname'*
	kountry countryiso3, from(iso3c)
	drop if NAMES_STD==""
	save ${path_data}/`shortname'.dta, replace
}

import delimited ${path_input}/channels21st/services_va.csv, varnames(5) encoding(UTF-8) rowrange(6) clear 
local shortname "serv_va_growth"
local y = 5
forvalues year = 1960/2020 {
			rename v`y' `shortname'`year'
			local y = `y' + 1
			gen log`shortname'`year' = log(`shortname'`year')
}

keep countrycode log* `shortname'*
kountry countrycode, from(iso3c)
drop if NAMES_STD==""
save ${path_data}/`shortname'.dta, replace


use ${path_data}/import_value.dta, clear
local shortnames export_value manu_va_growth serv_va_growth import_gdp export_gdp manu_va_gdp serv_va_gdp
local n:word count `shortnames'
di `n'
forvalues i = 1/`n'{
	local shortname "`:word `i' of `shortnames''"
	di "`shortname'"
	merge 1:1 NAMES_STD using ${path_data}/`shortname'.dta, nogenerate
}
save ${path_data}/innovation.dta, replace

************************************
************************************ China trade data: import

import delimited ${path_input}/channels21st/comtrade.csv, clear

kountry reporteriso, from(iso3c) marker
drop if MARKER==0
keep if tradeflow=="Import"
keep year NAMES_STD tradevalueus
rename tradevalueus china_import
reshape wide china_import, i(NAMES_STD) j(year)
keep china_import2001-china_import2019 NAMES_STD
// egen mean_import_china = rowmean(china_import2001-china_import2019)

save ${path_data}/china_import.dta, replace

************************************
************************************ China trade data: export

import delimited ${path_input}/channels21st/comtrade.csv, clear

kountry reporteriso, from(iso3c) marker
drop if MARKER==0
keep if tradeflow=="Export"
keep year NAMES_STD tradevalueus
rename tradevalueus china_export
reshape wide china_export, i(NAMES_STD) j(year)
keep china_export2001-china_export2019 NAMES_STD
// egen mean_export_china = rowmean(china_export2001-china_export2019)

save ${path_data}/china_export.dta, replace

************************************
************************************ Merge all channels data 

*** import countries data 
use ${path_data}/countries.dta, replace

*** merge with containmenthealth10.dta
merge 1:1 NAMES_STD using ${path_data}/containmenthealth10.dta
drop if _merge==2
drop _merge

*** merge with coverage10.dta
merge 1:1 NAMES_STD using ${path_data}/coverage10.dta
drop if _merge==2
drop _merge

*** merge with introduce_policy.dta
merge 1:1 NAMES_STD using ${path_data}/introduce_policy.dta
drop if _merge==2
drop _merge

*** merge with wdi.dta
merge 1:1 NAMES_STD using ${path_data}/wdi.dta
drop if _merge==2
drop _merge

*** merge with pwt.dta
merge 1:1 NAMES_STD using ${path_data}/pwt.dta
drop if _merge==2
drop _merge

*** merge with pwt.dta
merge 1:1 NAMES_STD using ${path_data}/imf.dta
drop if _merge==2
drop _merge

*** merge with ddcg.dta
merge 1:1 NAMES_STD using ${path_data}/ddcg.dta
drop if _merge==2
drop _merge

*** merge with innovation.dta
merge 1:1 NAMES_STD using ${path_data}/innovation.dta
drop if _merge==2
drop _merge

*** merge with china_import.dta
merge 1:1 NAMES_STD using ${path_data}/china_import.dta
drop if _merge==2
drop _merge

*** merge with china_export.dta
merge 1:1 NAMES_STD using ${path_data}/china_export.dta
drop if _merge==2
drop _merge

save ${path_data}/channels.dta, replace


