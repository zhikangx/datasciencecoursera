# Q1 U.S. PM2.5 Emission Trend
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

agg1 <- aggregate(as.numeric(NEI$Emissions), by=list(Category=NEI$year), FUN=sum)

png("plot1.png", width=480, height=480)
plot(agg1[,1],agg1[,2],xlab = "year",ylab = "Emissions", main="U.S. PM2.5 Emission Trend")
par(new=TRUE)
lines(agg1[,2]~agg1[,1], col=rgb(0.8,0.4,0.1,0.7), lwd=3 , pch=19, type="b" )
dev.off()
