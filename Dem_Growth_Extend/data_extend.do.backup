/*
Extends variables from the main dataset in "Democracy Does Cause Growth" ANRR
*/

global path "/Users/leonardofancello/Dropbox/Democracy/Dem_Growth_Extend"

local START = 1960
local END = 2020
local BASE_END = 2010

/* 
y: log of GDP per capita in 2000 constant dollars (multiplied by a 100) 
*/
insheet using ${path}/data/in/API_NY.GDP.PCAP.KD_DS2_en_csv_v2_4027038.csv, names clear // data.worldbank.org/indicator/NY.GDP.PCAP.KD
drop v66 v67 
reshape long v, i(countrycode) j(year)
replace year = year + `START'-5
replace v = v * 74.6264770821792 / 100 // Covert from 2015 to 2000 USD: data.worldbank.org/indicator/NY.GDP.DEFL.ZS
gen y_ext = log(v) * 100
replace countrycode = "ZAR" if countrycode == "COD" // Congo, Dem. Rep. of
replace countrycode = "NAU" if countrycode == "NRU" // Nauru
replace countrycode = "ROM" if countrycode == "ROU" // Romania
replace countrycode = "SIN" if countrycode == "SGP" // Singapore
replace countrycode = "UAE" if countrycode == "ARE" // United Arab Emirates
rename countrycode wbcode
keep year y_ext wbcode
tempfile f
save `f'

use ${path}/replication_files_ddcg/DDCGdata_final.dta, clear
merge m:m year wbcode using `f'
bys wbcode: egen temp = max(_merge)
replace _merge = 3 if temp == 3
drop temp
keep if _merge == 3 | _merge == 1
gen missing = missing(country_name)
bys wbcode (missing) : gen temp = country_name[1]
replace country_name = temp
replace y = y_ext if year > `BASE_END'
drop _merge missing temp y_ext

/*
dem: Democracy measure by ANRR
*/
merge m:m year wbcode using ${path}/data/dem.dta
bys wbcode: egen temp = max(_merge)
replace _merge = 3 if temp == 3
keep if _merge == 3 | _merge == 1
replace dem = rep_dem if year > `BASE_END'
drop _merge temp rep_dem
duplicates drop
gen missing = missing(wbcode2)
bys wbcode (missing) : gen temp = wbcode2[1]
replace wbcode2 = temp
drop missing temp
sort wbcode2 year

/*
yy*: Year dummies
*/
keep if `START' <= year & year <= `END'
loc temp = `BASE_END'-`START'+1
forvalues i=1/`temp' {
	replace yy`i' = year == `START'+`i'-1
}
loc temp1 = `BASE_END'-`START'+2
loc temp2 = `temp1'+`END'-`BASE_END'-1
forvalues i=`temp1'/`temp2' {
	loc j = `START'+`i'-1
	gen yy`i' = year == `j'
	lab var yy`i' "year== `j'.0000"
}

/*
sov1: Soviets post 89
sov2: Soviets post 90
sov3: Soviets post 91
sov4: Soviets post 92
*/
// assign forward based on 2010 value
forvalues i=1/4 {
	bys wbcode (year): replace sov`i' = sov`i'[_n-1] if missing(sov`i') & _n > 1 
}

