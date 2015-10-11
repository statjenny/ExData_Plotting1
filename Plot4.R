#Plot4

#Make sure the datafile is in the current working directory
getwd()

##1.Identify colClasses
test=read.table('household_power_consumption.txt', sep=';', header=TRUE, nrows=10)
head(test)
str(test)
classes=sapply(test, class)
classes
##2.Read Large Table
data3=read.table('household_power_consumption.txt', header=TRUE, sep=';', colClasses=classes, nrows=2075259, comment.char='', na.strings='?')
head(data3)
tail(data3)
str(data3)

##3. Convert the Date and Time variable to Date/Time classes
#Note: Y capital,o.w. Wrong.
data3$Date=as.Date(data3$Date, format='%d/%m/%Y')
#Note: it is assumed that unspecified seconds, minutes or hours are zero;
#				and an unspecified year, month or day is the current one.
# So we have to define the month first
Time2=paste(data3$Date, data3$Time)
Time2=strptime(Time2, format='%Y-%m-%d %H:%M:%S')
data3$Time=Time2
head(data3)
tail(data3)
str(data3)

#4. Subset data
data=subset(data3, data3$Date=='2007-02-01'|data3$Date=='2007-02-02')
head(data)
tail(data)
str(data)

#5 plot3
#Tips: Don't send the plot to screen and then create a png file using dev.copy.This can create anomolies. Create directly using png()

plot1=plot(data$Time, data$Global_active_power, ylab='Global Active Power (kilowatts)',type='l', xlab=NA )

plot2=plot(data$Time, data$Voltage, xlab='datetime', ylab='Voltage', type='l')
  
plot3=plot(data$Time, data$Sub_metering_1, ylab='Energy sub metering',type='l', xlab=NA )
points(data$Time, data$Sub_metering_2, col='red', type='l')
points(data$Time, data$Sub_metering_3, col='blue', type='l')
legend('topright', lty=1, col=c('black', 'red', 'blue'), legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))


plot4=plot(data$Time, data$Global_reactive_power, xlab='datetime', ylab='Global_reactive_power',type='l')
  
png(filename='plot4.png',width=480, height=480)

par(mfrow=c(2,2))
#plot1

#plot2

#plot3

#plot4



dev.off()
