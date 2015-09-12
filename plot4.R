# read the Household Power Compsumption file.  It assumes that it is loacted in your working directory
print("Loading household_power_consumption.txt, please wait...")
colclasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
hpc <- read.table("household_power_consumption.txt", sep=";", header = TRUE, colClasses=colclasses,  na.strings="?")
print("File loaded...")

# subset the dataset to the two days to be analyzed
hpc2<- hpc[hpc$Date %in% c("1/2/2007","2/2/2007"),]
rm(hpc)

#Create a Datetime column
hpc2 <- transform(hpc2, Date = as.character(as.Date(hpc2$Date, "%d/%m/%Y")))
hpc2 <- transform(hpc2, Datetime = paste(hpc2$Date, hpc2$Time, sep= " "), stringsAsFactors=FALSE)
hpc2 <- transform(hpc2, Datetime = strptime(hpc2$Datetime, format="%Y-%m-%d %H:%M:%S"))

# create plot
png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
with(hpc2, {
      plot(Datetime, Global_active_power, xlab="Datetime", ylab="Global Active Power (kilowatts)", type="l")
      plot(Datetime, Voltage, xlab="Datetime", ylab="Voltage", type="l")
      plot(Datetime, Sub_metering_1, ylab="Energy sub metering", type="l")
      lines(hpc2$Datetime,hpc2$Sub_metering_2,type="l",col="red")
      lines(hpc2$Datetime,hpc2$Sub_metering_3,type="l",col="blue")
      legend("topright", pch = 1, col = c("black","blue", "red"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
      plot(Datetime, Global_reactive_power, xlab="Datetime", ylab="Global Rreactive Power", type="l")
})
dev.off()
print("Plot4.png created")
