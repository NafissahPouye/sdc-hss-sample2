#Load required packages
library(readxl)      #for excel, csv sheets manipulation
library(sdcMicro)    #sdcMicro package with functions for the SDC process 
library(tidyverse)   #for data cleaning if needed before the SDC process

#Import microdata
setwd("C:/Users/LENOVO T46OS/Desktop/C:/Users/LENOVO T46OS/Desktop/sdc-hss-sample2") #set working directory
data <- read_excel("data.xlsx")

#Classify variables 
#Select key variables
selectedKeyVars <- c('surveycountry',	'surveysite', 'Q03_hhsize',	
                     'Q04_gender', 'Q1_age_random', 'Q21_job', 
                    'Q22_nojob_occup', 'Q42_migr_why_marriage',
                     'Q45_before_county', 'Q62_ethnic_identity_manipulated',
                    'Q86_weap_perp',	'Q87_weap_actor_police', 'Q116_rob_perp',
                    'Q117_rob_actor_police','Q126_sex_perp',	'Q127_sex_actor_police',
                    'Q146_pris_perp','Q156_abduc_perp', 'Q166_beat_perp',	
                    'Q167_beat_actor_police', 'Q186_marr_perp')

#selectedKeyVars <- c( 'Q04_gender', 
#                      'Q42_migr_why_marriage'
 #                    )

#Convert variables to factor
cols = c('surveycountry',	'surveysite', 'Q1_age_random')

data[,cols] <- lapply(data[,cols], factor)

#Set subset of file with key variables
fileRes<-data[,selectedKeyVars]
fileRes <- as.data.frame(fileRes)

#Create a SDC object
objSDC <- createSdcObj(dat = fileRes, keyVars = selectedKeyVars)

#Print the global risk
print(objSDC, "risk")

#Generating an internal (extensive) report
report(objSDC, filename = "index", internal = TRUE) 


