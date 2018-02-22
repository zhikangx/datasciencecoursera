# Q4 Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

SCC$SCC <- as.character(SCC$SCC)
a <- merge(NEI, SCC, by = "SCC")

jd1 <- grepl("coal", a$Short.Name,ignore.case=TRUE)

data <- a[jd1,]
agg4 <- aggregate(as.numeric(data$Emissions), by=list(data$year), FUN=sum)
names(agg4) <- c("year", "Emissions")

png("plot4.png", width=480, height=480)
plot(agg4[,1],agg4[,2],xlab = "year",ylab = "Emissions", main="Coal Combustion-related PM2.5 Emission Trend")
par(new=TRUE)
lines(agg4[,2]~agg4[,1], col=rgb(0.8,0.4,0.1,0.7), lwd=3 , pch=19, type="b" )
dev.off()
