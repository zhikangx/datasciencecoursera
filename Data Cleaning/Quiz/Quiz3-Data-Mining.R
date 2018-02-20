# Question 1



# Question 2

if(!require("jpeg")){
  install.packages("jpeg")
  library(jpeg)
}

pic1<- readJPEG('data-w3/getdata-jeff.jpg', native = TRUE)

quantile(pic1, probs = 0.3)

quantile(pic1, probs = 0.8)

### the answer are
### 30% 
### -15259150 
### 80% 
### -10575416 

# Question 3

data_EDSTATS_Country <- read.csv("data-w3/getdata-data-EDSTATS_Country.csv", header=FALSE)
data_GDP <- read.csv("data-w3/getdata-data-GDP.csv", header=FALSE)

colnames(data_EDSTATS_Country) <- as.character(data_EDSTATS_Country[1,])

sort(unique(data_GDP[,1]))

length(intersect(data_GDP[,1], data_EDSTATS_Country[,1]))

new <- data_GDP[order(data_GDP$V2)]


# Question 4




# Question 5
