# Download data file
#fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#download.file(fileUrl,destfile="exdata_data_household_power_consumption.zip")
#unzip("exdata_data_household_power_consumption.zip")

# Read data, select date and global active power column
columnSel<-c("character","character","NULL","NULL","NULL","NULL","numeric","numeric","numeric")
sub_metering<-read.table("household_power_consumption.txt", sep=";", header=TRUE, colClasses=columnSel, na.strings="?")

# Filter data by date
sub_metering$Date<-as.Date(sub_metering$Date,format= "%d/%m/%Y")
sub_metering<-subset(sub_metering,Date==as.Date("2007-02-01",format= "%Y-%m-%d") | Date==as.Date("2007-02-02",format= "%Y-%m-%d"))

# Combine date and time
datetime<-paste(sub_metering$Date,sub_metering$Time,sep=" ")
sub_metering$Datetime<-strptime(datetime,format= "%Y-%m-%d %H:%M:%S")

# Remove NA
sub_metering<-na.omit(sub_metering)

# Plot 
png(file = "plot3.png",  width = 480, height = 480, bg = "transparent")
plot(sub_metering$Datetime,sub_metering$Sub_metering_1,type="n",xlab="", ylab="Energy sub metering")
points(sub_metering$Datetime,sub_metering$Sub_metering_1,type="l",col="black")
points(sub_metering$Datetime,sub_metering$Sub_metering_2,type="l",col="red")
points(sub_metering$Datetime,sub_metering$Sub_metering_3,type="l",col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"), lwd=1)
dev.off()
