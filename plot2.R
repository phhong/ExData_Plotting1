# Download data file
#fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#download.file(fileUrl,destfile="exdata_data_household_power_consumption.zip")
#unzip("exdata_data_household_power_consumption.zip")

# Read data, select date and global active power column
columnSel<-c("character","character","numeric","NULL","NULL","NULL","NULL","NULL","NULL")
global_active_power<-read.table("household_power_consumption.txt", sep=";", header=TRUE, colClasses=columnSel, na.strings="?")

# Filter data by date
global_active_power$Date<-as.Date(global_active_power$Date,format= "%d/%m/%Y")
global_active_power<-subset(global_active_power,Date==as.Date("2007-02-01",format= "%Y-%m-%d") | Date==as.Date("2007-02-02",format= "%Y-%m-%d"))

# Combine date and time
datetime<-paste(global_active_power$Date,global_active_power$Time,sep=" ")
global_active_power$Datetime<-strptime(datetime,format= "%Y-%m-%d %H:%M:%S")

# Remove NA
global_active_power<-subset(global_active_power,!is.na(Global_active_power) | !is.na(Datetime))

# Plot 
png(file = "plot2.png",  width = 480, height = 480, bg = "transparent")
plot(global_active_power$Datetime,global_active_power$Global_active_power,type="l",xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
