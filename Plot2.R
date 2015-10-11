#Plot2

#Make sure the datafile is in the current working directory
getwd()

##1.Identify colClasses
test=read.table('household_power_consumption.txt', sep=';', header=TRUE, nrows=10)
head(test)
str(test)
classes=sapply(test, class)
classes
##2.Read Large Table
data2=read.table('household_power_consumption.txt', header=TRUE, sep=';', colClasses=classes, nrows=2075259, comment.char='', na.strings='?')
head(data2)
tail(data2)
str(data2)

##3. Convert the Date and Time variable to Date/Time classes
#Note: Y capital,o.w. Wrong.
data2$Date=as.Date(data2$Date, format='%d/%m/%Y')
#Note: it is assumed that unspecified seconds, minutes or hours are zero;
#				and an unspecified year, month or day is the current one.
# So we have to define the month first
Time2=paste(data2$Date, data2$Time)
Time2=strptime(Time2, format='%Y-%m-%d %H:%M:%S')
data2$Time=Time2
head(data2)
tail(data2)
str(data2)

#4. Subset data
data=subset(data2, data2$Date=='2007-02-01'|data2$Date=='2007-02-02')
head(data)
tail(data)
str(data)

#5. plot2
#Tips: Don't send the plot to screen and then create a png file using dev.copy.This can create anomolies. Create directly using png()

png(filename='plot2.png',width=480, height=480)
plot(data$Time, data$Global_active_power, ylab='Global Active Power (kilowatts)',type='l', xlab=NA )
dev.off()


