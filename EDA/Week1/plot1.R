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

# plot

png("plot1.png", width=480, height=480)
hist(data_used$Global_active_power,xlab = "Global Active Power (kilowatts)", col = "red", ylim = c(0,1200), main="Global Active Power")
dev.off()