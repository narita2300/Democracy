/*
Creates the dichotomous measure of democracy described in "Democracy Does Cause Growth" ANRR
*/

global path "/Users/masaoishihara/Democracy/Dem_Growth_Extend"

/* 
Polity: http://www.systemicpeace.org/inscrdata.html
ANRR Appendix: "Polity IV gives it a positive democracy score (The Polity IV index is between -10 and 10)." but in the codebook for Polity IV: "The Democracy indicator is an additive eleven-point scale (0-10)."
This means either POLITY or POLITY2 (both scaled between -10 and 10) is actually used.
*/
import excel ${path}/data/in/p5v2018.xls, firstrow clear
gen demPOL = polity2 > 0
replace demPOL = . if polity2 == -88 | polity2 == -66
replace country = "Bosnia & Herzegovina" if country == "Bosnia"
replace country = "Central African Rep." if country == "Central African Republic"
replace country = "Congo, Republic of" if country == "Congo Brazzaville"
replace country = "Congo, Dem. Rep. of" if country == "Congo Kinshasa"
replace country = "Cote d'Ivoire" if country == "Cote D'Ivoire"
replace country = "Gambia, The" if country == "Gambia"
replace country = "Germany, E. " if country == "Germany East"
replace country = "Germany, W. " if country == "Germany West"
replace country = "Iran, I.R. of" if country == "Iran"
replace country = "Korea" if country == "Korea South"
replace country = "Kyrgyz Republic" if country == "Kyrgyzstan"
replace country = "Lao People's Dem.Rep" if country == "Laos"
replace country = "Macedonia, FYR" if country == "Macedonia"
replace country = "Myanmar" if country == "Myanmar (Burma)"
replace country = "North Korea" if country == "Korea North"
replace country = "Syrian Arab Republic" if country == "Syria"
replace country = "Timor-Leste" if country == "Timor Leste"
replace country = "United Arab Emirates" if country == "UAE"
replace country = "United States" if country == "United States                   "
replace country = "Venezuela, Rep. Bol." if country == "Venezuela"
replace country = "Yemen, N." if country == "Yemen North"
replace country = "Yemen, Republic of" if country == "Yemen"
replace country = "Yemen, S." if country == "Yemen South"
rename country country_name
keep year demPOL scode country_name
tempfile f1
save `f1'

/* 
Freedom House: https://freedomhouse.org/report/freedom-world
Preprocess data using freedom_house_csv.ipynb
*/
insheet using ${path}/data/in/fh_1990_2021.csv, clear
gen demFH = (rating == "PF") | (rating == "F")
replace demFH = . if rating == "-"
replace country = "Bosnia & Herzegovina" if country == "Bosnia and Herzegovina"
replace country = "Brunei Darussalam" if country == "Brunei"
replace country = "Cape Verde" if country == "Cabo Verde"
replace country = "Central African Rep." if country == "Central African Republic"
replace country = "Congo, Republic of" if country == "Congo (Brazzaville)"
replace country = "Congo, Dem. Rep. of" if country == "Congo (Kinshasa)"
replace country = "Gambia, The" if country == "The Gambia"
replace country = "Iran, I.R. of" if country == "Iran"
replace country = "Korea" if country == "South Korea"
replace country = "Kyrgyz Republic" if country == "Kyrgyzstan"
replace country = "Lao People's Dem.Rep" if country == "Laos"
replace country = "Macedonia, FYR" if country == "North Macedonia"
replace country = "Serbia & Montenegro" if country == "Serbia and Montenegro"
replace country = "Slovak Republic" if country == "Slovakia"
replace country = "St. Vincent & Grens." if country == "St. Vincent and the Grenadines"
replace country = "Swaziland" if country == "Eswatini"
replace country = "Syrian Arab Republic" if country == "Syria"
replace country = "Venezuela, Rep. Bol." if country == "Venezuela"
replace country = "Yemen, Republic of" if country == "Yemen"
rename country country_name
keep year demFH country_name
tempfile f2
save `f2'

/*  
Boix-Miller-Rosato: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/FENWWR
*/
u ${path}/data/in/democracy-v4.0.dta, clear
gen demBMR = democracy
replace country = proper(country)
rename abbreviation wbcode
keep year demBMR wbcode country
tempfile f3
save `f3'

/*
Cheibub, Gandhi and Vreeland: https://xmarquez.github.io/democracyData/reference/pacl_update.html
*/
import excel ${path}/data/in/Bjrnskov-Rode-integrated-dataset-v3.2.xlsx, firstrow sheet("Regime characteristics") clear
gen demCGV = Democracy
rename countryisocode wbcode
keep year demCGV wbcode country
tempfile f4
save `f4'

