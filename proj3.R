# On Linux, run with 
# Rscript proj3.R

source("read.R")

metering_colors = c("black", "red", "blue")

dev = png(filename = "plot3.png", width = 480, height = 480, units = "px")
# https://cran.r-project.org/doc/contrib/Lemon-kickstart/kr_addat.html 
plot(rawData$Time, rawData$Sub_metering_1, col = metering_colors[1], type = "c", xlab = "", ylab = "Energy sub metering")
lines(rawData$Time, rawData$Sub_metering_2, col = metering_colors[2], xaxt = "n", yaxt = "n")
lines(rawData$Time, rawData$Sub_metering_3, col = metering_colors[3], xaxt = "n", yaxt = "n")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") 
       , col = metering_colors, lwd = 1)
dev.off()