/*
unrest: Occurrence of events of unrest (from Banks CNTS)
*/
preserve
	insheet using ${path}/data/in/2022_Edition_CNTSDATA.csv, names clear // library.yale.edu/databases/11973989
	gen unrest_ext = domestic6 > 0 | domestic7 >  0
	replace wbcode = "TAW" if wbcode == "TWN" // Taiwan
	replace wbcode = "UAE" if wbcode == "ARE" // United Arab Emirates
	keep year unrest_ext wbcode
	keep if `START' <= year & year <= `END'
	tempfile f
	save `f'
restore
merge m:m year wbcode using `f'
bys wbcode: egen temp = max(_merge)
replace _merge = 3 if temp == 3
drop temp
keep if _merge == 3 | _merge == 1
replace unrest = unrest_ext if year > `BASE_END'
drop _merge unrest_ext

/*
tradewb:  Exports plus Imports as a share of GDP from World Bank
*/
preserve
	insheet using ${path}/data/in/API_NE.TRD.GNFS.ZS_DS2_en_csv_v2_4325652.csv, names clear // data.worldbank.org/indicator/NE.TRD.GNFS.ZS
	drop v66 v67
	reshape long v, i(countrycode) j(year)
	replace year = year + `START'-5
	rename v tradewb_ext
	replace countrycode = "ZAR" if countrycode == "COD" // Congo, Dem. Rep. of
	replace countrycode = "NAU" if countrycode == "NRU" // Nauru
	replace countrycode = "ROM" if countrycode == "ROU" // Romania
	replace countrycode = "SIN" if countrycode == "SGP" // Singapore
	replace countrycode = "UAE" if countrycode == "ARE" // United Arab Emirates
	rename countrycode wbcode
	keep year tradewb_ext wbcode
	tempfile f
	save `f'
restore
merge m:m year wbcode using `f'
bys wbcode: egen temp = max(_merge)
replace _merge = 3 if temp == 3
drop temp
keep if _merge == 3 | _merge == 1
replace tradewb = tradewb_ext if year > `BASE_END'
drop _merge tradewb_ext

/*
nfagdp: (mean) nfagdp, Financial Flows
*/
preserve
	insheet using ${path}/data/in/EWN-dataset_9.14.21.csv, names clear // brookings.edu/research/the-external-wealth-of-nations-database
	rename netiipexclgoldgdpdomesticcurrenc nfagdp_ext
	rename country country_name
	replace country_name = "Afghanistan" if country_name == "Afghanistan, I.R. of"
	replace country_name = "Bahamas" if country_name == "Bahamas, The"
	replace country_name = "Bosnia & Herzegovina" if country_name == "Bosnia and Herzegovina"
	replace country_name = "China" if country_name == "China,P.R.: Mainland"
	replace country_name = "Iran, I.R. of" if country_name == "Iran, Islamic Republic of"
	replace country_name = "Macedonia, FYR" if country_name == "North Macedonia"
	replace country_name = "Swaziland" if country_name == "Eswatini"
	keep year nfagdp_ext country_name
	tempfile f
	save `f'
restore
merge m:m year country_name using `f'
bys country_name: egen temp = max(_merge)
replace _merge = 3 if temp == 3
drop temp
preserve
	keep if _merge == 2
	replace wbcode = "CIV" if country_name == "Côte d'Ivoire"
	replace wbcode = "STP" if country_name == "São Tomé & Príncipe"
	keep if wbcode != ""
	keep year nfagdp_ext wbcode
	tempfile f
	save `f'
restore
keep if _merge == 3 | _merge == 1
drop _merge
replace nfagdp = nfagdp_ext if year > `BASE_END'
drop nfagdp_ext
merge m:m year wbcode using `f'
bys wbcode: egen temp = max(_merge)
replace _merge = 3 if temp == 3
drop temp
keep if _merge == 3 | _merge == 1
drop _merge
replace nfagdp = nfagdp_ext if year > `BASE_END'
drop nfagdp_ext

/*
PopulationtotalSPPOPTOTL: Population, total [SP.POP.TOTL]
Populationages014oftotal: Population ages 0-14 (% of total) [SP.POP.0014.TO.ZS]
Populationages1564oftota: Population ages 15-64 (% of total) [SP.POP.1564.TO.ZS]
*/
preserve
	insheet using ${path}/data/in/API_SP.POP.TOTL_DS2_en_csv_v2_4335082.csv, names clear // data.worldbank.org/indicator/SP.POP.TOTL
	drop v66 v67
	reshape long v, i(countrycode) j(year)
	replace year = year + `START'-5
	rename v PopulationtotalSPPOPTOTL_ext
	replace countrycode = "ZAR" if countrycode == "COD" // Congo, Dem. Rep. of
	replace countrycode = "NAU" if countrycode == "NRU" // Nauru
	replace countrycode = "ROM" if countrycode == "ROU" // Romania
	replace countrycode = "SIN" if countrycode == "SGP" // Singapore
	replace countrycode = "UAE" if countrycode == "ARE" // United Arab Emirates
	rename countrycode wbcode
	keep year PopulationtotalSPPOPTOTL_ext wbcode
	tempfile f
	save `f'
restore
merge m:m year wbcode using `f'
bys wbcode: egen temp = max(_merge)
replace _merge = 3 if temp == 3
drop temp
keep if _merge == 3 | _merge == 1
replace PopulationtotalSPPOPTOTL = PopulationtotalSPPOPTOTL_ext if year > `BASE_END'
drop _merge PopulationtotalSPPOPTOTL_ext
preserve
	insheet using ${path}/data/in/API_SP.POP.0014.TO.ZS_DS2_en_csv_v2_4354886.csv, names clear // data.worldbank.org/indicator/SP.POP.0014.TO.ZS
	drop v66 v67
	reshape long v, i(countrycode) j(year)
	replace year = year + `START'-5
	rename v Populationages014oftotal_ext
	replace countrycode = "ZAR" if countrycode == "COD" // Congo, Dem. Rep. of
	replace countrycode = "NAU" if countrycode == "NRU" // Nauru
	replace countrycode = "ROM" if countrycode == "ROU" // Romania
	replace countrycode = "SIN" if countrycode == "SGP" // Singapore
	replace countrycode = "UAE" if countrycode == "ARE" // United Arab Emirates
	rename countrycode wbcode
	keep year Populationages014oftotal_ext wbcode
	tempfile f
	save `f'
restore
merge m:m year wbcode using `f'
bys wbcode: egen temp = max(_merge)
replace _merge = 3 if temp == 3
drop temp
keep if _merge == 3 | _merge == 1
replace Populationages014oftotal = Populationages014oftotal_ext if year > `BASE_END'
drop _merge Populationages014oftotal_ext
preserve
	insheet using ${path}/data/in/API_SP.POP.1564.TO.ZS_DS2_en_csv_v2_4353503.csv, names clear // data.worldbank.org/indicator/SP.POP.1564.TO.ZS
	drop v66 v67
	reshape long v, i(countrycode) j(year)
	replace year = year + `START'-5
	rename v Populationages1564oftota_ext
	replace countrycode = "ZAR" if countrycode == "COD" // Congo, Dem. Rep. of
	replace countrycode = "NAU" if countrycode == "NRU" // Nauru
	replace countrycode = "ROM" if countrycode == "ROU" // Romania
	replace countrycode = "SIN" if countrycode == "SGP" // Singapore
	replace countrycode = "UAE" if countrycode == "ARE" // United Arab Emirates
	rename countrycode wbcode
	keep year Populationages1564oftota_ext wbcode
	tempfile f
	save `f'
restore
merge m:m year wbcode using `f'
bys wbcode: egen temp = max(_merge)
replace _merge = 3 if temp == 3
drop temp
keep if _merge == 3 | _merge == 1
replace Populationages1564oftota = Populationages1564oftota_ext if year > `BASE_END'
drop _merge Populationages1564oftota_ext
sort wbcode2 year

/*
yeardem: Identifier for a democratization during this year 
*/
gen temp = (dem - l.dem) == 1
replace temp = . if (dem - l.dem) == .
replace yeardem = temp if year > `BASE_END'
drop temp

