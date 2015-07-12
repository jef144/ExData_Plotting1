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


#Prepare to read the text file
ElecConsump <- file("household_power_consumption.txt") 
attr(ElecConsump, "file.format") <- list(sep = ";", header = TRUE) 
#Filter by rows to speed things up
df <- sqldf("select * from ElecConsump where Date IN ('1/2/2007', '2/2/2007')  ") 

#Normalize character strings to dates
df$DateTime<- dmy(df$Date) + hms(df$Time)
 

#Initialize a multi-panel plot
png(filename = "plot4.png")
#Set up a 2x2 panel arraignment
par(mfrow=c(2,2), mar=c(4,4,2,1), oma = c(0,0,2,0))
 
#Plot multiple view of the dataframe
   with(df, {
     #Top left plot, Global power
     plot(DateTime,  Global_active_power,    type="l",    col="black", ylab = "Global Average Power (kilowatts)", xlab="")
     
     plot(DateTime,  Voltage,    type="l",    col="black", xlab="") 
      
     plot(DateTime,  Sub_metering_1,    type="l",    col="black", ylab = "Energy sub metering", xlab="")
     points(DateTime,  Sub_metering_2,   type="l",    col="red"  )
     points(DateTime,  Sub_metering_3,   type="l",    col="blue"  )
     legend("topright",  lty=1, col=c("black", "red", "blue"), 
            legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"  )) 
     
     plot(DateTime,  Global_reactive_power,    type="l",    col="black", xlab="") 
     
    
   }   )
   
dev.off()  
  