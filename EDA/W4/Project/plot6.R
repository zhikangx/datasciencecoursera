# Q6 Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (𝚏𝚒𝚙𝚜 == "𝟶𝟼
# 𝟶𝟹𝟽"). Which city has seen greater changes over time in motor vehicle emissions?

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

SCC$SCC <- as.character(SCC$SCC)
a <- merge(NEI, SCC, by = "SCC")

data_veh <- subset(a, as.character(Data.Category) == "Onroad", select = c(year,fips,SCC,Emissions,Data.Category))
data_B_veh <- subset(data_veh,fips == "24510", select = c(year,Emissions))
data_LA_veh <- subset(data_veh,fips == "06037", select = c(year,Emissions))
agg6_B <- aggregate(as.numeric(data_B_veh$Emissions), by=list(data_B_veh$year), FUN=sum)
agg6_LA <- aggregate(as.numeric(data_LA_veh$Emissions), by=list(data_LA_veh$year), FUN=sum)
names(agg6_LA) <- c("year", "Emissions")
names(agg6_B) <- c("year", "Emissions")


png("plot6.png", width=480, height=480)

plot(agg6_LA[,1],agg6_LA[,1] , type="b" , bty="l" , xlab="year" , ylab="Emissions" , col=rgb(0main="Motor vehicle-related PM2.5 Emission Trend", .2,0.4,0.1,0.7) , lwd=3 , pch=17, ylim = c(0,4700))
par(new=TRUE)
lines(agg6_B[,2]~agg6_LA[,1], col=rgb(0.8,0.4,0.1,0.7), lwd=3 , pch=19, type="b" )
par(new=TRUE)
abline(h=mean(agg6_LA[,2]), col=rgb(0.2,0.4,0.1,0.7) ,lty=2, lwd=2 , pch=1)
par(new=TRUE)
abline(h=mean(agg6_B[,2]), col=rgb(0.8,0.4,0.1,0.7) ,lty=2, lwd=2 , pch=1)

legend("center", 
       legend = c("Los Angeles", "Baltimore"), 
       col = c(rgb(0.2,0.4,0.1,0.7), 
               rgb(0.8,0.4,0.1,0.7)), 
       pch = c(17,19), 
       bty = "n", 
       pt.cex = 2, 
       cex = 1.2, 
       text.col = "black", 
       horiz = F , 
       inset = c(0.1, 0.1))

dev.off()
