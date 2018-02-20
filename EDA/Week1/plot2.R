# loading and formatting the data
data <- read.table("data/household_power_consumption.txt", quote="\"", comment.char="", sep = ";", header = TRUE)
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")
data[,3:9] <- lapply(data[,3:9],as.character)
data[,3:9] <- lapply(data[,3:9],as.numeric)

## setting the target period
date_target <- c("01/02/2007","02/02/2007")
date_target <- as.Date(date_target, format = "%d/%m/%Y")

## filtering data
data_used <- data[data$Date %in% date_target, ]

# get the time info
date_and_time <- paste(as.character(data_used$Date), as.character(data_used$Time), sep=" ")
datetime <- strptime(date_and_time, "%Y-%m-%d %H:%M:%S") 

# plot
date_and_time <- paste(as.character(data_used$Date), as.character(data_used$Time), sep=" ")
datetime <- strptime(date_and_time, "%Y-%m-%d %H:%M:%S") 

png("plot2.png", width=480, height=480)
plot(datetime, data_used[,3],type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()