# On Linux, run with 
# Rscript proj3.R

#source("read.R")

url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Download to a temporary location 
temp = tempfile(fileext = c(".zip"))
download.file(url, temp)

# Need to unzip since the zip file can't be read directly by read.* 
unzippedFile = unzip(temp) 
#unzippedFile = "household_power_consumption.txt"

# ============================================
# Read the data 
#read.csv(unzippedFile, header = TRUE, sep=";")

# Much more efficient way to select only the desired rows
# http://stackoverflow.com/a/35999777 
library(sqldf)
query = "select * from file where Date=='1/2/2007' or Date=='2/2/2007'"
rawData = read.csv.sql(file = unzippedFile, header = TRUE, sep = ";", sql = query)

#head(rawData)

# ============================================
# Clean up
file.remove(unzippedFile)
file.remove(temp)

# ============================================
# There are no missing values for the two days 
# First convert Time since it uses Date with character type as originally read
rawData$Time = strptime(paste(rawData$Date, rawData$Time), format = "%d/%m/%Y %H:%M:%S")
rawData$Date = as.Date(as.character(rawData$Date), format="%d/%m/%Y")

# ============================================
metering_colors = c("black", "red", "blue")

dev = png(filename = "plot3.png", width = 480, height = 480, units = "px")
# https://cran.r-project.org/doc/contrib/Lemon-kickstart/kr_addat.html 
plot(rawData$Time, rawData$Sub_metering_1, col = metering_colors[1], type = "c", xlab = "", ylab = "Energy sub metering")
lines(rawData$Time, rawData$Sub_metering_2, col = metering_colors[2], xaxt = "n", yaxt = "n")
lines(rawData$Time, rawData$Sub_metering_3, col = metering_colors[3], xaxt = "n", yaxt = "n")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") 
       , col = metering_colors, lwd = 1)
dev.off()
