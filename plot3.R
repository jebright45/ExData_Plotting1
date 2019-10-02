# --- LOADING DATA INTO A TABLE ---------------------------------------------------

housedata <- read.table(file = "./household_power_consumption.txt", sep = ";", na.strings = "NA", header = TRUE )
dim(housedata)
?read.table

str(housedata)
subhousedata1 <- housedata[which(housedata$Date == "2/2/2007"), ]   # in the notepad txt file, the dates are formatted as day/month/year
subhousedata2 <- housedata[which(housedata$Date == "1/2/2007"), ]

subhousedata3 <- rbind(subhousedata2, subhousedata1) # Ah, got it.

str(subhousedata3)

subhousedata3$Date <- as.Date(x = subhousedata3$Date, format = "%d/%m/%Y") 
# not sure if I needed to do this after all, since I was orginally trying to turn the date column to date and time column to time, separately. What I eventually
# ended up doing was to join the two columns to make a DateTime column, then used strptime() to make them into POSIX. But I guess the date column did also need
# to be changed into class character before I did that, and changing it to date first like I did here accomplished that, so I guess it was necessary unless I 
# had just changed it to character directly as I did with the time variable below.

str(subhousedata3)

## Not working yet.
# ?strptime
# subhousedata3$Time <- strptime(x = subhousedata3$Time, format = "%H:%M:%S")
# format((subhousedata3$Date), "%H:%M:%S")
## 

## This didn't work either.
#  subhousedata3[, 3:8] <- as.character(subhousedata3[ , 3:8])
## 

subhousedata3$Time <- as.character(subhousedata3$Time)
subhousedata3$Global_active_power <- as.numeric(as.character(subhousedata3$Global_active_power))
subhousedata3$Global_reactive_power <- as.numeric(as.character(subhousedata3$Global_reactive_power))
subhousedata3$Voltage <- as.numeric(as.character(subhousedata3$Voltage))
subhousedata3$Global_intensity <- as.numeric(as.character(subhousedata3$Global_intensity))
subhousedata3$Sub_metering_1 <- as.numeric(as.character(subhousedata3$Sub_metering_1))
subhousedata3$Sub_metering_2 <- as.numeric(as.character(subhousedata3$Sub_metering_2))
subhousedata3$Sub_metering_3 <- as.numeric(as.character(subhousedata3$Sub_metering_3))

DateTime <- paste(subhousedata3$Date, subhousedata3$Time)
subhousedata3 <- cbind(DateTime, subhousedata3)

subhousedata3$DateTime <- strptime(x = subhousedata3$DateTime, format = "%Y-%m-%d %H:%M:%S") # Aha, this worked.



# --- CREATING THIRD PLOT ---------------------------------------------------

par(mfrow = c(1,1))
plot(x = subhousedata3$DateTime, y = subhousedata3$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
lines(x = subhousedata3$DateTime, y = subhousedata3$Sub_metering_1)
points(x = subhousedata3$DateTime, y = subhousedata3$Sub_metering_2, type = "n")
lines(x = subhousedata3$DateTime, y = subhousedata3$Sub_metering_2, col = "red")
points(x = subhousedata3$DateTime, y = subhousedata3$Sub_metering_3, type = "n")
lines(x = subhousedata3$DateTime, y = subhousedata3$Sub_metering_3, col = "blue")
legend(x = "topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))




# --- CREATING THIRD PLOT PNG ---------------------------------------------------

png(filename = "plot3.png", width = 480, height = 480)
        plot(x = subhousedata3$DateTime, y = subhousedata3$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
        lines(x = subhousedata3$DateTime, y = subhousedata3$Sub_metering_1)
        points(x = subhousedata3$DateTime, y = subhousedata3$Sub_metering_2, type = "n")
        lines(x = subhousedata3$DateTime, y = subhousedata3$Sub_metering_2, col = "red")
        points(x = subhousedata3$DateTime, y = subhousedata3$Sub_metering_3, type = "n")
        lines(x = subhousedata3$DateTime, y = subhousedata3$Sub_metering_3, col = "blue")
        legend(x = "topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))
dev.off()






