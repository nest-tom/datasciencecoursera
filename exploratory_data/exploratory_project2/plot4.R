# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
library(ggplot2)

# filter the data we want
comb <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coal <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalComb <- (comb & coal)
combSCC <- SCC[coalComb,]$SCC
combNEI <- NEI[NEI$SCC %in% combSCC,]

# make a bar chart
g <- ggplot(combNEI,aes(factor(year),Emissions)) + geom_bar(stat = "identity") + labs(x = "Year", y = "Emissions", title = "Coal Combustion Emissions by Year") 
g

# export to png
dev.copy(png, file = "plot4.png", bg = "white",  width=480, height=480)
dev.off()

