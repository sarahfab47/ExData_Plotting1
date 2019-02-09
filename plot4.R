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

#Prepare the partitions of the plots
par(mfrow=c(2,2))

#Draw plot #1
plot(subdata$Time,as.numeric(as.character(subdata$Global_active_power)),type="l",xlab="",ylab="Global Active Power")

#Draw plot #2
plot(subdata$Time,as.numeric(as.character(subdata$Voltage)),type="l",xlab="datetime",ylab="Voltage")

#Draw plot #3
plot(subdata$Time, subdata$Sub_metering_1, xlab="", ylab="Energy sub metering", type="n")
with(subdata,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(subdata,lines(Time,as.numeric(as.character(Sub_metering_2)), col="red"))
with(subdata,lines(Time,as.numeric(as.character(Sub_metering_3)), col="blue"))
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n", cex=0.6)

#Draw plot #4
plot(subdata$Time,as.numeric(as.character(subdata$Global_reactive_power)),type="l",xlab="datetime", ylab="Global_reactive_power")


#Save as PNG file
dev.cur()
dev.copy(png, file="plot4.png")
dev.off()