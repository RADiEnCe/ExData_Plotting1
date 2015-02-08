# use a function to get and screen data,
# for reusual in the other files

# You don't really need to read all this:
# lots of bad programming practices,
# don't want to waste your time

####################################################
getdata <- function(){
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
    return(readdata(datapath = "screened.txt"))
  } else {
    return(screendata(readdata()))
  }
}
#####################################################

# get data & store into df
df <- getdata()

# fix up the time
rawdt <- paste(df[,1], df[,2])
dt <- as.POSIXct(rawdt, format = "%d/%m/%Y %H:%M:%S")

# Uncomment this to get rid of time locale problems for the dates in
# Linux-based systems
# Sys.setlocale("LC_TIME", "C")
# Uncomment this to get rid of time locale problems in Windows
# Sys.setlocale("LC_TIME", "English")

# Open PNG device
png(filename = "plot3.png", height = 480, width = 480)

# Make initial plot and add 2 extra lines
plot(dt, df[,7], type = "l",
    ylab = "Energy sub metering", xlab = "",
    col = "black")
lines(dt, df[,8], col = "red")
lines(dt, df[,9], col = "blue")

# add legend
legend("topright",
       lty = c(1, 1, 1), col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()