#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

pm25 <- filter(NEI, Pollutant=="PM25-PRI")
emissions <- aggregate(Emissions ~ year, data=pm25, FUN=sum)

library(data.table)
e <- data.table(emissions)
barplot(e$Emissions,  xaxt = 'n', main = "Total Emissions Reported by Year", xlab = "Year", ylab = "Total Emissions (millions)" )
axis(side=1, at = c(1, 2, 3, 4), labels = c("1999","2002","2005", "2008"))
 
# export to png
dev.copy(png, file = "plot1.png", bg = "white",  width=480, height=480)
dev.off()


