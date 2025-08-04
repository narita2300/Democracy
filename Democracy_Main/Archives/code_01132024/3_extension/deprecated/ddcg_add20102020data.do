

// https://economics.mit.edu/files/13147
// page A1, A2
********************************************************************************
// import the Freedom House measure of democracy 
// import excel ${path_input}/democracy/freedom_house/2020_All_Data_FIW_2013-2020.xlsx, sheet("FIW13-20") cellrange(A2:AR1677) firstrow
import excel ${path_input}/democracy/freedom_house/Aggregate_Category_and_Subcategory_Scores_FIW_2003-2021.xlsx, sheet("FIW06-21") firstrow clear
keep if Edition >= 2011

// create a dummy to record whether it is "free" or "partially free"
gen dem_fh = (Status == "PF" | Status == "F")

// standardize the country names 
kountry CountryTerritory, from(other) m
// keep if MARKER==1
gen year = Edition - 1
rename CountryTerritory country_fh
keep NAMES_STD dem_fh year 

duplicates list NAMES_STD year

// save the data
save ${path_data}/dem_fh.dta, replace
********************************************************************************
// import the polity IV measure of democracy 
import excel ${path_input}/democracy/center_for_systemic_peace/p5v2018.xls, sheet("p5v2018") firstrow clear
keep if year >= 2010

// create a dummy to record whether the polity score is positive 
gen dem_polity = (polity > 0)

// standardize the country names 
kountry country, from(other) m
// keep if MARKER==1

duplicates drop NAMES_STD year, force

// rename country country_polity
keep NAMES_STD dem_polity year

// save the data
save ${path_data}/dem_polity.dta, replace

********************************************************************************

// merge the two datasets 

use ${path_data}/dem_fh.dta, clear

merge 1:1 NAMES_STD year using ${path_data}/dem_polity.dta

// 1. Code a country as democratic if Freedom House regards it as "Free" or "Partially Free" and Polity IV gives it a positive democracy score
gen dem = (dem_fh == 1 & dem_polity == 1) 

// 2. For small countries that only appear in the Freedom House sample, we code them as democratic if their Freedom House status is "Free" or "Partially Free" and either CGV or MBR consider them to be democratic 
// What are the small countries that only appear in the Freedom House sample? 
gen only_in_fh = (dem_fh !=. & dem_polity ==. )


********************************************************************************
// deal with problematic cases (duplicates in NAMES_STD-year pairs) later
