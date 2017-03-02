# On Linux, run with 
# Rscript proj4.R

source("read.R")

metering_colors = c("black", "red", "blue")

dev = png(filename = "plot4.png", width = 480, height = 480, units = "px")

par(mfrow=c(2,2))
# Plot 1,1
plot(rawData$Time, rawData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Plot 1,2
plot(rawData$Time, rawData$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# Plot 2,1
plot(rawData$Time, rawData$Sub_metering_1, col = metering_colors[1], type = "c", xlab = "", ylab = "Energy sub metering")
lines(rawData$Time, rawData$Sub_metering_2, col = metering_colors[2], xaxt = "n", yaxt = "n")
lines(rawData$Time, rawData$Sub_metering_3, col = metering_colors[3], xaxt = "n", yaxt = "n")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") 
       , col = metering_colors, lwd = 1, bty = "n")

# Plot 2,2
plot(rawData$Time, rawData$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()
