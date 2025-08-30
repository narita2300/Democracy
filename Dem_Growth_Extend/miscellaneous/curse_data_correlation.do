global path "/Users/masaoishihara/Democracy/Dem_Growth_Extend"

// use ${path}/replication_files_ddcg/DDCGdata_final.dta
use ${path}/data/extended.dta, clear

// Curse Figure 1: Correlation Between Democracy and Outcomes
// (a)
g y_growth= 100*(y[_n]-y[_n-1])/y[_n-1] if _n!=1
g y_growth_01_19= y_growth if 2001 <= year & year <= 2019
egen m_y_growth_01_19 = mean(y_growth_01_19), by(wbcode2)
reg m_y_growth_01_19 dem if year == 2000 [aweight=y], r

// (b)
bys wbcode2 : g dem_l1 = dem[_n-1]
reg y_growth dem_l1 if year == 2020, r

// (c)
// N/A

// Added #1: Regression with year quadratic
reg y_growth c.dem##c.year, r
reg y_growth c.dem##c.year if year >= 2000, r

// ADDED TEST: country FE
xtset
xtreg y_growth c.dem##c.year, fe r
xtreg y_growth c.dem##c.year if year >= 2000, fe r
