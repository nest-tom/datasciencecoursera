#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.
# first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

pm25 <- filter(NEI, Pollutant=="PM25-PRI" & fips == "24510")
emissions <- aggregate(Emissions ~ year, data=pm25, FUN=sum)

library(data.table)
e <- data.table(emissions)
barplot(e$Emissions, type="l", main = "Baltimore PM25 Emissions", xlab = "Year", xact = 'n', ylab = "Total Emissions (millions)" )
axis(side=1, at = c(1, 2, 3, 4), labels = c("1999","2002","2005", "2008"))

# export to png
dev.copy(png, file = "plot2.png", bg = "white",  width=480, height=480)
dev.off()
