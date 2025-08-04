
// load V-Den data for countries 
import delimited "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/democracy/Country_Year_V-Dem_Core_CSV_v11.1/V-Dem-CY-Core-v11.1.csv", clear 

keep if year >= 2000

// what variables do we want to look at changes in? 

/// first,  all the components of the liberal democracy index

// // regime type
// v2x_regime

// // the electoral democracy index: freedom of association thick (v2x_frassoc_thick), clean elections (v2xel_frefair), freedom of expression (v2x_freexp_altinf), elected officials (v2x_elecoff), and suffrage (v2x_suffr) 
// v2x_freexp_altinf 
// v2x_frassoc_thick 
// v2x_suffr 
// v2xel_frefair
// v2x_elecoff 
// // the liberal component: equality before the law and individual liberties (v2xcl_rol), judicial constraints on the executive (v2x_jucon), and legislative constraints on the executive (v2xlg_legcon).
// v2xcl_rol 
// v2x_jucon
// v2xlg_legcon
// v2lgbicam 

keep country_name country_text_id year v2x_regime v2x_polyarchy v2x_libdem v2x_liberal v2x_freexp_altinf v2x_frassoc_thick v2x_suffr v2xel_frefair v2x_elecoff v2xcl_rol v2x_jucon v2xlg_legcon v2lgbicam 

keep if year == 2000 | year == 2019

gen regime2000 = v2x_regime if year == 2000
sort country_name year
by country_name: replace regime2000 = v2x_regime[_n-1] if year == 2019
keep if regime2000==1 | regime2000==2 // only keep electoral democracies or liberal democracies

foreach var of varlist v2x_polyarchy v2x_libdem v2x_liberal v2x_freexp_altinf v2x_frassoc_thick v2x_suffr v2xel_frefair v2x_elecoff v2xcl_rol v2x_jucon v2xlg_legcon v2lgbicam{
	sort country_name year
	by country_name: gen `var'2000 = `var'[_n-1] if year == 2019
	// bysort country_name: gen `var'_diff_2000_2019 = `var'[_n] - `var'[_n-1]
	rename `var' `var'2019
}

keep if year == 2019
keep country_name country_text_id *2000 *2019



// show how the liberal component index has changed over the past two decades for countries with the electoral democracy index in 2000 above the median 


// load V-Den data for countries 
import delimited "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/democracy/Country_Year_V-Dem_Core_CSV_v11.1/V-Dem-CY-Core-v11.1.csv", clear 

keep if year >= 2000

keep country_name country_text_id year v2x_regime v2x_polyarchy v2x_libdem v2x_liberal v2x_freexp_altinf v2x_frassoc_thick v2x_suffr v2xel_frefair v2x_elecoff v2xcl_rol v2x_jucon v2xlg_legcon v2lgbicam 

label variable v2x_polyarchy2000 "Electoral Democracy Index in 2000"

keep if year == 2000 | year == 2019

gen regime2000 = v2x_regime if year == 2000
sort country_name year
by country_name: replace regime2000 = v2x_regime[_n-1] if year == 2019
keep if regime2000==1 | regime2000==2 // only keep electoral democracies or liberal democracies

foreach var of varlist v2x_polyarchy v2x_libdem v2x_liberal v2x_freexp_altinf v2x_frassoc_thick v2x_suffr v2xel_frefair v2x_elecoff v2xcl_rol v2x_jucon v2xlg_legcon v2lgbicam{
	sort country_name year
	bysort country_name: gen `var'_diff_2000_2019 = `var'[_n] - `var'[_n-1]
}

// plot the 2000 variable against the 2019 variable 
scatter v2x_polyarchy2019 v2x_polyarchy2000 || line v2x_polyarchy2000 v2x_polyarchy2000 || lfit v2x_polyarchy2019 v2x_polyarchy2000, mlabel(country_name)

scatter v2x_libdem2019 v2x_libdem2000 || line v2x_libdem2000 v2x_libdem2000 || lfit v2x_libdem2019 v2x_libdem2000

foreach var in v2x_polyarchy v2x_libdem v2x_liberal v2x_freexp_altinf v2x_frassoc_thick v2x_suffr v2xel_frefair v2x_elecoff v2xcl_rol v2x_jucon v2xlg_legcon v2lgbicam{
	scatter `var'2019 `var'2000 || line `var'2019 `var'2019 || lfit `var'2019 `var'2000
	graph export "/Users/ayumis/Dropbox/Democracy/MainAnalysis/code/2_analyze/explore/`var'.png", as(png) name("Graph"), replace
}


