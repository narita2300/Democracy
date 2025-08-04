global path_data /home/rg884/project/MainAnalysis/output/data
global path_output /home/rg884/project/MainAnalysis/output/figures/extensions

*** Set IV
loc iv = "lpd1500s"
// loc iv = "legor_uk"

*** Change to appropriate directory
cd ${path_output}

********************************************************************************
* Regression Estimates of Democracy's Effects 1980-2020
********************************************************************************

*** Load data 
use ${path_data}/total.dta, replace

global lead_year = 1980

gen year = .
gen reg_coef = .
gen se_ub = .
gen se_lb = .

forval i = 1/40 {
	loc y = $lead_year + `i' 
	replace year = `y' if _n == `i'
}

// OLS: no controls, no weights
forval i = 1/40 {
	loc y = $lead_year + `i'
	loc y_1 = $lead_year + `i' - 1
	reg gdp_growth`y' democracy_vdem`y_1' if `:word 1 of `iv'' != ., r
	replace reg_coef = _b[democracy_vdem`y_1'] if _n == `i'
	replace se_ub = reg_coef + 1.96*_se[democracy_vdem`y_1'] if _n == `i'
	replace se_lb = reg_coef - 1.96*_se[democracy_vdem`y_1'] if _n == `i'
}
twoway line reg_coef year, lc(black) || (lfit reg_coef year) (rarea se_ub se_lb year, fcolor(gs8) fintensity(70) lc(white) below) , ytitle(, margin(0 2 0 0)) ///
xscale(r(1980,2020)) xlabel(1980(5)2020) ///
graphregion(color(white)) xtitle("Year") legend(off) ytitle("Effect GDP Growth Rate")
graph export "OLS_no_cont_`iv'.pdf", replace

// IV: no controls, no weights
forval i = 1/40 {
	loc y = $lead_year + `i'
	loc y_1 = $lead_year + `i' - 1
	ivreg2 gdp_growth`y' (democracy_vdem`y_1' = `iv'), r
	replace reg_coef = _b[democracy_vdem`y_1'] if _n == `i'
	replace se_ub = reg_coef + 1.96*_se[democracy_vdem`y_1'] if _n == `i'
	replace se_lb = reg_coef - 1.96*_se[democracy_vdem`y_1'] if _n == `i'
}
twoway line reg_coef year, lc(black) || (lfit reg_coef year) (rarea se_ub se_lb year, fcolor(gs8) fintensity(70) lc(white) below) , ytitle(, margin(0 2 0 0)) ///
xscale(r(1980,2020)) xlabel(1980(5)2020) ///
graphregion(color(white)) xtitle("Year") legend(off) ytitle("Effect GDP Growth Rate")
graph export "IV_no_cont_`iv'.pdf", replace

// OLS: no controls, weights
forval i = 1/40 {
	loc y = $lead_year + `i'
	loc y_1 = $lead_year + `i' - 1
	reg gdp_growth`y' democracy_vdem`y_1' if `:word 1 of `iv'' != . [aw=total_gdp`y_1'], r
	replace reg_coef = _b[democracy_vdem`y_1'] if _n == `i'
	replace se_ub = reg_coef + 1.96*_se[democracy_vdem`y_1'] if _n == `i'
	replace se_lb = reg_coef - 1.96*_se[democracy_vdem`y_1'] if _n == `i'
}
twoway line reg_coef year, lc(black) || (lfit reg_coef year) (rarea se_ub se_lb year, fcolor(gs8) fintensity(70) lc(white) below) , ytitle(, margin(0 2 0 0)) ///
xscale(r(1980,2020)) xlabel(1980(5)2020) ///
graphregion(color(white)) xtitle("Year") legend(off) ytitle("Effect GDP Growth Rate")
graph export "OLS_no_cont_weight_`iv'.pdf", replace

// IV: no controls, weights
forval i = 1/40 {
	loc y = $lead_year + `i'
	loc y_1 = $lead_year + `i' - 1
	ivreg2 gdp_growth`y' (democracy_vdem`y_1' = `iv') [aw=total_gdp`y_1'], r
	replace reg_coef = _b[democracy_vdem`y_1'] if _n == `i'
	replace se_ub = reg_coef + 1.96*_se[democracy_vdem`y_1'] if _n == `i'
	replace se_lb = reg_coef - 1.96*_se[democracy_vdem`y_1'] if _n == `i'
}
twoway line reg_coef year, lc(black) || (lfit reg_coef year) (rarea se_ub se_lb year, fcolor(gs8) fintensity(70) lc(white) below) , ytitle(, margin(0 2 0 0)) ///
xscale(r(1980,2020)) xlabel(1980(5)2020) ///
graphregion(color(white)) xtitle("Year") legend(off) ytitle("Effect GDP Growth Rate")
graph export "IV_no_cont_weight_`iv'.pdf", replace

// OLS: controls, no weights
forval i = 1/40 {
	loc y = $lead_year + `i'
	loc y_1 = $lead_year + `i' - 1
	if `i' < 6 {
		loc cont = "abs_lat mean_temp_1971_1980 mean_precip_1971_1980 pop_density`y_1' median_age1980"
	}
	else if `i' < 11 {
		loc cont = "abs_lat mean_temp_1971_1980 mean_precip_1971_1980 pop_density`y_1' median_age1985"
	}
	else if `i' < 16 {
		loc cont = "abs_lat mean_temp_1981_1990 mean_precip_1981_1990 pop_density`y_1' median_age1990"
	}
	else if `i' < 21 {
		loc cont = "abs_lat mean_temp_1981_1990 mean_precip_1981_1990 pop_density`y_1' median_age1995"
	}
	else if `i' < 26 {
		loc cont = "abs_lat mean_temp_1991_2000 mean_precip_1991_2000 pop_density`y_1' median_age2000"
	}
	else if `i' < 31 {
		loc cont = "abs_lat mean_temp_1991_2000 mean_precip_1991_2000 pop_density`y_1' median_age2005"
	}
	else if `i' < 36 {
		loc cont = "abs_lat mean_temp_2001_2010 mean_precip_2001_2010 pop_density`y_1' median_age2010"
	}
	else if `i' < 41 {
		loc cont = "abs_lat mean_temp_2001_2010 mean_precip_2001_2010 pop_density`y_1' median_age2015"
	}
	reg gdp_growth`y' `cont' democracy_vdem`y_1' if `:word 1 of `iv'' != ., r
	replace reg_coef = _b[democracy_vdem`y_1'] if _n == `i'
	replace se_ub = reg_coef + 1.96*_se[democracy_vdem`y_1'] if _n == `i'
	replace se_lb = reg_coef - 1.96*_se[democracy_vdem`y_1'] if _n == `i'
}
twoway line reg_coef year, lc(black) || (lfit reg_coef year) (rarea se_ub se_lb year, fcolor(gs8) fintensity(70) lc(white) below) , ytitle(, margin(0 2 0 0)) ///
xscale(r(1980,2020)) xlabel(1980(5)2020) ///
graphregion(color(white)) xtitle("Year") legend(off) ytitle("Effect GDP Growth Rate")
graph export "OLS_cont_`iv'.pdf", replace

// IV: controls, no weights
forval i = 1/40 {
	loc y = $lead_year + `i'
	loc y_1 = $lead_year + `i' - 1
	if `i' < 6 {
		loc cont = "abs_lat mean_temp_1971_1980 mean_precip_1971_1980 pop_density`y_1' median_age1980"
	}
	else if `i' < 11 {
		loc cont = "abs_lat mean_temp_1971_1980 mean_precip_1971_1980 pop_density`y_1' median_age1985"
	}
	else if `i' < 16 {
		loc cont = "abs_lat mean_temp_1981_1990 mean_precip_1981_1990 pop_density`y_1' median_age1990"
	}
	else if `i' < 21 {
		loc cont = "abs_lat mean_temp_1981_1990 mean_precip_1981_1990 pop_density`y_1' median_age1995"
	}
	else if `i' < 26 {
		loc cont = "abs_lat mean_temp_1991_2000 mean_precip_1991_2000 pop_density`y_1' median_age2000"
	}
	else if `i' < 31 {
		loc cont = "abs_lat mean_temp_1991_2000 mean_precip_1991_2000 pop_density`y_1' median_age2005"
	}
	else if `i' < 36 {
		loc cont = "abs_lat mean_temp_2001_2010 mean_precip_2001_2010 pop_density`y_1' median_age2010"
	}
	else if `i' < 41 {
		loc cont = "abs_lat mean_temp_2001_2010 mean_precip_2001_2010 pop_density`y_1' median_age2015"
	}
	ivreg2 gdp_growth`y' `cont' (democracy_vdem`y_1' = `iv'), r
	replace reg_coef = _b[democracy_vdem`y_1'] if _n == `i'
	replace se_ub = reg_coef + 1.96*_se[democracy_vdem`y_1'] if _n == `i'
	replace se_lb = reg_coef - 1.96*_se[democracy_vdem`y_1'] if _n == `i'
}
twoway line reg_coef year, lc(black) || (lfit reg_coef year) (rarea se_ub se_lb year, fcolor(gs8) fintensity(70) lc(white) below) , ytitle(, margin(0 2 0 0)) ///
xscale(r(1980,2020)) xlabel(1980(5)2020) ///
graphregion(color(white)) xtitle("Year") legend(off) ytitle("Effect GDP Growth Rate")
graph export "IV_cont_`iv'.pdf", replace

// OLS: controls, weights
forval i = 1/40 {
	loc y = $lead_year + `i'
	loc y_1 = $lead_year + `i' - 1
	if `i' < 6 {
		loc cont = "abs_lat mean_temp_1971_1980 mean_precip_1971_1980 pop_density`y_1' median_age1980"
	}
	else if `i' < 11 {
		loc cont = "abs_lat mean_temp_1971_1980 mean_precip_1971_1980 pop_density`y_1' median_age1985"
	}
	else if `i' < 16 {
		loc cont = "abs_lat mean_temp_1981_1990 mean_precip_1981_1990 pop_density`y_1' median_age1990"
	}
	else if `i' < 21 {
		loc cont = "abs_lat mean_temp_1981_1990 mean_precip_1981_1990 pop_density`y_1' median_age1995"
	}
	else if `i' < 26 {
		loc cont = "abs_lat mean_temp_1991_2000 mean_precip_1991_2000 pop_density`y_1' median_age2000"
	}
	else if `i' < 31 {
		loc cont = "abs_lat mean_temp_1991_2000 mean_precip_1991_2000 pop_density`y_1' median_age2005"
	}
	else if `i' < 36 {
		loc cont = "abs_lat mean_temp_2001_2010 mean_precip_2001_2010 pop_density`y_1' median_age2010"
	}
	else if `i' < 41 {
		loc cont = "abs_lat mean_temp_2001_2010 mean_precip_2001_2010 pop_density`y_1' median_age2015"
	}
	reg gdp_growth`y' `cont' democracy_vdem`y_1' if `:word 1 of `iv'' != . [aw=total_gdp`y_1'], r
	replace reg_coef = _b[democracy_vdem`y_1'] if _n == `i'
	replace se_ub = reg_coef + 1.96*_se[democracy_vdem`y_1'] if _n == `i'
	replace se_lb = reg_coef - 1.96*_se[democracy_vdem`y_1'] if _n == `i'
}
twoway line reg_coef year, lc(black) || (lfit reg_coef year) (rarea se_ub se_lb year, fcolor(gs8) fintensity(70) lc(white) below) , ytitle(, margin(0 2 0 0)) ///
xscale(r(1980,2020)) xlabel(1980(5)2020) ///
graphregion(color(white)) xtitle("Year") legend(off) ytitle("Effect GDP Growth Rate")
graph export "OLS_cont_weight_`iv'.pdf", replace

// IV: controls, weights
forval i = 1/40 {
	loc y = $lead_year + `i'
	loc y_1 = $lead_year + `i' - 1
	if `i' < 6 {
		loc cont = "abs_lat mean_temp_1971_1980 mean_precip_1971_1980 pop_density`y_1' median_age1980"
	}
	else if `i' < 11 {
		loc cont = "abs_lat mean_temp_1971_1980 mean_precip_1971_1980 pop_density`y_1' median_age1985"
	}
	else if `i' < 16 {
		loc cont = "abs_lat mean_temp_1981_1990 mean_precip_1981_1990 pop_density`y_1' median_age1990"
	}
	else if `i' < 21 {
		loc cont = "abs_lat mean_temp_1981_1990 mean_precip_1981_1990 pop_density`y_1' median_age1995"
	}
	else if `i' < 26 {
		loc cont = "abs_lat mean_temp_1991_2000 mean_precip_1991_2000 pop_density`y_1' median_age2000"
	}
	else if `i' < 31 {
		loc cont = "abs_lat mean_temp_1991_2000 mean_precip_1991_2000 pop_density`y_1' median_age2005"
	}
	else if `i' < 36 {
		loc cont = "abs_lat mean_temp_2001_2010 mean_precip_2001_2010 pop_density`y_1' median_age2010"
	}
	else if `i' < 41 {
		loc cont = "abs_lat mean_temp_2001_2010 mean_precip_2001_2010 pop_density`y_1' median_age2015"
	}
	ivreg2 gdp_growth`y' `cont' (democracy_vdem`y_1' = `iv') [aw=total_gdp`y_1'], r
	replace reg_coef = _b[democracy_vdem`y_1'] if _n == `i'
	replace se_ub = reg_coef + 1.96*_se[democracy_vdem`y_1'] if _n == `i'
	replace se_lb = reg_coef - 1.96*_se[democracy_vdem`y_1'] if _n == `i'
}
twoway line reg_coef year, lc(black) || (lfit reg_coef year) (rarea se_ub se_lb year, fcolor(gs8) fintensity(70) lc(white) below) , ytitle(, margin(0 2 0 0)) ///
xscale(r(1980,2020)) xlabel(1980(5)2020) ///
graphregion(color(white)) xtitle("Year") legend(off) ytitle("Effect GDP Growth Rate")
graph export "IV_cont_weight_`iv'.pdf", replace

******************************************************************************************************************
* 1990 onwards
******************************************************************************************************************

*** Load data 
use ${path_data}/total.dta, replace

global lead_year = 1990

gen year = .
gen reg_coef = .
gen se_ub = .
gen se_lb = .

forval i = 1/30 {
	loc y = $lead_year + `i' 
	replace year = `y' if _n == `i'
}

// OLS: no controls, no weights
forval i = 1/30 {
	loc y = $lead_year + `i'
	loc y_1 = $lead_year + `i' - 1
	reg gdp_growth`y' democracy_vdem`y_1' if `:word 1 of `iv'' != ., r
	replace reg_coef = _b[democracy_vdem`y_1'] if _n == `i'
	replace se_ub = reg_coef + 1.96*_se[democracy_vdem`y_1'] if _n == `i'
	replace se_lb = reg_coef - 1.96*_se[democracy_vdem`y_1'] if _n == `i'
}
twoway line reg_coef year, lc(black) || (lfit reg_coef year) (rarea se_ub se_lb year, fcolor(gs8) fintensity(70) lc(white) below) , ytitle(, margin(0 2 0 0)) ///
xscale(r(1990,2020)) xlabel(1990(5)2020) ///
graphregion(color(white)) xtitle("Year") legend(off) ytitle("Effect GDP Growth Rate")
graph export "OLS_no_cont_90_`iv'.pdf", replace

// IV: no controls, no weights
forval i = 1/30 {
	loc y = $lead_year + `i'
	loc y_1 = $lead_year + `i' - 1
	ivreg2 gdp_growth`y' (democracy_vdem`y_1' = `iv'), r
	replace reg_coef = _b[democracy_vdem`y_1'] if _n == `i'
	replace se_ub = reg_coef + 1.96*_se[democracy_vdem`y_1'] if _n == `i'
	replace se_lb = reg_coef - 1.96*_se[democracy_vdem`y_1'] if _n == `i'
}
twoway line reg_coef year, lc(black) || (lfit reg_coef year) (rarea se_ub se_lb year, fcolor(gs8) fintensity(70) lc(white) below) , ytitle(, margin(0 2 0 0)) ///
xscale(r(1990,2020)) xlabel(1990(5)2020) ///
graphregion(color(white)) xtitle("Year") legend(off) ytitle("Effect GDP Growth Rate")
graph export "IV_no_cont_90_`iv'.pdf", replace

// OLS: no controls, weights
forval i = 1/30 {
	loc y = $lead_year + `i'
	loc y_1 = $lead_year + `i' - 1
	reg gdp_growth`y' democracy_vdem`y_1' if `:word 1 of `iv'' != . [aw=total_gdp`y_1'], r
	replace reg_coef = _b[democracy_vdem`y_1'] if _n == `i'
	replace se_ub = reg_coef + 1.96*_se[democracy_vdem`y_1'] if _n == `i'
	replace se_lb = reg_coef - 1.96*_se[democracy_vdem`y_1'] if _n == `i'
}
twoway line reg_coef year, lc(black) || (lfit reg_coef year) (rarea se_ub se_lb year, fcolor(gs8) fintensity(70) lc(white) below) , ytitle(, margin(0 2 0 0)) ///
xscale(r(1990,2020)) xlabel(1990(5)2020) ///
graphregion(color(white)) xtitle("Year") legend(off) ytitle("Effect GDP Growth Rate")
graph export "OLS_no_cont_weight_90_`iv'.pdf", replace

// IV: no controls, weights
forval i = 1/30 {
	loc y = $lead_year + `i'
	loc y_1 = $lead_year + `i' - 1
	ivreg2 gdp_growth`y' (democracy_vdem`y_1' = `iv') [aw=total_gdp`y_1'], r
	replace reg_coef = _b[democracy_vdem`y_1'] if _n == `i'
	replace se_ub = reg_coef + 1.96*_se[democracy_vdem`y_1'] if _n == `i'
	replace se_lb = reg_coef - 1.96*_se[democracy_vdem`y_1'] if _n == `i'
}
twoway line reg_coef year, lc(black) || (lfit reg_coef year) (rarea se_ub se_lb year, fcolor(gs8) fintensity(70) lc(white) below) , ytitle(, margin(0 2 0 0)) ///
xscale(r(1990,2020)) xlabel(1990(5)2020) ///
graphregion(color(white)) xtitle("Year") legend(off) ytitle("Effect GDP Growth Rate")
graph export "IV_no_cont_weight_90_`iv'.pdf", replace

// OLS: controls, no weights
forval i = 1/30 {
	loc y = $lead_year + `i'
	loc y_1 = $lead_year + `i' - 1
	if `i' < 6 {
		loc cont = "abs_lat mean_temp_1981_1990 mean_precip_1981_1990 pop_density`y_1' median_age1990"
	}
	else if `i' < 11 {
		loc cont = "abs_lat mean_temp_1981_1990 mean_precip_1981_1990 pop_density`y_1' median_age1995"
	}
	else if `i' < 16 {
		loc cont = "abs_lat mean_temp_1991_2000 mean_precip_1991_2000 pop_density`y_1' median_age2000"
	}
	else if `i' < 21 {
		loc cont = "abs_lat mean_temp_1991_2000 mean_precip_1991_2000 pop_density`y_1' median_age2005"
	}
	else if `i' < 26 {
		loc cont = "abs_lat mean_temp_2001_2010 mean_precip_2001_2010 pop_density`y_1' median_age2010"
	}
	else if `i' < 31 {
		loc cont = "abs_lat mean_temp_2001_2010 mean_precip_2001_2010 pop_density`y_1' median_age2015"
	}
	reg gdp_growth`y' `cont' democracy_vdem`y_1' if `:word 1 of `iv'' != ., r
	replace reg_coef = _b[democracy_vdem`y_1'] if _n == `i'
	replace se_ub = reg_coef + 1.96*_se[democracy_vdem`y_1'] if _n == `i'
	replace se_lb = reg_coef - 1.96*_se[democracy_vdem`y_1'] if _n == `i'
}
twoway line reg_coef year, lc(black) || (lfit reg_coef year) (rarea se_ub se_lb year, fcolor(gs8) fintensity(70) lc(white) below) , ytitle(, margin(0 2 0 0)) ///
xscale(r(1990,2020)) xlabel(1990(5)2020) ///
graphregion(color(white)) xtitle("Year") legend(off) ytitle("Effect GDP Growth Rate")
graph export "OLS_cont_90_`iv'.pdf", replace

// IV: controls, no weights
forval i = 1/30 {
	loc y = $lead_year + `i'
	loc y_1 = $lead_year + `i' - 1
	if `i' < 6 {
		loc cont = "abs_lat mean_temp_1981_1990 mean_precip_1981_1990 pop_density`y_1' median_age1990"
	}
	else if `i' < 11 {
		loc cont = "abs_lat mean_temp_1981_1990 mean_precip_1981_1990 pop_density`y_1' median_age1995"
	}
	else if `i' < 16 {
		loc cont = "abs_lat mean_temp_1991_2000 mean_precip_1991_2000 pop_density`y_1' median_age2000"
	}
	else if `i' < 21 {
		loc cont = "abs_lat mean_temp_1991_2000 mean_precip_1991_2000 pop_density`y_1' median_age2005"
	}
	else if `i' < 26 {
		loc cont = "abs_lat mean_temp_2001_2010 mean_precip_2001_2010 pop_density`y_1' median_age2010"
	}
	else if `i' < 31 {
		loc cont = "abs_lat mean_temp_2001_2010 mean_precip_2001_2010 pop_density`y_1' median_age2015"
	}
	ivreg2 gdp_growth`y' `cont' (democracy_vdem`y_1' = `iv'), r
	replace reg_coef = _b[democracy_vdem`y_1'] if _n == `i'
	replace se_ub = reg_coef + 1.96*_se[democracy_vdem`y_1'] if _n == `i'
	replace se_lb = reg_coef - 1.96*_se[democracy_vdem`y_1'] if _n == `i'
}
twoway line reg_coef year, lc(black) || (lfit reg_coef year) (rarea se_ub se_lb year, fcolor(gs8) fintensity(70) lc(white) below) , ytitle(, margin(0 2 0 0)) ///
xscale(r(1990,2020)) xlabel(1990(5)2020) ///
graphregion(color(white)) xtitle("Year") legend(off) ytitle("Effect GDP Growth Rate")
graph export "IV_cont_90_`iv'.pdf", replace

// OLS: controls, weights
forval i = 1/30 {
	loc y = $lead_year + `i'
	loc y_1 = $lead_year + `i' - 1
	if `i' < 6 {
		loc cont = "abs_lat mean_temp_1981_1990 mean_precip_1981_1990 pop_density`y_1' median_age1990"
	}
	else if `i' < 11 {
		loc cont = "abs_lat mean_temp_1981_1990 mean_precip_1981_1990 pop_density`y_1' median_age1995"
	}
	else if `i' < 16 {
		loc cont = "abs_lat mean_temp_1991_2000 mean_precip_1991_2000 pop_density`y_1' median_age2000"
	}
	else if `i' < 21 {
		loc cont = "abs_lat mean_temp_1991_2000 mean_precip_1991_2000 pop_density`y_1' median_age2005"
	}
	else if `i' < 26 {
		loc cont = "abs_lat mean_temp_2001_2010 mean_precip_2001_2010 pop_density`y_1' median_age2010"
	}
	else if `i' < 31 {
		loc cont = "abs_lat mean_temp_2001_2010 mean_precip_2001_2010 pop_density`y_1' median_age2015"
	}
	reg gdp_growth`y' `cont' democracy_vdem`y_1' if `:word 1 of `iv'' != . [aw=total_gdp`y_1'], r
	replace reg_coef = _b[democracy_vdem`y_1'] if _n == `i'
	replace se_ub = reg_coef + 1.96*_se[democracy_vdem`y_1'] if _n == `i'
	replace se_lb = reg_coef - 1.96*_se[democracy_vdem`y_1'] if _n == `i'
}
twoway line reg_coef year, lc(black) || (lfit reg_coef year) (rarea se_ub se_lb year, fcolor(gs8) fintensity(70) lc(white) below) , ytitle(, margin(0 2 0 0)) ///
xscale(r(1990,2020)) xlabel(1990(5)2020) ///
graphregion(color(white)) xtitle("Year") legend(off) ytitle("Effect GDP Growth Rate")
graph export "OLS_cont_weight_90_`iv'.pdf", replace

// IV: controls, weights
forval i = 1/30 {
	loc y = $lead_year + `i'
	loc y_1 = $lead_year + `i' - 1
	if `i' < 6 {
		loc cont = "abs_lat mean_temp_1981_1990 mean_precip_1981_1990 pop_density`y_1' median_age1990"
	}
	else if `i' < 11 {
		loc cont = "abs_lat mean_temp_1981_1990 mean_precip_1981_1990 pop_density`y_1' median_age1995"
	}
	else if `i' < 16 {
		loc cont = "abs_lat mean_temp_1991_2000 mean_precip_1991_2000 pop_density`y_1' median_age2000"
	}
	else if `i' < 21 {
		loc cont = "abs_lat mean_temp_1991_2000 mean_precip_1991_2000 pop_density`y_1' median_age2005"
	}
	else if `i' < 26 {
		loc cont = "abs_lat mean_temp_2001_2010 mean_precip_2001_2010 pop_density`y_1' median_age2010"
	}
	else if `i' < 31 {
		loc cont = "abs_lat mean_temp_2001_2010 mean_precip_2001_2010 pop_density`y_1' median_age2015"
	}
	ivreg2 gdp_growth`y' `cont' (democracy_vdem`y_1' = `iv') [aw=total_gdp`y_1'], r
	replace reg_coef = _b[democracy_vdem`y_1'] if _n == `i'
	replace se_ub = reg_coef + 1.96*_se[democracy_vdem`y_1'] if _n == `i'
	replace se_lb = reg_coef - 1.96*_se[democracy_vdem`y_1'] if _n == `i'
}
twoway line reg_coef year, lc(black) || (lfit reg_coef year) (rarea se_ub se_lb year, fcolor(gs8) fintensity(70) lc(white) below) , ytitle(, margin(0 2 0 0)) ///
xscale(r(1990,2020)) xlabel(1990(5)2020) ///
graphregion(color(white)) xtitle("Year") legend(off) ytitle("Effect GDP Growth Rate")
graph export "IV_cont_weight_90_`iv'.pdf", replace
