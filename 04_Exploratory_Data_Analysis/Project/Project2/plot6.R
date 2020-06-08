## Download file and Unzip the zip file contents

data_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url=data_url,destfile="NEI.zip")
unzip(zipfile = "NEI.zip")

## Load the Data through readRDS

NEI <- readRDS(file="summarySCC_PM25.rds")
SCC <- readRDS(file="Source_Classification_Code.rds")

## Convert from data.frame to data.table
library(data.table)
NEI <- as.data.table(NEI)
SCC <- as.data.table(SCC)

## Filter for Vehicle Sources

vehicles <- grepl("vehicle",SCC[, SCC.Level.Two],ignore.case = TRUE)


## List of SCC with Vehicles
SCC.vehicles <- SCC[vehicles,]
setkeyv(SCC.vehicles,"SCC")
setkeyv(NEI,"SCC")
# Subset Join between NEI and SCC
NEI.vehicles <- NEI[SCC.vehicles,nomatch=0, .(fips,SCC,Pollutant,Emissions,type,year)]
# subset vehicles data for Baltimore
NEI.baltimore.vehicles <- NEI.vehicles[fips=="24510",][, city := "Baltimore"]
# subset vehicles data for Los Angeles
NEI.losangeles.vehicles <- NEI.vehicles[fips=="06037",][, city := "Los Angeles"]

NEI.both.vehicles <- rbind(NEI.baltimore.vehicles,NEI.losangeles.vehicles)
## Plot the barplot 
png(filename="plot6.png", width=480, height = 480)

## ggplot 
library(ggplot2)

ggplot(NEI.both.vehicles, aes(x= factor(year), y= Emissions)) +
  geom_col(aes(fill=year)) +
  facet_grid(cols=vars(city)) +
  labs(x="Year", y= expression("PM"[2.5]*" Emissions")) +
  labs(title = expression("PM"[2.5]*" Emissions- Vehicles Source across Baltimore and LosAngeles"))


dev.off()



