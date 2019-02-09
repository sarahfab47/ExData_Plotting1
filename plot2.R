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

#Transforming Date and Time
subdata$Date <- as.Date(subdata$Date, format="%d/%m/%Y")
subdata$Time <- strptime(subdata$Time, format="%H:%M:%S")
subdata[1:1440,"Time"] <- format(subdata[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subdata[1441:2880,"Time"] <- format(subdata[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

#Draw a new plot
plot(subdata$Time,as.numeric(as.character(subdata$Global_active_power)),type="l",xlab="",ylab="Global Active Power (kilowatts)")

#Save as PNG file
dev.cur()
dev.copy(png, file="plot2.png")
dev.off()