# Q5 How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

SCC$SCC <- as.character(SCC$SCC)
a <- merge(NEI, SCC, by = "SCC")

data_B_veh <- subset(a, as.character(Data.Category) == "Onroad", select = c(year,fips,SCC,Emissions,Data.Category))
data <- subset(data_B_veh,fips == 24510,select = c(year,Emissions))

agg5 <- aggregate(as.numeric(data$Emissions), by=list(data$year), FUN=sum)
png("plot5.png", width=480, height=480)
plot(agg5[,1],agg5[,2],xlab = "year",ylab = "Emissions", main="Motor vehicle-related PM2.5 Emission Trend")
par(new=TRUE)
lines(agg5[,2]~agg5[,1], col=rgb(0.8,0.4,0.1,0.7), lwd=3 , pch=19, type="b" )
dev.off()
