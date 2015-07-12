#Script to download a dataset of electrical consumption, by minute, from a household
#SOurce is UC Irvine Machine Learning Repository
#Then generate a plot, in 20 budkets, of home consumption

library(sqldf)
library(lubridate)

setwd("~/DSExplore")

if (!file.exists("household_power_consumption.txt"))  {
   download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "ElecConsumption.zip",
                    mode="wb")
   unzip("ElecConsumption.zip", "household_power_consumption.txt")
}


ElecConsump <- file("household_power_consumption.txt") 
attr(ElecConsump, "file.format") <- list(sep = ";", header = TRUE) 
#Filter by rows to speed things up
df <- sqldf("select * from ElecConsump where Date IN ('1/2/2007', '2/2/2007')  ") 

#Normalize character strings to dates
df$DateTime<- dmy(df$Date) + hms(df$Time)

#Produce a plot
png(filename = "plot1.png")
  myhist <- with(df, hist( Global_active_power,    breaks=24, plot = TRUE, main = "Global Active Power", col="tomato"))

dev.off()  
  