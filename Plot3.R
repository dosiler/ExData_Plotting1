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

## Generate a plot for Sub_metering_1 on the y-axis, with Date on the x-axis 
plot(data$DateTime, as.numeric(data$Sub_metering_1), ylab="Energy Sub Metering", type="l", xlab="")

## Add Sub_metering_2 variable to the plot
points(data$DateTime, as.numeric(data$Sub_metering_2), col="red", type="l") 

## Add sub_metering_3 to the plot
points(data$DateTime, as.numeric(data$Sub_metering_3), col="blue", type="l") 

## Add the legend with color 
legend("topright", lty = c(1, 1, 1), col=c("black", "red", "blue"), legend=c("Sub Metering 1","Sub Metering 2","Sub Metering 3"))

## Save the histogram to file 
dev.copy(png, file="plot3.png", height=480, width=480) 

## Turn off the graphic device that created png output file
dev.off() 
