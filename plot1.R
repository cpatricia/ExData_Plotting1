#Read the dataset
energy=read.table("household_power_consumption.txt",sep=";",header=TRUE)

#Replace ? with NA
energy[energy=="?"]<-NA

#Make Date as datetime object
energy$Date=as.Date(energy$Date,format="%d/%m/%Y")

#Filter dataset by 2007-02-01 and 2007-02-02
energy=energy[energy$Date=="2007-02-01"|energy$Date=="2007-02-02",]

#Convert chr to numeric
energy$Global_active_power=as.numeric(energy$Global_active_power)

#Generate the plot
hist(energy$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")

#output the plot to a png file
dev.copy(png,file="plot1.png")
dev.off()