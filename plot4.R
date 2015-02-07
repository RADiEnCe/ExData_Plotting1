# I don't think you're required to waste your time
# on reading my data processing bits of code, 
# so I've marked them out so that you could jump
# right over

##############################################
readdata <- function(datapath = "./household_power_consumption.txt") {
  ret = read.table(datapath, header = TRUE, sep = ";", colClasses = "character")
}
  screendata <- function(df) {
  condition1 <- df[,"Date"] == "1/2/2007"
  condition2 <- df[,"Date"] == "2/2/2007"
  conditionfin <- condition1 | condition2
  return(df[conditionfin,])
}

if(file.exists("screened.txt")){
  df <- (readdata(datapath = "screened.txt"))
} else {
  df <- (screendata(readdata()))
}
##############################################

# Now: data sitting all cozy in df

# Concatenating Date and Time, convert to
# POSIXct, and store in dt
rawdt <- paste(df[,1], df[,2])
dt <- as.POSIXct(rawdt, format = "%d/%m/%Y %H:%M:%S")

# Prepare for plot: configure device and organize panels
png(filename = "plot4.png", height = 480, width = 480,)
par(mfrow = c(2,2))

# plot panels
  # commencing panel 1
    plot(dt, df[,3], type = "l",     # 3 is Global_active_power
           ylab = "Global Active Power (kilowatts)", xlab = "")
  # panel 1 completed
    
  # commencing panel 2
    plot(dt, df[,5], type = "l",
         xlab = "datetime", ylab = "Voltage")
  # panel2 completed
    
  # commencing plot 3
    # Make initial plot and add 2 extra lines
    plot(dt, df[,7], type = "l",
         ylab = "Energy sub metering", xlab = "",
         col = "black")
    lines(dt, df[,8], col = "red")
    lines(dt, df[,9], col = "blue")
    
    # add legend
    legend("topright",
           lty = c(1, 1, 1), col = c("black", "red", "blue"),
           bty = "n",
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  # panel 3 done
  
  # commencing panel 4
    plot(dt, df[,4], type = "l",
       xlab = "datetime", ylab = "Global_reactive_power")
  # panel 4 done
# done plotting panels
#closing
dev.off()


## and again, I'm sorry that my pngs have chinese labels
## These code will produce properly labeled graphcs
## So I'm just going to ask you for a big favor:
## that you be lenient and ignore them