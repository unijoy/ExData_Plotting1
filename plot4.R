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
# plot 4
png(file="plot4.png",width = 480,height = 480)
par(mfrow = c(2, 2))
with(md,{
    plot(md$Global_active_power ~ md$dt,type="l",ylab = "Global Active Power(kilowatts)", xlab="")
    plot(md$Voltage ~ md$dt,type="l",ylab = "Voltage", xlab="datetime")
    with(md,{
        plot(md$dt,md$Sub_metering_1,type="l",ylab = "Energy sub metering",xlab = "")
        lines(md$dt,md$Sub_metering_2,col="red")
        lines(md$dt,md$Sub_metering_3,col="blue")
    })
    plot(md$Global_reactive_power ~ md$dt,type="l",ylab = "Global_reactive_power", xlab="datetime")
})
dev.off()