/*
yearrev: Identifier for a reversal to autocracy during this year 
*/
gen temp = (dem - l.dem) == -1
replace temp = . if (dem - l.dem) == .
replace yearrev = temp if year > `BASE_END'
drop temp

/*
InitReg: Democratic status after independence or in 1960
*/
// assign all same
bys wbcode (year): replace InitReg = InitReg[_n-1] if missing(InitReg) & _n > 1 

/*
region: Geographical region
*/
// assign all same
bys wbcode (year): replace region = region[_n-1] if missing(region) & _n > 1 

/*
demext: Democratic status at beginning of sample
*/
// assign all same
bys wbcode (year): replace demext = demext[_n-1] if missing(demext) & _n > 1 

/*
region_initreg_year: Region/Initial regime/year cells
*/
replace region_initreg_year = region + demext + string(year)

/*
regdum*: region_initreg_year fixed effects
*/
drop regdum*
loc i = 1
levelsof region_initreg_year
foreach r in `r(levels)' {
	gen regdum`i' = region_initreg_year == "`r'"
	loc i = `i' + 1
}

/*
demreg: Average democracy in the region*initial regime (leaving own country out)
*/
egen temp_sum = total(dem), by(region_initreg_year)
egen temp_count = count(dem), by(region_initreg_year)
gen temp = (temp_sum - dem) / (temp_count - 1)
replace temp = temp_sum / temp_count if dem == .
replace demreg = temp
drop temp_sum temp_count temp

/*
yreg: Regional GDP per capita
*/
egen temp_sum = total(y), by(region_initreg_year)
egen temp_count = count(y), by(region_initreg_year)
gen temp = (temp_sum - y) / (temp_count - 1)
replace temp = temp_sum / temp_count if y == .
replace yreg = temp if year > `BASE_END'
drop temp_sum temp_count temp

/*
tradewbreg: Regional trade
*/
egen temp_sum = total(tradewb), by(region_initreg_year)
egen temp_count = count(tradewb), by(region_initreg_year)
gen temp = (temp_sum - tradewb) / (temp_count - 1)
replace temp = temp_sum / temp_count if tradewb == .
replace tradewbreg = temp if year > `BASE_END'
drop temp_sum temp_count temp

/*
unrestreg: Regional unrest
*/
egen temp_sum = total(unrest), by(region_initreg_year)
egen temp_count = count(unrest), by(region_initreg_year)
gen temp = (temp_sum - unrest) / (temp_count - 1)
replace temp = temp_sum / temp_count if unrest == .
replace unrestreg = temp if year > `BASE_END'
drop temp_sum temp_count temp

