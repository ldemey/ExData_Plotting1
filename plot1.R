# PHASE 1: (i)  read the data file 
#          (ii) select the data from 2007-02-01 and 2007-02-02

classes <- c("character",        # Date
             "character",        # Time    
             "numeric",          # Global_active_power
             "numeric",          # Global_reactive_power
             "numeric",          # Voltage 
             "numeric",          # Global_intensity
             "numeric",          # Sub_metering_1
             "numeric",          # Sub_metering_2
             "numeric")          # Sub_metering_3

data <- read.table("household_power_consumption.txt",
                   sep = ";",
                   header = TRUE,
                   na.strings= "?",
                   colClasses = classes)

relevantdata <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")


# PHASE 2: create the plot

png("plot1.png", width = 480, height = 480)    
# note: the default values of width and height are actually already 480

with(relevantdata, hist(Global_active_power, 
                        main = "Global Active Power", 
                        xlab = "Global Active Power (kilowatts)", 
                        col = "red"))

dev.off()