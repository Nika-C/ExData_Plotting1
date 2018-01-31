# Exploratory Data Analysis
# Week 1 Assignment - plot4.R

#Step 1. Download and read data into R
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="./W1Data.zip")
unzip("./W1Data.zip")
Power <- read.table("./household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?", stringsAsFactors = FALSE)

#Step 2. clean up data
library(lubridate)
Power$Date2 <- dmy(Power$Date)
d <- as.Date("2007-02-01")
SubPower <- subset(Power, (Power$Date2==d | Power$Date2==d+1))
SubPower$Time2 <- strptime(paste(SubPower$Date, SubPower$Time, sep="-"), "%d/%m/%Y-%H:%M:%S")

#Step 3. create plot and save directly into PNG
png(file="plot4.png")

par(mfcol=c(2,2))
with(SubPower, {
  plot(Time2, Global_active_power, type="line", ylab="Global Active Power", xlab="")
  
  plot(Time2, Sub_metering_1, type="line", ylab="Energy sub metering", xlab="")
  lines(Time2, Sub_metering_2, col="red")
  lines(Time2, Sub_metering_3, col="blue")
  legend("topright", lty=c(1,1), col=c("black","red","blue"),
         legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), box.lwd=0)

  plot(Time2, Voltage, xlab="datetime", type="line")
  plot(Time2, Global_reactive_power, xlab="datetime", type="line")
  })

dev.off()
