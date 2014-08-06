download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","power.csv")
unzip("power.csv")
power<-read.table("household_power_consumption.txt",sep=";",header=T,stringsAsFactors=F)

data<-subset(power,Date=="1/2/2007" | Date=="2/2/2007")

data$Date <- strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")

par(mfrow=c(2,2))

#Top Right Plot
with(data,plot(Date,as.numeric(Global_active_power),type="n",ylab="Global Active Power (kilowatts)"))

lines(data$Date,as.numeric(data$Global_active_power))

#Top Left Plot
with(data,plot(Date,as.numeric(Voltage),type="n",ylab="Voltage",xlab="datetime"))
with(data,lines(Date,as.numeric(Voltage)))


#Bottom Left Plot
with(data,plot(Date,Sub_metering_1,type="n",ylab="Energy sub metering"))

lines(data$Date,data$Sub_metering_1,col="black")

lines(data$Date,data$Sub_metering_2,col="red")

lines(data$Date,data$Sub_metering_3,col="blue")

legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty="solid",col=c("black","red","blue"))



#Bottom Right Plot
with(data,plot(Date,as.numeric(Global_reactive_power),type="n",ylab="Global_reactive_power"))

lines(data$Date,as.numeric(data$Global_reactive_power))

dev.copy(png,"plot4.png")
dev.off()