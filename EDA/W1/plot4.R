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

png("plot4.png", width=480, height=480)

par(mfrow = c(2, 2)) 

plot(datetime, data_used$Global_active_power,type="l", xlab="", ylab="Global Active Power")

plot(datetime, data_used$Voltage,type = "l", xlab = "datetime", ylab = "Voltage")

plot(datetime, data_used$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering",col = "black")
lines(datetime, data_used$Sub_metering_2, type="l", xlab="", col = "red")
lines(datetime, data_used$Sub_metering_3, type="l", xlab="", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=NULL, bty = "n", lwd=2.5, col=c("black", "red", "blue"))

plot(datetime, data_used$Global_reactive_power,type="l", xlab="datetime", ylab="Global_Reactive_Power")

dev.off()
