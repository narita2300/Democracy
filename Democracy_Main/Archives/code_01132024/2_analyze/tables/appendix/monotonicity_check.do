***************************************
*** Table A2: OLS on Democracy Index *** 
***************************************
clear

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data
cd ${path_dropbox}/tables


*** Load data 
use ${path_data}/total.dta, replace

*************************************** split samples by continent: Africa & Asia vs. Americas & Oceania

eststo clear 
forv i=1/3{
		eststo: reg ${dem2019} ${iv`i'} ${weight2019} if continent == "Africa" | continent == "Asia", vce(robust)
		eststo: reg ${dem2019} ${iv`i'} ${base_covariates2019} ${weight2019} if continent == "Africa" | continent == "Asia", vce(robust)
}

	esttab using ${path_appendix}/monotonicity_check1.tex, nocons replace label b(a1) se(a1) nostar nodepvars drop(${base_covariates2019} _cons) stats(N, labels("N")) obslast nogaps nonotes mlabels(none)
	
eststo clear 
forv i=1/3{
		eststo: reg ${dem2019} ${iv`i'} ${weight2019} if continent == "North America" | continent == "South America" | continent == "Oceania", vce(robust)
		eststo: reg ${dem2019} ${iv`i'} ${base_covariates2019} ${weight2019} if continent == "North America" | continent == "South America" | continent == "Oceania", vce(robust)
}

esttab using ${path_appendix}/monotonicity_check1.tex, nocons append label b(a1) se(a1) nostar nodepvars drop(${base_covariates2019} _cons) stats(N, labels("N")) obslast nogaps nonotes mlabels(none)

*************************************** split samples by continent: Africa & Oceania vs. Americas & Oceania

eststo clear 
forv i=1/3{
		eststo: reg ${dem2019} ${iv`i'} ${weight2019} if continent == "Africa" | continent == "Oceania", vce(robust)
		eststo: reg ${dem2019} ${iv`i'} ${base_covariates2019} ${weight2019} if continent == "Africa" | continent == "Oceania", vce(robust)
}

	esttab using ${path_appendix}/motonotonicity_check2.tex, nocons replace label b(a1) se(a1) nostar nodepvars drop(${base_covariates2019} _cons) stats(N, labels("N")) obslast nogaps nonotes mlabels(none)
	
eststo clear 
forv i=1/3{
		eststo: reg ${dem2019} ${iv`i'} ${weight2019} if continent == "North America" | continent == "South America" | continent == "Asia", vce(robust)
		eststo: reg ${dem2019} ${iv`i'} ${base_covariates2019} ${weight2019} if continent == "North America" | continent == "South America" | continent == "Asia", vce(robust)
}

esttab using ${path_appendix}/motonotonicity_check2.tex, nocons append label b(a1) se(a1) nostar nodepvars drop(${base_covariates2019} _cons) stats(N, labels("N")) obslast nogaps nonotes mlabels(none)

*************************************** split samples by continent: Africa & S. America vs. Asia & Oceania & N.America

eststo clear 
forv i=1/3{
		eststo: reg ${dem2019} ${iv`i'} ${weight2019} if continent == "Africa" |continent == "South America"  , vce(robust)
		eststo: reg ${dem2019} ${iv`i'} ${base_covariates2019} ${weight2019} if continent == "Africa" | continent == "South America" , vce(robust)
}

	esttab using ${path_appendix}/motonotonicity_check3.tex, nocons replace label b(a1) se(a1) nostar nodepvars drop(${base_covariates2019} _cons) stats(N, labels("N")) obslast nogaps nonotes mlabels(none)
	
eststo clear 
forv i=1/3{
		eststo: reg ${dem2019} ${iv`i'} ${weight2019} if continent == "Oceania" | continent == "Asia" | continent == "North America", vce(robust)
		eststo: reg ${dem2019} ${iv`i'} ${base_covariates2019} ${weight2019} if continent == "Oceania" | continent == "Asia" | continent == "North America", vce(robust)
}

esttab using ${path_appendix}/motonotonicity_check3.tex, nocons append label b(a1) se(a1) nostar nodepvars drop(${base_covariates2019} _cons) stats(N, labels("N")) obslast nogaps nonotes mlabels(none)

*************************************** split samples by continent: Africa & N.America vs. S.America & Asia & Oceania

eststo clear 
forv i=1/3{
		eststo: reg ${dem2019} ${iv`i'} ${weight2019} if continent == "Africa" |continent == "North America"  , vce(robust)
		eststo: reg ${dem2019} ${iv`i'} ${base_covariates2019} ${weight2019} if continent == "Africa" | continent == "North America" , vce(robust)
}

	esttab using ${path_appendix}/motonotonicity_check4.tex, nocons replace label b(a1) se(a1) nostar nodepvars drop(${base_covariates2019} _cons) stats(N, labels("N")) obslast nogaps nonotes mlabels(none)
	
eststo clear 
forv i=1/3{
		eststo: reg ${dem2019} ${iv`i'} ${weight2019} if continent == "Oceania" | continent == "Asia" | continent == "South America", vce(robust)
		eststo: reg ${dem2019} ${iv`i'} ${base_covariates2019} ${weight2019} if continent == "Oceania" | continent == "Asia" | continent == "South America", vce(robust)
}

esttab using ${path_appendix}/motonotonicity_check4.tex, nocons append label b(a1) se(a1) nostar nodepvars drop(${base_covariates2019} _cons) stats(N, labels("N")) obslast nogaps nonotes mlabels(none)

*************************************** split samples by continent: Africa & N.America vs. S.America & Asia & Oceania

eststo clear 
forv i=1/3{
		eststo: reg ${dem2019} ${iv`i'} ${weight2019} if continent == "Africa" |continent == "North America"  , vce(robust)
		eststo: reg ${dem2019} ${iv`i'} ${base_covariates2019} ${weight2019} if continent == "Africa" | continent == "North America" , vce(robust)
}

	esttab using ${path_appendix}/motonotonicity_check4.tex, nocons replace label b(a1) se(a1) nostar nodepvars drop(${base_covariates2019} _cons) stats(N, labels("N")) obslast nogaps nonotes mlabels(none)
	
eststo clear 
forv i=1/3{
		eststo: reg ${dem2019} ${iv`i'} ${weight2019} if continent == "Oceania" | continent == "Asia" | continent == "South America", vce(robust)
		eststo: reg ${dem2019} ${iv`i'} ${base_covariates2019} ${weight2019} if continent == "Oceania" | continent == "Asia" | continent == "South America", vce(robust)
}

esttab using ${path_appendix}/motonotonicity_check4.tex, nocons append label b(a1) se(a1) nostar nodepvars drop(${base_covariates2019} _cons) stats(N, labels("N")) obslast nogaps nonotes mlabels(none)

*************************************** split samples by first letter's alphabet

gen first_letter = substr(countries, 1, 1)
gen name_betw_a_m = (first_letter == "A" | first_letter == "B" | first_letter == "C" | first_letter == "D" | first_letter == "E" | first_letter == "F" | first_letter == "G" | first_letter == "H" | first_letter == "I" | first_letter == "J" | first_letter == "K"| first_letter == "L"| first_letter == "M")

eststo clear 
forv i=1/6{
		eststo: reg ${dem2019} ${iv`i'} ${weight2019} if name_betw_a_m, vce(robust)
		eststo: reg ${dem2019} ${iv`i'} ${base_covariates2019} ${weight2019} if name_betw_a_m, vce(robust)
}

esttab using ${path_appendix}/first_stage_alph1.tex, nocons replace label b(a1) se(a1) nostar nodepvars drop(${base_covariates2019} _cons) stats(N, labels("N")) obslast nogaps nonotes mlabels(none)
	
eststo clear 
forv i=1/6{
		eststo: reg ${dem2019} ${iv`i'} ${weight2019} if !name_betw_a_m, vce(robust)
		eststo: reg ${dem2019} ${iv`i'} ${base_covariates2019} ${weight2019} if !name_betw_a_m, vce(robust)
}

esttab using ${path_appendix}/first_stage_alph2.tex, nocons replace label b(a1) se(a1) nostar nodepvars drop(${base_covariates2019} _cons) stats(N, labels("N")) obslast nogaps nonotes mlabels(none)



	
