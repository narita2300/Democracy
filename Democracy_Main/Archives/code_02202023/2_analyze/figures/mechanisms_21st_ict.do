
import delimited "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/channels21st/raw_data.csv", clear 

// foreach indicator in "Research and development expenditure (% of GDP)" "ICT goods exports (% of total goods exports)" "ICT service exports (% of service exports, BoP)" "High-technology exports (% of manufactured exports)" "Patent applications, residents" "Investment in telecoms with private participation (current US$)" "Employment in agriculture (% of total employment)" "Urban population (% of total)"

// Checked:
// "Research and development expenditure (% of GDP)": insignificant negative relationship if we look at growth rates
// "ICT goods exports (% of total goods exports)": significant negative relationship. also causal.
// "ICT service exports (% of service exports, BoP)": insignificant
// "High-technology exports (% of manufactured exports)": insignificant
// "Patent applications, residents": significant negative relationship
// "Investment in telecoms with private participation (current US$)": significant positive relationship
// "Urban population (% of total)": 
// "Researchers in R&D (per million people)"

// keep if indicator=="Researchers in R&D (per million people)"
cd /Users/ayumis/Dropbox/Democracy/MainAnalysis/output/figures
// local indicators "Research and development expenditure (% of GDP)" "Researchers in R&D (per million people)" "ICT goods exports (% of total goods exports)" "ICT service exports (% of service exports, BoP)" "High-technology exports (% of manufactured exports)" "Patent applications, residents" "Investment in telecoms with private participation (current US$)" 
// local shortnames rd_expenditure rd_researchers ict_goods_exports ict_services_exports high_tech_exports patent_apps telecoms_investment 

local indicators "Research and development expenditure (% of GDP)" "Researchers in R&D (per million people)" "ICT goods exports (% of total goods exports)" "ICT service exports (% of service exports, BoP)" "High-technology exports (% of manufactured exports)" "Patent applications, residents" "Investment in telecoms with private participation (current US$)" "Export value index (2000 = 100)" "Gross national expenditure (% of GDP)" "Import value index (2000 = 100)" "International tourism, expenditures for passenger transport items (current US$)" "Manufacturing, value added (annual % growth)" "Merchandise exports to low- and middle-income economies in Latin America & the Caribbean (% of total merchandise exports)" "Merchandise exports to low- and middle-income economies in South Asia (% of total merchandise exports)" "Net trade in goods (BoP, current US$)" "Net trade in goods and services (BoP, current US$)" "New business density (new registrations per 1,000 people ages 15-64)" "New businesses registered (number)" "Services, etc., value added (% of GDP)" "Services, etc., value added (annual % growth)" "Taxes on goods and services (% value added of industry and services)" "Taxes on income, profits and capital gains (% of total taxes)" "Technicians in R&D (per million people)" 

local shortnames rd_expenditure rd_researchers ict_goods_exports ict_services_exports high_tech_exports patent_apps telecoms_investment export_value national_expenditure import_value tourism manufacturing_value_added merch_exports_latin merch_exports_south_asia net_trade_goods net_trade_goods_services new_business_density new_business_registered services_va services_va_growth tax_goods_services tax_income technicians_rd
local n:word count "`indicators'"
di "`:word 1 of `shortnames''"

forvalues i = 1/`n' {
	import delimited "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/channels21st/raw_data.csv", clear 
// 	di "`: word `i' of "`indicators'"'"
// 	di "`:word `i' of `shortnames''"
	local indicator "`: word `i' of "`indicators'"'"
	local shortname "`:word `i' of `shortnames''"
	
	keep if indicator=="`indicator'"
	local y = 6
	forvalues year = 1960/2020 {
			rename v`y' dep`year'
			local y = `y' + 1
			gen logdep`year' = log(dep`year')
	}
	
	keep countryiso3 logdep2000-logdep2020 dep*
	kountry countryiso3, from(iso3c)
	drop if NAMES_STD==""
	merge 1:1 NAMES_STD using ${path_data}/total.dta
	drop if _merge==1

	gen dep_gdp2000 = dep2000/(total_gdp2000*1000000000)
	forvalues year = 2001/2019{
		local previous = `year'-1
		gen dep_growth`year' = (dep`year' - dep`previous')/dep`previous'
		gen dep_gdp`year' = dep`year'/(total_gdp`year'*1000000000)
		gen log_dep_gdp`year' = log(dep_gdp`year')
		gen dep_gdp_growth`year' = (dep_gdp`year' - dep_gdp`previous')/dep_gdp`previous'
	}
	egen mean_dep_2001_2019 = rowmean(dep2001-dep2019)
	scatter mean_dep_2001_2019 democracy_vdem2000  [w=total_gdp2000], mlabel(countryiso3) || lfit mean_dep_2001_2019 democracy_vdem2000  [w=total_gdp2000], title("`indicator'") ytitle("Mean of dependent variable in 2001-2019") legend(order(2 "GDP-Weighted OLS" 3 "Unweighted OLS")) || lfit mean_dep_2001_2019 democracy_vdem2000 
	graph export "`shortname'.png", as(png) replace
}
// legend("No Weighting OLS") 

