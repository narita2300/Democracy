library(haven)
library(stargazer)
library(ivreg)
library(sandwich)
library(lmtest)
library(RCurl)
library(estimatr)

url_robust <- "https://raw.githubusercontent.com/IsidoreBeautrelet/economictheoryblog/master/robust_summary.R"
eval(parse(text = getURL(url_robust, ssl.verifypeer = FALSE)),
     envir=.GlobalEnv)

total <- read_dta("/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/total.dta")
total <- as.data.frame(total)
setwd("/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/tables")
total <- total[!is.na(total$logem),]

m_iv <- ivreg(gdp_growth2020 ~ democracy_vdem2019 
              | logem, 
              weights = total_gdp2019,
              data = total)
summary(m_iv)
coeftest(m_iv, vcov = vcovHC(m_iv, "HC1"))
waldtest(m_iv, vcov = vcovHC(m_iv, type = "HC1"))

total$cooksd <- cooks.distance(m_iv)
total[total$cooksd > 0.05,]$countries
total <- total[total$cooksd < 0.05, ]

m <- iv_robust(gdp_growth2020 ~ democracy_vdem2019 
               | logem, 
               weights = total_gdp2019,
               data = total, 
               se_type="HC1", 
               diagnostics = TRUE)
summary(m)
total$cooksd <- cooks.distance(m)


m_f <- lm(democracy_vdem2019 ~ logem, 
           weights = total_gdp2019, 
           data = total)
summary(m_f)
coeftest(m_f, vcov = vcovHC(m_f, "HC1"))
waldtest(m_f,vcov = vcovHC(m_f, type = "HC1"))


