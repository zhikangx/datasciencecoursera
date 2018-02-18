# Week 1

## Q1

data1 <- read.csv("data-w1/getdata-data-ss06hid.csv")
jd <- data1$VAL==24
sum(jd,na.rm=TRUE)

### the ansewer is 53

## Q2

data1$FES
head(data1)

### too many NA?

## Q3

### under r 2.7

col_index <- 7:15
row_index <- 18:23
data2 <- read.xlsx("data-w1/getdata-data-DATA.gov_NGAP.xlsx",sheetIndex=1, colIndex=col_index, rowIndex=row_index)

### under r 3.3, uses readxl package
install.packages("readxl")
library(readxl)

dat <- read_excel("data-w1/getdata-data-DATA.gov_NGAP.xlsx",range = "G18:O23")
sum(dat$Zip*dat$Ext,na.rm=T)
### the answer is 36534720

## Q4
library(XML)
fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileURL, useInternal=TRUE)
rootNode <- xmlRoot(doc)

xmlSApply(rootNode, xmlValue)
ct <- xpathSApply(rootNode,"//zipcode",xmlValue)
length(ct[ct==21231])

### the answer is 27


## Q5

fileURL2 <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileURL2,destfile = "data-w1/dataQ5.csv",method="curl")
dateDownloaded <- date()
print(dateDownloaded)
install.packages("data.table")
library(data.table)

## fread not available in r3.3
## DT <- fread(input="dataQ5.csv", sep=",")
DT <- read.csv("data-w1/dataQ5.csv")

system.time(DT[,mean(pwgtp15),by=SEX])


system.time(tapply(DT$pwgtp15,DT$SEX,mean))
### user  system elapsed 
### 0.001   0.000   0.001 

system.time(mean(DT$pwgtp15,by=DT$SEX))
### user  system elapsed 
### 0       0       0 

system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
### user  system elapsed 
### 0.002   0.000   0.002 

system.time(mean(DT[DT$SEX==1,]$pwgtp15)) 
### user  system elapsed 
### 0.024   0.001   0.027 

system.time(mean(DT[DT$SEX==2,]$pwgtp15))
### user  system elapsed 
### 0.025   0.002   0.027 