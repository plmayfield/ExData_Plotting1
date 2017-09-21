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


Plot1 <- function()
{
  x <- PrepData()   #read and prep data
  
  png (file = "plot1.png", bg="white", width = 480, height = 480, units = "px") ##open file
  hist(x$Global_active_power, main = "Global Active Power", xlab= "Global Active Power (kilowtts)", ylab = "Frequency", col = "red", )
  dev.off() ##close file
}

