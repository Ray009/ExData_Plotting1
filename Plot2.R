# read the Household Power Compsumption file.  It assumes that it is loacted in your working directory
print("Loading household_power_consumption.txt, please wait...")
#hpc <- read.table("C:/Users/Raymond/Documents/coursera/EDA/household_power_consumption.txt", sep=";", header = TRUE, colClasses=colclasses,  na.strings="?")
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
png(file = "plot2.png")
with(hpc2, plot(Datetime, Global_active_power, xlab="Datetime", ylab="Global Active Power (kilowatts)", type="l"))
dev.off()
print("Plot2.png created")
