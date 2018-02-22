NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Q1 U.S. PM2.5 Emission Trend
agg1 <- aggregate(as.numeric(NEI$Emissions), by=list(Category=NEI$year), FUN=sum)

png("plot1.png", width=480, height=480)
plot(agg1[,1],agg1[,2],xlab = "year",ylab = "Emissions", main="U.S. PM2.5 Emission Trend")
dev.off()

# Q2 total emissions trend in Baltimore City, Maryland

data_B <- subset(NEI,fips=="24510",select = c(year,Emissions))
agg2 <- aggregate(as.numeric(data_B$Emissions), by=list(Category=data_B$year), FUN=sum)

png("plot2.png", width=480, height=480)
plot(agg2[,1],agg2[,2],xlab = "year",ylab = "Emissions", main="Baltimore City PM2.5 Emission Trend")
dev.off()

#Q3 total emissions trend (by resources type) in Baltimore City, Maryland
if(!require("ggplot2")){
  install.packages("ggplot2")
  library("ggplot2")
}
data_B_type <- subset(NEI,fips=="24510",select = c(year,Emissions,type))

agg2 <- aggregate(as.numeric(data_B_type$Emissions), by=list(data_B$year, data_B_type$type), FUN=sum)
names(agg2) <- c("year", "type", "Emissions")

png("plot3.png", width=480, height=480)
g <- ggplot(agg2, aes(x = year, y =Emissions)) + geom_point()
g + facet_wrap(~type, nrow=1, ncol=4)
dev.off()

# Q4

jd1 <- grepl("coal", SCC$Short.Name,ignore.case=TRUE)

SCC_sub <- SCC[jd1,]
jd1_SCC = SCC_sub[,1]

data_B_coal <- subset(NEI, SCC == jd1_SCC, select = c(year,Emissions))
agg3 <- aggregate(as.numeric(data_B_coal$Emissions), by=list(data_B_coal$year), FUN=sum)

names(agg3) <- c("year", "Emissions")

png("plot4.png", width=480, height=480)
plot(agg3[,1],agg3[,2],xlab = "year",ylab = "Emissions", main="Coal Combustion-related sources PM2.5 Emission Trend")
dev.off()

# Q5



jd2 <- grepl("Onroad", SCC$Data.Category,ignore.case=TRUE)
SCC_sub <- SCC[jd2,]
jd2_SCC = SCC_sub[,1]

data_B_veh <- subset(NEI, (SCC == jd2_SCC) & (fips == "24510"), select = c(fips, year,Emissions))

agg4 <- aggregate(as.numeric(data_B_veh$Emissions), by=list(data_B_veh$year), FUN=sum)

# test

t1 <- subset(NEI, SCC == jd2_SCC, select = c(SCC, year,fips, Emissions))

t2 <- subset(t1, SCC == jd2_SCC)

names(agg4) <- c("year", "Emissions")

png("plot5.png", width=480, height=480)
plot(agg4[,1],agg4[,2],xlab = "year",ylab = "Emissions", main="Motor vehicle-related sources PM2.5 Emission Trend")
dev.off()


# Q6

data_LA <- subset(NEI,fips=="𝟶𝟼𝟶𝟹𝟽",select = c(year,Emissions))

