# This function requires 124 MB of memory

# this function requires data.table package to be installed
# install.packages("data.table")

plot1<-function(){
  # Load the data.table package in case it hasn't been done
  library(data.table)
  
  # Disable warnings
  options(warn=-1)
  
  # Read the file
  DT<-fread("household_power_consumption.txt",sep=";",header=TRUE)
  
  # Subset the needed data from 1st and 2nd February 2007
  Data<-subset(DT,DT$Date=="1/2/2007" | DT$Date=="2/2/2007")
  
  # get the needed information
  global_active_power<-as.numeric(Data$Global_active_power)
  
  # plot the histogram
  hist(global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red")
  
  # save it as png
  dev.copy(png, file = "plot1.png",width=480,height=480)
  dev.off()
  
  # enable comments again
  options(warn=0)
}