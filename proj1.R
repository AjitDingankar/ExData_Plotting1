# On Linux, run with 
# Rscript proj1.R

source("read.R")

dev = png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(rawData$Global_active_power, col = "red"
     , main = "Global Active Power"
     , xlab = "Global Active Power (kilowatts)")
dev.off()
# ============================================