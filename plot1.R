# use a function to get and screen data,
# for easy reusual in the other files

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
####################################################

# get data
df <- getdata()

# draw histogram onto screen
hist(as.numeric(df[,3]), col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

# save to device. alternate solution: 
# write directly to file
dev.copy(device = png,
         filename = "plot1.png", width = 480, height = 480)

# kill current graphics to complete file
dev.off()