
xtreg y l.y dem yy*, fe r cluster(wbcode2)

estimates store e1
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: 0)  (lag3: 0)  (lag4: 0), post
vareffects
estimates store e1_add

// What are the recorded democratizations? 
gen become_dem = 0
replace become_dem = 1 if l.dem == 0 & dem == 1
sort year

reg y dem


****** merge the original dataset with the 
