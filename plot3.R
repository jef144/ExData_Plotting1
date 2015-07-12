#Script to download a dataset of electrical consumption, by minute, from a household
#SOurce is UC Irvine Machine Learning Repository
#Plot 2 is a line charte of power consumption over time

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
png(filename = "plot3.png")
   with(df, plot(DateTime,  Sub_metering_1,    type="l",    col="black", ylab = "Energy sub metering", xlab=""))
   with(df, points(DateTime,  Sub_metering_2,   type="l",    col="red"  ))
   with(df, points(DateTime,  Sub_metering_3,   type="l",    col="blue"  ))
   legend("topright",  lty=1, col=c("black", "red", "blue"), 
          legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"  )) 

dev.off()  
  