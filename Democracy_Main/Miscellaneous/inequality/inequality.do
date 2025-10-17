

************************************ 
************************************ Install required packages
cap ssc install wid, replace

************************************ 
************************************ Download inequality data
wid, indicators(ptinc pllin pkkin )
