# use a function to get and screen data,
# for reusual in the other files

# You don't really need to read all this:
# lots of bad programming practices,
# don't want to waste your time on this

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
####################################################

# get data
df <- getdata()

# fix datetime
rawdt <- paste(df[,1], df[,2])
dt <- as.POSIXct(rawdt, format = "%d/%m/%Y %H:%M:%S")

# Open PNG device
png(filename = "plot2.png", height = 480, width = 480)

# Plot GlobalActivePower against time

# Uncomment this to get rid of locale problems for the dates in
# Linux-based systems
# Sys.setlocale("LC_TIME", "C")
# Uncomment this to get rid of locale problems in Windows
# Sys.setlocale("LC_TIME", "English")

plot(dt, df[,3], type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()