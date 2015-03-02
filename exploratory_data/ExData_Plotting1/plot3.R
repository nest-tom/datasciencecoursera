# read in the large data set
ds <- read.csv("household_power_consumption.txt", sep=";")
library(dplyr)

# filter out the two dates we're interested in
ds2 <- filter(ds, Date=="1/2/2007"| Date=="2/2/2007")

# convert the Date field to a Date class
ds3 <- mutate(ds2, Date = as.Date(ds2$Date, "%d/%m/%Y"))

# merge the Date and Time fields into a new DateTime field for future convenience
ds4 <- mutate(ds3, DateTime = as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"))

# add an Epoch column converting the DateTime column to a numeric epoch-time value
ds5 <- mutate(ds4, Epoch = as.numeric(as.POSIXct(DateTime)))

# make a chart
plot(as.numeric(ds5$Sub_metering_1), type="l", xaxt = 'n', yaxt = 'n' , xlab = "", ylab = "Energy sub metering") 
axis(side=1, at = c(0, 1000, 2000), labels = c("Thu","Fri","Sat"))
axis(side=2, at = c(0, 10, 20, 30), labels = c(0,10,20,30))
lines(as.numeric(ds5$Sub_metering_2), col = "red" )
lines(as.numeric(ds5$Sub_metering_3), col = "blue" )
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red","blue"), pch='-')

# export to png
dev.copy(png, file = "plot3.png",  bg = "white", width=480, height=480)
dev.off()

