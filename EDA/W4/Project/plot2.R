# Q2 total emissions trend in Baltimore City, Maryland
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

data_B <- subset(NEI,fips=="24510",select = c(year,Emissions))
agg2 <- aggregate(as.numeric(data_B$Emissions), by=list(Category=data_B$year), FUN=sum)
names(agg2) <- c("year", "Emissions")

png("plot2.png", width=480, height=480)
plot(agg2[,1],agg2[,2],xlab = "year",ylab = "Emissions", main="Baltimore City PM2.5 Emission Trend")
par(new=TRUE)
lines(agg2[,2]~agg2[,1], col=rgb(0.8,0.4,0.1,0.7), lwd=3 , pch=19, type="b" )

dev.off()
