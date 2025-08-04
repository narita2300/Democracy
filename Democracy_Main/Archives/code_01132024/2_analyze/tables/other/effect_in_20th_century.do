

*** Load data 
use "./output/total.dta", replace

egen mean_growth_rate_1981_1990 = rowmean(gdp_growth1981-gdp_growth1990)
egen mean_growth_rate_1991_2000 = rowmean(gdp_growth1991-gdp_growth2000)
egen mean_growth_rate_2001_2010 = rowmean(gdp_growth2001-gdp_growth2010)
egen mean_growth_rate_2011_2020 = rowmean(gdp_growth2011-gdp_growth2020)

regress mean_growth_rate_1981_1990 democracy_vdem1980, vce(robust)
regress mean_growth_rate_1981_1990 democracy_vdem1980 [w=total_gdp1980], vce(robust)
regress mean_growth_rate_1981_1990 democracy_vdem1980 [w=population1980], vce(robust)

regress mean_growth_rate_1991_2000 democracy_vdem1990, vce(robust)
regress mean_growth_rate_1991_2000 democracy_vdem1990 [w=total_gdp1990], vce(robust)
regress mean_growth_rate_1991_2000 democracy_vdem1990 [w=population1990], vce(robust)

regress mean_growth_rate_2001_2019 democracy_vdem2000, vce(robust)
regress mean_growth_rate_2001_2019 democracy_vdem2000 [w=total_gdp2000], vce(robust)
regress mean_growth_rate_2001_2019 democracy_vdem2000 [w=population2000], vce(robust)


ivregress 2sls mean_growth_rate_1981_1990 (democracy_vdem1980=${iv3}) [w=total_gdp1980], vce(robust)
ivregress 2sls mean_growth_rate_1991_2000 (democracy_vdem1990=${iv3}) [w=total_gdp1990], vce(robust)
ivregress 2sls mean_growth_rate_1981_1990 (democracy_vdem1980=${iv4}) [w=total_gdp1980], vce(robust)
ivregress 2sls mean_growth_rate_1991_2000 (democracy_vdem1990=${iv4}) [w=total_gdp1990], vce(robust)

ivreg2 mean_growth_rate_1981_1990 (democracy_vdem1980=${iv1}) [w=total_gdp1980], robust
ivreg2 mean_growth_rate_1991_2000 (democracy_vdem1990=${iv1}) [w=total_gdp1990], robust
ivreg2 mean_growth_rate_2001_2010 (democracy_vdem2000=${iv1}) [w=total_gdp2000], robust
ivreg2 mean_growth_rate_2011_2020 (democracy_vdem2010=${iv1}) [w=total_gdp2000], robust


ivregress 2sls mean_growth_rate (democracy_vdem2000=${iv6}) [w=total_gdp1990], vce(robust)