***************************************************
*************************************************** GDP-weighted OLS with CI

// local indicators "Research and development expenditure (% of GDP)" "Researchers in R&D (per million people)" "ICT goods exports (% of total goods exports)" "ICT service exports (% of service exports, BoP)" "High-technology exports (% of manufactured exports)" "Patent applications, residents" "Investment in telecoms with private participation (current US$)" 
// local shortnames rd_expenditure rd_researchers ict_goods_exports ict_services_exports high_tech_exports patent_apps telecoms_investment 
local indicators "Research and development expenditure (% of GDP)" "Researchers in R&D (per million people)" "ICT goods exports (% of total goods exports)" "ICT service exports (% of service exports, BoP)" "High-technology exports (% of manufactured exports)" "Patent applications, residents" "Investment in telecoms with private participation (current US$)" "Export value index (2000 = 100)" "Gross national expenditure (% of GDP)" "Import value index (2000 = 100)" "International tourism, expenditures for passenger transport items (current US$)" "Manufacturing, value added (annual % growth)" "Merchandise exports to low- and middle-income economies in Latin America & the Caribbean (% of total merchandise exports)" "Merchandise exports to low- and middle-income economies in South Asia (% of total merchandise exports)" "Net trade in goods (BoP, current US$)" "Net trade in goods and services (BoP, current US$)" "New business density (new registrations per 1,000 people ages 15-64)" "New businesses registered (number)" "Services, etc., value added (% of GDP)" "Services, etc., value added (annual % growth)" "Taxes on goods and services (% value added of industry and services)" "Taxes on income, profits and capital gains (% of total taxes)" "Technicians in R&D (per million people)" 

local shortnames rd_expenditure rd_researchers ict_goods_exports ict_services_exports high_tech_exports patent_apps telecoms_investment export_value national_expenditure import_value tourism manufacturing_value_added merch_exports_latin merch_exports_south_asia net_trade_goods net_trade_goods_services new_business_density new_business_registered services_va services_va_growth tax_goods_services tax_income technicians_rd
local n:word count "`indicators'"
di "`:word 1 of `shortnames''"

forvalues i = 1/`n' {
	import delimited "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/channels21st/raw_data.csv", clear 
// 	di "`: word `i' of "`indicators'"'"
// 	di "`:word `i' of `shortnames''"
	local indicator "`: word `i' of "`indicators'"'"
	local shortname "`:word `i' of `shortnames''"
	
	keep if indicator=="`indicator'"
	local y = 6
	forvalues year = 1960/2020 {
			rename v`y' dep`year'
			local y = `y' + 1
			gen logdep`year' = log(dep`year')
	}
	
	keep countryiso3 logdep2000-logdep2020 dep*
	kountry countryiso3, from(iso3c)
	drop if NAMES_STD==""
	merge 1:1 NAMES_STD using ${path_data}/total.dta
	drop if _merge==1

	gen dep_gdp2000 = dep2000/(total_gdp2000*1000000000)
	forvalues year = 2001/2019{
		local previous = `year'-1
		gen dep_growth`year' = (dep`year' - dep`previous')/dep`previous'
		gen dep_gdp`year' = dep`year'/(total_gdp`year'*1000000000)
		gen log_dep_gdp`year' = log(dep_gdp`year')
		gen dep_gdp_growth`year' = (dep_gdp`year' - dep_gdp`previous')/dep_gdp`previous'
	}
	egen mean_dep_2001_2019 = rowmean(dep2001-dep2019)
	graph twoway lfitci mean_dep_2001_2019 democracy_vdem2000  [w=total_gdp2000], title("`indicator'",size(textsizestyle)) ytitle("Mean of dependent variable in 2001-2019") legend(order(2 "GDP-Weighted OLS" 1 "95% CI")) || scatter mean_dep_2001_2019 democracy_vdem2000  [w=total_gdp2000], mlabel(countryiso3)
	graph export "`shortname'.png", as(png) replace
}
