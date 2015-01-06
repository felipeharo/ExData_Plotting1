# This function requires 124 MB of memory

# this function requires data.table package to be installed
# install.packages("data.table")

plot2<-function(){
  # Load the data.table package in case it hasn't been done
  library(data.table)
  
  # Set the language to English to get the correct day names
  Sys.setlocale("LC_TIME", "English")
  
  # Disable warnings
  options(warn=-1)
  
  # Read the file
  DT<-fread("household_power_consumption.txt",sep=";",header=TRUE)
  
  # Subset the needed data from 1st and 2nd February 2007
  Data<-subset(DT,DT$Date=="1/2/2007" | DT$Date=="2/2/2007")
  
  # get the needed information
  global_active_power<-as.numeric(Data$Global_active_power)
  date<-strptime(paste(Data$Date,Data$Time),"%d/%m/%Y %H:%M:%S")
  
  # plot
  plot(date,global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
  
  # save it as png
  dev.copy(png, file = "plot2.png",width=480,height=480)
  dev.off()
  
  # re-enable warnings
  options(warn=0)
}