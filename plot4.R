# This function requires 124 MB of memory

# this function requires data.table package to be installed
# install.packages("data.table")

plot4<-function(){
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
  global_reactive_power<-as.numeric(Data$Global_reactive_power)
  voltage<-as.numeric(Data$Voltage)
  Sub_metering_1<-as.numeric(Data$Sub_metering_1)
  Sub_metering_2<-as.numeric(Data$Sub_metering_2)
  Sub_metering_3<-as.numeric(Data$Sub_metering_3)
  date<-strptime(paste(Data$Date,Data$Time),"%d/%m/%Y %H:%M:%S")
  
  # plot
  par(mfrow = c(2,2),mar=c(4,4,1,1))
  plot(date,global_active_power,type="l",ylab="Global Active Power",xlab="")
  plot(date,voltage,type="l",ylab="Voltage",xlab="datetime")
  plot(date,Sub_metering_1,mar=c(0,0,0,0),type="l",ylim=range(Sub_metering_1,Sub_metering_2,Sub_metering_3),ylab="Energy sub metering",xlab="")
  par(new = TRUE)
  plot(date,Sub_metering_2,type="l",col="red",ylim=range(Sub_metering_1,Sub_metering_2,Sub_metering_3),ylab="Energy sub metering",xlab="")
  par(new = TRUE)
  plot(date,Sub_metering_3,type="l",col="blue",ylim=range(Sub_metering_1,Sub_metering_2,Sub_metering_3),ylab="Energy sub metering",xlab="")
  legend("topright",bty = "n",cex=0.6,pt.cex = 1, lwd=1, lty=c(1,1),col=c("black","red","blue"),legend=c("Sub_metering_1    ","Sub_metering_2    ","Sub_metering_3    "))
  plot(date,global_reactive_power,lwd=1,type="l",ylab="Global_reactive_power",xlab="datetime")
  # save it as png
  dev.copy(png, file = "plot4.png",width=480,height=480)
  dev.off()
  
  # re-enable warnings
  options(warn=0)
}