/*ANRR: https://www.journals.uchicago.edu/doi/full/10.1086/700936 */
use ${path}/replication_files_ddcg/DDCGdata_final.dta, clear
keep country_name wbcode year dem
// Merge f4: wbcode, country_name
merge m:m year wbcode using `f4'
bys wbcode: egen temp = max(_merge)
replace _merge = 3 if temp == 3
drop temp
gen missing = missing(country_name)
bys wbcode (missing) : gen temp = country_name[1]
replace country_name = temp
drop missing temp
preserve
	keep if _merge == 1
	drop _merge
	keep country_name wbcode year dem
	tempfile t1
	save `t1'
restore
preserve
	keep if _merge == 2
	drop _merge
	keep year demCGV wbcode country
	rename wbcode countryisocode
	rename country country_name
	tempfile t2
	save `t2'
restore
preserve
	keep if _merge == 3
	drop _merge country
	tempfile t3
	save `t3'
restore
u `t1', clear
merge m:m year country_name using `t2'
bys country_name: egen temp = max(_merge)
replace _merge = 3 if temp == 3
drop temp
keep if _merge == 3 | _merge == 1
drop _merge countryisocode
gen missing = missing(wbcode)
bys country_name (missing) : gen temp = wbcode[1]
replace wbcode = temp
drop missing temp
append using `t3'
// Merge f3: wbcode, country_name
merge m:m year wbcode using `f3'
bys wbcode: egen temp = max(_merge)
replace _merge = 3 if temp == 3
drop temp
gen missing = missing(country_name)
bys wbcode (missing) : gen temp = country_name[1]
replace country_name = temp
drop missing temp
preserve
	keep if _merge == 1
	drop _merge
	keep country_name wbcode year dem demCGV
	tempfile t1
	save `t1'
restore
preserve
	keep if _merge == 2
	drop _merge
	keep year demBMR wbcode country
	rename wbcode abbreviation
	rename country country_name
	tempfile t2
	save `t2'
restore
preserve
	keep if _merge == 3
	drop _merge country
	tempfile t3
	save `t3'
restore
u `t1', clear
merge m:m year country_name using `t2'
bys country_name: egen temp = max(_merge)
replace _merge = 3 if temp == 3
drop temp
keep if _merge == 3 | _merge == 1
drop _merge abbreviation
gen missing = missing(wbcode)
bys country_name (missing) : gen temp = wbcode[1]
replace wbcode = temp
drop missing temp
append using `t3'
// Merge f2: country_name
replace country = "Cote d'Ivoire" if wbcode == "CIV"
replace country = "Sao Tome and Principe" if wbcode == "STP"
merge m:m year country_name using `f2', nogen
gen missing = missing(wbcode)
bys country_name (missing) : gen temp = wbcode[1]
replace wbcode = temp
drop missing temp
// Merge f1: country_name
merge m:m year country_name using `f1', nogen
drop scode
gen missing = missing(wbcode)
bys country_name (missing) : gen temp = wbcode[1]
replace wbcode = temp
drop missing temp

sort country_name year

// 1. Freedom House "Free" or "Partially Free" & Polity IV positive
gen rep_dem = demFH * demPOL
cor rep_dem dem
/* 
3,358/8,735: 0.9403 
1,777/2,024: 0.9630 2000-2010 Only
6,038/8,733: 0.7432 DDCGdata_final.dta
1,721/2,024: 0.6165 DDCGdata_final.dta; 2000-2010 Only
*/

// 2. No Polity IV: Freedom House "Free" or "Partially Free" & CGV democratic or BMR democratic
replace rep_dem = 1 if demPOL == . & demFH == 1 & (demCGV == 1 | demBMR == 1)
replace rep_dem = 0 if demPOL == . & demFH == 1 & demCGV == 0 & demBMR == 0 // Samoa
levelsof year if demCGV != .
global CGV_end : word `r(r)' of `r(levels)'
levelsof year if demBMR != .
global BMR_end : word `r(r)' of `r(levels)'
loc min_end = min(${CGV_end}, ${BMR_end})
bys wbcode: egen steady_check = mean(demFH) if year >= `min_end'
replace rep_dem = demFH if demPOL == . & year >= `min_end' & steady_check == demFH // Freedom House if steady and CGV/BMR end
drop steady_check
cor rep_dem dem 
/* 
3,765/8,735: 0.9444
1,995/2,024: 0.9608 2000-2010 Only
6,612/8,733: 0.7696 DDCGdata_final.dta
1,946/2,024: 0.6442 DDCGdata_final.dta; 2000-2010 Only
*/

