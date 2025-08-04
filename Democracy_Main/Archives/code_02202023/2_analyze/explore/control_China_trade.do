
*** Load data 
use ${path_data}/total.dta, replace

reg mean_china_import_gdp ${dem2000} ${weight2000}, vce(robust)
reg mean_china_export_gdp ${dem2000} ${weight2000}, vce(robust)

reg mean_import_value_2001_2019 ${dem2000} ${weight2000}, vce(robust)
reg mean_import_value_2001_2019 ${dem2000} mean_china_import_gdp ${weight2000}, vce(robust)

reg mean_export_value_2001_2019 ${dem2000} ${weight2000}, vce(robust)
reg mean_export_value_2001_2019 ${dem2000} mean_china_export_gdp ${weight2000}, vce(robust)

forv i = 1/5{
	ivregress 2sls mean_import_value_2001_2019 mean_china_import_gdp (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)
}

forv i = 1/5{
	ivregress 2sls mean_export_value_2001_2019 mean_china_export_gdp (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)
}

reg mean_china_import_gdp ${dem2000} ${weight2000}, vce(robust)
reg mean_china_export_gdp ${dem2000} ${weight2000}, vce(robust)

forv i = 1/5{
	ivregress 2sls mean_china_import_gdp (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)
}

forv i = 1/5{
	ivregress 2sls mean_china_export_gdp (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)
}
