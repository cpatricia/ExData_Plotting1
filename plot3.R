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
energy$Sub_metering_1=as.numeric(energy$Sub_metering_1)
energy$Sub_metering_2=as.numeric(energy$Sub_metering_2)
energy$Sub_metering_3=as.numeric(energy$Sub_metering_3)

#Generate the plot
plot(energy$DateTime,energy$Sub_metering_1,
     main="",
     ylab="Energy sub metering",
     type="l",
     xlab="",
     color="black")
lines(energy$DateTime,energy$Sub_metering_2,col="red")
lines(energy$DateTime,energy$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)

#output the plot to a png file
dev.copy(png,file="plot3.png")
dev.off()