// 3. No Freedom House before 1972: Polity IV positive & CGV democratic or BMR democratic
levelsof year if demFH != .
global FH_start : word 1 of `r(levels)'
replace rep_dem = 1 if year < $FH_start & demPOL == 1 & (demCGV == 1 | demBMR == 1)
replace rep_dem = 0 if year < $FH_start & demPOL == 1 & demCGV == 0 & demBMR == 0 // coded nondemocracies by CGV/BMR
cor rep_dem dem 
/*
5,190/8,735: 0.9327 
1,995/2,024: 0.9608 2000-2010 Only
7,136/8,733: 0.7860 DDCGdata_final.dta
1,946/2,024: 0.6442 DDCGdata_final.dta; 2000-2010 Only
*/

// 4. Ex-Soviet and Ex-Yugoslav countries are coded as nondemocracies before 1990, based on the USSR and Yugoslavia scores before their dissolution
/* sov1 sov2 sov3 sov4 but Missing Yugoslavia scores */

// 5. Both Freedom House and Polity missing: code manually
replace rep_dem = 1 if country_name == "Antigua and Barbuda" & year >= 1981 // Antigua and Barbuda
replace rep_dem = 1 if country_name == "Barbados" & year >= 1966 & year < $FH_start // Barbados
replace rep_dem = 1 if country_name == "Germany" | country_name == "Iceland" | country_name == "Luxembourg" // Germany, Iceland, Luxembourg
replace rep_dem = 0 if country_name == "Kuwait" & (year == 1961 | year == 1962) // Kuwait
replace rep_dem = 0 if country_name == "Maldives" & year >= 1965 & year < $FH_start // Maldives
replace rep_dem = 1 if country_name == "Malta" & year >= 1964 & year < $FH_start // Malta
replace rep_dem = 1 if country_name == "Nauru" & year >= 1968 & year < $FH_start // Nauru
replace rep_dem = 0 if country_name == "Syrian Arab Republic" & year == 1960 // Syria
replace rep_dem = 0 if country_name == "Tonga" & year >= 1970 // Tonga
replace rep_dem = 0 if country_name == "Vietnam" | country_name == "Yemen, Republic of" // Vietnam, Yemen
replace rep_dem = 0 if country_name == "Samoa" & demPOL == . & demFH == . & demCGV == 0 & demBMR == 0 // Samoa
replace rep_dem = 0 if country_name == "Zimbabwe" & year >= 1965 & year <= 1969 // Zimbabwe
cor rep_dem dem 
/*
5,471/8,735: 0.9371 
1,995/2,024: 0.9619 2000-2010 Only
7,346/8,733: 0.7916 DDCGdata_final.dta
1,964/2,024: 0.6469 DDCGdata_final.dta; 2000-2010 Only
*/

// 6. Remove spurious transitions created when countries enter or leave the Freedom House, Polity, or our secondary sources' samples
replace rep_dem = 1 if country_name == "Cyprus" & year >= 1974 // Cyprus
replace rep_dem = 0 if country_name == "Malaysia" // Malaysia
replace rep_dem = 1 if country_name == "Guyana" 
replace rep_dem = 0 if country_name == "Guyana" & year >= 1966 & year <= 1990 // Guyana
replace rep_dem = 1 if country_name == "Gambia, The" & year >= 1965 & year <= 1993 // Gambia
cor rep_dem dem 
/*
5,483/8,735: 0.9494
1,995/2,024: 0.9738 2000-2010 Only
7,352/8,733: 0.7977 DDCGdata_final.dta
1,964/2,024: 0.6476 DDCGdata_final.dta; 2000-2010 Only
*/

// 7. adjust it to match the dates for permanent democratizations that PS coded
/* [NO CHANGES NEEDED] */

keep if year >= 1960
keep year wbcode country_name rep_dem
save ${path}/data/dem.dta, replace
