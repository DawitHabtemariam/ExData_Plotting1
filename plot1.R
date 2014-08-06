download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","power.csv")
unzip("power.csv")
power<-read.table("household_power_consumption.txt",sep=";",header=T,stringsAsFactors=F)

data<-subset(power,Date=="1/2/2007" | Date=="2/2/2007")

data$Date <- strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")

hist(as.numeric(data$Global_active_power),col="red",xlab="Global Active Power (in kilowatts)", main="Global Active Power")

dev.copy(png,"plot1.png")

dev.off()
