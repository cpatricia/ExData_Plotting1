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

#Generate the plot
plot(energy$DateTime,energy$Global_active_power,
     main="",
     ylab="Global Active Power (kilowatts)",
     type="l",
     xlab="")

#output the plot to a png file
dev.copy(png,file="plot2.png")
dev.off()
