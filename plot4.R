#Read the dataset
energy=read.table("household_power_consumption.txt",sep=";",header=TRUE)

#Replace ? with NA
energy[energy=="?"]<-NA

#Make Date and Time as datetime object
energy$DateTime=paste(energy$Date,energy$Time)
energy$DateTime=strptime(energy$DateTime,format="%Y-%m-%d %H:%M:%S")
energy$Date=as.Date(energy$Date,format="%d/%m/%Y")
energy$Time=strptime(energy$Time,format="%H:%M:%S")

#Filter dataset by 2007-02-01 and 2007-02-02
energy=energy[energy$Date=="2007-02-01"|energy$Date=="2007-02-02",]

#Convert chr to numeric
energy$Global_active_power=as.numeric(energy$Global_active_power)
energy$Global_reactive_power=as.numeric(energy$Global_reactive_power)
energy$Sub_metering_1=as.numeric(energy$Sub_metering_1)
energy$Sub_metering_2=as.numeric(energy$Sub_metering_2)
energy$Sub_metering_3=as.numeric(energy$Sub_metering_3)

#Set up the plotting matrix
par(mfrow=c(2,2))

#Generate the plots
plot(energy$DateTime,energy$Global_active_power,
     main="",
     ylab="Global Active Power (kilowatts)",
     type="l",
     xlab="")

plot(energy$DateTime,energy$Voltage,
     ylab="Voltage",
     xlab="datetime",
     type="l")

plot(energy$DateTime,energy$Sub_metering_1,
     main="",
     ylab="Energy sub metering",
     type="l",
     xlab="",
     color="black")
lines(energy$DateTime,energy$Sub_metering_2,col="red")
lines(energy$DateTime,energy$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)

plot(energy$DateTime, energy$Global_reactive_power,
     ylab="Global_reactive_power",
     xlab="datetime",
     type="l")

#output the plot to a png file
dev.copy(png,file="plot4.png")
dev.off()
