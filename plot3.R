# read data from file
mdata <- fread("household_power_consumption.txt")
mdata[,'dt'] <- paste(mdata$Date,mdata$Time)
head(mdata)

mdata$Date <- as.Date(mdata$Date,"%d/%m/%Y")
startDate <- as.Date("2007/02/01","%Y/%m/%d")
endDate <- as.Date("2007/02/02","%Y/%m/%d")
str(mdata)
md <- mdata[(mdata$Date >= startDate & mdata$Date <= endDate),]
md$Global_active_power <- as.numeric(md$Global_active_power)
md$dt <- as.POSIXct(strptime(md$dt,format = "%d/%m/%Y %H:%M:%S"))
str(mdata)
# plot 3
png(file="plot3.png",width = 480,height = 480)
with(md,plot(md$dt,md$Sub_metering_1,type="l",ylab = "Energy sub metering",xlab = ""))
lines(md$dt,md$Sub_metering_2,col="red")
lines(md$dt,md$Sub_metering_3,col="blue")
legend("topright",col=c("black","red","blue"),lty=1,lwd=2,legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()