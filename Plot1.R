#Plot1.R

#1. Roughly Calculate Memory Requirements
# 2075259*9*8 bytes/numeric= 149,418,648 bytes 
#						   =149,418,648/(2^20)  bytes/MB
#						   =142.5MB

#Make sure the datafile is in the current working directory
getwd()

##2.Identify colClasses
test=read.table('household_power_consumption.txt', sep=';', header=TRUE, nrows=10)
head(test)
str(test)
classes=sapply(test, class)
classes
##3.Read Large Table
data1=read.table('household_power_consumption.txt', header=TRUE, sep=';', colClasses=classes, nrows=2075259, comment.char='', na.strings='?')
head(data1)
tail(data1)
str(data1)

#4. Convert the Date and Time variable to Date/Time classes
#Note: Y capital,o.w. Wrong.
data1$Date=as.Date(data1$Date, format='%d/%m/%Y')
#Note: it is assumed that unspecified seconds, minutes or hours are zero;
#				and an unspecified year, month or day is the current one.
# So we have to define the month first
Time1=paste(data1$Date, data1$Time)
Time1=strptime(Time1, format='%Y-%m-%d %H:%M:%S')
data1$Time=Time1
head(data1)
tail(data1)
str(data1)

#5. Subset data
data2=subset(data1, data1$Date=='2007-02-01'|data1$Date=='2007-02-02')
head(data2)
tail(data2)
str(data2)

#6 Plot1 using the base plotting system
#Tips: Don't send the plot to screen and then create a png file using dev.copy.This can create anomolies. Create directly using png()

png(filename='plot1.png',width=480, height=480)
hist(data2$Global_active_power, col='red', breaks=12, main='Global Active Power', xlab='Global Active Power (kilowatts)')
dev.off()

