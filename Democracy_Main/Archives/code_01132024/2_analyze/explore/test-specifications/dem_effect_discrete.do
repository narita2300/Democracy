
use "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/democracy/Country_Year_V-Dem_Core_CSV_v11.1/vdem_simple.dta",clear

keep country_text_id v2x_regime regime2000 dem2000
duplicates drop country_text_id, force

rename country_text_id iso3

save "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/democracy/Country_Year_V-Dem_Core_CSV_v11.1/vdem_simple_bycountry.dta", replace

use "/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/data/total.dta", clear

merge 1:1 iso3 using "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/democracy/Country_Year_V-Dem_Core_CSV_v11.1/vdem_simple_bycountry.dta",keep(match master) force nogenerate


****************************************************************************
***** DISCRETIZE DEMOCRACY

// OLS
reg mean_growth_rate_2001_2019 i.regime2000, robust
reg mean_growth_rate_2001_2019 i.regime2000 [w=total_gdp2000], robust

// We don't have a separate instrument for each level of democracy. Is 2SLS possible?  
ivreg2 mean_growth_rate_2001_2019 i.regime2000 [w=total_gdp2000], robust

