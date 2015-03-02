# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
library(data.table)

# filter the data we want
v <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vSCC <- SCC[v,]$SCC
vNEI <- NEI[NEI$SCC %in% vSCC,]
balt<- filter(vNEI, fips=="24510")
balt_emissions <- aggregate(Emissions ~ year, data=balt, FUN=sum)

losa<- filter(vNEI, fips=="06037")
losa_emissions <- aggregate(Emissions ~ year, data=losa, FUN=sum)

# make a bar chart
par(mfrow = c(1,2))  # 1 row 2 columns
b <- data.table(balt_emissions)
l <- data.table(losa_emissions)

barplot(b$Emissions,  xaxt = 'n', main = "Total Emissions Baltimore", xlab = "Year", ylim=c(0,7000), ylab = "Total Emissions (millions)" )
axis(side=1, at = c(1, 2, 3, 4), labels = c("1999","2002","2005", "2008"))
barplot(l$Emissions,  xaxt = 'n', main = "Total Emissions Los Angeles", xlab = "Year",  ylim=c(0,7000), ylab = "Total Emissions (millions)" )
axis(side=1, at = c(1, 2, 3, 4), labels = c("1999","2002","2005", "2008"))

# export to png
dev.copy(png, file = "plot6.png", bg = "white",  width=480, height=480)
dev.off()

