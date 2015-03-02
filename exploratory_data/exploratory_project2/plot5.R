# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
library(ggplot2)

# filter the data we want
v <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vSCC <- SCC[v,]$SCC
vNEI <- NEI[NEI$SCC %in% vSCC,]
balt<- filter(vNEI, fips=="24510")
balt_emissions <- aggregate(Emissions ~ year, data=balt, FUN=sum)

# make a bar chart
g <- ggplot(balt_emissions, aes(balt_emissions$year, balt_emissions$Emissions)) + geom_bar(stat = "identity") + labs(x = "Year", y = "Emissions", title = "Baltimore Emissions by Year") + scale_x_continuous(breaks=c(1999,2002,2005,2008), labels=c("1999", "2002", "2005", "2008"))
g

# export to png
dev.copy(png, file = "plot5.png", bg = "white",  width=480, height=480)
dev.off()

