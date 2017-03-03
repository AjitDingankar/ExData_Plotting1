# On Linux, run with 
# Rscript proj1.R

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
dev = png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(rawData$Global_active_power, col = "red"
     , main = "Global Active Power"
     , xlab = "Global Active Power (kilowatts)")
dev.off()
# ============================================