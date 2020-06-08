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

## Filter for Coal Combustion

comb <- grepl("Comb",SCC[, EI.Sector],ignore.case = TRUE)
coal <- grepl("Coal",SCC[, EI.Sector],ignore.case = TRUE)

## List of SCC with Combustion Coal
SCC.comb.coal <- SCC[comb&coal,]
setkeyv(SCC.comb.coal,"SCC")
setkeyv(NEI,"SCC")
# Subset Join between NEI and SCC
NEI.comb.coal <- NEI[SCC.comb.coal,nomatch=0, .(fips,SCC,Pollutant,Emissions,type,year)]


## Plot the barplot 
png(filename="plot4.png", width=480, height = 480)

## ggplot 
library(ggplot2)
options(scipen=999)
ggplot(NEI.comb.coal, aes(x= factor(year), y= Emissions)) +
  geom_col(fill="#2353d9") +
  labs(x="Year", y= expression("PM"[2.5]*" Emissions")) +
  labs(title = expression("PM"[2.5]*" Emissions- Coal Combustion Source across US from 1999-2008"))


dev.off()



