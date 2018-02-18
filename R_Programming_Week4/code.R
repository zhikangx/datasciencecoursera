# setwd("Users/Zhikang.Xu/Documents/datasciencecoursera/Users/Zhikang.Xu/Documents/datasciencecoursera/R_Programming_Week4")

outcome <- read.csv("~/Documents/datasciencecoursera/R_Programming_Week4/data/outcome-of-care-measures.csv", header = TRUE, colClasses = "character")


# HW1
outcome[, 11] <- as.numeric(outcome[,11])
hist(outcome[,11])


# HW2

outcome[, 11] <- as.numeric(outcome[,11])
outcome[, 17] <- as.numeric(outcome[,17])
outcome[, 23] <- as.numeric(outcome[,23])

death_data_30_day <- cbind(outcome[2], outcome[7], outcome[,11], outcome[,17], outcome[,23])
colnames(death_data_30_day) <- c("hospital","state", "heart attack", "heart failure", "pneumonia")

best <- function(state, outcome) { ## Read outcome data
  state1 <- state
  outcome1 <- outcome
  ## Check that state and outcome are valid
  outcome_name <- c('heart attack', 'heart failure', 'pneumonia')
  try(if(!is.element('AL',death_data_30_day[, 2])) stop('invaid state'))
  try(if(!is.element('heart attack', outcome_name)) stop('invaid outcome'))
  
  ## Return hospital name in that state with lowest 30-day death ## rate
  data2 <- subset(death_data_30_day, state == state1, select = c('hospital', 'state', outcome1))
  colnames(data2) <- c('hospital', 'state', 'outcome')
  data2_clean <- na.omit(data2)
  data2_ranked <- data2_clean[order(data2_clean$`outcome`),]
  return(data2_ranked[1,1])
  }
  
# test
# best("TX", "heart attack")

# HW3

rankhospital <- function(state, outcome, num = "best") { ## Read outcome data
  
  state1 <- state
  outcome1 <- outcome
  
  num <- 4
  state1 <- "TX"
  outcome1 <- "heart failure"
  
  ## Check that state and outcome are valid
  outcome_name <- c('heart attack', 'heart failure', 'pneumonia')
  try(if(!is.element('AL',death_data_30_day[, 2])) stop('invaid state'))
  try(if(!is.element('heart attack', outcome_name)) stop('invaid outcome'))
  
  ## Return hospital name in that state with the given rank ## 30-day death rate
  data2 <- subset(death_data_30_day, state == state1, select = c('hospital', 'state', outcome1))
  colnames(data2) <- c('hospital', 'state', 'outcome')
  data2_clean <- na.omit(data2)
  data2_ranked <- data2_clean[order(data2_clean$`outcome`),]
  if(num == 'best'){
    dic <- 1
  } else if( num == 'worst'){
    dic <- length(data2_ranked[,1])
  } else{
    dic <- num
  }
  
  print(data2_ranked[dic,1])
  
  return(data2_ranked[dic,1])
}

# test
# rankhospital("TX", "heart failure", 4)
# rankhospital("MD", "heart attack", "worst")

# HW 4

data <- read.csv("~/Documents/datasciencecoursera/R_Programming_Week4/data/outcome-of-care-measures.csv", header = TRUE, colClasses = "character")

rankall <- function(outcome, num = "best") { ## Read outcome data
  outcome1 <- outcome
  ## Check that state and outcome are valid
  outcome_name <- c('heart attack', 'heart failure', 'pneumonia')
  try(if(!is.element('heart attack', outcome_name)) stop('invaid outcome'))
  
  ## For each state, find the hospital of the given rank
  stategroup <- unique(data$State)
  lt <- length(stategroup)
  
  result <- data.frame(state=character(), 
                   hospital=character(), 
                   stringsAsFactors=FALSE) 
  for(i in 1:lt){
    state1 = stategroup[i]
    data2 <- subset(death_data_30_day, state == state1, select = c('hospital', 'state', outcome1))
    colnames(data2) <- c('hospital', 'state', 'outcome')
    data2_clean <- na.omit(data2)
    data2_ranked <- data2_clean[order(data2_clean$`outcome`),]
    if(num == 'best'){
      dic <- 1
    } else if( num == 'worst'){
      dic <- length(data2_ranked[,1])
    } else{
      dic <- num
    }
    new_result <- data.frame(state1, data2_ranked[dic,1])
    colnames(new_result) <- c('state', 'hospital')
    
    result <- rbind(result, new_result)
  }
  
  ## Return a data frame with the hospital names and the ## (abbreviated) state name
  result <- result[order(result$state), ]
  print(result)
}

# test
# head(rankall("heart attack", 20), 10)
tail(rankall("pneumonia", "worst"), 3)
