

*** Load data 
use ${path_data}/total.dta, replace

eststo clear
estpost correlate logem lpd1500s legor_uk EngFrac EurFrac bananas coffee copper maize millet rice rubber silver sugarcane wheat, matrix listwise
eststo correlate
esttab using ivs_corr.tex,replace label unstack not noobs compress nostar

