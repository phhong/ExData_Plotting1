# Download data file
#fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#download.file(fileUrl,destfile="exdata_data_household_power_consumption.zip")
#unzip("exdata_data_household_power_consumption.zip")

# Read data, select date and global active power column
columnSel<-c("character","character","numeric","numeric","numeric","NULL","numeric","numeric","numeric")
household_power_consumption<-read.table("household_power_consumption.txt", sep=";", header=TRUE, colClasses=columnSel, na.strings="?")

# Filter data by date
household_power_consumption$Date<-as.Date(household_power_consumption$Date,format= "%d/%m/%Y")
household_power_consumption<-subset(household_power_consumption,Date==as.Date("2007-02-01",format= "%Y-%m-%d") | Date==as.Date("2007-02-02",format= "%Y-%m-%d"))

# Combine date and time
datetime<-paste(household_power_consumption$Date,household_power_consumption$Time,sep=" ")
household_power_consumption$Datetime<-strptime(datetime,format= "%Y-%m-%d %H:%M:%S")

# Remove NA
household_power_consumption<-na.omit(household_power_consumption)

# Plot 
png(file = "plot4.png",  width = 480, height = 480, bg = "transparent")
par(mfrow=c(2,2))

# Plot 1
plot(household_power_consumption$Datetime,household_power_consumption$Global_active_power,type="l",xlab="", ylab="Global Active Power")

# Plot 2
plot(household_power_consumption$Datetime,household_power_consumption$Voltage,type="l",xlab="datetime", ylab="Voltage")

# Plot 3
plot(household_power_consumption$Datetime,household_power_consumption$Sub_metering_1,type="n",xlab="", ylab="Energy sub metering")
points(household_power_consumption$Datetime,household_power_consumption$Sub_metering_1,type="l",col="black")
points(household_power_consumption$Datetime,household_power_consumption$Sub_metering_2,type="l",col="red")
points(household_power_consumption$Datetime,household_power_consumption$Sub_metering_3,type="l",col="blue")
legend("topright", bty="n",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"), lwd=1)

# Plot 4
plot(household_power_consumption$Datetime,household_power_consumption$Global_reactive_power,type="l",xlab="datetime", ylab="Global_reactive_power")

dev.off()
