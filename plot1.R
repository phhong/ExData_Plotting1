# Download data file
#fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#download.file(fileUrl,destfile="exdata_data_household_power_consumption.zip")
#unzip("exdata_data_household_power_consumption.zip")

# Read data, select date and global active power column
columnSel<-c("character","NULL","numeric","NULL","NULL","NULL","NULL","NULL","NULL")
global_active_power<-read.table("household_power_consumption.txt", sep=";", header=TRUE, colClasses=columnSel, na.strings="?")

# Convert date to type Date
global_active_power$Date<-as.Date(global_active_power$Date,format= "%d/%m/%Y")

# Filter data by date
global_active_power<-subset(global_active_power,Date==as.Date("2007-02-01",format= "%Y-%m-%d") | Date==as.Date("2007-02-02",format= "%Y-%m-%d"))

# Remove NA
global_active_power<-subset(global_active_power,!is.na(Global_active_power))

# Plot histogram
png(file = "plot1.png",  width = 480, height = 480, bg = "transparent")
hist(global_active_power$Global_active_power,col="red",main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
