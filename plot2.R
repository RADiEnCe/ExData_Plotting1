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

# Although my pictures have weekdays labled in Chinese,
# these code will produce English-labeled plots when run
# under an English locale,
# so I'm going to ask you for a big favor:
# plese ignore them
plot(dt, df[,3], type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()