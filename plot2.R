# PHASE 1: (i)   read the data file 
#          (ii)  select the data from 2007-02-01 and 2007-02-02
#          (iii) create a new DateTime column that will be used when plotting

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

relevantdata$DateTime <- as.POSIXct(strptime(paste(relevantdata$Date, relevantdata$Time),
                                             format = "%d/%m/%Y %H:%M:%S"))


# PHASE 2: create the plot

Sys.setlocale(category = "LC_TIME", locale = "en_US")
# note: my locale is nl_NL (i.e. Nederlands/Dutch) 
# so without the above command, the abbreviated day labels on the x-axis of the plot
# are in Dutch: they would read "do"-"vr"-"za" instead of "Thu"-"Fri"-"Sat"
# see ?Sys.setlocale and http://stackoverflow.com/questions/20960821/ 

png("plot2.png", width = 480, height = 480)    
# note: the default values of width and height are actually already 480

with(relevantdata, plot(Global_active_power ~ DateTime, 
                        type = "l", 
                        xlab = "", 
                        ylab = "Global Active Power (kilowatts)"))

dev.off()

Sys.setlocale(category = "LC_TIME", locale = "nl_NL")
# (restore locale back from English to Dutch)