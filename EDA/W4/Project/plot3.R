#Q3 total emissions trend (by resources type) in Baltimore City, Maryland
if(!require("ggplot2")){
  install.packages("ggplot2")
  library("ggplot2")
}

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

data_B_type <- subset(NEI,fips=="24510",select = c(year,Emissions,type))

agg3 <- aggregate(as.numeric(data_B_type$Emissions), by=list(data_B_type$year, data_B_type$type), FUN=sum)
names(agg3) <- c("year", "type", "Emissions")

png("plot3.png", width=480, height=480)
g <- ggplot(agg3, aes(x = year, y =Emissions)) + geom_point()
g + facet_wrap(~type, nrow=1, ncol=4)
dev.off()