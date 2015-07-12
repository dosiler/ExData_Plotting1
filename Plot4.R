# This script creates the first plot required for Project 1 in the Coursera class Exploratory Data Analysis
# 
# Before running this script, first do the following:
# 1. Download the data from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# 2. Extract the file "household_power_consumption.txt" from the archive into your working directory
# 3. Place this script in your working directory

## Load sqldf, necessary to run read.csv.sql below
library(sqldf) 

## Read the file and subset on the specified dates
data <- read.csv.sql("./household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", sep=";", header=TRUE)

## Close all connections (to prevent the relevant error messages)
closeAllConnections()

## Convert the Data and Time strings to objects of class "Date"
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

## Drop old Date and Time variables
oldvars <- names(data) %in% c("Date", "Time") 
data <- data[!oldvars]

## Create 2 x 2 plot 
par(mfrow=c(2,2)) 

## Plot 1
plot(data$DateTime, as.numeric(data$Global_active_power), 
     ylab="Global Active Power", type="l", xlab="")

## Plot 2
plot(data$DateTime, as.numeric(data$Voltage), 
     ylab="Voltage", type="l", xlab="")

## Plot 3
plot(data$DateTime, as.numeric(data$Sub_metering_1), ylab="Energy Sub Metering", type="l", xlab="") 
points(data$DateTime, as.numeric(data$Sub_metering_2), col="red", type="l") 
points(data$DateTime, as.numeric(data$Sub_metering_3), col="blue", type="l") 
legend("topright", lty = c(1, 1, 1), col=c("black", "red", "blue"), legend=c("Sub Metering 1","Sub Metering 2","Sub Metering 3"))

## Plot 4
plot(data$DateTime,data$Global_reactive_power,type="l", xlab="", ylab="Global Reactive Power")

## Save the histogram to file 
dev.copy(png, file="plot4.png", height=480, width=480) 

## Turn off the graphic device that created png output file
dev.off() 

## Reset the plot structure
par(mfrow=c(1,1))