/*
cen_lon: longitude of country centroid
*/
// assign all same
bys wbcode (year): replace cen_lon = cen_lon[_n-1] if missing(cen_lon) & _n > 1 

/*
cen_lat: latitude of country centroid
*/
// assign all same
bys wbcode (year): replace cen_lat = cen_lat[_n-1] if missing(cen_lat) & _n > 1 

/*
gdp1960: GDP per capita in 1960 from Madisson
*/
// assign all same
bys wbcode (year): replace gdp1960 = gdp1960[_n-1] if missing(gdp1960) & _n > 1 

/*
rtrend*: Region 1-7 trends
*/
// year interacted with region
loc i = 1
levelsof region
foreach r in r(levels) {
	replace rtrend`i' = year if region == "`r'"
	replace rtrend`i' = 0 if region != "`r'"
	loc i = `i' + 1
}

/*
quintile50s
*/
// assign all same
bys wbcode (year): replace quintile50s = quintile50s[_n-1] if missing(quintile50s) & _n > 1 

/*
dquint*
interfull_yy*_quintile*
*/
forvalues i=1/5 {
	replace dquint`i' = quintile50s == `i'
}
drop interfull*
loc temp = `END'-`START'+1
forvalues i=1/`temp' {
	forvalues j=1/5 {
		gen interfull_yy`i'_quintile`j' = yy`i' * dquint`j'
	}
}

/*
ginv: Gross investment as a share of GDP
loginvpc: log investment (multiplied by 100)
*/
// API_NE.GDI.TOTL.ZS_DS2_en_csv_v2_4353870.csv // data.worldbank.org/indicator/NE.GDI.TOTL.ZS

/*
rtfpna: TFP at constant national prices (2005=1) from PWT
ltfp: log TFP (multiplied by 100)
*/
// pwt100.dta // rug.nl/ggdc/productivity/pwt/

/*
marketref: Index of market reforms
AUTHORS DO NOT EXTEND
*/

/*
ltrade2: lof of trade (multiplied by 100)
*/
// tradewb

/*
taxratio: Tax revenue as a share of GDP (from Hendrix)
lgov: log of taxes to GDP (multiplied by a 100)
AUTHORS DO NOT EXTEND
*/

/*
prienr: Primary enrollment from World Bank
lprienr: lof of primary enrollment (multiplied by 100)
*/
// API_SE.PRM.ENRR_DS2_en_csv_v2_4354186.csv // data.worldbank.org/indicator/SE.PRM.ENRR

/*
secenr: Secondary enrollment from World bank
lsecenr: log of secondary enrollment (multiplied by 100)
*/
// API_SE.SEC.ENRR_DS2_en_csv_v2_4354278.csv // data.worldbank.org/indicator/SE.SEC.ENRR

/*
mortnew: Child mortality per 1000 births from World Bank
lmort: log of child mortality rate (multiplied by a 100)
*/
// API_SP.DYN.IMRT.IN_DS2_en_csv_v2_4354762.csv // data.worldbank.org/indicator/SP.DYN.IMRT.IN

/*
unrestn: Likelihood of unrest (0-100 scale)
*/

/*
ls_bl: Percentage of population with at most secondary (Barro-Lee)
lh_bl: Percentage of population with tertiary education (Barro-Lee)
*/
preserve
	insheet using ${path}/data/in/BL_v3_MF1564.csv, names clear // barrolee.com
	replace wbcode = "ZAR" if wbcode == "COD" // Congo, Dem. Rep. of
	replace wbcode = "ROM" if wbcode == "ROU" // Romania
	replace wbcode = "SIN" if wbcode == "SGP" // Singapore
	replace wbcode = "UAE" if wbcode == "ARE" // United Arab Emirates
	replace wbcode = "TAW" if wbcode == "TWN" // Taiwan
	keep year ls lh wbcode
	keep if year >= `START'
	tempfile f
	save `f'
restore
merge m:m year wbcode using `f'
bys wbcode: egen temp = max(_merge)
replace _merge = 3 if temp == 3
drop temp
keep if _merge == 3 | _merge == 1
replace ls_bl = ls if year > `BASE_END'
replace lh_bl = lh if year > `BASE_END'
drop _merge ls lh
duplicates drop wbcode2 year, force // Romania bugged
sort wbcode2 year

save ${path}/data/extended.dta, replace
