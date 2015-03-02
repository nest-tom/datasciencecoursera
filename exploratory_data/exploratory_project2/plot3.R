# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
library(ggplot2)

# filter the data we want
balt<- filter(NEI, fips=="24510")
balt_emissions <- aggregate(Emissions ~ year, data=balt, FUN=sum)

# make a bar chart
g <- ggplot(balt, aes(balt_emissions$year, balt_emissions$Emissions)) + geom_bar(stat = "identity") + facet_grid(. ~ type) + scale_x_continuous(breaks=c(1999,2002,2005,2008), labels=c("99", "02", "05", "08")) + labs(x = "Year", y = "Emissions", title = "Baltimore Emissions by Year")
g

# export to png
dev.copy(png, file = "plot3.png", bg = "white",  width=480, height=480)
dev.off()

