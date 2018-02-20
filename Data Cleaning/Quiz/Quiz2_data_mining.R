# Question 1


# Question 2

acs <- read.csv("data-w2/getdata-data-ss06pid.csv")

if(!require("sqldf")){
  install.packages("sqldf")
  library("sqldf")
}

sqldf("select pwgtp1 from acs where AGEP < 50")


# Question 3

ts <- unique(acs$AGEP)

## sqldf("select unique AGEP from acs")
rs <- sqldf("select distinct AGEP from acs")
rs==ts
### the answer is sqldf("select distinct AGEP from acs")

## sqldf("select AGEP where unique from acs")

# Question 4
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)
htmlCode

nchar(htmlCode[10])
nchar(htmlCode[20])
nchar(htmlCode[30])
nchar(htmlCode[100])

### 45,31,7,25

# Question 5
x <- read.fwf(
  file=url("http://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"),
  skip=4,
  widths=c(14,5,9,4,9,4,9,4,5))

sum(x$V4)

### the answer is 32426.7
