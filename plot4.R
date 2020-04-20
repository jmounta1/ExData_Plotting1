# jmounta1 Exploratory Data Analysis Week 1 Course Project
# making plot2.png

# packages
library(tidyverse)
library(lubridate)

# load in data from 2007-02-01 to 2007-02-02 to reduce import size
# did so by importing various chunks of data until I found the rows corresponding to the correct dates
# rows 66638 to 69518 (so skip 66637 rows and read in 2880 rows)
headers <- read.csv('household_power_consumption.txt', nrows = 1, header = T, sep = ';')
power_table <- read.csv('household_power_consumption.txt', skip = 66637, nrows = 2880, header = F, sep = ';',
                        col.names = colnames(headers))

# convert date/time columns to date-times via lubridate package
# first merge date and time columns, then parse
datetimes_raw <- paste(power_table$Date, power_table$Time, sep = " ")
datetimes <- data.frame("Datetimes" = dmy_hms(datetimes_raw))

# make new table with formatted datetimes
power_table_tidy <- cbind(datetimes, power_table[,3:9])

# plot into a png file
png(filename = 'plot4.png')
par(mfrow = c(2,2))
with(power_table_tidy, {
  plot(Datetimes, Global_active_power, type = 'l', ylab = 'Global Active Power (kilowatts)')
  plot(Datetimes, Voltage, type = 'l')
  {
    plot(Datetimes, Sub_metering_1, type = 'l', ylab = 'Energy sub metering')
    lines(Datetimes, Sub_metering_2, col = 'tomato2')
    lines(Datetimes, Sub_metering_3, col = 'blue')
    legend('topright', lty = 1, col = c('black', 'tomato2', 'blue'), legend = colnames(power_table_tidy[6:8]), bty = 'n')
  }
  plot(Datetimes, Global_reactive_power, type = 'l')
})
dev.off()