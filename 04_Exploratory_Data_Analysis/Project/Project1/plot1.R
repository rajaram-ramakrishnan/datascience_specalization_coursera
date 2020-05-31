####  Set the data file path ###
data_file <- file.path("exdata_data_household_power_consumption",
                       "household_power_consumption.txt")


library(data.table)

## Load the data from file
## Load only 1/2/2207 and 2/2/2007 data. As the data is ordered 
## in the file, we use skip and nrows to load only these required rows
power.consumption <- fread(data_file,skip=66636,nrows=2880,
                           na.strings ="?",header=TRUE,
                           col.names=c("Date","Time","Global_active_power",
                                       "Global_reactive_power","Voltage",
                                       "Global_intensity","Sub_metering_1",
                                       "Sub_metering_2","Sub_metering_3"))


## Create plot1.png with width of 480 pixels and height of 480 pixels
png("plot1.png",width=480, height=480)

## Hist of Global Active Power
hist(power.consumption[,Global_active_power],
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency",
     col="red")

dev.off()





