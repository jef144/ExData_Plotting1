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


#Do a line plot
png(filename = "plot2.png")
  with(df, plot(DateTime,  Global_active_power,    type="l",    col="black", ylab = "Global Average Power (kilowatts)", xlab=""))

  #with(df, rug( Global_active_power))
dev.off()  
  