
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data
cd ${path_dropbox}/tables

********************************************************************************

// Could you do the following?
// 1) let Xit be country i’s GDP growth rate in year t
// 2) for each country i, compute \Sum_{t=2000,...,2019} Xit^2 (mean squared deviation from 0)
// 3) sort countries in terms of (2)

******************************************************************************** Total GDP growth rates

*** Load data 
use ${path_data}/total.dta, replace

forvalues year = 2000/2019{
	gen gdp_growth`year'_2 = (gdp_growth`year')^2
}
egen sumsqdev = rowtotal(gdp_growth2000_2-gdp_growth2019_2)
sort sumsqdev

keep countries gdp_growth2* sumsqdev

gsort - sumsqdev 
gen sumsqdev_rank = _n

******************************************************************************** GDP per capita growth rates

*** Load data 
use ${path_data}/total.dta, replace

forvalues year = 2000/2019{
	gen gdppc_growth`year'_2 = (gdppc_growth`year')^2
}
egen sumsqdev = rowtotal(gdppc_growth2000_2-gdppc_growth2019_2)
sort sumsqdev

keep countries gdp_growth2* sumsqdev

gsort - sumsqdev 
gen sumsqdev_rank = _n

export excel using "gdppcgrowth_sumsqdev", firstrow(variables)
