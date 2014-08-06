download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","power.csv")
unzip("power.csv")
power<-read.table("household_power_consumption.txt",sep=";",header=T,stringsAsFactors=F)

data<-subset(power,Date=="1/2/2007" | Date=="2/2/2007")

data$Date <- strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")

data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
data$Sub_metering_2<-as.numeric(data$Sub_metering_2)
data$Sub_metering_3<-as.numeric(data$Sub_metering_3)

with(data,plot(Date,Sub_metering_1,type="n",ylab="Energy sub metering"))

lines(data$Date,data$Sub_metering_1,col="black")

lines(data$Date,data$Sub_metering_2,col="red")

lines(data$Date,data$Sub_metering_3,col="blue")

legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty="solid",col=c("black","red","blue"))

dev.copy(png,"plot3.png")
dev.off()

