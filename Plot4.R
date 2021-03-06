PrepData <- function()
{
  data <- read.table("household_power_consumption.txt", sep=";", header = TRUE) #read the data
  
  ##combine the data and time into a single column
  data$Date <- as.Date(data$Date,format="%d/%m/%Y")
  data$FullDate <- paste(data$Date,data$Time)
  data$FullDate <- strptime(data$FullDate,format = "%Y-%m-%d %H:%M:%S")
  
  ##only include data from the two days of interest
  data <- data[data$FullDate < "2007-02-03" & data$FullDate >= "2007-02-01",]
  
  ##for some reason all the data came in as factors, this puts it back into numeric vlaues
  ##future pont of caution, the columns were read in as factors, conversion to numbers require converting to text first
  data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
  data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
  data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
  data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))
  data$Voltage<- as.numeric(as.character(data$Voltage))
  data$Global_reactive_power<- as.numeric(as.character(data$Global_reactive_power))
  data  ##return data
}





##Plot4 writes the four pack of charts to a png file
Plot4 <- function()
{
  
  x <- PrepData()   #read and prep data
  
  png (file = "plot4.png", bg="white", width = 480, height = 480, units = "px") ##open file
  
  par(mfrow = c(2,2))  ##change to grid of charts 2 by 3
  plot(x$FullDate,x$Global_active_power,type="l", xlab = "", ylab="Global Active Power")
  plot(x$FullDate,x$Voltage,type="l", xlab = "datetime", ylab="Voltage")

 
  plot(x$FullDate,x$Sub_metering_1,type="l", xlab = "", ylab="Energy sub metering", col= "black")
  lines(x$FullDate,x$Sub_metering_2, col="red")
  lines(x$FullDate,x$Sub_metering_3, col = "blue")
  legend ("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black","red","blue"), lwd = 1, cex=0.8)
  
  plot(x$FullDate,x$Global_reactive_power,type="l", xlab = "datetime", ylab="Global_reactive_power")
  dev.off() ##close file
}

