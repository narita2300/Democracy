library(haven)
library(stargazer)

# Extract the corresponding countries to the max, min and median of each variable
MinMedMax <- function(Var){
  return(total[c(which.min(Var),
                 which.min(abs(Var - median(Var, na.rm = TRUE))),
                 which.max(Var)), ]$countries)
}

printm <- function(Var){
  paste("& & & & & (", MinMedMax(Var)[1], ") & (", MinMedMax(Var)[2], ") & (", MinMedMax(Var)[3], ") \\\\", sep="")
}

################################################################################
total <- read_dta("/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/populism/CPD_V-Party_Stata_v1/vparty_bycountry.dta")
total <- as.data.frame(total)
setwd("/Users/ayumis/Dropbox/アプリ/Overleaf/Curse_of_Democracy/supporting_files/tables")

################################################################################

vparty <- total[, c(
  "mean_ruling_illib_2001_2019",
  "mean_seatw_illib_2001_2019",
  "mean_votew_illib_2001_2019",
  "change_ruling_illib_2001_2019",
  "change_seatw_illib_2001_2019",
  "change_votew_illib_2001_2019",
  "mean_ruling_popul_2001_2019",
  "mean_seatw_popul_2001_2019",
  "mean_votew_popul_2001_2019",
  "change_ruling_popul_2001_2019",
  "change_seatw_popul_2001_2019",
  "change_votew_popul_2001_2019")]

output <- stargazer(vparty, 
                    title = "Descriptive Statistics",
                    summary.stat = c("n", "mean", "sd", "min", "median","max"),
                    covariate.labels = c(
                      "Mean ruling party's illiberalism score in 2001-19", 
                      "Mean seat-share-weighted illiberalism score in 2001-19",
                      "Mean vote-share-weighted illiberalism score in 2001-19",
                      
                      "Change in ruling party's illiberalism score in 2001-19",
                      "Change in seat-share-weighted illiberalism score in 2001-19",
                      "Change in vote-share-weighted illiberalism score in 2001-19",
                      
                      "Mean ruling party's populism score in 2001-19", 
                      "Mean seat-share-weighted populism score in 2001-19",
                      "Mean vote-share-weighted populism score in 2001-19", 
                      
                      "Change in ruling party's populism score in 2001-19",
                      "Change in seat-share-weighted populism score in 2001-19", 
                      "Change in vote-share-weighted populism score in 2001-19"),
                    column.sep.width = "0pt", 
                    font.size= "small", 
                    no.space = TRUE, 
                    header = FALSE,
                    omit.stat = c("rsq","f", "ser" ), 
                    digits = 2)

line = 11
i = 1
while (line < 11 + ncol(vparty)){
  print(i)
  print(line)
  print(11+ncol(vparty))
  line1 <- paste("&", output[line])
  line2 <- printm(unlist(vparty[i]))
  print(line1)
  print(line2)
  
  if (i == 1){
    write(line1, file="1_descriptive_vparty.tex", append = FALSE)
  } else {
    write(line1, file="1_descriptive_vparty.tex", append = TRUE)
  }
  write(line2, file="1_descriptive_vparty.tex", append = TRUE)
  line = line + 1
  i = i + 1
}

