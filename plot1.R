library("data.table")

#Set working directory
setwd("C:/Users/sjfabito/Desktop/Coursera/Exploratory Analysis")

#Import dataset (text file)
data<-read.table("household_power_consumption.txt", skip=1, sep=";")

#Assign variables names
names(data) <-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

#Subset data dated February 1-2, 2007 only
#Note: Date is in DD/MM/YYYY format
subdata<-subset(data, data$Date=="1/2/2007" | data$Date=="2/2/2007")

#Draw a new plot
hist(as.numeric(as.character(subdata$Global_active_power)),col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

#Save as PNG file
dev.cur()
dev.copy(png, file="plot1.png")
dev.off()