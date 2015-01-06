# This function requires 124 MB of memory

# this function requires data.table package to be installed
# install.packages("data.table")

plot3<-function(){
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
  Sub_metering_1<-as.numeric(Data$Sub_metering_1)
  Sub_metering_2<-as.numeric(Data$Sub_metering_2)
  Sub_metering_3<-as.numeric(Data$Sub_metering_3)
  date<-strptime(paste(Data$Date,Data$Time),"%d/%m/%Y %H:%M:%S")
  
  # plot
  par(mfrow = c(1,1),mar=c(4,4,1,1))
  plot(date,Sub_metering_1,type="l",ylim=range(Sub_metering_1,Sub_metering_2,Sub_metering_3),ylab="Energy sub metering",xlab="")
  par(new = TRUE)
  plot(date,Sub_metering_2,type="l",col="red",ylim=range(Sub_metering_1,Sub_metering_2,Sub_metering_3),ylab="Energy sub metering",xlab="")
  par(new = TRUE)
  plot(date,Sub_metering_3,type="l",col="blue",ylim=range(Sub_metering_1,Sub_metering_2,Sub_metering_3),ylab="Energy sub metering",xlab="")
  legend("topright",cex=0.6,pt.cex = 1, lwd=1, lty=c(1,1),col=c("black","red","blue"),legend=c("Sub_metering_1     ","Sub_metering_2     ","Sub_metering_3     "))
  
  # save it as png
  dev.copy(png, file = "plot3.png",width=480,height=480)
  dev.off()
  
  # re-enable warnings
  options(warn=0)
}