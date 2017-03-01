# On Linux, run with 
# Rscript proj2.R

source("read.R")

dev = png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(rawData$Time, rawData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
